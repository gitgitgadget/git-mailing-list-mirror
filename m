Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278F4283124
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203957; cv=none; b=JyGlbv3lRVzPiePhJ/d33Z7nSf/5bBd7MoHUC5qOYWk7XW9nmZTKY72usJP1J+2LpBm3MOIgyVelC8jVAlD2f9PyVkef0TUet/OlDpCm1Bf+43oQEJE8+lQyfjlLjlW1n+GnDOm2/DX3keeX2dzNg+5lLoB7iWXso352sd2mRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203957; c=relaxed/simple;
	bh=k0KSncLR1tThu47jZaX4Smct3it0qK23trzD2SPb58E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWHWxXbnGHhzptAzhtdvFqY4MTzWBu0KDPa2aQKFpV5OVGu5oGipUHX8erYduwoBepEO/npEccGXiXBKKBa64SR0IEYEz885mO7aOQCRODgy8pHNL8GyJw6PkU8B1UvSHgZ64zm4FbukAkvMx9WMpORBEVcdvESbxWBdSvrncRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lhze5Fnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmHqvKjw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lhze5Fnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmHqvKjw"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 593031400350;
	Sun,  3 Aug 2025 02:52:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sun, 03 Aug 2025 02:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203955; x=
	1754290355; bh=W00T6IDmHRYt+V4GuyvnYJvgYZoFoZn52XosrHATz3g=; b=l
	hze5FnfSFfTwInlw2g2878l6NJNJnpwElhgJ2GeO0o6XGw1xKRiW6mTIlzsjVovS
	ObOxA84plK+UXlE004l+79/wweH7HtXdw4eS9hFDMoEx42oo/+fcxLbN0vGb52e+
	OSkCTJ5bYLGaP35jHNugatZI5fwaH2aqx1Q9Q1LiURjaWxZr4uNvWyo9ruoOgHQh
	6Pdsa+ASQz3csg5C3BT3Q73lYx6nFpuItM2ZMsUJD0AArYDIo+ud1BYAcGiRiID7
	x2vWecE3VwTbPsTX+DZaW1N3y9CB1vXOhydvK5vAiYU00PEHXJVbKamHU0Lssdoc
	bai6feJdBv/rNSgFcLPHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203955; x=1754290355; bh=W00T6IDmHRYt+V4GuyvnYJvgYZoF
	oZn52XosrHATz3g=; b=VmHqvKjw9LGqLt+lVfUk9UmHYBKp/8MEPJsGpOgQor1u
	JxvYFVFZbqIkDgcYywWT0FMJfDdDnf56bblnwhnT3x4OzIAn9PGRib/l5V0+CuoT
	bPskjyG84RCf995d/M27gQja+F8r1f7dQIOyCFZtPLii6GYdi0cybLQj16pcoZ36
	KXCVV/dLlWw8uiuHtrBVbe+cW5qJEa8Ej9iTJZ/kzifA01SaGdyFgXuXlW9UqDKE
	BP+P5cNRN0zH4VnSYzPr+TtqQ5ConTKDymxlfF6HK2l1ZXMtG8OhZ9ayvOYeP+7z
	R+4W+cb0TXgpzzIr9DjomF8Ue6PRAXgbnyDMAuRa8Q==
X-ME-Sender: <xms:MwePaNth5PSopfgJnVIiioVzfLuXbtjImMk7yQiWt6fJVPT-4nJKTg>
    <xme:MwePaGpiVcnb6iHm_HhTwfCdzzT815L-BIcytzyjXVETWKOQGwJFMSgSv-5zlSrG8
    8FpiwbgjuuStA22iA>
X-ME-Received: <xmr:MwePaClsWD13aMUnKq0AXmQ_DigwFLLLfKJWcA-dGxjjFFqsfaObXfNHSkYwG2q5u-dwRLOHB2kx8Cw--4ixqATCX8j-3ZFaJs_oi2U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MwePaCxhZb0tGs4PZWHxo1xFIqUWPsrGLYFYCkG1awwH0irlxLol1g>
    <xmx:MwePaCnTnxMuuZpIvXoFK_7yrjvsWzZrh6Lr7MLkZsQv-4h9Z-flsQ>
    <xmx:MwePaDdxJAaxwc57e-zvCtG2ZDHemUcdUK2qgO5Onu9Bt8y-C6I-LQ>
    <xmx:MwePaAqWwR0Jw07RVr8GHMAIaLf79foKCNPlbVxouvskVI8tumD1LA>
    <xmx:MwePaARnKrKOQOKyio3mB3NHjE3tEsE1cc0CP0NzO0Gu2bEIgRyyFlgL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:52:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 7/7] string-list: split-then-remove-empty can be done while splitting
Date: Sat,  2 Aug 2025 23:52:23 -0700
Message-ID: <20250803065223.3325111-8-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065223.3325111-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065223.3325111-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to the new STRING_LIST_SPLIT_NONEMPTY flag, a common pattern
to split a string into a string list and then remove empty items in
the resulting list is no longer needed.  Instead, just tell the
string_list_split*() to omit empty ones while splitting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 notes.c                     | 4 ++--
 pathspec.c                  | 3 +--
 t/helper/test-hashmap.c     | 4 ++--
 t/helper/test-json-writer.c | 4 ++--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/notes.c b/notes.c
index 6afcf088b9..3603c4a42b 100644
--- a/notes.c
+++ b/notes.c
@@ -970,8 +970,8 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	char *globs_copy = xstrdup(globs);
 	int i;
 
-	string_list_split_in_place(&split, globs_copy, ":", -1);
-	string_list_remove_empty_items(&split, 0);
+	string_list_split_in_place_f(&split, globs_copy, ":", -1,
+				     STRING_LIST_SPLIT_NONEMPTY);
 
 	for (i = 0; i < split.nr; i++)
 		string_list_add_refs_by_glob(list, split.items[i].string);
diff --git a/pathspec.c b/pathspec.c
index de325f7ef9..5993c4afa0 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -201,8 +201,7 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 	if (!value || !*value)
 		die(_("attr spec must not be empty"));
 
-	string_list_split(&list, value, " ", -1);
-	string_list_remove_empty_items(&list, 0);
+	string_list_split_f(&list, value, " ", -1, STRING_LIST_SPLIT_NONEMPTY);
 
 	item->attr_check = attr_check_alloc();
 	CALLOC_ARRAY(item->attr_match, list.nr);
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 7782ae585e..e4dc02bd7a 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -149,8 +149,8 @@ int cmd__hashmap(int argc UNUSED, const char **argv UNUSED)
 
 		/* break line into command and up to two parameters */
 		string_list_setlen(&parts, 0);
-		string_list_split_in_place(&parts, line.buf, DELIM, 2);
-		string_list_remove_empty_items(&parts, 0);
+		string_list_split_in_place_f(&parts, line.buf, DELIM, 2,
+					     STRING_LIST_SPLIT_NONEMPTY);
 
 		/* ignore empty lines */
 		if (!parts.nr)
diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index a288069b04..f8316a7d29 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -492,8 +492,8 @@ static int scripted(void)
 
 		/* break line into command and zero or more tokens */
 		string_list_setlen(&parts, 0);
-		string_list_split_in_place(&parts, line, " ", -1);
-		string_list_remove_empty_items(&parts, 0);
+		string_list_split_in_place_f(&parts, line, " ", -1,
+					     STRING_LIST_SPLIT_NONEMPTY);
 
 		/* ignore empty lines */
 		if (!parts.nr || !*parts.items[0].string)
-- 
2.50.1-633-g69dfdd50af

