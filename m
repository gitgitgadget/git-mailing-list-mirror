Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7F1A9F86
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140853; cv=none; b=k4d3cC2xinLDSsheZTi++T7Iq7rPKTzy9Hml0Er1IJaPrh96D8nhlNj+y4DmWUGp6KV60Jm6gdxnbdOS2jBJx8GZqvZbbmIyjwUo1dQ9PKkW+r3rsiy/Bqa0xrmwXrjRQ6qznUXqMdUsgOAM8Rd53gQxpcyNqshC6zGPseidFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140853; c=relaxed/simple;
	bh=vT9918IBQUxHwVrgLnkfS3GytIpTENWFrH2CmmVBpm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pohaAx/3278vnEKOT3SE5/fq2lttXPDjikBx8ghErw83PRRH3+NscZlDRAcBd9q8cAG//SnyZjqolvtGRVZmCfrxfSnh1QuALHLdqKiUnJUChF4O4I+wuK29I5x8USbcVJ0rk0FMXiWLQKqXs1G0QKm9k+xmZcDHOA9JOJ21aW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IvuUyh69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIxagjju; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IvuUyh69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIxagjju"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F4F4EC027D;
	Wed, 17 Sep 2025 16:27:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 17 Sep 2025 16:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140850;
	 x=1758227250; bh=OSYUeBRdHu/0spDw7Oflck9tHhdF7iDdzxTwTiix2OY=; b=
	IvuUyh697CWlLBBYeLEotSAujMAIr0TRt992jUiW0suSCJqZKMX7PPekvMlRG542
	53ED5K0zGx0XJ+MYIiAL2a1YMKnuSpeoea7uGooeofknh2VKT6ChW992/12PNXJK
	4laqEbjp8jmA1f1ZIQPRKbc1gCi6wxv2PQnIgL40WmisyXWNKVzF3y4HQDi7hMWv
	p32h3/xCiTgHA8uLMp+GcvT+4Jo4UzN2n8p1TnXYX/PpLtkIHOjxay6cD5w+j7w/
	YDcjLHptz2BOcfIXykVJJkfl9Ts8sJgya2KvkUa+DIJ/nRgkMY7F2eC/8LYuk5TP
	/dzDdFan1X0329oxWIInAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140850; x=
	1758227250; bh=OSYUeBRdHu/0spDw7Oflck9tHhdF7iDdzxTwTiix2OY=; b=L
	IxagjjuKTQfGXYMNKQzUlzTaKSBDn5wUfG3Rekinm111oBALYVJqt2Ed5a3dForL
	3FH/UgrEwy5MhoBi2rb6aY4eyt2TxciBX2XCzm+KE9OqQ/7rW8KPBAAh+Je6tTRX
	nBC9h3P15VkIU11Io+K45noSsruTC4LDcnur4FyNeNEg0nVYSRO7FTk3oh3tqGIx
	GPmO5LNTOdzoqKwWoc4jIauUtSi8WiNbRJvFFdVFlXlG+iGl7hdm2F5v+amiYorA
	d+j3sFav1PDLjwGA+nlTRHCaZxgmrAFeu5EcNVflKblRjxINOUoVONVK3ynCsQTX
	wlu39lq9L7tiu5f5YyatA==
X-ME-Sender: <xms:shnLaHFVS_u38SAwaOxJ6vuXod9ETdVZbOmguEvWmZCU7W98PvzaxXo>
    <xme:shnLaMxBxrgxZj7MVdgKtvKZZcnlln-Rgufd62OytHfB8nygzKNwhtffYckz_x4n4
    24tzVi3Rkn18KBTlQ>
X-ME-Received: <xmr:shnLaJm7hD-bjyI7Ju_22cLrXKkKlrLTh-nMul7SpwancdYoiH--83_uuHXTcU_9qt_T6yUV799P7b5gXNfAE59KdGCUbCWCiuuBIMrUNU6UAxoEtI3B7TbG4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepjeffveehteefudekgeehveduueegieevudeigfdtgfefiefgueeutdehteekffej
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithdqshgtmhdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:shnLaFklkVFmrTM_CQjm3q4-cAJJAqRVOQorz_8SXURgn_unrj1aNg>
    <xmx:shnLaLz7lk3YsKXnlrYpTKkpIYMnFwnkPSGjN74_6f_VL7vu_8_QoA>
    <xmx:shnLaKqNzNY2gw2QJpdtIuEGFQFrV1g4j8n1ujVccAI1vLnO3snYpA>
    <xmx:shnLaK4R5T-vIP_tkOwRsJ6y7WAevyUshRiVkxCKd1mEqck5xgyIIA>
    <xmx:shnLaBdQe5e7iV0Fo8Glj0pUkMfcNv5gSdvlRxzPyPuTUCRoYPWsUmO6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:27:28 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 7/9] whatchanged: hint about git-log(1) and aliasing
Date: Wed, 17 Sep 2025 22:24:17 +0200
Message-ID: <b0831.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name> <cover.1758139856.short.code@khaugsbakk.name>
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

Tell them what options to plug into git-log(1), either as a replacement
command or as an alias.[3]  That template produces almost the same
output[4] and is arguably a plug-in replacement.  Concretely, add
an optional `hint` argument so that we can use it right after the
initial error line.

Also mention the same concrete options in the documentation while we’re
at it.

[1]: E.g.,
    • https://lore.kernel.org/git/e1a69dea-bcb6-45fc-83d3-9e50d32c410b@5y5.one/
    • https://lore.kernel.org/git/1011073f-9930-4360-a42f-71eb7421fe3f@chrispalmer.uk/#t
    • https://lore.kernel.org/git/9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.org/#t
    • https://lore.kernel.org/git/83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com/
[2]: The error message on 2.51.0 does tell them to report it, unconditionally
[3]: We allow aliasing deprecated builtins now for people who are very
    used to the command name or just like it a lot
[4]: You only get different outputs if you happen to have empty
     commits (no changes)[4]
[5]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v5:
    
    Mention the aliasing hint in the commit message.
    
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
2.51.0.274.gdcb64e51a0f

