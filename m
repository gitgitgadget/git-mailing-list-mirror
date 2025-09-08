Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C36918A93F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346001; cv=none; b=omeqEkeWNi3X/naA2gc2s0VHG6xAmiazLhvIix5V5oPNa6z8eWjkqE2Tn5fOpH5CYgrLQNU92cWKmmn4Ng3+YOrqDXmvDt4uwUJaXyrxsw0Z7GZhi+zC6MCP/TpzZHSmxkWfFdH5gy0GoDaG/NPzToMiilIrWBxRkU0Hhu0SJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346001; c=relaxed/simple;
	bh=VSSAI7bas9QUmow+KEagF8XSVTDSAA0S+qRlgTf9f3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFWv9aqAteiJZMqxZp5Rq4OKEYqHA3Kl6LfJECqHp9zPi+jduBBdW38J5vKJH+SzATwdTgeeqkSmn/y9OPn7Hi7AqKqMIYF5ClQ/48s54By+mFtjo9LHBQ9t4f70GKaOLPoCLUV/H8Jnnmuc3yz2NbZN+1QIEqbbZkEm9Olrr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gXQhFqOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lvsAZIiw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gXQhFqOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvsAZIiw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C6BCF14000EB;
	Mon,  8 Sep 2025 11:39:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 11:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757345998;
	 x=1757432398; bh=OWi+jm6fC2uzLnrmbevIUpUZxNJ1B8q1epziVTIv7fE=; b=
	gXQhFqOb5VS66d5b2CPrTGOQeg8deJGnqe/dah7RQLLwkkuu3v1TJB5b153IQzJM
	a0MoQgVjIXdPLcHwUZeXQdgT1fZBAtf7h/QRgHdH93WDknGoF+vbSMTCT5Dcsig0
	/JnHS4HbrIx19sHB/14IuF3mJyjvtRyFdJZSx5k4/DngHIrVoMmb83sasPrEXy0S
	wSlMiYilIKq1H4HCOdUJC9HyzRRU/9tSd4MGx8oJ9nxc0L0q8tlDSxKsDYrdgza/
	PyPhxKpKV7gZTSpklENAUNky7RNZA7qQWHhIDDVLnBAr6HWJF2kNhngwMVElU1fF
	O/rFi5smodAm+on8AQwfnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757345998; x=
	1757432398; bh=OWi+jm6fC2uzLnrmbevIUpUZxNJ1B8q1epziVTIv7fE=; b=l
	vsAZIiwySTlCj788ktegWW8AghVrGYc21y5RdOh+QEqyvTZ3SPsBRBPErRljLZiY
	yFf0C2emUy9o8UV3vvRtQ8BNXlxxZO4DoXwMCRSB0CcKWmZch+AZeXtX8OJKPm4C
	wOJY7OP461pEanjwAM9BQLKDDyXZ7j32Baa5QS5PKYyF4jzGiqUFyCLifkckRTmf
	ckg1e68UkFmaUZ/zYz1/o/ZBVXrnVu9Y/ncqkcbuw4kDzWcATQ6ASt+m72+Nwld4
	AUQq9KESZf+ES3oytOmInQpV88TcxNi9XPc69m/fgwsgIoRtXQI2vM9CuWy4XLot
	xYNbIV8ET9aZ+G8o0R/ug==
X-ME-Sender: <xms:zvi-aNpZpKvMtx0D0xtqSATrJuVDfmsZJtzt2fkWV7X6uMO1EDJg4R8>
    <xme:zvi-aKMrlgx7kN3Rk80Nm-kuFA4g-KE-MZW10dyEpuiuwPjRDV7_X876vx1HmNEOZ
    F_8a-6GpggXQ6o92Q>
X-ME-Received: <xmr:zvi-aGwUibSlz9bl8y4bM2yCPK6-R58y7cIRHhDHyF8a86nNZpgCZPTa4B1uKSsB2N3w4-AEI-F6uzXjrskq5eJt8cGxAYrG2_OGEnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepjeffveehteefudekgeehveduueegieevudeigfdtgfefiefgueeutdehteekffej
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithdqshgtmhdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:zvi-aLvvhy_yARCOS6Z1Nuywe4B1VVb3ztg_JLKuA2yktUBZv0EnwA>
    <xmx:zvi-aH5iPdeXz_R4C6tX64H7gXnedhPmtNb8f5M9Wtzq-aeDs9wVFQ>
    <xmx:zvi-aCQ3s2MS45kSF25tZKw1tYUEvoWvm8wDIWvyiGXv_-YRnbYDMQ>
    <xmx:zvi-aOq4NZ8MBA7bhg0SGKkQ5OoTNJuAVS_KXpLojmbDdtmbKsOgAQ>
    <xmx:zvi-aHY6eyP5bbiiAWqa5EbwDC2Ing3j_TcNzyhqT7jviSjI40K07j7F>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:39:57 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 6/8] whatchanged: tell users the git-log(1) equivalent
Date: Mon,  8 Sep 2025 17:36:17 +0200
Message-ID: <50621a0748fd98b061352dce91e9a86e1e930b8d.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name> <cover.1757345711.git.code@khaugsbakk.name>
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

