Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0E266B72
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073678; cv=none; b=PW7SPVjGFlMT30yDecIw9p3L0uhTYj+r5sxXZxMAvnKVl2G3Q+MfQ1d2Qv85Zihjey6IbeGcu1V5Q/zvnInkmkrZdpLqjelv09s0jDRHWyA9b2VgNAfxfu98WngpHIr7Udr8xgBX1snD8A/e5XvJz4UsRCsbR4IKXconB280gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073678; c=relaxed/simple;
	bh=sH8KouLA29J7/iLzwMG0x0g8Xf8mrL/6RtzpYMkxUhY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=iS8RDwV0jTJAUdTYjSHiujzb/ZVuwggT0U4+Lg2PUCn1KNcT1iF++EnrWSqTeEfcZUF/uLnrv0QknayHdFe7OiqypZ7G32fCCznRpV+UIRHmkiPGBxUoyj2kMyv2Oi7wSG0temUigaMB73byGFMKS3OQu08OBya1tnxywSKS8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q7adYKdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6STFYTD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q7adYKdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6STFYTD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B74C14000BF;
	Thu,  6 Aug 2026 23:34:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 23:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786073675;
	 x=1786160075; bh=QrqHjONG5ZMN8cdTK5KNN+PgPlDVJfpwTWYxBe6R7e0=; b=
	Q7adYKdQgJp1wKVf06s0iBvg011/N4EhbR2lgHLscQ+yDg9cFJC7omAME2a3pbkC
	OdAao3DLKkGqlEwX67F9qtI/wtRGgJi9NxUS5r11bMRFghYPBF7w0xQZ/pow3v65
	NTUdz+cI7p5ySoNRJtS7SUX9iBRCRysd0LAW6Jy1GHVJvBWEbbvUBG8912BC9pf2
	thr8khWw6c8d29sGTc4v7/OU5fioWEwNC8F+9oWVnoAeWSe33FDRZs3FCW1xn9a5
	9T8EpqbwfgdeL1I1YEpW3d740dKbelBE6sn2XQrkYer7ytYwsRUG101wr/unVkg1
	1pv7yDnXgnLcyQ1XYbSRWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786073675; x=
	1786160075; bh=QrqHjONG5ZMN8cdTK5KNN+PgPlDVJfpwTWYxBe6R7e0=; b=T
	6STFYTDwH+JI2zBM7cZaGGKau2HxNtvQXXpgvXq/uea0R4cu3e5ngY2jQO4c4c6K
	Ew4bO+6Z8/pRLIU/SKt2p3cNXRj/AuX5RxF//sF4ZgstB6TJGubSy1uTEqUKY1Hb
	PvJ8MvIt+8NoUpkq6Qsg8UZCiLyU/UBzJMi2yybMlgFfsPSOAoo9ow6cFWPOjEex
	1XLFLQ4+E/tkH1GbuIWVsvTqWry296SogxgUlAWWaq8JMmQ5xjioHUnesrwknLvZ
	MyAcajXTD/kdFU5n5yhox8HhQ4mIiVcnHR/U+fpS91owzInwOoTXB7ybRKq0LFYk
	xD5VYLLt3RgWFyB6G9SVQ==
X-ME-Sender: <xms:SlJ1atCIxGHKEa9lCEQPMW84GOdVVq38OMEPEBEkn_VlZgx8Jas3Gg>
    <xme:SlJ1amEuQyGPd88QFt9P-JKpNs-wUxD8U3VM8cWoqQRBiLCuknjmxcTPlaKsimD6L
    pOOY6Qz2DWnjGJRwBxVehdcJE4RbPhPs8jQSxkTRHtrbT1jb0Ippw>
X-ME-Received: <xmr:SlJ1alLz0T0VOYpAZ3HLkzFPqxHDafr_FldvQ2kfSuqZZG9q-5bG0w4HiqErypuarGd4k0WkLB5avf-Wz5TGo810xMAD-rJQupF1Sfoyvomixw>
X-ME-Proxy-Cause: dmFkZTGA/cKQbkeyWRDyPWmnanBCWu9s3oYeGXVL1mJX+jPBNhIfSCm0rlelEAlLCXYzqY
    WzwieOKgjfXpyct/PrQ3jqMJ9n9wuRiTkdW9gddnK2cOadFFLWg4X3fSTKcdRK3e48NQU/
    FdVS1Hk5vhhv9RtK+rAyltok3H2/HBO7wRWgem/4fN84ffzBqJzr3JDgHOx7s5qTu0kPQQ
    eqkxK1aZH/26hjjL5eZiuVA95fEt8nnk1Ny1FCiRvU8ts38JyPCF+UEY/5/iglo4CBi8AE
    AoS3ZdV/ghz+k5xxUbC+Z0K4xgh3FsfrfpiNEUjpX2jxrZYrklNnGttE2vuthIdLr3Z1q/
    xBJLjg14OYzW1gn7joQlFJHRDQ3LuL4ifB0+r178VUwhORlMfAgy8duFOl2cM6c0OAsdjU
    ehKK9HW2woEO8WxsNCxuxY9d3sA22yydqBhi50sG8+PF7t5zQqRYArGZm+akrX8kYxO1xL
    D1sQmoRCU2fSG/7GhD3Kr1RTQJVvEJHS9I5+dWtOL2FTKGzxOYk6rSSzFaVw2FgC+j7RR2
    lz2JBY68LB4MyVlNwqOKLn55H828/e3tppuktJNYD5uoRRccosMq/WC6yX2fR7/FlRubI6
    B8ciidEMr6i4bzJJT43AZ+j6t1CyIIUlFPYl65xhwtdQWjBG0HfvRcIldaRg
X-ME-Proxy: <xmx:SlJ1aql72QtP0asMJE07Yd3AeATXfEhvZAI06be_yFQ75J6tDx_beA>
    <xmx:SlJ1atTKFU02-UcO2SkxWX5RaW-ngTgwWa_JUGr942PE89VlLG3zlQ>
    <xmx:SlJ1asLn3MHjnV00Hov97ohDvj4lZUFEoPJE0WiRTST_UxTfARmX8Q>
    <xmx:SlJ1ajDgSwHaxUsiv3Auj3tdHhZZykoa8waF08D8SVrt-ixNpZwBWQ>
    <xmx:S1J1amTYXhmbWVo4nYtM-3L_Yh0XT3tDZt0SySXlL3K66K92cPpw5od7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 23:34:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6563075 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 03:34:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/6] odb: make creation of object database pluggable
Date: Fri, 07 Aug 2026 05:34:24 +0200
Message-Id: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNzU7DMBAE4FepfGaR/+30xHugHmzvhpqKpLLTC
 FTl3XEKgvaQ40gz31xZpZKpsv3uygrNueZxaME87Vg6huGNIGPLTHJpuRMczqcKI0ZIhcJEMA6
 AuZ4gkHfGeSuS7Vgbnwv1+fMGvx5+cr3Ed0rTqq2NY67TWL5uz7NYe78nUm+dzAI4qKhQWoOd6
 +JLKz7nD7Y+zPLf8HzbkM1A7H00XUTJ3YOh7g2zaahmJE6kQjJCi/7B0PeG3TR0M2LwUfeIklT
 6M5Zl+QYzsCpzlwEAAA==
X-Change-ID: 20260710-pks-odb-create-on-disk-ae8757861c69
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Hi,

when creating a new repository we create a couple of on-disk data
structures for the object database. This includes the "objects/"
directory hierarchy with "objects/info" and "objects/pack", which are
specific to the backend.

This patch series makes the creation of the on-disk data structures
pluggable. While we continue to always create "objects/" regardless of
the backend (it's required for a repository to be recognized as such),
the other subdirectories are now created by the backend. This will allow
other backends to plug in their own logic.

The series starts with a small detour into the loose-object map. This
detour is required so that we can defer initialization of the object
database itself to a later point in time.

The series is based on 9a0c4701dc (The 7th batch, 2026-07-22).

Changes in v5:
  - Remove a leftover formatting change.
  - Fix a stale comment.
  - Link to v4: https://patch.msgid.link/20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im

Changes in v4:
  - Drop `APPLY_REPOSITOY_FORMAT_SKIP_ODB_CREATION` in favor of explicit
    calls to `odb_new()`.
  - Remove a useless call to `xstrdup()`.
  - Mark a string as translatable.
  - Link to v3: https://patch.msgid.link/20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im

Changes in v3:
  - Move handling of GIT_OBJECT_DIRECTORY and
    GIT_ALTERNATE_OBJECT_DIRECTORIES into `odb_new()` itself. This
    deduplicates some of the logic and also preps us for a future where
    alternates are handled in the "files" backend itself.
  - Link to v2: https://patch.msgid.link/20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im

Changes in v2:
  - Add a testcase that demonstrates the bug fixed with alternate loose
    object maps.
  - Rename the "inmemory" bakcend to "in-memory".
  - Clarify some commit messages.
  - Link to v1: https://patch.msgid.link/20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      loose: load loose object map for the correct source
      setup: detangle loading of loose object maps
      setup: handle ODB-related environment variables in `odb_new()`
      setup: defer object database creation
      odb/source: introduce function to map source type to name
      odb: make creation of on-disk structures pluggable

 loose.c                       | 25 +++++++++++----------
 loose.h                       |  1 +
 odb.c                         | 21 ++++++++++--------
 odb.h                         | 17 +++++++++++++--
 odb/source-files.c            | 19 ++++++++++++++++
 odb/source-files.h            |  4 +++-
 odb/source-inmemory.h         |  4 +++-
 odb/source-loose.c            |  2 ++
 odb/source-loose.h            |  4 +++-
 odb/source-packed.h           |  4 +++-
 odb/source.c                  | 19 ++++++++++++++++
 odb/source.h                  | 29 ++++++++++++++++++++++++
 repository.c                  |  3 +--
 setup.c                       | 51 +++++++++++++++++++++----------------------
 setup.h                       |  4 ++--
 t/t1016-compatObjectFormat.sh | 18 +++++++++++++++
 t/unit-tests/u-odb-inmemory.c |  2 +-
 17 files changed, 169 insertions(+), 58 deletions(-)

Range-diff versus v4:

1:  40ca0d1345 = 1:  3a0fbf9498 loose: load loose object map for the correct source
2:  d18ddec5dd = 2:  7ba250f4d7 setup: detangle loading of loose object maps
3:  9b6fbc510f = 3:  fbe755388b setup: handle ODB-related environment variables in `odb_new()`
4:  f27f8d45a4 ! 4:  4d7a12e3cb setup: defer object database creation
    @@ setup.c: static int create_default_files(struct repository *repo,
      	baselen = path.len;
      
     @@ setup.c: int init_db(struct repository *repo,
    - 	 */
    - 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
      	repository_format_configure(&repo_fmt, hash, ref_storage_format);
    --	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
    -+	if (apply_repository_format(repo, &repo_fmt,
    -+				    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
    + 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
      		die("%s", err.buf);
     -	startup_info->have_repository = 1;
      
    @@ setup.c: int init_db(struct repository *repo,
      
      	if (repo_settings_get_shared_repository(repo)) {
      		char buf[10];
    +
    + ## setup.h ##
    +@@ setup.h: enum apply_repository_format_flags {
    + 
    + /*
    +  * Apply the given repository format to the repo. This initializes extensions
    +- * and basic data structures required for normal operation. Returns 0 on
    +- * success, a negative error code when the format is not valid as determined by
    ++ * required for normal operation. Returns 0 on success, a negative error code
    ++ * when the format is not valid as determined by
    +  * `verify_repository_format()`.
    +  */
    + int apply_repository_format(struct repository *repo,
5:  1c0afb893f = 5:  6bb4ecc76d odb/source: introduce function to map source type to name
6:  387fe6e204 = 6:  806f399c63 odb: make creation of on-disk structures pluggable

---
base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
change-id: 20260710-pks-odb-create-on-disk-ae8757861c69

