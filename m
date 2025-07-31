Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7C26772D
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001983; cv=none; b=HeFdgonWaMhRU8JsCu/wpo1RyE3pGukV9FjPJ/+PUvN0eZweOvglBUULuwO1xuGcAGwYIFoTsmPYsxHMYSYPBZVA9TMz4fhVyhy+SzjMDZFAytKpexV6AFnzUwr6Zql68u2Uy7wlwMBxiL6Qt9qFxkm2mUTURsq3wztiE6JzS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001983; c=relaxed/simple;
	bh=TrJmQIKmFORWnp+kVHVaUmNmOBCHHxhiqOVyx3HMmQY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCbxDnBb+UIYPqpdXRMas5p/9bdQAHOoiBy/vEqz6WDBEuMp3VemnekcpIreImtsWHwW92WtARak1tC2+tfC7rFObYtDP+ffENH1Py/SvRj/PeHVoW6iTkLpo+fd3ulb0F7aRNWeCtzfiPG8gnPSkSK5Gn5jUZ3zGluGaDXiyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EXHzTOgd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFsuMpQI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EXHzTOgd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFsuMpQI"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 00DB7EC14E0;
	Thu, 31 Jul 2025 18:46:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 31 Jul 2025 18:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754001978; x=
	1754088378; bh=+ZSh2gji3Qa++N6idFB40vhcar+E6too/Tdf0tzwUWc=; b=E
	XHzTOgdiaOSPh3rrnv/cZ22kG6pxqhRNj1ze/klyw68KBKfaXmf+eZdqNCHT9Ug6
	Hur1EpnFxvE2m7RVWcu71gn1+b/c9FuKoyDuWK6N5i6ozpbgZQoobcTiaMRfSXDA
	aMBS3jhKJmi7dGuiUlcho/TxJN99oymYw3orhtkUg5cwLXRRu9YgaZulEcMLjoC6
	GfzhfOwFTFqhTDYjyH5kQzJgj+Nk8NJ9Y4BTOQBmPx+rw6qYWW29eZ7Y4w0qfj4u
	KLYNIxH6aYNCXx+OUL2hK9szfOYejZvQRdM5CtyUygrU+c1ixIjIuecoDJMGpv+p
	IF/RGwoB6umLNG3oYaNmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754001978; x=1754088378; bh=+ZSh2gji3Qa++N6idFB40vhcar+E
	6too/Tdf0tzwUWc=; b=NFsuMpQI5twh5PU0N8zHJvQWxluMquVEbZ7yc1kNqc1i
	jtNfJdapsP1X3StF+bme2oHn9EwnpihgOwv4boI++dZMqeUFKd8+KGrlbKk3Q/t3
	ZjBKSxE9bdmDcKpctQU3B50Tg4uII4f191cWH3Stc/Iz+B2x7btmfTCwoXIANIBb
	Pt9CbbReOGehlszgVCpDHWV7fyKtqbOyPwxazZ+ykvF9o+uRPtFsj4ClgImKV0au
	DIBx4Vb5zJDVQ1rIeIf877COVpsZNFNwHv2Tffa00tpfsgNV8HTfAz0sN03YghUS
	/16znoRme3sSVgQiJkCTOJ8KmLbR3Q5iLa9ohXGesQ==
X-ME-Sender: <xms:OvKLaJuqkEh_nvE7K9v58U8LdaBWlnOnAm4sRSTVpd2rGCmpdOyXIw>
    <xme:OvKLaCrcDMSOxD8xHNp99k7U_UNyIBUhKtjhTbN-TI1hHnKEER1AYQO9csGyOd60B
    SXCUoh0TO7JNsT3Wg>
X-ME-Received: <xmr:OvKLaOnC2ZHpWPvGfe4CgPNRpgs4oneJcOJJXNDgdzYYbuhVPJluBelYh8pmEF5tR4ZLEfG1dUUVKo6pOk4Unfz5d1gyrkEPvr44hjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:OvKLaOzQZ2X1ckXpnudx0kInguYkOV2nQQo9J_SV_0E4-9Rjvf9wJw>
    <xmx:OvKLaOnnD1Ihn0cCNHfEPDlhl4nrOlCQi7ihCPNlDkbQUE0zrZ1Q_w>
    <xmx:OvKLaPfGge9qfBHT7qIW2r2dtPNADvRC-HzgLfS6jKbDZf2m00B0HA>
    <xmx:OvKLaMqYieIQFL5xFQUa9uBDn1t6DSm24Q6dnJwrRSq844Uf1YVAZw>
    <xmx:OvKLaMQPaitkY4lPlNOM6TdIofZZp99D0Tpa6GfwqStii6COK0f7fGBx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:46:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 7/7] string-list: split-then-remove-empty can be done while splitting
Date: Thu, 31 Jul 2025 15:46:06 -0700
Message-ID: <20250731224607.3942417-8-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731224607.3942417-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
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
2.50.1-618-g45d530d26b

