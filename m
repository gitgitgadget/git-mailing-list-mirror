Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98A19E7F7
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447278; cv=none; b=UfsjZ1PyX+AVuf10QTZ+ebNuqYS4tGlcJ0USAmwkbG9Bl62tAseLKa95aYi+elyuZ402ZlWXKmskjFHCRBuXWbV1c+4oUnHvYHOCkGV0Yc/pXMPBBV9xL4MEqWL3LGeTCkuAiALSKruQCqDw9UziQEfs2h/p4CT7qYM0My1KYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447278; c=relaxed/simple;
	bh=VSSAI7bas9QUmow+KEagF8XSVTDSAA0S+qRlgTf9f3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nu8y8pRaVo2s2Xby2qYAx0xP7Zh6/tOO466tZfvYFyx/AzETgWEg4gKqW/0MaA65mwDMkSdLte9n8sBqR4doQW2w4kmI7zgWzTgxw/Ko/Y0fT9aaGqC1kPYC31KfgAiLLUocOpNrVPlJXnf/PzIlK+3zvwQExpeGy8LIrrJ4ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LJHjejh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lxn4mA6/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LJHjejh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxn4mA6/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E10BEC00FB;
	Tue,  9 Sep 2025 15:47:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 15:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757447276;
	 x=1757533676; bh=OWi+jm6fC2uzLnrmbevIUpUZxNJ1B8q1epziVTIv7fE=; b=
	LJHjejh6zF7g9L3JJ3+/MSSo0JZSXtA4G4UWkrqL8CTYCJwUAUhAyMAzLeROFXFK
	eQ0I5MbQGMD3OoJ5bFrZ1vVXYbBeHk9zJW1DxzpiM8Ac6W3Ict7qsZ+E5g4XDnzT
	zLACVGQmZpJoYyTMg2rEqjff2+6Bri9YNZcVUwBv3+tp+N6PBO0C8kDH7LWnwkr2
	qG8FTIrDrIVVYPKnix+rYC+K/LGDGKXaRpQeuN/A0HF0/nSDE30UIZ8y6cqBNhAX
	MPW8LGZkxS8kEto47y8jwuih7q7IosNS48B1X5R7C4Ty5SN5mSLF5je80FJ45b5o
	O1nq0UuG88nRq4VxzvU71A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757447276; x=
	1757533676; bh=OWi+jm6fC2uzLnrmbevIUpUZxNJ1B8q1epziVTIv7fE=; b=l
	xn4mA6/u5xYwju1USaiYyANEU7mrXY+wnCqItlutGYxgmt7C73bCbB0oaKUpIjXd
	cN6FD97k6UxTT8v09xHVobYBOwFDcQwGVTR41PqAwrOwLCIZXTA9RmFq6n9xzv2J
	m9Kh1TXOQo+T1pf3oQCbWuY3uTjjOW+T3p4bFDMfAEaXaMcdZX3FdeaBP1AT/r0G
	XSJ0H+s5nc54GRi49nkJ9vBRHtlRA1EGbLcmg8qTcOAoJTkUhmPmPt0uOey0RRE7
	Aqvi2TqPhk+DqRG3xDN1Oojih/pNyTC0nHCeUXsLiJ3nVlXf+6MGW2LvIF40PNjB
	sFBFe8yHTnSMscw6oAHUg==
X-ME-Sender: <xms:a4TAaI8IFecTD7VzmPPR3nzhf3Djs3NjrKly9rryVh9lwBDWNPbpCd0>
    <xme:a4TAaMOxi9K_J0nAEO0pXbK8mZpf-t8x06s8FE_zAaVdJMCUjIaIZFr2NZqRUNZ_t
    FU7mCR_B2p0TsGzdg>
X-ME-Received: <xmr:a4TAaEcMlaZ4QlMeU9ZyI8hhixjEq7dW-aBjGdtyosnV-C6eT2XeeasUBDLQ6J3ZTUnpxU1DLTwV1XEGPigvEE7SHANYygk2dQ0_VNrm6TTN8VFRYX6Y7Rmvlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepjeffveehteefudekgeehveduueegieevudeigfdtgfefiefgueeutdehteekffej
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithdqshgtmhdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    ephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:a4TAaDXBB-_zgU71DJZ4NjWSkyov3hGZATAP5a5RjpWzCIBSimgzhg>
    <xmx:a4TAaEg7u9QG1odRmY0mQuEWu9mIM2bnbuYgHVDERlRbCtjajjNbFw>
    <xmx:a4TAaK81lDcyAxiQ0QsRtuaUOxq1cwSZPi5ITPPPHs9o9Jn4YXCiMA>
    <xmx:a4TAaOZWGwkU4R_i9qlkI4iU3l2M5JcuZV_5oOPet83DQeJm60QWxA>
    <xmx:bITAaHixARh59s3xUiakTbynRebWxVL9Hk6J6LzU10wumL3WLPYuY4rP>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:47:54 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 5/7] whatchanged: tell users the git-log(1) equivalent
Date: Tue,  9 Sep 2025 21:45:55 +0200
Message-ID: <58de9767b22ab2563c6afb4bed992301a5772071.1757446619.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757446619.git.code@khaugsbakk.name>
References: <cover.1757345711.git.code@khaugsbakk.name> <cover.1757446619.git.code@khaugsbakk.name>
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
    v3:
    
    Add an alias hint now that that is possible.  Also prefix each hint-line
    with `hint: `.
    
    v2:
    
    Review found a whitespace error in the prev. patch version.  I found a
    broken footnote and wanted to expand on the last footnote.
    
    • Fix whitespace error (I should have used `ci/check-whitespace.sh
      v2.51.0`)
    • Add missing colon (:) to footnote
    • Expand on footnote; a sentence is enough to summarize the difference

 Documentation/git-whatchanged.adoc |  6 +++++-
 builtin/log.c                      |  8 +++++++-
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 usage.c                            | 14 ++++++++++----
 5 files changed, 24 insertions(+), 8 deletions(-)

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
index c2f8bbf8630..1d1e6e9130a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -543,7 +543,13 @@ int cmd_whatchanged(int argc,
 	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
 
 	if (!cfg.i_still_use_this)
-		you_still_use_that("git whatchanged");
+		you_still_use_that("git whatchanged",
+				   _("\n"
+				     "hint: You can replace 'git whatchanged <opts>' with:\n"
+				     "hint:\tgit log <opts> --raw --no-merges\n"
+				     "hint: Or make an alias:\n"
+				     "hint:\tgit config set --global alias.whatchanged 'log --raw --no-merges'\n"
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

