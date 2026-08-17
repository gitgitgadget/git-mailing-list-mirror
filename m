Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A713246ED
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945190; cv=none; b=BWMDhi5UkrO/+IjA4f43w075tqsPFT4NqAAR0JPwP7GXWTSiHeOkpXHOB2X+e+t0zLuhYw0bbUXw+iDoVA42zshmDedv4gXyC9O+SmH34ZNn8GAqcHmzOpI2f8MRmD8yN+QEPQQ3VkGjBI4XOT1OlC3y55xYa+b3BTQiIXxc1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945190; c=relaxed/simple;
	bh=dmkZY9Iwlh8zImyEVy7uvpXAQ5kzSKC5sQgf/cwifwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=YHJc5vtNGEgzwAxYuDgQ1T+49SXaK8c3OFB7LuhV3nat1F6Izo02SURw4/GI0GX5f378WVOHK4AnYOPsC/McZ8gqfx5aqo4v1L3oMTcP6ov+eso8eT/RVTjOWKgcDT0sGMO/+YBT65WxNnYR0QrUH6EcezAtp7yFeh3SR+4SdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a9TO2aE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDi2Sqbe; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a9TO2aE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDi2Sqbe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD9C27A0112;
	Mon, 17 Aug 2026 01:39:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Aug 2026 01:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786945187;
	 x=1787031587; bh=nFBZ4SMj5erycth1BMcRM5YyuY5vc5a4vUDVzGMI14s=; b=
	a9TO2aE22HvhTxuIP24+QwGA/hE7l2i69uqXrOfT/MdNzmn22lAZ3RODj77Oy4un
	HsEeWPT9woUHK4nEigpvOcHWG31PoHpkSfQb1GzBtujnDME4rPCpgQz6PdvuhG30
	+iR+D1ZoghzoWy2lqXsv1R9wBcIxtlTA6KLAvjdRlagyx5H3+jf+rGcM4x+Z6OoE
	POtrSjN27zmkqOoIGT1IpCHusDAONKLLYNAOTPx9bP5HOSVsAZBOeqjBHYu87yN5
	5C4NFgtrD/3ar0Nx9saoofl1zChTmXx5KLrzchcPuvwSWuAbn1WQgNG2uLCShCwH
	MUa3P5p8gVpHExBCGl76VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786945187; x=
	1787031587; bh=nFBZ4SMj5erycth1BMcRM5YyuY5vc5a4vUDVzGMI14s=; b=S
	Di2SqbetEtYmItnthl6l1uOS0G4/8iaIjqtcWYFI/Z/HoAA8L3DrxGPJ4etLuwae
	nq0vp5/2Tu40Vbq9VL91nRTPmYFYkBbopwbQmfBs9ez2rmctFGFazkvufEhm4lLh
	vSLJbSYPbHdAuO/vO2kEVTnacCjPo4Fih0cWL4gDQIt0sO/pChAw6EOAEX09s1N6
	nOoganJFi238gqy+02bDeu8kW0MgPpWpVWW5zFHqKBqCStmE90C53VHHLZD1/5a9
	l9ywLa7+UIUM+7D0SOBvw41zF7Md6gyepEQvtvlr5zqH0jK2EpbfehmpVGX76SKA
	nxPzOTrNEu5rA1WItFk3Q==
X-ME-Sender: <xms:o56CavBPNuFuN79SjzaKXl1zMyFhKfsrwygLrFhQpqW5-FzlHzdiww>
    <xme:o56CarhIxVnSep03iWKb6R0KLxV6q2V5Yp_dFnRmKJFpb26MWrW14FiXWzc_V1AoG
    UcUvuXdX1NLQJ2sgmTzkcIm-DNIpGzFNMLvtVb4ljofHpf650B0Pg>
X-ME-Received: <xmr:o56CaoM8PkbwVIncYWP2GUCPnfml70bCm_eCu4YPqvf3F2uQTvOfAjMrP_qGFCxPXMKygLnXP35DESgTaj-cbPBFaNmz4PuXjfwgCfqQ4g>
X-ME-Proxy-Cause: dmFkZTE5indwYiMwPe7Dm83JWr5yrxAyjPhk2/0FZ4e0uCl99Rhl9vOWDm0pYyYFSidELX
    nfGtEorc/8SniKDL47zN5eMg8EIPX35yuXHLEA71EWLrdUQvqzm1AvXV+mZtTrMjMCBIuY
    FTG3mRALjwTlKjtONCIsBHCEHjiG3q2zX8GmeL+MR5PKN366nwOYAE5lYKwP83ic3SvKyC
    1uxlqBvqNAP98T+k6BXTBFkSWFCmhbFPQFvL/pSHzfRgysi2lM8rxFFa8//K5OmqvCKqUc
    fxPluq+FLTmo1aaBTa8+XkO8ucjuPJH9ZuV/ySoyob3TEfaT2bJS9VTFj0oE/8M28CunnA
    piZlOTBgrM5qbAjdADfcPN4yFoCPNcxXztfZLEr7a1szBchG6HaBhfv+ZqkefKLFm6PCHS
    wt/zZTVtXvjWXEMCfus50uM6keA4eXPfKdzJ6yfTx26O8L3w88a5vTrRu/HgrZSP9INy9g
    kP1HNQOPrSTEBs30DaAkuIkZUSi8BjtnufUvuVzPvkjvpTQCOH5EXK+PrPpSKnH30fzZyS
    MfWu5AJzHbrTfuhSKLptVIqsMam3Zxt9HIvQ2LmCCRIydZUVwxfo+9cDOUXG5jiBBOPCxh
    q+M473w55CoAdgOIT74hr3gHPZ5NIgHzeZl55arNVPuyMb41sFqqGgFl6C4w
X-ME-Proxy: <xmx:o56Cas6-e10kQX3YkypB1PJvQDVlbMS67vvRlFwBznWj6a8cpBj8eg>
    <xmx:o56Cam3Py25hxUeAZb2I5nF70-SLLNoL9gLxnaf1JevLIjs8uZYPdg>
    <xmx:o56CatYqN6XqBbpHr-ZOgy7iLOyO_L3D0vftD0xvsnCIcJsiQDWmIg>
    <xmx:o56CauAz1tWi20JAA-n6A-u9-dXBMpeLzPdh2_9Va2UjHKSttdCNrg>
    <xmx:o56CaiYWIsJeCYyww3qIxYGCV5MPiCZvJoAqQTOIThBOTwLm81MeiSTG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:39:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 804d1b87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:39:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] odb: make packfile generation pluggable
Date: Mon, 17 Aug 2026 07:39:41 +0200
Message-Id: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7ZhSiBhX3oOwaKdTGIlAWiQaw
 t0teAGXL3n//RUiB+EIt2yFwItEGYcE+pQBdWZoGcUlBq30RV1VhbbEqY84OostDxzMzDgZ6tE
 Xylty7AtPkOZTYC/vI103P44v+2Ca995udBLnMXyO7yXfvT9ulhwVVo6pLHLDFbl78s7yhGbbt
 i8LA+pvzwAAAA==
X-Change-ID: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
 odb/source-files.c    | 144 +++++++++++++++++++++++++++++++++++++++++++++++
 odb/source.h          |  33 +++++++++++
 send-pack.c           | 101 +++++++++++----------------------
 t/t5516-fetch-push.sh |  12 ++--
 upload-pack.c         | 125 +++++++++++++++--------------------------
 10 files changed, 501 insertions(+), 218 deletions(-)

Range-diff versus v1:

1:  fb02483cbf = 1:  44fdb3dabf odb: introduce interface to generate packfiles
2:  1293fa4488 = 2:  01a115f7b1 upload-pack: generate packfiles via the object database
3:  98bf918183 = 3:  07e2541ca7 send-pack: generate packfiles via the object database
4:  900536a5fd = 4:  dd3f7eaab7 builtin/bundle: refactor option handling for progress meter
-:  ---------- > 5:  cf01244c05 bundle: get (mostly) rid of `the_repository`
5:  37c0dc5d99 ! 6:  fa4d4dfdd5 bundle: generate packfiles via the object database
    @@ builtin/bundle.c: static int cmd_bundle_create(int argc, const char **argv, cons
      }
     
      ## bundle.c ##
    -@@ bundle.c: static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
    +@@ bundle.c: static int is_tag_in_date_range(struct repository *repo,
      
      
      /* Write the pack data to bundle_fd */
    @@ bundle.c: static int is_tag_in_date_range(struct object *tag, struct rev_info *r
      		struct object *object = revs->pending.objects[i].item;
      		if (object->flags & UNINTERESTING)
     -			write_or_die(pack_objects.in, "^", 1);
    --		write_or_die(pack_objects.in, oid_to_hex(&object->oid), the_hash_algo->hexsz);
    +-		write_or_die(pack_objects.in, oid_to_hex(&object->oid),
    +-			     revs->repo->hash_algo->hexsz);
     -		write_or_die(pack_objects.in, "\n", 1);
     +			oid_array_append(&opts.haves, &object->oid);
     +		else
    @@ bundle.c: static int is_tag_in_date_range(struct object *tag, struct rev_info *r
     -		return error(_("pack-objects died"));
     -	return 0;
     +
    -+	if (odb_generate_pack(the_repository->objects, &generator, &opts)) {
    ++	if (odb_generate_pack(revs->repo->objects, &generator, &opts)) {
     +		ret = error(_("Could not spawn pack-objects"));
     +		goto out;
     +	}

---
base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
change-id: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc

