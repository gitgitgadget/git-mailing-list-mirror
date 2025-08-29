Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A344322761
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480936; cv=none; b=m1qH6th/Vk0UTz15a1lAmxKAPKfSqtahMo4wmGsQtMiXg6/9yG9vdSaWxnSlvJyL9rBZ9sHeneMnnebVR1Q2je67v8Lqc6Lb3MGj0YlsEyqUYGmDLUMBBfXLuhpvIFP3xnRV7ZDk5AgSNJ3f3a2mgv7QQWy/WpZo4UUQq57/IXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480936; c=relaxed/simple;
	bh=uYt4gxgEQhzkWEZ08VcyjIPrYFwpjHISWkJ4jGiekgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUW6tIoQGd3lwUQWSsp7YSL/ii/n6nF9HIw9d2IYL8GM3MxTz9/DTmiY/Pt3zJ4X7E/k/oZ7tE2g2EvARmfPqpQcx+onfKzLYY3j/jvIc37sJpbQ69xQW3gx4Ie7WvfmY2UGIdEZYfu1H4KybKH9Ih1yspcVusO6H4lLU3fUnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HYqYCnn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+Kj+wvw; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HYqYCnn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+Kj+wvw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80C2F14000AF;
	Fri, 29 Aug 2025 11:22:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 29 Aug 2025 11:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756480933;
	 x=1756567333; bh=z3C5xfRBKYcWmSYg+Vz229Qq/MxmycC1LrkEaUYX2RE=; b=
	HYqYCnn2lvrKJTV8cDfxhvF2Mco2f0FuR7faFsxfbB+fBVWFcF5o8Yu99CqhM8Vq
	tyHNZniGmWRxHtjKsBOlnqwD8meRW9/GLWWpC4A/ZQ7XPhKAYScG9n7/85ccI0fV
	I6UaaV8XY6EQLcewWbgjBbT11vDYIqkaS08eRqkwFUCkPbssyaqFsboq7LZai1Oa
	/RmmuGV8ugXTsDqLNzZgSAQU8UudJVBck06CorZhk8S3RfmPscGobnp3yDimVKQA
	Vs+zudMTDW/9IbvqivQv+WG7NQo04VjiPs30mY/qE89qKPOYPkbTay7hyLqCEgbz
	Sxz7UPnB1TvMpSfVBiylTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756480933; x=
	1756567333; bh=z3C5xfRBKYcWmSYg+Vz229Qq/MxmycC1LrkEaUYX2RE=; b=G
	+Kj+wvwJPKwzHrZf0DcxqNyuYeiVmDjYltPTXSqI2NT6cWB3aPdxnxvpvrLY4CZV
	6jf30rAAGXLZuI7S2OYNq5nCzY2cvyLq2lAgkyl2ixjSgVv/Ov0JKimW1BKrHLWr
	/8dY2ctchwszHZAwZXofwJDV6VWhDaoLj0dtEaP7rmiefg4zN2VmnykOFFqYZUhR
	wN6mQDm2tSyWeX7choW3WqUPhBIj20q7cV8A91gpjjNZsTAEDpp3RATU9FIfquEM
	P9TfxADxHillcV54XvpwXpONz1SzF1xIJWfmSm//0uSVNVjR3RfeeDknSYJTTmex
	hxPadH2occmVJbjXkYKjQ==
X-ME-Sender: <xms:pcWxaOC5Gcq9YhbfTbytnpGk3Zis3H6cNXk9oZkvIKo46n5nr0B5Y_4>
    <xme:pcWxaLxs8fji767HoxsjMzYQfTnjlwbzVzrvn1Xb4zE-bwy8DyWd4z-A9DIPsPZXL
    eGiVRjBK255afhyNg>
X-ME-Received: <xmr:pcWxaLC3lhRQeypDjpvtdW3VQcIp35tA8zP_KdVxc-eMXQDUOaC1WQowV7DbkKfw22yjVm7dr08xSVyHOvACC3HUlpnwz-sL43Oc99zDeszLfY8mQmiDDrj3xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtth
    gvrhhnpeejffevheetfedukeegheevudeugeeiveduiefgtdfgfeeigfeuuedtheetkeff
    jeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtqdhstghmrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:pcWxaIbR1Y3IpQ7svGLHY8OqEYmxet6wqdgAtEf51xLi0wUZnS8AcQ>
    <xmx:pcWxaDgbYuSchd_eS8hCUGnXKaIxjgl5gNwwUtJrwQpaGRtYSz_QeA>
    <xmx:pcWxaK7wrHfsUHvt67__7dhs92-8xTlGp2wH_9be5NfyeMftCcIjEQ>
    <xmx:pcWxaK6OdXyQkzmrItC-Fpo2F4pM0AWLBsPlnOHK9sCxQrc6wkmMaA>
    <xmx:pcWxaDD4KgM2tJI0hPdBy8YuOOvlb3pz1dKJcjwUHMhXOgTKTxXuCaEk>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:22:12 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] whatchanged: tell users the git-log(1) equivalent
Date: Fri, 29 Aug 2025 17:21:04 +0200
Message-ID: <2f3ac952980cb982a68086d1c30400d2e2ba2185.1756480827.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1756480827.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name> <cover.1756480827.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

There have been quite a few `--i-still-use-this` user reports since Git
2.51.0 was released.[1][2]  And it doesn’t seem like they are reading
the man page about the git-log(1) equivalent.

Tell them what options to plug into git-log(1).  That template produces
almost the same output[3] and is arguably a plug-in replacement.
Concretely, add an optional `hint` argument so that we can use it right
after the initial error line.

Also mention the same concrete options in the documentation while we’re
at it.

[1]: E.g.,
    • https://lore.kernel.org/git/e1a69dea-bcb6-45fc-83d3-9e50d32c410b@5y5.one/
    • https://lore.kernel.org/git/1011073f-9930-4360-a42f-71eb7421fe3f@chrispalmer.uk/#t
    • https://lore.kernel.org/git/9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.org/#t
    • https://lore.kernel.org/git/83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com/
[2]: The error message on 2.51.0 does tell them to report it, unconditionally
[3]: You only get different outputs if you happen to have empty
     commits (no changes)[4]
[4]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    Review found a whitespace error in the prev. patch version.  I found a
    broken footnote and wanted to expand on the last footnote.
    
    • Fix whitespace error (I should have used `ci/check-whitespace.sh
      v2.51.0`)
    • Add missing colon (:) to footnote
    • Expand on footnote; a sentence is enough to summarize the difference

 Documentation/git-whatchanged.adoc |  6 +++++-
 builtin/log.c                      |  6 +++++-
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 usage.c                            | 14 ++++++++++----
 5 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatchanged.adoc
index d21484026fe..e71d2aa2d27 100644
--- a/Documentation/git-whatchanged.adoc
+++ b/Documentation/git-whatchanged.adoc
@@ -24,7 +24,11 @@ Shows commit logs and diff output each commit introduces.
 
 New users are encouraged to use linkgit:git-log[1] instead.  The
 `whatchanged` command is essentially the same as linkgit:git-log[1]
-but defaults to showing the raw format diff output and skipping merges.
+but defaults to showing the raw format diff output and skipping merges:
+
+----
+git log --raw --no-merges
+----
 
 The command is primarily kept for historical reasons; fingers of
 many people who learned Git long before `git log` was invented by
diff --git a/builtin/log.c b/builtin/log.c
index c2f8bbf8630..5dbb90c014d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -543,7 +543,11 @@ int cmd_whatchanged(int argc,
 	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
 
 	if (!cfg.i_still_use_this)
-		you_still_use_that("git whatchanged");
+		you_still_use_that("git whatchanged",
+				   _("\n"
+				     "hint: You can replace 'git whatchanged <opts>' with:\n"
+				     "    git log <opts> --raw --no-merges\n"
+				     "\n"));
 
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index fe81c293e3a..5d5ae4afa28 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -626,7 +626,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	}
 
 	if (!i_still_use_this)
-		you_still_use_that("git pack-redundant");
+		you_still_use_that("git pack-redundant", NULL);
 
 	if (load_all_packs)
 		load_all();
diff --git a/git-compat-util.h b/git-compat-util.h
index 9408f463e31..398e0fac4fa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -460,7 +460,7 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 void show_usage_if_asked(int ac, const char **av, const char *err);
 
-NORETURN void you_still_use_that(const char *command_name);
+NORETURN void you_still_use_that(const char *command_name, const char *hint);
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/usage.c b/usage.c
index 35dc57eb07e..7545a616453 100644
--- a/usage.c
+++ b/usage.c
@@ -376,7 +376,8 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 	va_end(ap);
 }
 
-NORETURN void you_still_use_that(const char *command_name)
+
+NORETURN void you_still_use_that(const char *command_name, const char *hint)
 {
 	struct strbuf percent_encoded = STRBUF_INIT;
 	strbuf_add_percentencode(&percent_encoded,
@@ -384,8 +385,13 @@ NORETURN void you_still_use_that(const char *command_name)
 				 STRBUF_ENCODE_SLASH);
 
 	fprintf(stderr,
-		_("'%s' is nominated for removal.\n"
-		  "If you still use this command, here's what you can do:\n"
+		_("'%s' is nominated for removal.\n"), command_name);
+
+	if (hint)
+		fputs(hint, stderr);
+
+	fprintf(stderr,
+		_("If you still use this command, here's what you can do:\n"
 		  "\n"
 		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
 		  "- check if anyone has discussed this on the mailing\n"
@@ -395,7 +401,7 @@ NORETURN void you_still_use_that(const char *command_name)
 		  "  know that you still use this command and were unable\n"
 		  "  to determine a suitable replacement\n"
 		  "\n"),
-		command_name, percent_encoded.buf);
+		percent_encoded.buf);
 	strbuf_release(&percent_encoded);
 	die(_("refusing to run without --i-still-use-this"));
 }
-- 
2.51.0.16.gcd94ab5bf81

