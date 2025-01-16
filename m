Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1217081B
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990736; cv=none; b=UkmsyKq2pFmKiQi2N1Jz0c2ZrG5z83pc5XcQKePheAcAxXuQNNtsXsvqGziT9zRGd/3gy8HKJkzCa1bTHcVpMOCDeMIQo+1IAFe6H7HC2T8mNDG/i9LpEwZJh+WyxorCS39BzvLJOZN4ZCyqhMeoZ9GdZBLfJeMquml/kT/uxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990736; c=relaxed/simple;
	bh=019usVTayZ8lqBWWQi44x9IxpqT3MkJIqemZOqXxtmM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJxO6i3ERxdtAK54oUN/ukjFKg0YmofOVc7So+TydMaU1v5RuHTgzlAnbYA646551JlyyKzXsZ+xy40fDsJWb1ucs2XFwAV6lA4ioFYRokbI0/aMyIzCgJ1D8+GB2b6S60f6hC75KeJdox65idUyKg0sFlyEDRDASBD9QONRxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LuOhI1A7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6wENsLY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LuOhI1A7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6wENsLY"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62C8C1140190;
	Wed, 15 Jan 2025 20:25:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jan 2025 20:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736990733; x=
	1737077133; bh=UktsyEHPiLei5xnLVXGpFIw42qAhxzrafqObFfiKBqk=; b=L
	uOhI1A7lepoOPJluo3IQuqCLz/clmgnqzWbe2diSSNUYytVIbUm+2TWRHRcV1Gx/
	QqQOLUawVKEfLQMxz8rrT/fiU5a38HCHlzNnE4tQ1Oit66N06Z5P7a3+AtffjZk1
	7zvAFUiUKQhStE2Nc3/r9MHVcW3HGmVRwJ+HbvfocRxrseFvQnJcdBUa3UoXNhIE
	KZ4hFyJvJma8bVzmuPykEQmYOA8+hr+nuSN+3sutBhPWi4RgFxf6Iks+Uqq5QKqk
	b3yKSUgjEX09pQk6mmok/vGXWDnn3vNxB7HFqIbOIRkqxSuQ3n3wYSLDrA+elyaX
	rYsgRmCFhk/Iuv1VezuwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736990733; x=1737077133; bh=UktsyEHPiLei5xnLVXGpFIw42qAh
	xzrafqObFfiKBqk=; b=Z6wENsLY9ofyqomakMA3CbAcVhgKGPA/hvphQV9JYk8+
	QGkX93pR8qgHA+9X5JzWGesQDXXgHQW/ut0+9aTgxVlFpstnEPbGoVwBImXynw3s
	ng0/l9d84s0LRZT7a4rTp8KUgiULgsojYPJaDxU7pLFr0wQ8BzdP2B+RfZc6w67o
	+XlnWdbDDM/nUUqgVCl4Rsqwl2to/Yl/m0WbM0Ubc5/fwIAktfwSEjBcO5ZqKbhr
	gytnX1ATxLG98QNSJtuBF5ljaQ2C//x7JIYIoL9rbf+tw+VRP8gBBHNwMkdIgOGN
	4ac2r9+oCIxJf4pbqsZvgnLtJdj9XuCZBFpd+wJLLg==
X-ME-Sender: <xms:DWCIZ4QKYTUSX0xsfLXEbN7PMUBsK6vcGwtnumsQ6oQFTY5AfHnWWQ>
    <xme:DWCIZ1wualsi-VymgtI5-GQRli1eNyF0XNGyYoknA_-eAytJ58gIuH9hXpAFOhNq0
    jBgBWZuW8MKnGDB3w>
X-ME-Received: <xmr:DWCIZ129DM5Jr_jlxP6XEhjiBJwH99jOscbT6APQyR480Ywhd_SuNHLVxghY4-WxuKHz-0ShRVGpO8aHCjIBbxM8vK_7577EWBo7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepleevie
    efieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DWCIZ8CaLarueaNtfwDrlM8FNrEYW6LJoxmYLcSa0glfsbHpM1mUfA>
    <xmx:DWCIZxgot9NFfPDv6uIsI5-sz80_5XX7oARXocvo9oATMkOWQnBDJA>
    <xmx:DWCIZ4o-CPpHR5g59ZJ8Rurag5bAM-2sWQCDiWPprJ7gZBQX8dN6Ng>
    <xmx:DWCIZ0guiKOXufJz5IvsplIPTeewKGpFpY-y4MFtmKp2t1HlJL1gEw>
    <xmx:DWCIZ0sgxnxgOOhlM1LnK6Rp9BpHDGBa3hpTzIxGBVeQaH_YywGPG4Fo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 20:25:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 5/6] oddballs: send usage() help text to standard output
Date: Wed, 15 Jan 2025 17:25:22 -0800
Message-ID: <20250116012524.1557441-6-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-191-gafe818080f
In-Reply-To: <20250116012524.1557441-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the show_usage_and_exit_if_asked() helper we introduced
earlier, fix callers of usage() that want to show the help text when
explicitly asked by the end-user.  The help text now goes to the
standard output stream for them.

The callers in this step are oddballs in that their invocations of
usage() are *not* guarded by

	if (argc == 2 && !strcmp(argv[1], "-h")
		usage(...);

They are (unnecessarily) being clever and do things like

	if (argc != 2 || !strcmp(argv[1], "-h")
		usage(...);

to say "I know I take only one argument, so argc != 2 is always an
error regardless of what is in argv[].  Ah, by the way, even if argc
is 2, "-h" is a request for usage text, so we do the same".  Some
just do not treat "-h" any specially, and let it take the same error
code paths as a parameter error.

Now we cannot do the same, so these callers are rewrittin to do the
show_usage_and_exit_if_asked() first and then handle the usage error
the way they used to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/credential.c     | 3 ++-
 builtin/unpack-file.c    | 8 ++++++--
 builtin/upload-archive.c | 3 ++-
 builtin/var.c            | 1 +
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/credential.c b/builtin/credential.c
index 14c8c6608b..8a8cffecc8 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -18,7 +18,8 @@ int cmd_credential(int argc,
 
 	git_config(git_default_config, NULL);
 
-	if (argc != 2 || !strcmp(argv[1], "-h"))
+	show_usage_and_exit_if_asked(argc, argv, usage_msg);
+	if (argc != 2)
 		usage(usage_msg);
 	op = argv[1];
 
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 6da2825753..307351af55 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -26,6 +26,9 @@ static char *create_temp_file(struct object_id *oid)
 	return path;
 }
 
+static const char usage_msg[] =
+"git unpack-file <blob>";
+
 int cmd_unpack_file(int argc,
 		    const char **argv,
 		    const char *prefix UNUSED,
@@ -33,8 +36,9 @@ int cmd_unpack_file(int argc,
 {
 	struct object_id oid;
 
-	if (argc != 2 || !strcmp(argv[1], "-h"))
-		usage("git unpack-file <blob>");
+	show_usage_and_exit_if_asked(argc, argv, usage_msg);
+	if (argc != 2)
+		usage(usage_msg);
 	if (repo_get_oid(the_repository, argv[1], &oid))
 		die("Not a valid object name %s", argv[1]);
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 9e9343f121..3b282d41e6 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -27,7 +27,8 @@ int cmd_upload_archive_writer(int argc,
 	const char *arg_cmd = "argument ";
 	int ret;
 
-	if (argc != 2 || !strcmp(argv[1], "-h"))
+	show_usage_and_exit_if_asked(argc, argv, upload_archive_usage);
+	if (argc != 2)
 		usage(upload_archive_usage);
 
 	if (!enter_repo(argv[1], 0))
diff --git a/builtin/var.c b/builtin/var.c
index 1449656cc9..6a09c1c39a 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -221,6 +221,7 @@ int cmd_var(int argc,
 	const struct git_var *git_var;
 	char *val;
 
+	show_usage_and_exit_if_asked(argc, argv, var_usage);
 	if (argc != 2)
 		usage(var_usage);
 
-- 
2.48.1-191-gafe818080f

