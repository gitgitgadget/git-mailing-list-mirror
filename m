Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4D47669B
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133255; cv=none; b=XGhIgoaY5RzO1u3+/6pI/YGpoDcozD4s31cq6LoRHk0XUtsK5D1Wq08uOdqsjngbxlLNq7aFoAT5Gj6fs7ysFj8TtSFnq9du2X79ZTiUSbu3RbXJvgQj52ziKNXOcfZf2IKe6Gp6/7owsECDyv2+hdfKGH64OrQxn8JwCuRCUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133255; c=relaxed/simple;
	bh=ry+fGO3yHc6lqCd2Gx1oTBu20MG9Vp3mS7DIriwKxGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=X4UKXl3wLqpptHu5YB1NKaIBkv8JnZd+h/iQMsQx7DVOY4Jo7uEzG17pvB9kmeYX2cKusvBaTFhGlKaCyZQ66tFsDfj2WgA+3e66hLTBCeobx9mUcy0FfWqY7ny+s2o82TiBserKdj4Ci7BkKcgyGBtao1m99jIv1i2wDeewK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PKD7DHHc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrLYJ0Ov; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PKD7DHHc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrLYJ0Ov"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C338EEC0237;
	Fri, 11 Sep 2026 09:27:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 09:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133252;
	 x=1789219652; bh=XVhYhypup6yy4ydWG+LHeKel3ctfVjZgvM/sKIaMfx8=; b=
	PKD7DHHcctEInN8zYADyP8Apwhig/qcOs+YQXo7HOW7s/vkWfvVQyVz0zmB9R0n/
	58ZTwZM+nGUkrrDb8cs7oNGUts0XcLb3hhqhsrl8/vrNX6QSQub//l/7l5rZ9NlX
	1UsCGWt76llw2Yiqjp5SC7eTzbujXJtauQ4/qh7wXjV8p3ygl8pyVEkU+5z8Hs7x
	eUWiNZxrS294CTc3zCdLlk2DG9Al3XIQOQ2xelidz6zq6kfyDKFNwix7/n3J8AR5
	FXa6V/F6gCCxNmD5bhVcOTW+iwpgcE0iiHEImfPELoP/OSwi0tXpRTADfyfWVwGg
	hkKeKOJ9gID/7uxRpsbfLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133252; x=
	1789219652; bh=XVhYhypup6yy4ydWG+LHeKel3ctfVjZgvM/sKIaMfx8=; b=P
	rLYJ0OvXDYtFLjua63v3RMifrXZ2V3fu8pvHpR7lElIX4Icc26BG9K3r3e39nAYs
	rUT7JiJMxnZlvDyPA8FCdAEL/ARmFezFboNOJHhTBkFrySz49AKubNZcswcVeFai
	GgxLF9ABQOBfV6rUc4A9rpx4nhXI3Zk/pIFjv5B+uRswMua0zlLobWikBLl5Qnl6
	PzYdL1Mna1x4n5Gh1YmfSVdU0VnMGaumkClI080swF+oKb4eZk2Ce+iY+XktEdio
	SNGZxJoQQ6wjWeXUko2/UNlhKJWHY7kLVaR2DkqjHb6SZJ46lH+ZQonmWPCAJwq3
	tceT5l140lUG9ct/gZm1A==
X-ME-Sender: <xms:xAGkantsUI2NjHZrdDE45iG9AWHcmXWfSD0hG-JEsKfuRiSfwZN_kA>
    <xme:xAGkav6p6sl-iIO2Bnb1vf9yi6fOk7vdAMiWUL38j2nMNwcwr1-0hZ8mLb-G39Xxq
    vJ7Te5yvMl3hLQueP91oFfDO1Eolza-u0ZTL_-x9J2t3TvwB4j4TQ>
X-ME-Received: <xmr:xAGkaoKdSvxqe12hEwfqclyi32ptUrCA29cNHtnp3PMf6KEcEe8nTtDYGi6ES_NDBnV4RQ>
X-ME-Proxy-Cause: dmFkZTFXLxuxAN40c64lPC/91HIftTfXI3xNfY4j31w8//knh3ykfD/uF45FO2skYZSNU/
    hBVEAtBA68GaI1HuNzQIYnyMZHdvuENuNWHpa1mA44eHwMVKWZj79EQJ0gEgXnNWAT62zI
    +98KxxK88NX1qaVVO54GIHNuMposO467C382gvkjmsRS0402gqtBYIB8VEEpOIgi/ls2au
    fuxQTNYbQllknN2jxI6Nyj7GQj9/sAPASfCtgAKQ+tZ1Fvv7yWxOmFN5Ewuuzc8d9boCIC
    ZaDZHmk3I9F/JI9Tq0V3Q98CErLLFQRPTcYLMlwqvDCEZI0+DVVFsCm6ls2d8A0+jDVyU/
    E83HHe4s+J6Nt+WIdyGlTZdUWysPPHbJIPlcHIOAnYth//C3sz+JUFD6k/4Z0FIrY0ltss
    qlr32q7H5KvNiOx28FAQTno2lntjBfahE2LbC2h2CUcKNfbF0NYyEnnbLiib82MPHL9K9W
    REZmNnS7Uo8Cjm8VUx//EOi0gq5IXF2TzLFb4MZr7aEW5FUqm815OWEqFvq3z9VynG89pS
    UOHpkMr0fgWvSMlUkU9xvoU28mAweVbEwkxLuI/IliP3sDmyixTdpaWbTwQKDiZA4c65oC
    hmu0Nr8B0IJ4cFcbmIKlUdNDhI3pX6HkR9h3FfQnMKD9EAbWLLrtLsp+G7Dg
X-ME-Proxy: <xmx:xAGkav5f6k2PKf0iSAhV1qc_uZOEJWN3sX56HMCBC82vevqhjiNcLQ>
    <xmx:xAGkaryOkutqCspQAxFvUyuC0JKbkkmtbORFiHKNskROxZpGyhU7VA>
    <xmx:xAGkajYvhaEt0RfpVajaBmNVj1SdKjaNNauiPp4FZWG7eFwV77VKkQ>
    <xmx:xAGkatSnujWXUw19qz67oPkTDzvwQRvAPXp0TiYiT7jxj1p_DL-hwQ>
    <xmx:xAGkar59kwfuTjPMtgi6giafDvMiNRhWTFYS_2P1w-MSIShBbzjGLgc1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d151113d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] odb: make consistency checks pluggable
Date: Fri, 11 Sep 2026 15:27:24 +0200
Message-Id: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23N0Q6CIBgF4FdxXEcDFMiueo/WReBPkkscKKs53
 z2w1rrw8mznfGdGAbyFgI7FjDxEG6zrUyh3BdLttb8Btk3KiBEmyIESPHQBu0bh4CavAZugOwy
 ikpJpCcANSsvBg7HPVT1fPjlM6g56zFRutDaMzr/W20hz7/vA+OZDpJhgJblogCjDKnNKrb19o
 MxH9geUdBtgCTC1ogJMVXOpfsCyLG8gOacPBgEAAA==
X-Change-ID: 20260810-pks-odb-source-fsck-e64772c7ee5f
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Hi,

this patch series makes object database consistency checks pluggable.

This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
with the following two dependencsie merged into it:

  - ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
    `alternates_db` field, 2026-08-17)

  - ps/odb-pluggable-pack-generation at 5176dd3d05 (bundle: generate
    packfiles via the object database, 2026-08-21)

Changes in v3:
  - Move check for `ODB_FSCK_FULL || local` into the "files" backend.
  - Ensure that repo settings are prepared.
  - Drop a mostly-useless `ret` variable.
  - Link to v2: https://patch.msgid.link/20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im

Changes in v2:
  - Some commit message improvements.
  - Link to v1: https://patch.msgid.link/20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      builtin/fsck: use `fsck_obj_buffer()` when checking loose objects
      builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
      builtin/fsck: de-globalize option handling
      builtin/fsck: don't check alternates with "--no-full"
      odb: provide infrastructure for pluggable fsck checks
      builtin/fsck: move packfile verification into the packed source
      builtin/fsck: move reverse index verification into the packed source
      builtin/fsck: move bitmap verification into the packed source
      builtin/fsck: move multi-pack index verification into the packed source
      builtin/fsck: move loose object verification into the loose source

 builtin/fsck.c                | 296 ++++++++----------------------------------
 odb.c                         |   8 ++
 odb.h                         |  33 +++++
 odb/source-files.c            |  16 +++
 odb/source-inmemory.c         |   8 ++
 odb/source-loose.c            |  92 +++++++++++++
 odb/source-packed.c           | 117 +++++++++++++++++
 odb/source.h                  |  21 +++
 pack-bitmap.c                 |  26 ++--
 pack-bitmap.h                 |   2 +-
 t/t1450-fsck.sh               |   5 +
 t/t5319-multi-pack-index.sh   |  13 ++
 t/t5325-reverse-index.sh      |   8 ++
 t/t5326-multi-pack-bitmaps.sh |  10 +-
 14 files changed, 396 insertions(+), 259 deletions(-)

Range-diff versus v2:

 1:  099ad8ddcd =  1:  575a49f5a1 builtin/fsck: use `fsck_obj_buffer()` when checking loose objects
 2:  4e223cfab6 =  2:  71040c9b34 builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
 3:  108b522c55 =  3:  adb2e035ee builtin/fsck: de-globalize option handling
 4:  c686809406 =  4:  68d143fc9f builtin/fsck: don't check alternates with "--no-full"
 5:  a82a1a8ed2 !  5:  bb785f4f00 odb: provide infrastructure for pluggable fsck checks
    @@ odb.c: void odb_reprepare(struct object_database *o)
     +{
     +	int ret = 0;
     +	for (struct odb_source *source = odb->sources; source; source = source->next)
    -+		if ((options->flags & ODB_FSCK_FULL) || source->local)
    -+			ret |= odb_source_fsck(source, options);
    ++		ret |= odb_source_fsck(source, options);
     +	return ret;
     +}
     
    @@ odb/source-files.c: static int odb_source_files_generate_pack(struct odb_source
     +	struct odb_source_files *files = odb_source_files_downcast(source);
     +	int ret = 0;
     +
    ++	if (!(opts->flags & ODB_FSCK_FULL) && !source->local)
    ++		return 0;
    ++
     +	ret |= odb_source_fsck(&files->loose->base, opts);
     +	ret |= odb_source_fsck(&files->packed->base, opts);
     +
 6:  166d9ad073 =  6:  9df4ebd53e builtin/fsck: move packfile verification into the packed source
 7:  83f1b18308 =  7:  b7b28d2ab4 builtin/fsck: move reverse index verification into the packed source
 8:  a760738e7a =  8:  e0efbab606 builtin/fsck: move bitmap verification into the packed source
 9:  f0acd3bdff !  9:  5bebd3fded builtin/fsck: move multi-pack index verification into the packed source
    @@ odb/source-packed.c: static int verify_reverse_indices(struct odb_source_packed
     +		       struct odb_fsck_options *opts)
     +{
     +	struct child_process midx_verify = CHILD_PROCESS_INIT;
    -+	int ret = 0;
     +
    ++	prepare_repo_settings(source->base.odb->repo);
     +	if (!source->base.odb->repo->settings.core_multi_pack_index)
     +		return 0;
     +
    @@ odb/source-packed.c: static int verify_reverse_indices(struct odb_source_packed
     +	else
     +		strvec_push(&midx_verify.args, "--no-progress");
     +	if (run_command(&midx_verify))
    -+		ret = -1;
    ++		return -1;
     +
    -+	return ret;
    ++	return 0;
     +}
     +
      static int odb_source_packed_fsck(struct odb_source *source,
10:  d140d15980 = 10:  f0f00e573a builtin/fsck: move loose object verification into the loose source

---
base-commit: 6b08999fb1b3ad0bad04d492dc206ad42839e274
change-id: 20260810-pks-odb-source-fsck-e64772c7ee5f

