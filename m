Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A3645
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763276583; cv=none; b=MNgyQ/G18QYiokQxytKE7A0qv0TIJHEMsJeKquDts91JsDMkbSosgQCGrU0QfwfbOsQ61n7S98XYMer/uNuSOjsHejyltE5iWEQEoh/sIfdsKGrCMtMNX2QDX6SmWgLB2NqAii0L9Rzkg70Z/FLyPBeKDYWymrKrHDDElLe1Zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763276583; c=relaxed/simple;
	bh=zMIIBQDRKa1NydroKH1c40tzq+1qlaSHaaa8PXizPrE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WUljMVzsBTN1yBq+jB0UBoh2jItBF+uPSr0BgMqLThdcbWwWsD7/4gr1WxQ2VtVkv3/jfAjmVt8Jy0uXwxCuXDs39sEk5cEicSbKc3nTQnKIz/JR7x6p61MDlUC4rJGDxYANLlgg03oD98BcZVgQspNQrwzqAnXM1q69X9NGILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Os9lKZMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMCy14EM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Os9lKZMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DMCy14EM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6342D1400094;
	Sun, 16 Nov 2025 02:02:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 16 Nov 2025 02:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1763276579; x=1763362979; bh=OPUtcjSczmebVKFWSKwTcRGYsREm4Z2L
	nk2g702QyhI=; b=Os9lKZMHg0bbHTIf+KnyNIchxMkCE0PdchpL5QVm6VIjuGNU
	NQHMUzYVO/20EPh5V0ewdrNARSAig70V8OFgYl8DcDrO1sh8VozC1semOCwEaPzS
	OD1rJQHeoQESazQ///zU1zBdWi9JiMfwG63cHbP+OaI3sx4Hu7ctgIfraIPGdeEY
	QNqOwR8HDvlUPxY3ZK8ptM/6fPIImE8cUJBoo0uOT4FOjcRskfyOvHRaxR0P1oct
	Gygn7f1Tz05/E/0pU9gmnzegAErzGHJAyQt6wUzKUFt69wK5GSC+yHyIbX8ihLDn
	UBH4JC9VEvc79wvU+5sTPupPEd2VqgdiQaDS2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763276579; x=
	1763362979; bh=OPUtcjSczmebVKFWSKwTcRGYsREm4Z2Lnk2g702QyhI=; b=D
	MCy14EM0LOncuTgr9Zt//v55GzU5rlOxE8zS+Hs3Y+R73R+bv9UuBU/P09CVIS/u
	0BCQSQNaYzGT1jZUjRPBGZOuO41FAR9C+9VypsjIF+YWtljS8zwVZaUwpMwsqRAZ
	RT4BRcheD9MQc30ibMVMCvEUNKWcC55uKhc1UI8gATqwo34aRkXBFlaH+I6c4xLx
	cbW2SkedxyutcxhBkg3ybkY7ecaCn84e2KdtFBIwhXWZQt9/9/IMz+aTGlxGb0fU
	e3ILdquss86FWwMKeWPEyYDK44I2iKZv5yXs3TgkM/18lTnCrI5AaMTyAsG0pbmd
	3AkHEKxf7I/z1N26KeEdA==
X-ME-Sender: <xms:I3cZaWVh1FtBbCHJtuP1U16JBUY1MFaniJTjCPJg7GdJkDgz5I0Edw>
    <xme:I3cZaaAt3PlvOQawEELtT3KI_Yj2fsIxfY9DnFWnbrnyyzDqmsPli5JWnFv4t7Tl0
    M00yBy-zkNyZ92au8vSeI57BS2fB3zVRk1I66-3SZudR4piIxp2AA>
X-ME-Received: <xmr:I3cZaXw1uzemyExhsQ4ztrHq7dNPLiTW8Y9EM-y16Cfvuj4efrmVEsKGGOLX74j4lXZeWcT49aSAf2viA_QyswtVnvHlUSn2eHOx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudegleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvufffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeelvdeftdeftdekfeeuveelgfelteeiueffffekhffgkeevheekhffgteejhfffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I3cZaXCx3aud31yoyX-m7TLxBjFFRi8JCP8SdZ6cNPJJzzC4VFUTtg>
    <xmx:I3cZaUaocHiZJ-njQBsxPtXzFf8jIO5Gv8fzYirmw6uiYKNlHjm-pg>
    <xmx:I3cZafgKQF5Wzuq-MxZBRAyz5cCenU4KIu2lPD_wxppc_L6hfFHvrw>
    <xmx:I3cZaW6FkkW45yHSFgkOkl_d7XCo80d9J0LXVIc00GzRAXHG3YkI5A>
    <xmx:I3cZaeAfTzaY5K7bvM_-gir96nkeEoobEEbtN7JX-pdxHonIJ0KgIevP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 02:02:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
    K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH] submodule add: sanity check existing .gitmodules
Date: Sat, 15 Nov 2025 23:02:57 -0800
Message-ID: <xmqqv7jacvdq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"git submodule add" tries to find if a submodule with the same name
already exists at a different path, by looking up an entry in the
.gitmodules file.  If the entry in the file is incomplete, e.g.,
when the submodule.<name>.something variable is defined but there is
no definition of submodule.<name>.path variable, it accessing the
missing .path member of the submodule structure and triggers a
segfault.

A brief audit was done to make sure that the code does not assume
members other than those that are absolutely certain to exist: a
submodule obtained by submodule_from_name() should have .name
member, while a submodule obtained by submodule_from_path() should
also have .path as well as .name member, and we cannot assume
anything else.  Luckily, the module_add() codepath was the only
problematic one.  It is fairly recent code that comes from 1fa06ced
(submodule: prevent overwriting .gitmodules on path reuse,
2025-07-24).

A helper used by update_submodule() seems to assume that its call to
submodule_from_path() always yields a submodule object without a
failure, which seems to rely on the caller's making sure it is the
case.  Leave an assert() with a NEEDSWORK comment there for future
developers to make sure the assumption actually holds.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 12 ++++++++++--
 t/t7400-submodule-basic.sh  | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a1935cbe..1a1043cdab 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1913,6 +1913,13 @@ static int determine_submodule_update_strategy(struct repository *r,
 	const char *val;
 	int ret;
 
+	/*
+	 * NEEDSWORK: audit and ensure that update_submodule() has right
+	 * to assume that submodule_from_path() above will always succeed.
+	 */
+	if (!sub)
+		BUG("update_submodule assumes a submodule exists at path (%s)",
+		    path);
 	key = xstrfmt("submodule.%s.update", sub->name);
 
 	if (update) {
@@ -3537,14 +3544,15 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		}
 	}
 
-	if(!add_data.sm_name)
+	if (!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
 	existing = submodule_from_name(the_repository,
 					null_oid(the_hash_algo),
 					add_data.sm_name);
 
-	if (existing && strcmp(existing->path, add_data.sm_path)) {
+	if (existing && existing->path &&
+	    strcmp(existing->path, add_data.sm_path)) {
 		if (!force) {
 			die(_("submodule name '%s' already used for path '%s'"),
 			    add_data.sm_name, existing->path);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fd3e7e355e..9ade97e432 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -48,6 +48,25 @@ test_expect_success 'submodule deinit works on empty repository' '
 	git submodule deinit --all
 '
 
+test_expect_success 'submodule add with incomplete .gitmodules' '
+	test_when_finished "rm -f expect actual" &&
+	test_when_finished "git config remove-section submodule.one" &&
+	test_when_finished "git rm -f one .gitmodules" &&
+	git init one &&
+	git -C one commit --allow-empty -m one-initial &&
+	git config -f .gitmodules submodule.one.ignore all &&
+
+	git submodule add ./one &&
+
+	for var in ignore path url
+	do
+		git config -f .gitmodules --get "submodule.one.$var" ||
+		return 1
+	done >actual &&
+	test_write_lines all one ./one >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup - initial commit' '
 	>t &&
 	git add t &&
-- 
2.52.0-rc2-455-g230fcf2819

