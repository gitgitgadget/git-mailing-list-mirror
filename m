Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626CE443C01
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928595; cv=none; b=gSfE1s/RXgkoVAvVyBfjPulnp1MlE7dTwtYNYM72Pv1oRcWWp0Bm4DTczFgB4MM2nHh7oLri6z/iNIFtvtQCeC4fk/uCqe/1zGHsIuenWmF45CeJJiynvJTIhRU61XGvacdlP/f7t+04Tk1PF6Q0iIxSidrBtrSGNd16gpfpgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928595; c=relaxed/simple;
	bh=SWmbJiDCh14z9DPAD14fg4xQ7tgq4h/OgIk66t0TOkE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=sNiA7wWUc1YhATypGYRa54673PFnoMk4rQ5LvLi4I/Do5EU+SCpA9umZ+GKY1tOCrd5N7IyEq64aeEvLf8yHwOqZW0uPGY8c4fcs00HTXO1NOgd1V2NS9GBFJseS4EJGkyZ2RVSafMXqohCAVZfAo/wOB1tmcghcxZTvLX98Mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q1qB3OiV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsIDuWvv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q1qB3OiV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsIDuWvv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DC0614000BD
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:09:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 04:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790928592;
	 x=1791014992; bh=uh5ogOsd+j1myxSdcw0gWIrLl0O+3pU/RfuFAS1ZEwg=; b=
	Q1qB3OiVHO9mQHIayFpGLQHWcKr40vMUcgCajUf4iQ2e3qL4SBL2EvQwZIPNLvHF
	p8PaUTf8Oew2WKaW+XLsa5fb2oTMda3u+TdKsADETMBwawpsp5uyHZPaHUZ+DzpI
	VYjdHv021vwhm7JQd95roLiMPr0Oo3EQ5px0l3huLuBmmzJ0x3Lu0CiAwcxsG8KD
	u6P0fl9Quc8+oV2hUE7rN41ug61uX89yG1ecf3lVFbF/gflfMLjfu4eQrzcRAv/c
	JMqtgNWIwzn6URyGYHv5uN1tmr3yTGFi/EtqcP7l0UPIkWRClR7vGM42Ba4GyRM4
	esWnZegfsexvjmYfPwvfOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790928592; x=
	1791014992; bh=uh5ogOsd+j1myxSdcw0gWIrLl0O+3pU/RfuFAS1ZEwg=; b=W
	sIDuWvvxoO2DzM9g1Sd/iH2NoBwz/z1phX5JsGiL4DjdUi1RrmluzTmMMI1k36nt
	iIB0MMsOqnqwe3wD0UpJcMIch4GDxEyu7+OiFl+YCT8FGTpflXQvilEpsXRfB+JM
	Onya2ET3DBc+GDeHIOnQNwSDNgqCl1GN1/RGIabh14qz+zdh6/qO7ro16vLH1ZRj
	/9hQ0kkv8tZzqyA5kH0nyvj97hzSAsgJi1cwJU9O3ueXC/Zx2aM/dXGZUS4Lc8vI
	n6kutpQwuIWS57aepjbwXLKrT08/Ehyc62bAkqhmkltDOJB/FYB8gDFGzLFSLISV
	Mftv3+byqf/ylB9LBaxcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790928592; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Sj2kwmiOH5k2fKE+M1Yu+26c20pTqvY6AAyTjPV6AedQCmw
	P5VY/TbH/9iZVPPtgkQzXbb63Ku4PukK5HMGlYoqNtJuaVUuGODRxkd/KVWCEvbY
	SgmRgqWyNut6fP01ss//3qxAqLtoC7mUlQqZKqQ1UdgG0u4qakuU+/Rfecc1rGKn
	KRFOzguyii2EUPiyE+MD+6GtHC85yofG2ZjbXXc8EpIuG37JietpteJhFpnShMV7
	kM5+ovB0mrZvMMeHFQ2Iimb7cSfO7ow2H/259j86PSeDqJTvFtuPbUACZ0YaWxIX
	OjyWfCK3dpl6Byz45ql3e2nS9D1g7c3+14eb92w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FSqqVF4+lvjxJIgkhZtR32ZOpOVxBlWMkdU+VkuMJtw=:SWmbJiDCh14z9DPAD14fg4xQ7tgq4h/OgIk66t0TOkE=;
X-ME-Sender: <xms:0Ga_apTmJYw_cwfPiMJZiIJ3gAci2zybMWRaHU-ZeDJDuN1YVuBV0A>
    <xme:0Ga_aozET3qte0V0hoedCmKuwHpxTz8fHMvkkRv6PEmNgAq-ij6A2vPPz1wdOmjCB
    VYLQtudyhPIM9gvwVQE_hio2rLF2tpTYkpwyICTH-DO04dZIOT2dA>
X-ME-Received: <xmr:0Ga_asdt5YvAaZH3o0-JBcmcx7JIIpfUDRI11De3Mi4BYE_dPpbwZQ>
X-ME-Proxy-Cause: dmFkZTEYFnPCuyx7X0brfaalsl8Gcb7HAT8pX6sNmy8tjddJ1jo1Py91KxQLQrVzJNl3Gr
    +aJ2zwCBHX8f2o4uhxNzGVYyCIeGK55jfVuOWsEI9++emWSkFNFzEM8twK+pA1fMz4fZ+V
    re6HMJ7Ha5QPkxh0/wQf0u3UVRVVzGqTX8JHsEIb1b82iVXxJ3/si3hpbJ44qJYSluvI2F
    VrtgWWhs1YP488oNeLbK4hYkn+I8UHEjKKixTKBwJ/PspH/rsm3WcgPD1iOMXuH35mo9/x
    COkT70JjCP66N4IvGqrQ9Tc8WPvlNV4mkM45EWLlrtZRwjwFcBfpn3uGBRFMDXJ2RAHErL
    Y73NMpK2icA59cFD5ngQOyO9e5dIe8+QnID4pSQWlTxP1bI3FE4DT2jaAzaok2HGkm/jpW
    /wyOZTR6Eg/kdgKUpLtC1EdYR2eOu/xyBk+mj+YNOKaGQSqViz9j5XxvEJNOhWI4jjDBTr
    zN/+HuEzwtakTM3X+qI8kjOyyzmuMTMpnqjDD+oKq+LTZg3o98JUQyizIR+Lkjzv4YDT0Y
    TvEwTQ2tOoQhE09oJ9DSOp1yit2TG+wL4QcPojxaY0Kp/y/diH2MjbSzg+3OCXzLJFsAON
    slpf4odEYGRJV52tNkJboplWouhc9BOVrEWrCq1Uz1eCdiDDMXOb5sHTBFrg
X-ME-Proxy: <xmx:0Ga_asLQnp5tIiDmLUcR6l5nlWquybTP6R6xcgPzONq0VLWbZiWoNA>
    <xmx:0Ga_alGsy9HbDFICkOI4zkAI-6F4dI6TbVikKLK5JoOjvtQ3B0K4wQ>
    <xmx:0Ga_auoPzQaIBMvrhBFz0QKk1n8e9NmEvIjVJSfPctEVaYUscL4CYw>
    <xmx:0Ga_amS16JSqVDV_z6t2j0cAepZoSQJ_FnuRLqR5axVaOvc4QzTAAQ>
    <xmx:0Ga_asrOdXry-Cs-RJFezevfGO_yBBo6lhCf_qZBFflYV5_3QB0PUqkb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 04:09:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10d99a53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 08:09:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] builtin/refs: introduce subcommand groups
Date: Fri, 02 Oct 2026 10:09:45 +0200
Message-Id: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOTQ6CMBBGr0Jm7Zi2IEZX3MOwaMsA1UCbDhAN4
 e4WPIHLl7zvZwWm6Ijhnq0QaXHs/JhAnTKwvR47QtckBiVUKYWQaAoML8agIxP6MCWfkWdj/TD
 oscEu+jkwXm4mb9W10aK0kMpCpNa9j6FH/eMUepKd9vbd6B1PPn6OJ4vcvb9HF4kChSSj2kIXN
 ldVSp3dAPW2bV+z/eyt6wAAAA==
X-Change-ID: 20261001-b4-pks-parse-options-subcommand-groups-59b3f27da06c
In-Reply-To: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

the git-refs(1) command has grown quite a bunch of different subcommands
by now. These subcommands can easily be grouped into three categories:

  - Operations that span across the whole reference database (migrate,
    verify, optimize).

  - Operations that read references (list, exists).

  - Operations that write references (create, delete, update, rename).

This patch series thus adapts the parse-options subsystem to support
grouping subcommands and then introduces the grouping for git-refs(1).
This results in the following output:

  usage: git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
     or: git refs verify [--strict] [--verbose]
     or: git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
                                  [(--sort=<key>)...] [--format=<format>]
                                  [--include-root-refs] [--points-at=<object>]
                                  [--merged[=<object>]] [--no-merged[=<object>]]
                                  [--contains[=<object>]] [--no-contains[=<object>]]
                                  [(--exclude=<pattern>)...] [--start-after=<marker>]
                                  [ --stdin | (<pattern>...)]
     or: git refs exists <ref>
     or: git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
     or: git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
     or: git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
     or: git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
     or: git refs rename [--message=<reason>] <old-ref> <new-ref>

  Reference database
      migrate               migrate the reference database to a different format
      verify                verify the consistency of the reference database
      optimize              optimize the reference database

  Reading references
      list                  list references
      exists                check whether a reference exists

  Writing references
      create                create a new reference
      delete                delete a reference
      update                update an existing reference
      rename                rename a reference

I expect that going forward, we'll probably have more use cases where we
can use these new capabilities (e.g. an upcoming git-objects(1) command,
which is going to be the equivalent to git-refs(1)).

Changes in v2:
  - Add a preliminary refactoring for `usage_with_options_internal()` so
    that we don't have to reindent a bunch of its code.
  - Drop `OPT_SUBCOMMAND_H()` and extend `OPT_SUBCOMMAND_F()` instead.
  - Rename `bool first` to `bool shown`.
  - Link to v1: https://patch.msgid.link/20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (4):
      parse-options: fix completion format when first option is skipped
      parse-options: extract functions to print single option
      parse-options: allow grouping subcommands
      builtin/refs: introduce subcommand groups

 Documentation/git-refs.adoc                    |   2 +-
 Documentation/technical/api-parse-options.adoc |   4 +-
 builtin/refs.c                                 |  32 +++--
 builtin/remote.c                               |   2 +-
 builtin/stash.c                                |   2 +-
 parse-options.c                                | 176 ++++++++++++++-----------
 parse-options.h                                |   5 +-
 t/helper/test-parse-options.c                  |   4 +-
 t/t0040-parse-options.sh                       |  16 +++
 9 files changed, 150 insertions(+), 93 deletions(-)

Range-diff versus v1:

1:  7ba8a5ca15 ! 1:  10b2249fa6 parse-options: fix completion format when first option is skipped
    @@ parse-options.c: static int show_gitcomp(const struct option *opts, int show_all
      {
      	const struct option *original_opts = opts;
      	int nr_noopts = 0;
    -+	bool first = true;
    ++	bool shown = false;
      
      	for (; opts->type != OPTION_END; opts++) {
      		const char *prefix = "--";
    @@ parse-options.c: static int show_gitcomp(const struct option *opts, int show_all
      		if (starts_with(opts->long_name, "no-"))
      			nr_noopts++;
     -		printf("%s%s%s%s", opts == original_opts ? "" : " ",
    -+		printf("%s%s%s%s", first ? "" : " ",
    ++		printf("%s%s%s%s", shown ? " " : "",
      		       prefix, opts->long_name, suffix);
    -+		first = false;
    ++		shown = true;
      	}
      	show_negated_gitcomp(original_opts, show_all, -1);
      	show_negated_gitcomp(original_opts, show_all, nr_noopts);
2:  8176cf838d < -:  ---------- parse-options: allow grouping subcommands
-:  ---------- > 2:  31e5f08cdb parse-options: extract functions to print single option
-:  ---------- > 3:  20da51f904 parse-options: allow grouping subcommands
3:  9599245895 ! 4:  11cfbe5cae builtin/refs: introduce subcommand groups
    @@ builtin/refs.c: int cmd_refs(int argc,
     -		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
     -		OPT_SUBCOMMAND("rename", &fn, cmd_refs_rename),
     +		OPT_GROUP(N_("Reference database")),
    -+		OPT_SUBCOMMAND_H("migrate", &fn, cmd_refs_migrate,
    -+				 N_("migrate the reference database to a different format")),
    -+		OPT_SUBCOMMAND_H("verify", &fn, cmd_refs_verify,
    -+				 N_("verify the consistency of the reference database")),
    -+		OPT_SUBCOMMAND_H("optimize", &fn, cmd_refs_optimize,
    -+				 N_("optimize the reference database")),
    ++		OPT_SUBCOMMAND_F("migrate", &fn, cmd_refs_migrate,
    ++				 N_("migrate the reference database to a different format"), 0),
    ++		OPT_SUBCOMMAND_F("verify", &fn, cmd_refs_verify,
    ++				 N_("verify the consistency of the reference database"), 0),
    ++		OPT_SUBCOMMAND_F("optimize", &fn, cmd_refs_optimize,
    ++				 N_("optimize the reference database"), 0),
     +		OPT_GROUP(N_("Reading references")),
    -+		OPT_SUBCOMMAND_H("list", &fn, cmd_refs_list,
    -+				 N_("list references")),
    -+		OPT_SUBCOMMAND_H("exists", &fn, cmd_refs_exists,
    -+				 N_("check whether a reference exists")),
    ++		OPT_SUBCOMMAND_F("list", &fn, cmd_refs_list,
    ++				 N_("list references"), 0),
    ++		OPT_SUBCOMMAND_F("exists", &fn, cmd_refs_exists,
    ++				 N_("check whether a reference exists"), 0),
     +		OPT_GROUP(N_("Writing references")),
    -+		OPT_SUBCOMMAND_H("create", &fn, cmd_refs_create,
    -+				 N_("create a new reference")),
    -+		OPT_SUBCOMMAND_H("delete", &fn, cmd_refs_delete,
    -+				 N_("delete a reference")),
    -+		OPT_SUBCOMMAND_H("update", &fn, cmd_refs_update,
    -+				 N_("update an existing reference")),
    -+		OPT_SUBCOMMAND_H("rename", &fn, cmd_refs_rename,
    -+				 N_("rename a reference")),
    ++		OPT_SUBCOMMAND_F("create", &fn, cmd_refs_create,
    ++				 N_("create a new reference"), 0),
    ++		OPT_SUBCOMMAND_F("delete", &fn, cmd_refs_delete,
    ++				 N_("delete a reference"), 0),
    ++		OPT_SUBCOMMAND_F("update", &fn, cmd_refs_update,
    ++				 N_("update an existing reference"), 0),
    ++		OPT_SUBCOMMAND_F("rename", &fn, cmd_refs_rename,
    ++				 N_("rename a reference"), 0),
      		OPT_END(),
      	};
      

---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20261001-b4-pks-parse-options-subcommand-groups-59b3f27da06c

