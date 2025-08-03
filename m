Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07C28313A
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203999; cv=none; b=uWXjA46WIaMb771XjhwVdyrRweLkHsFEuG+KKNa0Mi3QysqSYe5FWb4+qYtb2qVa1ZP23omjP1ODUTXB8be0y6CXy8hYdfGwjSQjtc4p1elCOSv8laIv27r2cClNXru9CTJASU99PH+U7KIU9a7rgGHqCaqQYltAxy81CaNz85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203999; c=relaxed/simple;
	bh=DGOEHMtPgD7K6pOGkqG62yp3TAMmaBd+JillDql+SnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf8vpLTAOGN8VSLetWktlCv7m3qH6fOvRArFI/2gAZItuh4Xuh8J4Acvvos5jhNjj9fBep8RlW12MUvp9lHpYGvkBkpDTRVs777ndbykrXL2Bh7bO9lF1qCZWuJRgRGxpPH1cUWqz44BwgmW7VWFExan64axRNn0bBk6Hg8CdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NhuI5ZrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+xoOVpv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NhuI5ZrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+xoOVpv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 88A2EEC1275;
	Sun,  3 Aug 2025 02:53:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 03 Aug 2025 02:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203997; x=
	1754290397; bh=XcVAnwx/5PmETj+zIlaw/igYwZMfjUea3Hecv6ec5Pg=; b=N
	huI5ZrT7CtQbsEZ1Wnm9zkCHOOS9NUlednZpLIfm1eDLdd9yCt6Yr1qyUt/POqzT
	D7LJp9XCw2vs8h7sdVU5+J/v91HUctu09HYNsPAnN5KRUHYUjsivdlwojqvdj1up
	Rh31h9Ymi0liR6HNLyM+Rnp8WdIZmjCXTFjHcPbRkKlHiRM767SM9ri5s5GBSj+O
	hHuY4OfuJBuAvdJsNy7ycpd64Sv6YRXQCs4a7L+Z7In3m151lrfWupmjoZ28QqqH
	KFPHx8B6ZgNSHDzJA5G1yPY1K2zs8rgPVpfn3lStarlABMqAxxGkyOJtF42+qIMl
	hbDtiMVj6e/ialYd1zVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203997; x=1754290397; bh=XcVAnwx/5PmETj+zIlaw/igYwZMf
	jUea3Hecv6ec5Pg=; b=P+xoOVpv6Cj4JWyNOPh6NsENwXZlR9INqU2g2RjzPbIE
	hdzejZLW7Nj60M5Upu0Q+3/3RslA5L43Jq7Gn1RTiW2W+T397niHsTRUv+P+zb2a
	71hCknNdmCKk47GDSoSXupQi7HeHbrN6xkHAYbJa551UVKR2PVOjCgX9hxlV1xvW
	Iiown/pf5P4z+FhL89E5YKr3vO4d9fYDU8aecXr27fe/E8BoVluB94of2q1WcRpp
	eKy5bl6NJoJzl4CKAY89H4a1LudZ5c4I5UOYW4AN3nbun/0pFQtk34JmKWt9Y1fE
	GNp/GnDQFwtee36UwulB+2gfmNegJouSsDc64oXE+w==
X-ME-Sender: <xms:XQePaIxQ6ZQ2r_BNlFUyGMKhE7d4qyaJX7yujJb1J0YDkkSi7VqdAQ>
    <xme:XQePaMcJDuOreNXNbrfHIjRBOVSWBIYA-FOI5NFk27DnG07xEqQQ4c6l9r5VU8OVY
    iwCPWIJMYgqMOYUBw>
X-ME-Received: <xmr:XQePaMI8EQfJ_pJQhBDq6lqNnNyichnZBM3SQcxyngBXB43oL8QDo8C6DQHkVgSiJTV3BoI-zYZORGsXUBjgGdhkQc6KsKWJ_FdDyLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepjeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:XQePaFGoi6fm_8eKRNNHO9-xOWiQxePI_ZXm5IvGZfJioPuQTOX9eQ>
    <xmx:XQePaOpb89UYNH1HR_z6MGCFhBXKFKdaj-2UJhUUQcqZCoYKcr5yjA>
    <xmx:XQePaGQRf0B_H5yOkHRKwd-g4UemDAlNqUFz3VdWPiSACEjY6WDnGg>
    <xmx:XQePaDM3vBEa9k6xM0TSqfDcS1HWrMOul_PrPi9LjILU9CxsO7ULYQ>
    <xmx:XQePaDWCKVukJNlX4rC4NpPB2cQxzeLSQ1WYLgRU1Gu35wLn3o9p776z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 09/12] environment: do not use strbuf_split*()
Date: Sat,  2 Aug 2025 23:53:01 -0700
Message-ID: <20250803065304.3325286-10-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065304.3325286-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065304.3325286-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

environment.c:get_git_namespace() learns the raw namespace from an
environment variable, splits it at "/", and appends them after
"refs/namespaces/"; the reason why it splits first is so that an
empty string resulting from double slashes can be omitted.

The split pieces do not need to be edited in any way, so an array of
strbufs is a wrong data structure to use.  Instead split into a
string list and use the pieces from there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index 7c2480b22e..ab3ed08433 100644
--- a/environment.c
+++ b/environment.c
@@ -163,10 +163,10 @@ int have_git_dir(void)
 const char *get_git_namespace(void)
 {
 	static const char *namespace;
-
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf **components, **c;
 	const char *raw_namespace;
+	struct string_list components = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 
 	if (namespace)
 		return namespace;
@@ -178,12 +178,17 @@ const char *get_git_namespace(void)
 	}
 
 	strbuf_addstr(&buf, raw_namespace);
-	components = strbuf_split(&buf, '/');
+
+	string_list_split(&components, buf.buf, "/", -1);
 	strbuf_reset(&buf);
-	for (c = components; *c; c++)
-		if (strcmp((*c)->buf, "/") != 0)
-			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
-	strbuf_list_free(components);
+
+	for_each_string_list_item(item, &components) {
+		if (item->string[0])
+			strbuf_addf(&buf, "refs/namespaces/%s/", item->string);
+	}
+	string_list_clear(&components, 0);
+
+	strbuf_trim_trailing_dir_sep(&buf);
 	if (check_refname_format(buf.buf, 0))
 		die(_("bad git namespace path \"%s\""), raw_namespace);
 	strbuf_addch(&buf, '/');
-- 
2.50.1-633-g69dfdd50af

