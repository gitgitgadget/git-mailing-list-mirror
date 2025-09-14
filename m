Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513057C9F
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879485; cv=none; b=caW6paCqWHzra11t3UvpUT4E+h+CWJ5F+x8WmGG5GfsUZvclNt0a7T4hBx3e4+Yu7IpuXCT8xuyxePu0W86MK/nOCmi0tfJYrvGy1B33HaxsE5wrzkWZ153YNc/Wq7hHqb4JZRCOe/Vc81Iwp2Shw7eCrKdHt+D67/1NbXiNRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879485; c=relaxed/simple;
	bh=Uyg8ymgab08L2z8kSAd3q1/eAxuJp3xv6zPfR+7lvI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I43KI1StkFhYDl4ZjLsPAzYjtlYEdyQzts8ILAYE1ak5aZutUsjSUFgYt38UaGBq0nX5psNZqalsF0QEIqG+Fs7djz6hWorlOBu1ZzmxKUe/3zd85zphFBa66h8mmH/jJS+7MSINR3Jxloqw0nPlRdp+fmkamhIQ5QW9t/QtjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fAkF484V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZCP7X2K; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fAkF484V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZCP7X2K"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EF3511D00043;
	Sun, 14 Sep 2025 15:51:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 14 Sep 2025 15:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879482;
	 x=1757965882; bh=j2CnjWcJzsEQP7yi3IxY/tnIF8Z6as6+PStSyTN7bHg=; b=
	fAkF484VgfBq8a/LRoCQQv/vmebaDdH2cLygCAijVlVTLvauExPVFrlAhjl/Hod5
	/Cv4jgKe1oox2i9D0vIXKdi5R7j7gV5A53HsTKDSVgANLQWHyjmVwpOXmmOZSDeE
	5BpYiqomWq6hU8D6TWC4lm3dFoRr6lcLWFCc4CUv0P8F11EeVVr4GPGGHZgDJbdv
	Oy9g+bHWrjbtWVZE8sBsm6HwLesvOvnrKtjNIh2zWsqMEDQtOAjaAyernF/uqWFv
	h23yHg+8Be9UJ1BQjHpT63HB+0lcOzPl1xwzvI+01eeGnu1YJ6Yoj+SyI5NaRrfa
	tT5YiuBk3nDaTKy5R3dcyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879482; x=
	1757965882; bh=j2CnjWcJzsEQP7yi3IxY/tnIF8Z6as6+PStSyTN7bHg=; b=D
	ZCP7X2KuBXDs1NoF8QenZ+BxzUvMh6R18K6K0eejvuIiMQ7MWkn56WdhTAFRLDS7
	HEY2fs3/XnhCN7LtW4C7+f3lefOmM2QEHq8BSQq53tPQybquO86I7EEW3KF7ggUX
	NjFJX7KKjUkTNhMKh05uRobnjsqJiKG91hGc+DHUQj+m9L9lqwmD8kQE9UmESIIQ
	TnKsq2Bz7e4jaZR6zYbICVNH11baGmuJD33NlPs/2EasG1HZo93dopDF3D9ACtYn
	gMwzn9pgq8PnVLFZSn0Hdq8iQI86II1OkxSWZBQebBbwT1SONXSfad3+9Aymhqv2
	e+8AxgaAuAvYnagd+8Vzw==
X-ME-Sender: <xms:uhzHaBWYwHu54yV6KOO7cMDE1DXwSnrOTVNzQdP93rdQLdDtqhMmhuo>
    <xme:uhzHaKD5wmtLpE9wOd2sShlHv5T8V2lsO-yGnkNLxLfuEIanD-f5qRHsNHbVcrHmP
    RqaaRh3uUUQrJWAnA>
X-ME-Received: <xmr:uhzHaN14t9FLEsZRbeRJKvADbHQgOl6805sUjQizGKcwLpfw2018TvuBNCM2O7xGzGw_QAHk4UwzD4NGaI35rk_a4j7S0l4idzkcT1296-E_Zhi9jBS0u5qkKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uhzHaE3T5pmIEvRlAHLsD6_jhBdrCpqGcrde76MNHzcj46pgKL2qng>
    <xmx:uhzHaKBESwk4UwpJRXtwSm7Vu5QOmTfDLTszZI24nleK1jLc2R9bFQ>
    <xmx:uhzHaL5uPKYISKBdJaWf-kvBIlA6Sx-eL-NweyxdWlyDg7SkNvlGQw>
    <xmx:uhzHaDLfL-2onZeG5701SE1kMapgLtPFhZ-h1gt6UZbHdQDq2RP1aw>
    <xmx:uhzHaDu2LCk0fYfJ8m9owtcGomgTh1aG6bA-1HEZm9GCJFn6781VImjd>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:51:21 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 3/8] git: allow alias-shadowing deprecated builtins
Date: Sun, 14 Sep 2025 21:49:37 +0200
Message-ID: <4bfe36cccd03fd822fc40c24bb46d4e237d11ac4.1757879060.git.code@khaugsbakk.name>
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

git-whatchanged(1) is deprecated and you need to pass
`--i-still-use-this` in order to force it to work as before.
There are two affected users, or usages:

1. people who use the command in scripts; and
2. people who are used to using it interactively.

For (1) the replacement is straightforward.[1]  But people in (2) might
like the name or be really used to typing it.[3]

An obvious first thought is to suggest aliasing `whatchanged` to the
git-log(1) equivalent.[1]  But this doesn’t work and is awkward since you
cannot shadow builtins via aliases.

Now you are left in an uncomfortable limbo; your alias won’t work until
the command is removed for good.

Let’s lift this limitation by allowing *deprecated* builtins to be
shadowed by aliases.[4]

The only observed demand for aliasing has been for git-whatchanged(1),
not for git-pack-redundant(1).  But let’s be consistent and treat all
deprecated commands the same.

[1]:

        git log --raw --no-merges

     With a minor caveat: you get different outputs if you happen to
     have empty commits (no changes)[2]
[2]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM/
[4]: The test “looping aliases - deprecated builtins” covers the
    case of the extra output mentioned in footnote number 3 of the
    previous commit

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v5:
    
    Fix a leak caused by calling `alias_lookup(...)` without freeing the
    return value by not calling that function.
    
    Add tests for deprecated builtins for infinite alias looping as well as
    simple chaining.  This is to exercise all code paths that we could think
    of.
    
    Expand on the infinite alias looping test on the whole error
    output (compared to the one above).  Link this change to the
    previous patch/commit by mentioning it in a footnote.
    
    See the last footnote and the note on the previous commit/patch.  I have
    opted not to get rid of this redundant line.  But this documents the
    change and future changes that affect it will trigger this
    assertion (say if they remove the redundant line).
    
    v4:
    
    Better `is_deprecated_command` implementation.
    
    v3 (new):
    
    Prerequisite for telling the user that they can alias `whatchanged` to
    `git log --raw --no-merged`.
    
    Link: https://lore.kernel.org/git/cover.1756311355.git.code@khaugsbakk.name/T/#md434b0968f499263262fb1805d82b788b8349d9a
    
    > I think that is good advice, but... it won't do anything until we
    > actually drop the whatchanged command, since until then we'll refuse to
    > override the command (even the crippled --i-still-use-this one).
    >
    > We'd need something like the patch here:
    
    ❦
    
    The
    
        test_file_not_empty expect
    
    is here because the git(1) command could fail.  Make sure that it did
    indeed output anyhing on stdout.  (Or if a previous redirect to `expect`
    outputted something it should be completely different to `actual` in any
    case)
    
    I don’t know if this is just a waste.

 Documentation/config/alias.adoc |  3 ++-
 git.c                           | 17 ++++++++++++++
 t/t0014-alias.sh                | 41 +++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 2c5db0ad842..3c8fab3a95c 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -3,7 +3,8 @@ alias.*::
 	after defining `alias.last = cat-file commit HEAD`, the invocation
 	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
 	confusion and troubles with script usage, aliases that
-	hide existing Git commands are ignored. Arguments are split by
+	hide existing Git commands are ignored except for deprecated
+	commands.  Arguments are split by
 	spaces, the usual shell quoting and escaping are supported.
 	A quote pair or a backslash can be used to quote them.
 +
diff --git a/git.c b/git.c
index f9c2d8c8d86..1310363e5c4 100644
--- a/git.c
+++ b/git.c
@@ -823,12 +823,29 @@ static void execv_dashed_external(const char **argv)
 		exit(128);
 }
 
+static int is_deprecated_command(const char *cmd)
+{
+	struct cmd_struct *builtin = get_builtin(cmd);
+	return builtin && (builtin->option & DEPRECATED);
+}
+
 static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
 	struct string_list expanded_aliases = STRING_LIST_INIT_DUP;
 
 	while (1) {
+		/*
+		 * Allow deprecated commands to be overridden by aliases. This
+		 * creates a seamless path forward for people who want to keep
+		 * using the name after it is gone, but want to skip the
+		 * deprecation complaint in the meantime.
+		 */
+		if (is_deprecated_command(args->v[0]) &&
+		    handle_alias(args, &expanded_aliases)) {
+			done_alias = 1;
+			continue;
+		}
 		/*
 		 * If we tried alias and futzed with our environment,
 		 * it no longer is safe to invoke builtins directly in
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 854d59ec58c..2f71c3265f0 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -27,6 +27,21 @@ test_expect_success 'looping aliases - internal execution' '
 	test_grep "^fatal: alias loop detected: expansion of" output
 '
 
+test_expect_success 'looping aliases - deprecated builtins' '
+	test_config alias.whatchanged pack-redundant &&
+	test_config alias.pack-redundant whatchanged &&
+	cat >expect <<-EOF &&
+	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
+	${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
+	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
+	fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ} does not terminate:
+	  whatchanged <==
+	  pack-redundant ==>
+	EOF
+	test_must_fail git whatchanged -h 2>actual &&
+	test_cmp expect actual
+'
+
 # This test is disabled until external loops are fixed, because would block
 # the test suite for a full minute.
 #
@@ -55,4 +70,30 @@ test_expect_success 'tracing a shell alias with arguments shows trace of prepare
 	test_cmp expect actual
 '
 
+can_alias_deprecated_builtin () {
+	cmd="$1" &&
+	# some git(1) commands will fail for `-h` (the case for
+	# git-status as of 2025-09-07)
+	test_might_fail git status -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias."$cmd"=status "$cmd" -h >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'can alias-shadow deprecated builtins' '
+	for cmd in $(git --list-cmds=deprecated)
+	do
+		can_alias_deprecated_builtin "$cmd" || return 1
+	done
+'
+
+test_expect_success 'can alias-shadow via two deprecated builtins' '
+	# some git(1) commands will fail... (see above)
+	test_might_fail git status -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias.whatchanged=pack-redundant \
+		-c alias.pack-redundant=status whatchanged -h >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.51.0.16.gcd94ab5bf81

