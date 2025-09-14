Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ECD2B2D7
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879541; cv=none; b=VLzw7XekojK/3i1NGJebS7NKgWzhfcWku27k3jqC4eOnsthHUFpDOuzoFfBayIhpB4w1R8WWDxTobQIEUWZ6Dj3sHZeIjJ4xOWLXD7Li6UpK01GnSIVxFi9eytcIdJjM1svOfPtW6CMoR/SiQ5A5CztmoCZf+qtLnLOupb9yymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879541; c=relaxed/simple;
	bh=Xu5HAjskYBEPBXdKjpKgJIPrnsWyIhaxc1k+6jySDIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goTtvVQORkXUL+olL8+DPqvwcB8Xm1b0ndaP8qO6RKd+VB8neD4EjVwi9HZMcsCFPHZ3OPif156EXeN00vfhXds80EBJ7no/eng7zCQQZ1gpsy60YjUT+ppw7g4/3S6bpSNqFQcbD2rFLWl/dQFmVY8EOsiHtpWnYoeBAz4lvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CIkVDG/e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQ0Wk1RF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CIkVDG/e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQ0Wk1RF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DF7DB1D000F8;
	Sun, 14 Sep 2025 15:52:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 14 Sep 2025 15:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879538;
	 x=1757965938; bh=gYE9YLNEk20ozaj3ZKSUtkwoT/MDWEgFMPCxCXbmX1w=; b=
	CIkVDG/eaKeOe99JJIpFa3P3S4JYHs9wpAdlG9MVGtrxHaWeMlRcYkbsL1Q7cdJv
	7qrNsT1I3uvzWFmKNmRRcq4JpsMpjAEFnZ1sPuCr2k99sBL50iTMBFW5TuMP1rRA
	1KKaKPD4rDAOldJ+6c+q4hyEhfqwYcGzZmWADnkbV90NI2pP4/LYRUHWLnluOPpP
	L6khcMuBchFoz1uZZ/f5HrArJsDN570a07zozeZb7074CXeXfs6MO+VZKomAEFA7
	pka1cuxzjfPlR2hEzdJTwHzIaxOygQxOPr+eyE0H6F76fvEnXXYvs59sG3esDHfb
	R0+lNEXm7FZmCDtrt9K4UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879538; x=
	1757965938; bh=gYE9YLNEk20ozaj3ZKSUtkwoT/MDWEgFMPCxCXbmX1w=; b=a
	Q0Wk1RFbPv7xHhpd1H0TPmXlaBuHoNLzQ+EtOzqeZRLtbpukfKF5xIVfr+lUm+vA
	rbhfaRYm5mvCVQFyrXLC7CNhkymwO0JPb9qujxBavMnWPGsCk1uJbVR3kcrXEuAv
	UBIp7QzGgYdSO4pEQtJbbMthCmLR8d2cj+MS4EbhCZ3FaHmYWY/mEFTHNYNOqz/w
	Gt4uiYy/xrneAaNBMOpZQ3/YK5BOLg7AYpLeyMdqceLY+GAheX1gf7oTg0g8e0Mj
	ghfwnnmM86bekYbaIXvleIlZtwR85dnG8ShHlBLxheeEGLiKRzpETLqjjg8IQndB
	8GeMZ4f5nEW0Xl+QJSrDQ==
X-ME-Sender: <xms:8hzHaM8L8g_AY46YvhiYFeAnAU1YGO5VH1SZt3PQ8EmZVrf2LdACeto>
    <xme:8hzHaNJbQu5Q61M8W0IfZ4-UkWcQSZaKByBlmdZwW8k5kcKNou7vLLhPen1HyqKiQ
    ZzcE8gDXhuW4S5bTg>
X-ME-Received: <xmr:8hzHaCc0RbYhfXOSrOQsGJ0P7f1jAbYrIn5jAspHwK-_eyOZn_y6hQre6fXk7ksNpazK--7JcFKxEJ6ykkjNc5yzs3AL4oaKHPwDlAtqo_G-PQGcuYD5zxp4VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:8hzHaM8NvBSKjrn0Bz1f77B2xk5csvltpTS1UOD-wiTpIb50bb2_Ow>
    <xmx:8hzHaPr5fZRjSbJ32fDo_VRj-ilit9IRYWQEWYiTeRa3T_fik6e8FA>
    <xmx:8hzHaBCCurTjyBpHuf_7xmnHN_La0YvfFkYYklLThiChZzKg3VELkw>
    <xmx:8hzHaBzF0Ul8NAn-HU4w7j5LcWs26o08B0joYEaZ1Y56Af1z0gRDbw>
    <xmx:8hzHaLWeHnbttMXmpxa-NJbBNRUyfOCWST2_zvBZJOIm_I3BIsDoZyG->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:52:17 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 6/8] whatchanged: hint about git-log(1) and aliasing
Date: Sun, 14 Sep 2025 21:49:40 +0200
Message-ID: <3444306664589067a151fc4a50c7a51869bb18de.1757879060.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
References: <cover.1757446619.git.code@khaugsbakk.name> <cover.1757879060.git.code@khaugsbakk.name>
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
2.51.0.16.gcd94ab5bf81

