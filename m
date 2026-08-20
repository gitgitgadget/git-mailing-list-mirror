Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092F1F09AD
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212539; cv=none; b=n6hwrENtdtOHVxnSVA5pVmns1LCxCw1hb0CDJz86/VMUcSmrB1cc5OWTnJFxoHJQCagmODVPS2L1hyefibhT0kl+BQWqnZ4CzWJMxaUQeEhDUpmwgWkp3SDOpxnReFcRBzntTUxlYm7KUDgvtu6Hj1riBS8bSbvIcxNBYiNpUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212539; c=relaxed/simple;
	bh=q6b5GtSstkzE9bpaOIlSc1j5m/+icRjbsdAZEYTMntQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Oq+6ds+ewjfgY2Rph3m24HLr1fs8fSTd7gupCd/1AVHxf2PxDx3gDhG1BzotrglBOTUFcdJVjMuQ6g9yBCVeC6MZrXZjXJzniUiiSw0mueGNvnJpYC6scP9wCfh6wrXDq25G4EBZo4Q+bCNadFIcV889ly+1tWF4kxoIN5LTprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d5YXI/Zp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kDH2Pew+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d5YXI/Zp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kDH2Pew+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ECE05EC01B2;
	Thu, 20 Aug 2026 03:55:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 20 Aug 2026 03:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787212536;
	 x=1787298936; bh=LEGXPhGWJUT0fB/i5oWBsFm9etuCpHxWPjCGXY8Pi7Y=; b=
	d5YXI/ZpaR2gyjRzdHXq7GV5vOm4coWV7GSZtOS7RxEqe84C8+armjtUpo5SDpai
	KCS8GcYTMKLbMCzlIIHAQ6s0AD2KOWdipI09eTGPov0i1XRx/F9mzpiepUSXHBKy
	jTYUZmHO5hekA84FR9qHW4FeQjKjR3kdJV1B7axt4m8aN8VZwk1r5hE86hfN7qT1
	jGl5y69a87Lup6F02itapfFGVBxaBLzrwz6nEByhwbb39HGDk5B0Cd5aMVt+rCUv
	CK41pvLKEGmM4mPj/NCdtr1Uql78d+YRgvs+3jU8/qF5rnPHQRt5rioI3WveWhfB
	E48vMfC5kZ7DUrbqdyhKoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787212536; x=
	1787298936; bh=LEGXPhGWJUT0fB/i5oWBsFm9etuCpHxWPjCGXY8Pi7Y=; b=k
	DH2Pew+5yIMxSRF0zx+2NxMmJrcni/2nVj9JiQHvo3zc3bGkwZ8NFAEVIwXZ1OA6
	0qe1dVR5Aa1FQr7niXFP1LuexDzJTMcbOq+IIMwj7fdwJxAnNrnq/IDZoULG/eU8
	P0aNivJv3rSClOiVFzJ+CF6YZcfoMCZExaMXntt20tiv0L77EP9bVdisMhMn4jOR
	p8BL14QlGhDqmU6wAbUm2iXLuAvgEpxObx0WHo9DawDOgJjrWVjx3o1uVOuyPKzx
	a84qM/pV52ub27zgYelznui66NdWAHzls/edgrS11+4qCPpWlOg9AlllLlS+il52
	zWP5YWGwUIM0SbqoaF3Ug==
X-ME-Sender: <xms:-LKGapVbS7yse6fCTSUstL0thFILXHFPWU1UvLbqNvAyiEjPSyXUfg>
    <xme:-LKGagmd6OYiP-SjsHAjAOGSR5tkSqEwbPPXG3LrbZiiKVwK-EqtEWa1tIt7wT1H3
    -RzbPnLOLzVTcl2D2aij-ogZf7-ah4NinHIXfw1j0MSXdsWVbH_cA>
X-ME-Received: <xmr:-LKGaqYAV04vs-I0wakQb4VBj0naizZKwTFpKRSkBTsFnUQKgR88jtITwkJrUDI1wBrvRqaVCEKv69sEoniIlx8WER6uKgJRChvDsT0DDg>
X-ME-Proxy-Cause: dmFkZTGZQP7DP3G/BJaFcgX7cVUGhr2IxiU2MMAHNnpSt0PstAjtMy5Ac5eYPmUmF8fF8n
    Pzjy/q4/meI5AOwNIPKMTIP63+PJudoYYouLW7ZmBduJhfDRGR+adrTrTs94EwICVEkBdq
    mXnIflHdEPG8J72sGVhgRPW+XhDqIyEjz5Ks7N+FirPvU3OHCw1Fw+wfHfEy2nqgTWhu3I
    bKP/VUe8ncbDG1TlejW6SjLZoHUtBbl/FxZ7xDTB5zij/QEw5lge/7gz8GPt5vf/E12G5h
    BoWNeyCHF4ATWix5CHFBRjiRUWwlhkP6eU7Tc+rJ940b/4OCIlICH/fOyS9koKiPIf2DZD
    vwXKcwiqngmfnlYlYxCMXbZe1SIMzdaqIg9JLOXrMPnoYFatCjqJ6A9XbiYsoDlYcuTudr
    SHFusUhWC9yG/fRuekNZq/KuSBJ8/AhSncAnZd1Mlu3iLdl+AD1FMIYpRJI5mV0rwCtNAA
    K3OydLYIhcWeQPnb6NOFFhWb+ocagVWYGPY0zytFL4n+Yq2+IVzAC0pPfmrPUCKopgbTbw
    q2xgb6SduE2P+U7xmouayAogBHYEcRr1W9bz4N/jundw7Tha3RHZgsQzrGamTTADkBt6eu
    YIJBYM10Jrrb+dPbo6JPT+q6vH9PuxGJg0OoanDZDpL74VImdEW+3Zio+TvQ
X-ME-Proxy: <xmx:-LKGarN4yOsZR5ahsINcSyI0pbxKw1SdpNwE15WJ4xoInVgkBFnIdQ>
    <xmx:-LKGavZrEa0P8gvccRgsjP03erpo59tKkw1DQCkxlSPAUzWh_bs5pg>
    <xmx:-LKGap1JyIAuw1kmmVSvy8D_ZYDHg8XWBCEUmjU1bRmfZphivuVPjQ>
    <xmx:-LKGald5EVKbVKeoHLtEzMdOVExu_ENcdA_aHKC2gq6JRUhCrBftWw>
    <xmx:-LKGal4yHWfFvbkKrVyHpDrgcvrxrQ4jHFnRSlzk8QQe4j7aUFVWGvTJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:55:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a6b6795 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 07:55:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/6] odb: make packfile generation pluggable
Date: Thu, 20 Aug 2026 09:55:24 +0200
Message-Id: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NwQ6CMBAFf4X07JqWEkBP/ofx0G63UIlAWiQaw
 r/bYmI8GY+TzJu3sEDeUWDHbGGeZhfc0EeQu4xhq/qGwJnILOd5yWtegS5g7AIMRkNDPXk1EYw
 KO7CSW42GrLTI4nz0ZN1jS58vbw53fSWcUi8ZrQvT4J/b9yyS98fNLIBDZQgLKRRVaE7R27sbS
 x9z/lURvyp5rBRYq0OJaI2Wn8q6ri+2rCctFQEAAA==
X-Change-ID: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series makes packfile generation pluggable.

Note that this series only makes those parts pluggable that are required
for the transport layer. The other parts that relate to packfile
generation as required by our repository maintenance is kept as-is, as
there is a bunch of options there that are way too specific to the
"files" backend to be portable. This should ultimately not be much of a
problem though, as maintenance itself is already pluggable in the first
place.

It's a bit of a shame though for git-pack-objects(1), which still isn't
usable with alternate backends. I tried several times to find good
solutions for making it fully pluggable, but due to the backend-specific
options it's an utter mess. I want to eventually address this though:
same as with git-refs(1), I want to introduce git-objects(1) to care
about all things ODB. And as part of that command we can also introduce
a command that generates packfiles in a generic fashion, without all the
cruft that git-pack-objects(1) has. This is part of a future patch
series though.

Changes in v3:
  - Fix a use-after-scope bug on abnormal exit when child processes are
    cleaned up via `mark_child_for_cleanup()`, as noticed by Elijah.
  - Link to v2: https://patch.msgid.link/20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im

Changes in v2:
  - Mostly remove the dependencies on `the_repository` in "bundle.c".
  - Link to v1: https://patch.msgid.link/20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im

The series is built on top of 2c78326f81 (The 11th batch, 2026-08-05).

Thanks!

Patrick

---
Patrick Steinhardt (6):
      odb: introduce interface to generate packfiles
      upload-pack: generate packfiles via the object database
      send-pack: generate packfiles via the object database
      builtin/bundle: refactor option handling for progress meter
      bundle: get (mostly) rid of `the_repository`
      bundle: generate packfiles via the object database

 builtin/bundle.c      |  31 ++++------
 bundle.c              |  97 ++++++++++++++++++--------------
 bundle.h              |   3 +-
 odb.c                 |  21 +++++++
 odb.h                 | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-files.c    | 149 +++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source.h          |  33 +++++++++++
 send-pack.c           | 101 +++++++++++----------------------
 t/t5516-fetch-push.sh |  12 ++--
 upload-pack.c         | 125 +++++++++++++++--------------------------
 10 files changed, 506 insertions(+), 218 deletions(-)

Range-diff versus v2:

1:  34a7d13ccb ! 1:  d1282ffc64 odb: introduce interface to generate packfiles
    @@ odb/source-files.c: int odb_source_files_optimize(struct odb_source *source,
     +					  struct odb_pack_generator **out,
     +					  const struct odb_generate_pack_options *opts)
     +{
    -+	struct child_process cp = CHILD_PROCESS_INIT;
     +	struct odb_pack_generator_files *generator;
    ++	struct child_process *cp;
     +	FILE *in;
     +
    ++	CALLOC_ARRAY(generator, 1);
    ++	child_process_init(&generator->cp);
    ++	cp = &generator->cp;
    ++
     +	/*
     +	 * The hook is expected to spawn "$hook git pack-objects <args...>"
     +	 * and to behave like git-pack-objects(1) would have. This can for
     +	 * example be used to serve precomputed packfiles.
     +	 */
     +	if (opts->pack_objects_hook) {
    -+		strvec_push(&cp.args, opts->pack_objects_hook);
    -+		strvec_push(&cp.args, "git");
    -+		cp.use_shell = 1;
    ++		strvec_push(&cp->args, opts->pack_objects_hook);
    ++		strvec_push(&cp->args, "git");
    ++		cp->use_shell = 1;
     +	} else {
    -+		cp.git_cmd = 1;
    ++		cp->git_cmd = 1;
     +	}
     +
     +	/*
    @@ odb/source-files.c: int odb_source_files_optimize(struct odb_source *source,
     +	 * be neutralized.
     +	 */
     +	if (opts->shallows.nr) {
    -+		strvec_push(&cp.args, "--shallow-file");
    -+		strvec_push(&cp.args, "");
    ++		strvec_push(&cp->args, "--shallow-file");
    ++		strvec_push(&cp->args, "");
     +	}
    -+	strvec_push(&cp.args, "pack-objects");
    -+	strvec_push(&cp.args, "--revs");
    -+	strvec_push(&cp.args, "--stdout");
    ++	strvec_push(&cp->args, "pack-objects");
    ++	strvec_push(&cp->args, "--revs");
    ++	strvec_push(&cp->args, "--stdout");
     +	if (opts->thin)
    -+		strvec_push(&cp.args, "--thin");
    ++		strvec_push(&cp->args, "--thin");
     +	if (opts->shallow)
    -+		strvec_push(&cp.args, "--shallow");
    ++		strvec_push(&cp->args, "--shallow");
     +	if (opts->ofs_delta)
    -+		strvec_push(&cp.args, "--delta-base-offset");
    ++		strvec_push(&cp->args, "--delta-base-offset");
     +	if (opts->include_tag)
    -+		strvec_push(&cp.args, "--include-tag");
    ++		strvec_push(&cp->args, "--include-tag");
     +	if (opts->missing_allow_promisor)
    -+		strvec_push(&cp.args, "--missing=allow-promisor");
    ++		strvec_push(&cp->args, "--missing=allow-promisor");
     +	if (opts->disable_bitmaps)
    -+		strvec_push(&cp.args, "--no-use-bitmap-index");
    ++		strvec_push(&cp->args, "--no-use-bitmap-index");
     +	switch (opts->progress) {
     +	case ODB_GENERATE_PACK_PROGRESS_NONE:
    -+		strvec_push(&cp.args, "--quiet");
    ++		strvec_push(&cp->args, "--quiet");
     +		break;
     +	case ODB_GENERATE_PACK_PROGRESS_STANDARD:
    -+		strvec_push(&cp.args, "--progress");
    ++		strvec_push(&cp->args, "--progress");
     +		break;
     +	case ODB_GENERATE_PACK_PROGRESS_VERBOSE:
    -+		strvec_push(&cp.args, "--all-progress");
    ++		strvec_push(&cp->args, "--all-progress");
     +		break;
     +	default:
     +		BUG("unknown progress option %d", opts->progress);
     +	}
     +	if (opts->filter_spec)
    -+		strvec_pushf(&cp.args, "--filter=%s", opts->filter_spec);
    ++		strvec_pushf(&cp->args, "--filter=%s", opts->filter_spec);
     +	if (opts->uri_protocols)
     +		for (size_t i = 0; i < opts->uri_protocols->nr; i++)
    -+			strvec_pushf(&cp.args, "--uri-protocol=%s",
    ++			strvec_pushf(&cp->args, "--uri-protocol=%s",
     +				     opts->uri_protocols->items[i].string);
     +
    -+	cp.in = -1;
    -+	cp.out = opts->pack_fd;
    -+	cp.err = opts->progress_fd;
    -+	cp.clean_on_exit = 1;
    ++	cp->in = -1;
    ++	cp->out = opts->pack_fd;
    ++	cp->err = opts->progress_fd;
    ++	cp->clean_on_exit = 1;
     +
    -+	if (start_command(&cp))
    ++	if (start_command(cp)) {
    ++		free(generator);
     +		return error(_("could not spawn pack-objects"));
    ++	}
     +
     +	/*
     +	 * Feed the objects to pack-objects. This is safe to do synchronously
     +	 * because pack-objects consumes all of its standard input before it
     +	 * starts to generate the pack.
     +	 */
    -+	in = xfdopen(cp.in, "w");
    ++	in = xfdopen(cp->in, "w");
     +	for (size_t i = 0; i < opts->shallows.nr; i++)
     +		fprintf(in, "--shallow %s\n", oid_to_hex(&opts->shallows.oid[i]));
     +	for (size_t i = 0; i < opts->wants.nr; i++)
    @@ odb/source-files.c: int odb_source_files_optimize(struct odb_source *source,
     +		error(_("error writing to pack-objects"));
     +		fclose(in);
     +		if (opts->pack_fd < 0)
    -+			close(cp.out);
    ++			close(cp->out);
     +		if (opts->progress_fd < 0)
    -+			close(cp.err);
    -+		finish_command(&cp);
    ++			close(cp->err);
    ++		finish_command(cp);
    ++		free(generator);
     +		return -1;
     +	}
     +	fclose(in);
     +
    -+	CALLOC_ARRAY(generator, 1);
    -+	generator->base.out = opts->pack_fd < 0 ? cp.out : -1;
    -+	generator->base.err = opts->progress_fd < 0 ? cp.err : -1;
    ++	generator->base.out = opts->pack_fd < 0 ? cp->out : -1;
    ++	generator->base.err = opts->progress_fd < 0 ? cp->err : -1;
     +	generator->base.finish = odb_pack_generator_files_finish;
    -+	generator->cp = cp;
     +
     +	*out = &generator->base;
     +	return 0;
2:  c7234030ad = 2:  b17dfd945b upload-pack: generate packfiles via the object database
3:  9866e8af3d = 3:  8e9be66b36 send-pack: generate packfiles via the object database
4:  1cd0c10438 = 4:  3dfc5df91d builtin/bundle: refactor option handling for progress meter
5:  621c9bb411 = 5:  9f938bce19 bundle: get (mostly) rid of `the_repository`
6:  5c1ee3d116 = 6:  41395b1444 bundle: generate packfiles via the object database

---
base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
change-id: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc

