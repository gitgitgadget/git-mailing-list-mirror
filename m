Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42628DF33
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085878; cv=none; b=VZOu6wxyU3enF604YXXZbSP263PqBoVcTTUcEd3ae1q5dMqQ2Te03xqoW20Vomf5uv/jrjwITw34y05q/gl0KFJqhk/k57uQZ6xWImSQuRYKLRK29/niGGhj4fcYqD3Cft5s4RQKcgRDV5CaeZ12V7NOz6KiGdsHWYKqIvv+zbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085878; c=relaxed/simple;
	bh=vVZuGD1t6volBPMFmrPGzM8zu3UK90/BgxZpnwVc+4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYNAYkHQVav2dmKZqDAgNpvUCu5jtYxUq5RZyryGmexNqn7mpnPdU2BeMyBqed0nGAr460LMYQ2Otm3NXHOLZ6aOIBjKwkA7ZwHEDoslxVisPtibF7IIZUgWdOMFs91drMPMakIlR+Xrmhqm0pjrQyWwGx6B2/qbUVyIB6TJHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rl6onXTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHlLkT85; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rl6onXTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHlLkT85"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B09DD140026A;
	Fri,  1 Aug 2025 18:04:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 18:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754085875; x=
	1754172275; bh=PqWFfaIUanW9T2ssSdU/1AbMAijARMd8Wi48rRhv5q8=; b=R
	l6onXTnNdhBKrTFQg5kMM0jFUzg8BGtJq+rWrTeqOfbgJXrh8Bxe0uo2R/k6TeXR
	C0LazZluSNcmZPO0KtxShSZE2ZlBHEAczx2qjwN+VPCMN2wv4Z5kmojj7Z6l7HP3
	NkgYaQclkJOZiXHhS33/DvxrtXPpE13sKdDjBHkWd+IeZy45w8w4j3RezxFsBFIB
	y0SHFAeiouFZUR8v58EXPVD/HlQxfi1i0vNByLRo+bSjUDUpS2XSUdyLfTuSalzo
	e8KlZUw5QFwHf7CQtdMBIzJ7uXjmFVfEbZYpZQcGuiHfoKbvZnQtjvPQzKXaiY5G
	YWC+7pjer9kDP3VMT4lgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754085875; x=1754172275; bh=PqWFfaIUanW9T2ssSdU/1AbMAijA
	RMd8Wi48rRhv5q8=; b=lHlLkT85DRGLd+LUnI3Eguk3Z3DeU2qYnPN25C2JqzHn
	2gHCKNra7psrVRwZB6KolvRrPKMzPGSdR2eEnSqhHT76s4Eb5QuK3ADl/9iVxXLO
	Cco7NzA6YaJ0n8lyPCPDe70HVLkwo5JK1qVuQO+iXMke9J6tBnQDitlGU8lBIMIR
	601bm7DHJ6nRUPvOiEVn/9Ehla6Vv6Axdu1mOAFFD0zmBK580K8JFva0cevhtUiB
	GSk6DiRY23rUZDhdvh79Gji64EE5ncWiEpWRdzDYVTBaG5VMyk223BW/weMIFXfn
	HB5m7OKFU5hmxRbWQck5QyiVQ/8dYMRau/sSy5zh7w==
X-ME-Sender: <xms:8zmNaPU7hARVMcrMNtkfA5zPU_n_kXx8FZ50VLWKbrE_8co6Rpe7Vw>
    <xme:8zmNaHybUKoTi-z-ADnf79Su1yFgEWOJrOipcH9by68qNcgFnKUlICEujHa0XqmQF
    gOf_rsuJIoyOXkvzw>
X-ME-Received: <xmr:8zmNaNPkLfaabEk79WprlSE1UX1CDn51AAIJNGRR9ifxzYrmoDnQhgv-0KxLDydTmf0yK7epIY6vo7VJJIO9a4e4Ebe0J8R65wj-xqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepgeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:8zmNaI59auM_Z0RKESPrD6PlkiITbc1ocrgGN_YQ8vo9tfobEpjMBQ>
    <xmx:8zmNaOP0pAGRr_NdAbSDULn4TZcqHkmqXJSfe7mfzIO7FReJ15JgMQ>
    <xmx:8zmNaGnpGF4Dbe-1ABajWqgsTjN1hl8Osdo3XvrXpZZ6ItCdh34EGg>
    <xmx:8zmNaFSv7V70d-Eu5usWdLtP1phgNx0elU0vsOxS0lvE0WBXvlLv7Q>
    <xmx:8zmNaB5W03w3DpQwHZ3t336eQY07Qid0OeFy3ngC9U4-tbe-xYhgn_R0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 18:04:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 7/7] string-list: split-then-remove-empty can be done while splitting
Date: Fri,  1 Aug 2025 15:04:23 -0700
Message-ID: <20250801220423.1230969-8-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g85c5610de3
In-Reply-To: <20250801220423.1230969-1-gitster@pobox.com>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
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
2.50.1-633-g85c5610de3

