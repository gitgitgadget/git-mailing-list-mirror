Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6F2416A1
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063365; cv=none; b=tjwl6yXUOoO0eqHQJI83PBOZb9MKAHHNMYxJExjgkOvNZ/FLkwNZ5mbtJVxm4n0KDwv6lNDPMW5oMNsFYIB8H68ZUvIo7b9iEvoe9gEXTF7u/62ZLP/NLG8/j6W15RrmWA8KqgyJiF5ZIKMqlQAHtlNrLYhkxqUtF13ypfyxBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063365; c=relaxed/simple;
	bh=Ar8gfXflg7vNQvnCp61WgdbP9ZdzovxdJg4I7Yv4AjQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XexlTSQZGniXqzMIxDXuuMupFj0e5q6r+yl6YkX5Mk7rYoLTy70AR7gMjuIgTVl7xWm7DA3VJtdSZZuTZRVCPTZXJQRzA2YE1kD5ptjkDDs2fJIdntX/VKbAStQt7KoglqrwdLEqRCORX67Ls/ylAX9iqCoVGPFFjJteo7uiT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Px7O7poH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3Rls0vU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Px7O7poH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3Rls0vU"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4AE9A114015B;
	Thu, 16 Jan 2025 16:36:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jan 2025 16:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737063363; x=
	1737149763; bh=XDn6qOep1UlzEMcRC82d65BjAMYW6QKZJmxhggIwrSo=; b=P
	x7O7poHWwx1g4GwAUilsBM8a0EYQxh4gL3ztB/3t9XoHeFfjYDO44Ir9XG6oIsjq
	4/k8TW5CYL0d6GwmbH+W3r1Sxj3IWxwtdOjZs1IvTkiWeM6RrAqhxSupmg4Rv6r4
	z0PQfswL6M5TiC7/ivQp8agtL5rVfAzeJh+WOvvS3bgU6+C0GTK7NIbrvKO0dcNb
	i0R7z+saN9edhmbIyz30jOISUvHK6wuwy+09owVkr7Lbhv/RMtnxwiqVPUSBCDXu
	bAbPHPQudtfS34EAGIXdctVh2NtIaEc/gKGlVPj3whYOCdGyMeBkPPFJ6ByYfqXZ
	2tJkDJvcO7KityfNv4cfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1737063363; x=1737149763; bh=XDn6qOep1UlzEMcRC82d65BjAMYW
	6QKZJmxhggIwrSo=; b=m3Rls0vUcmMaeQY2odcgwc+WsTZyu0CLv8/p5wQt8P1s
	p6BdSAUqFbq+TTDe//wWDuf+muI9LUEjip+ElVodlcvKBRB+CFkGn7kq8LrqirIk
	kipiP1OMSQzljgqem9tyA9nIVJJ+ahEGkGaooISr7jrV+a2jReRtk5rbzm+zt6wq
	Ce2ApqX8gCZWo6P6b9Frama1QvZdYALnKFNTbzdpcYkhkCPRfsnli7uuHztK8gnB
	43TGvhcG+8V4AB2V9Al/zb8TKXjTKRE1koxP6xKVbgawnJTBGiu0Myki/OZbsOZt
	iLNKqU43QdPdRG2x2xbs0ad1e4Em4TPUvRW4TV+88g==
X-ME-Sender: <xms:w3uJZ6N2mVuVu1qXmV_Wn9kIshfDEF0mzi8vDoMjNi9x-oc_dWLoBQ>
    <xme:w3uJZ48RKOHpNKoKdY4vhorODm2huNOtrJQYhICSOtnKYrb2Uhup2Mg3VOl4o715N
    Q9O1w1BwIqQxHpvqg>
X-ME-Received: <xmr:w3uJZxRMCgco41TTPqUK1AHM3r2xR-5CBQwYtBFzLyQDx5GWkWY3NgVg3bpSMiMPZGDDUFisEFJGTAqC1WFLpx_4AChMI3sMvwxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:w3uJZ6vID_-Bf0dZueQSNHlfu5kDrdy4nO7Nbh4UILUd-c2aUV2rmA>
    <xmx:w3uJZyfX6Utt79OBC6ONPc7ACLDjG2d-n5GVVZPc3h5lXAUh0ysqWQ>
    <xmx:w3uJZ-1BuBQA8FxlaCxYoYovgB3dlU0k6UBdQmqUUMFQu7jdqcYsaQ>
    <xmx:w3uJZ2-RyByh5dT34G405W1Bf91-q23L5MqxkQViO3yoVVRdYkCVPw>
    <xmx:w3uJZzoCNBSv5HQXTqveGdGl7Ekp8mclKsHr2Nhipvhn0QtIVJijD9n5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 16:36:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 5/6] oddballs: send usage() help text to standard output
Date: Thu, 16 Jan 2025 13:35:52 -0800
Message-ID: <20250116213553.2563751-6-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-210-gaa1682cadd
In-Reply-To: <20250116213553.2563751-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116213553.2563751-1-gitster@pobox.com>
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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Helper function renamed.
   Fix fo fetch-pack.c moved from the next step and redone.

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
2.48.1-191-gafe818080f

