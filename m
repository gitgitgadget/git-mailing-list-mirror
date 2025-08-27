Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB646A926
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312247; cv=none; b=YaMBo05xg1vp/CM4joIMIkaXnNUrPwXoU0rye85rGUgliXLSarsD67BDfR4DmnOR6/CP4V5tE7i029mPulREsmqpOo/zS/oH7fWjPHSWs9lZVcmnX1arsdNaFjDj7GAvw3MV8G3Vl35buzUTNr7o+0t7j4WjorfBD4eeLu0JyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312247; c=relaxed/simple;
	bh=7WmcJoTB7RtoNNh3OSApIuJ+ydQln89dLTXeTQ1bAKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTpBi3GDW/b/YwtVcm7IWoc8cj0qJwPFFbkX5hUX5Sk5xmN5lilszdWXx1XeVjFgGEtFsJ93NwHNz39cqzdz2ULd6OnJc1hLKSXQVkl7ZRYhahDoKw2n3Z7mRf5rdaRCm48MQmfJ/OQdpC8C6mmOCSCH0GsZKSqFwl5BHQOVuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jT1vvETg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqn53eBI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jT1vvETg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqn53eBI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EECF140017D;
	Wed, 27 Aug 2025 12:30:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 12:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756312245;
	 x=1756398645; bh=dJO8CfrdxE1ieUhppVubyJMfi0VyaKWeCahtzfSZpR8=; b=
	jT1vvETge/XuaD4KUpAVIM/t6go/MngY7pTr7mE12B+1HgQu/Xcyp1SepSv219bd
	cJ8in+UL37v6RVe1xvixugLiylJ+CkkFxDU21cPCX4nujknKV08RmC/TVlUahBhh
	7eHlCbaL5gBP7I2So7b44u9BbkrGU2BuC+c7mIQ7EvSeLFRCheSh/YGK6dJLo/Fm
	Q8XZaKme2i2cUpZ7sfv8FENLNdQKfiWCsCifXWjStEzKvfM+v7z9IfK1m7Q8RW19
	1ik6Xiny2RhldGFf7i1RnB8LURR3kOSyW9LesZ53lJ49JEunR34Yobfxb/9YR4px
	gR4KahbrWpUbQErAWyAHiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756312245; x=
	1756398645; bh=dJO8CfrdxE1ieUhppVubyJMfi0VyaKWeCahtzfSZpR8=; b=g
	qn53eBI9YYPNtXAZwynRJvgUDPWavtrweRyikwJ9fndzy3AFlqUQXO48Y0657dAj
	nJGQfcD1fEYNoItvaLmlBHkzqPxKBx+ADd28e4AHIm9bnjKD22QL3CJ8P1WH3AGA
	PcHg2KWEzv0226MYSNL7UaOUR4M8bf2uJRKTgKzV7aR5XsvEvrBGivL25RBn92Ge
	aLohysB9gK77Cm9R30D2I0aSKBY1cJCUbg2fuo/3GdWz6piQI0kFu4HErm8Z7K8u
	gqglczQ2zxtNZvEOhiohKl8r7iA3QX6fY4WpNIutEgf6bXEPGwsfSk/gMSpUftr1
	OYy6pdUb8QVu9mn1Zd3DA==
X-ME-Sender: <xms:tDKvaCGNP0FDKViCCffBGYN8skIQdAR8_vaP6ywSps1cHvRvygpZXTk>
    <xme:tDKvaDizj80rIJI6fDMzuHtIBNRcBnmSFxfrHd0QEChy409NFx-EUf4WS7Uje6HAg
    ac4y0Y1_YWt5qDI-w>
X-ME-Received: <xmr:tDKvaN_nrZDdfPWYQwIILvVj8aavE9Jhys-MnzqiFV1qYDgjxpJ5oPFh_reYdJoURx3QVLca9ZxenjdP8uIV0djCsTXR3LRWyP032Us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepjeffveehteefudekgeehveduueegie
    evudeigfdtgfefiefgueeutdehteekffejnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghdpghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:tTKvaKqRuOVjOTRQ6Yzv66WAKed1Tq8oWWuK4kK1DncP-bKVYNszDg>
    <xmx:tTKvaM-sxPTsb9TqUYKqk6_MqLgI9m7434aKcsLorxwpj0wLrRBF8A>
    <xmx:tTKvaOVAaJfUlLFqwZGWJPhZ8A1HT6xT1UlRcDncSSRUdsJQUg4oXg>
    <xmx:tTKvaCBXnzyzG7y11xKj8muVypEb9loQ4H_ExIHECqNllKz9yKR3PA>
    <xmx:tTKvaEqtSpcZ99ph1rz85PwsYYxndtKsvu-MBMunEondEUc-gkWbIaTR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:30:44 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/4] whatchanged: tell users the git-log(1) equivalent
Date: Wed, 27 Aug 2025 18:29:47 +0200
Message-ID: <5407c0955af7b5bb30fbc32264481990b2e4e8b8.1756311355.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.11.g23cedd8a747
In-Reply-To: <cover.1756311355.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name>
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
[2] The error message on 2.51.0 does tell them to report it, unconditionally
[3]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-whatchanged.adoc |  6 +++++-
 builtin/log.c                      |  8 ++++++--
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 usage.c                            | 14 ++++++++++----
 5 files changed, 23 insertions(+), 9 deletions(-)

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
index c2f8bbf8630..2f9e5e5a898 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -542,8 +542,12 @@ int cmd_whatchanged(int argc,
 	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
 
-	if (!cfg.i_still_use_this)
-		you_still_use_that("git whatchanged");
+        if (!cfg.i_still_use_this)
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
index 29988395f19..c661561b149 100644
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
@@ -393,7 +399,7 @@ NORETURN void you_still_use_that(const char *command_name)
 		  "  help you: https://lore.kernel.org/git/?q=%s\n"
 		  "- send an email to <git@vger.kernel.org>\n"
 		  "\n"),
-		command_name, percent_encoded.buf);
+		percent_encoded.buf);
 	strbuf_release(&percent_encoded);
 	die(_("refusing to run without --i-still-use-this"));
 }
-- 
2.51.0.11.g23cedd8a747

