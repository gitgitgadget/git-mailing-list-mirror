Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C91DE895
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149520; cv=none; b=Vj4ZLz1ifq4ImesBI6OxO7dTEKKNJ/EbPSgqapQrmezz1NtHWcbPSCeBFKaUxo468gqiuc+OurLZQqDAb1I25kkr5BOh3e6Q530RztDva3vKHcRglAsmVA0zaPJHygcrW/jDCt4o2RKZFrJ6EzqYbW6q8wrQ82vOqhOKK3lzG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149520; c=relaxed/simple;
	bh=vJdZi6Lfu784JIUdqNygl8j9ZHcGYk4oEylkU5S13s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/+LNlDb08O/HthS4K+hIwUkINN7kiE6y2ZgL0gdPiKtRNxOmiXXO9ue8eOOgqFST1lfivwVpGrKP7TRW5yMYs8YVrCozsQRCdSsLqY5rNxgDSITt83aKwxAPpZWaTRj4EALLsXfuu5QHpUkLyR7Thwp8LvbdD/2fvBOuMwbeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lUQtdZ4e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aR8Gw75Y; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lUQtdZ4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aR8Gw75Y"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F7AA114010A;
	Fri, 17 Jan 2025 16:31:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 17 Jan 2025 16:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737149517; x=
	1737235917; bh=yK57puxiPTX1CvrxDKA/0e1qHVUGTjdkFTAKSmubZE4=; b=l
	UQtdZ4eRaiDMXg7iANE6UAjl8wZPbLYo7SNi+K2RP90D55YKZ+Ro/5s6gOk59RQQ
	Ukqlfb4PG67ClFe+cFwIOQxTSogSV/7wSpMe7KE8NH7tSH+IRvegW93uriDBH4q9
	Tdqtz4fRB+t/oGSgCTC2l9j52boYVrA6YXfuH/331Y4Cj9YXRXfrAjxCkBxi/U9L
	RJLPRkII+cEwV07Ww7o9fCR5sN0NzxiNJnmtvO7e1H2kYUygTZfjkoexKSfzqi8C
	jehLR+zarhd3M3c3Q86h+92vvjhb0ix6DnK39tvMElbdTtWv0VjAfwD57GjmTpoL
	AIC6pEYrgo547NyB/6Xag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737149517; x=1737235917; bh=y
	K57puxiPTX1CvrxDKA/0e1qHVUGTjdkFTAKSmubZE4=; b=aR8Gw75YNEDWR+MX0
	9SIhyWK2WRJNiUcouBpjaiOmBTvt44ALOcDNlBHLJ2NnejGZFTeBoXg1W1Lvke6n
	O1fixGAI/HgpTDEA5VQLlhkFPuVjLbxCDQVcYdDk/3elL2uV3bCktb4jy0UiFu1T
	8QO9koXJeut+NzX3BjOYL5KOTLita8wHtrbIejbSq2AdH6niYR+kjxzwv10zX0FI
	zeRFVAy5JXHJg1rTvtC8TBKX8eoOgy1m+OLZlYVrYefJ56wtfFhJuKkZAb5F5bRn
	PgaIgUF9aafYG5Yf15fBfHEhC+etc5DjcosPP8BIMuDMh2op/s2QrfX/kH1wVZRL
	lRftQ==
X-ME-Sender: <xms:TcyKZyhfCw8G0FCcmQ4rkcSIW62Q85Pc0mbDJ0kvAci2LbImeuCsGQ>
    <xme:TcyKZzCQK1Bnv0MVRjaNDdWZUXPUl6-Op4CjLKDO5BqK0_MXtc0A_PopdPG5USJSu
    mCRPgytfHd4Mw9q0Q>
X-ME-Received: <xmr:TcyKZ6Hct8lXLRzdxBbQc5LRr7GohSvaHZYFh5dGXLwBR03aLBUqAJY3eRE4LIuqVBOy9JoNzeZ8Awr2JAsyfIMlOdk6CG4npwfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvd
    fflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddvudeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:TcyKZ7QC0VoMnCozEtEiTWAY3ggBmEUzGOIMRRFqCj9xXuDWkfkaMA>
    <xmx:TcyKZ_yin0WVL2L1JWLgR5gRykKAWHRRJxSgPbeum8gaHumVuMTcxA>
    <xmx:TcyKZ55pnVpyW9HZewWwr1Ivx8Yy-5Z6SSIHZyGVkkxmE74fG4adAQ>
    <xmx:TcyKZ8x9L9b5wncxEmUQafyM1UnsZbhHrVVjFCeLeG-UUBA6LyNVNQ>
    <xmx:TcyKZ_8kYr5WE6WQEq-AR1-iQOwGN-vREUB0POA22we1StzoUgfFPiMt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 16:31:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v5 5/6] oddballs: send usage() help text to standard output
Date: Fri, 17 Jan 2025 13:31:47 -0800
Message-ID: <20250117213148.3974552-6-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-218-gc7e8be6a8f
In-Reply-To: <20250117213148.3974552-1-gitster@pobox.com>
References: <20250116213553.2563751-1-gitster@pobox.com>
 <20250117213148.3974552-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the show_usage_if_asked() helper we introduced earlier, fix
callers of usage() that want to show the help text when explicitly
asked by the end-user.  The help text now goes to the standard
output stream for them.

The callers in this step are oddballs in that their invocations of
usage() are *not* guarded by

	if (argc == 2 && !strcmp(argv[1], "-h")
		usage(...);

There are (unnecessarily) being clever ones that do things like

	if (argc != 2 || !strcmp(argv[1], "-h")
		usage(...);

to say "I know I take only one argument, so argc != 2 is always an
error regardless of what is in argv[].  Ah, by the way, even if argc
is 2, "-h" is a request for usage text, so we do the same".

Some like "git var -h" just do not treat "-h" any specially, and let
it take the same error code paths as a parameter error.

Now we cannot do the same, so these callers are rewrittin to do the
show_usage_and_exit_if_asked() first and then handle the usage error
the way they used to.

Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/credential.c     | 3 ++-
 builtin/fetch-pack.c     | 2 ++
 builtin/unpack-file.c    | 8 ++++++--
 builtin/upload-archive.c | 3 ++-
 builtin/var.c            | 1 +
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/credential.c b/builtin/credential.c
index 14c8c6608b..f6fc948123 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -18,7 +18,8 @@ int cmd_credential(int argc,
 
 	git_config(git_default_config, NULL);
 
-	if (argc != 2 || !strcmp(argv[1], "-h"))
+	show_usage_if_asked(argc, argv, usage_msg);
+	if (argc != 2)
 		usage(usage_msg);
 	op = argv[1];
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bed2816c2d..d07eec9e55 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -75,6 +75,8 @@ int cmd_fetch_pack(int argc,
 	list_objects_filter_init(&args.filter_options);
 	args.uploadpack = "git-upload-pack";
 
+	show_usage_if_asked(argc, argv, fetch_pack_usage);
+
 	for (i = 1; i < argc && *argv[i] == '-'; i++) {
 		const char *arg = argv[i];
 
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 6da2825753..fb5fcbc40a 100644
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
+	show_usage_if_asked(argc, argv, usage_msg);
+	if (argc != 2)
+		usage(usage_msg);
 	if (repo_get_oid(the_repository, argv[1], &oid))
 		die("Not a valid object name %s", argv[1]);
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 9e9343f121..9d76a31c8f 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -27,7 +27,8 @@ int cmd_upload_archive_writer(int argc,
 	const char *arg_cmd = "argument ";
 	int ret;
 
-	if (argc != 2 || !strcmp(argv[1], "-h"))
+	show_usage_if_asked(argc, argv, upload_archive_usage);
+	if (argc != 2)
 		usage(upload_archive_usage);
 
 	if (!enter_repo(argv[1], 0))
diff --git a/builtin/var.c b/builtin/var.c
index 1449656cc9..46d40d6fba 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -221,6 +221,7 @@ int cmd_var(int argc,
 	const struct git_var *git_var;
 	char *val;
 
+	show_usage_if_asked(argc, argv, var_usage);
 	if (argc != 2)
 		usage(var_usage);
 
-- 
2.48.1-218-gc7e8be6a8f

