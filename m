Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04153AA19B
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007273; cv=none; b=XecgeT/9JC47HmZAf1VqegO9AN24IlnwxoMO5QpdUy4lJk6FScOb96OlfE7dicU9bKB1iLWYfzYKuBXmR5TVh7F6JJN0CKdcKoTty+VZ3C1MpPwkmmDZpvxUkKAK3IbOIUJfQjBlMf1/IY83QpSnTnWpDmRIpnmA7hDXHSoX8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007273; c=relaxed/simple;
	bh=uhLgmQuigFEIUzRLUfXwI5SQk5we1qHTOli/cPRRh2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJKP928TGwkwknjpUvJ1BtaaYToY5VZqgJXNf9kb9wE0G5sYQWounZHecaM6r3qiKqDuutAT0G0IKxfpn+yjH94tyYD4pCu86w2/hlvEVIv2WKexElqhcT3rctOnrzlrmOoZYNeabYR9s+9ISgwW1h7MMENKdUAvcazqFCoy48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FLglSIKA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=49aKix9F; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FLglSIKA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="49aKix9F"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24DE91400176
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Mar 2026 07:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007271;
	 x=1774093671; bh=dvd+2RCEkkcvpKNRixsJg7oETOpjrpwZkAjwJ/li1kk=; b=
	FLglSIKAOuz6r42Eic5RM284panx2UgWNCWOLT310TAJPVaCPGq+rqhNP6KJaO+Q
	q0j3yxk++6tV9WYzFirHPNNvMHL8GjfZvvi/DU3JGJGCzmqblzIvV1B9Sb4BvYR+
	F8PUkWN0i3fyUWdBdpxQ6LipZ+7MEHkukGweOm9y+OK8CWdqTQ4ZP/EBTTxLSKbP
	1PAgHNKXN2t5ld7Mcs/LVdW8NxiST5W9LXhVXj/zaH9MUy+AicQd9e9jyOI0ysCv
	rDaf97rqcy3bPIqg2PVTq/5pBIKj/Cdw4wJh6XZbKHu6D3s4hnjx+LiYrO98QIhC
	dL7oq5uZ9+rxyzuhir3g9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007271; x=
	1774093671; bh=dvd+2RCEkkcvpKNRixsJg7oETOpjrpwZkAjwJ/li1kk=; b=4
	9aKix9FNEOl6Vx+xJp1id5S57z+oZ8sf/OqHGzLpU+GNte5www3rm81t8zQgw8YL
	VwV/H84m+HsVvxwNRyBhi2hsBlSpUe7e5GuKOhZ8l9lqJhnF8D3fET1jwLbn7FSO
	cNj7+heaRgHS33z9SXxLL+Y17rK6HHRVl0OndmKOCZErRfegSW4VdUjfQ3f9cnOU
	YNe22a9amHjByZnYcOx1QJYg5Uk3QJ84OKU/YRE7+3+pVAttMjuDA3kwoYMehgjK
	SNnPOkOAym8+x8ztYVagMQ+5hxROjSjcHVgXkfFtVeKN/y5Sk7X3TbS0/XxA+5/4
	d2UsGJWbdIqbK3XEDmjQA==
X-ME-Sender: <xms:5zO9aUTFmotaR-kEyXsmY7yQwXu-aASmPYCMYtRols-2aGQthPVDog>
    <xme:5zO9aYsqcfcIzvfleXcpKNv4SRjwe1hPGBu8lXlld_WiwW79Su9ANWrIWOEoMMYWc
    I_y4tB1alauSMPIbsUNyqaDCdi1rpUpzFVAcj2ERGGHANZjvwnlSQ>
X-ME-Received: <xmr:5zO9aXdqrkWDJY8QavYfYWTIDmhYvxJRHPO_TwfFeWIRiAdMONp2YzlxzMfYLagtJtGGKi6g8WXpUx1HTVBb88J-eTc9N8FPeO_xyaG7oeq->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpefhleehfeefhfelveetgedvveelgeejiedtgfefgeeuheekheejgfdvhfej
    keffveenucffohhmrghinhepshhkihhplhhishhtrddqihhnthenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5zO9adK_Ex85WVvQDZj74m5UkcEop-3BUF145e1dpsk15hru3QREQg>
    <xmx:5zO9adZNfIyrOey_G6K4T1nRBmCWoF9NBj8_YUzQAaI2IEKDng1lFQ>
    <xmx:5zO9aQtVzpUYi5uMxfaLj6S8ku0-otUzyWbKs2Ii9U_PoKRK6dbxSA>
    <xmx:5zO9aSshZSgbt49fXD8KSNiBJ90MQDtZEXJZpd36D6tveZI1YNhXog>
    <xmx:5zO9acSnnxiJhBH41TvPxnbhNTrzp5ntpg_Q3DyIrfLx5QB81Hack7-a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55b2da98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:47:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:08 +0100
Subject: [PATCH 03/14] fsck: refactor interface to parse fsck options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-3-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `git_fsck_config()` is supposed to be used as a callback
function for `repo_config()`. It expects the caller to provide a
repository as callback payload, which is easy to miss. Furthermore, in
the next commit we're about to refactor the function to not rely on
global state anymore, which will require callers to pass a different
payload.

Prepare for this change by refactoring the interface to be fully
self-contained. Like this, callers know exactly which parameters are
expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c  |  2 +-
 builtin/mktag.c |  3 ++-
 builtin/refs.c  |  2 +-
 fsck.c          | 11 +++++++++--
 fsck.h          |  9 ++++-----
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8f994010da..fd689a1e14 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1023,7 +1023,7 @@ int cmd_fsck(int argc,
 	if (name_objects)
 		fsck_enable_object_names(&fsck_walk_options);
 
-	repo_config(the_repository, git_fsck_config, &fsck_obj_options);
+	fsck_options_parse_config(&fsck_obj_options, the_repository);
 	prepare_repo_settings(the_repository);
 
 	if (check_references)
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 7cf6e1230a..2cf843c195 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -98,7 +98,8 @@ int cmd_mktag(int argc,
 	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
 				   FSCK_WARN);
 	/* config might set fsck.extraHeaderEntry=* again */
-	repo_config(the_repository, git_fsck_config, &fsck_options);
+	fsck_options_parse_config(&fsck_options, the_repository);
+
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
 				&tagged_oid, &tagged_type))
 		die(_("tag on stdin did not pass our strict fsck check"));
diff --git a/builtin/refs.c b/builtin/refs.c
index 3064f888b2..c0a3b475e9 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -97,7 +97,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	if (argc)
 		usage(_("'git refs verify' takes no arguments"));
 
-	repo_config(the_repository, git_fsck_config, &fsck_refs_options);
+	fsck_options_parse_config(&fsck_refs_options, the_repository);
 	prepare_repo_settings(the_repository);
 
 	worktrees = get_worktrees_without_reading_head();
diff --git a/fsck.c b/fsck.c
index 1f7d568acf..a7ebab9581 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1404,8 +1404,9 @@ void fsck_options_clear(struct fsck_options *options)
 	kh_clear_oid_map(options->object_names);
 }
 
-int git_fsck_config(const char *var, const char *value,
-		    const struct config_context *ctx, void *cb)
+static int fsck_options_parse_config_key(const char *var, const char *value,
+					 const struct config_context *ctx,
+					 void *cb)
 {
 	struct fsck_options *options = cb;
 	const char *msg_id;
@@ -1435,6 +1436,12 @@ int git_fsck_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
+void fsck_options_parse_config(struct fsck_options *options,
+			       struct repository *repo)
+{
+	repo_config(repo, fsck_options_parse_config_key, options);
+}
+
 /*
  * Custom error callbacks that are used in more than one place.
  */
diff --git a/fsck.h b/fsck.h
index bfe9b3ffc9..7d0d876103 100644
--- a/fsck.h
+++ b/fsck.h
@@ -304,12 +304,11 @@ void fsck_put_object_name(struct fsck_options *options,
 const char *fsck_describe_object(struct fsck_options *options,
 				 const struct object_id *oid);
 
-struct key_value_info;
 /*
- * repo_config() callback for use by fsck-y tools that want to support
- * fsck.<msg> fsck.skipList etc.
+ * Parse fsck options from the gitconfig. This covers settings like for example
+ * fsck.<msg> fsck.skipList.
  */
-int git_fsck_config(const char *var, const char *value,
-		    const struct config_context *ctx, void *cb);
+void fsck_options_parse_config(struct fsck_options *options,
+			       struct repository *repo);
 
 #endif

-- 
2.53.0.1055.ga2ffed1127.dirty

