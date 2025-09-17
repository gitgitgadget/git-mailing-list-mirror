Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA41A9F86
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140796; cv=none; b=u/9BDvjtnH09D4hl+iJuNsOlq06jocUBmshxI9pGW06eSXuLw/kOPIsQM0tn7/yRgdSbcr3APTEI6ZAcPNpsb+nzIybaJkIObJDBg5Qu0IrERJve93sGFET9dnLujS8FwJsVA3C4RgUwHHKXxepyaK80hH5wYmJXW2VllxTZUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140796; c=relaxed/simple;
	bh=WWmvf8ZzUznrX0Y2SHQ6y+NjMdjSUzRCOZXGnZ2QVz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juAnebqyVxwRBtnp6Q21/JPCZ23j/2sc83IQ0v6qo7THO8FQKgxq1eFVJn5eAIZjdlaX9luem7sNC0aGSIDn0QQwr85jDKT30pQnZSQEMryAkOCfiMg7ifbYGTRAr4GXSl2+2KaNyilocXWZAHsOKXE8I9tREwulUli8g1zDCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=l+TmHbZi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cd8NXlEg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="l+TmHbZi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cd8NXlEg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED338140020B;
	Wed, 17 Sep 2025 16:26:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 17 Sep 2025 16:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140793;
	 x=1758227193; bh=elAPpc6HqTzuu2m+PL0rnh3/eolN9aPokHFqmLFgXVU=; b=
	l+TmHbZi0LCcgQunGYGVKF2nXI9VkNnLvvGaRoLSeE1BAXIQDIGZhMUokhqyYd/9
	YMWqhBEuBl4q0k4GQg/CBwYGpLrzFH2pJ3mcWyfItQ5g3llLJJ9wBxFbipTtZpX8
	Zy9ZWV9ZLA9OohJQ0D7uk3Q+CBpS+fq1F+HuUZKssdmzUh18ikEQ9NyBrMaPCIMJ
	v9ebthPMWRNBpdBJ41G8HtIKqY9+MDCJAr4wVuiOj4UWSAvFOg3a72qG/fO1mk/e
	/g3icpVuCOHXGB9Ufn2rHZe+Z5r/KdXDmnwCMP7N9rOjEcWe8+xoKrhes6q5DGiz
	HF9SVnHw7Xqd3dtqOx0bIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140793; x=
	1758227193; bh=elAPpc6HqTzuu2m+PL0rnh3/eolN9aPokHFqmLFgXVU=; b=C
	d8NXlEgZxfxdwi05WTmwTfgM3Io1eb3OLZmeJNYbjFK6GIsK6zjJb91/eCRdWoB/
	UMT17FWEEKomS9gr5Ez4XTiFj5T3CKZK1gUTBkbhn1IzJuyEFafzjsEStbXZQaTv
	RZ5pGOu6tlpB6gTOHZQHAYQWzbdXbQjwmEGIN4zBap17PpiC77c19haWAn6b4Qb+
	t+W2tU2yP5e8AUzM+PxA8MQwHwzwyG2lY73lTnkCp8hT1tJJokQ9/hQ7cQLhhYfh
	+1uspPGY3wLF6ivhPc2Z2OqwvAcMKtX17N4oNEH/M+fxz6TPhmn8v89+E2yHGsmr
	E52ynJtDEppV2r/3r5/9A==
X-ME-Sender: <xms:eRnLaEMUUnl6rqzkOUnzRaT9_fCVb5j9C03r1ce2Q6qU3ZPeyc0e5Rg>
    <xme:eRnLaDYtrnazgUfIhjdPNruCqi-gQkep_GjlRiW_Jhr3CW0qswJOUi6RBWmaQebcw
    xkmxF9BCZB2MkUalA>
X-ME-Received: <xmr:eRnLaLszfWp6QeXaUI8Pi4lJk-59_F6ouezif-58zAxTKXTAY7U6OTOcyN8Z5EPnjOeaHXIstCpEbnr97ZCDAcWVZ44N9Zxwp-pZvJzBj0iW627NZLnBZhmmTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:eRnLaNPXohRaBf6QWJ6XkiPvN38b2wMRBCe23EHD99M1f6bIDhobXQ>
    <xmx:eRnLaK6V8Zbqr27jgm7irJGapI9RmKKc6xlPof2-_Diqm930nxeOJg>
    <xmx:eRnLaLSFxz-p8xVs5Wxa0HE67d907mULUjmRn2_ESiyJp3lp_GNJ7Q>
    <xmx:eRnLaPCp0cKKyKr5XFRvfDjUPQGlJeZcRbsvt0s_VCbmLkXFEwDFew>
    <xmx:eRnLaKlwCaKhwhPkCePIspX4s06DD1sW417FyHrPL5eETbb4Q1K2f3a4>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:26:31 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 4/9] git: allow alias-shadowing deprecated builtins
Date: Wed, 17 Sep 2025 22:24:14 +0200
Message-ID: <2cac7.1758139856.short.code@khaugsbakk.name>
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
shadowed by aliases.

The only observed demand for aliasing has been for git-whatchanged(1),
not for git-pack-redundant(1).  But let’s be consistent and treat all
deprecated commands the same.

[1]:

        git log --raw --no-merges

     With a minor caveat: you get different outputs if you happen to
     have empty commits (no changes)[2]
[2]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM/

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v6:
    
    Drop footnote now that we don’t have the “extra output line” problem.
    
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
 t/t0014-alias.sh                | 40 +++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

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
index ef1e7b205aa..8c85da84c30 100644
--- a/git.c
+++ b/git.c
@@ -824,12 +824,29 @@ static void execv_dashed_external(const char **argv)
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
index 854d59ec58c..1b196ed9d6d 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -27,6 +27,20 @@ test_expect_success 'looping aliases - internal execution' '
 	test_grep "^fatal: alias loop detected: expansion of" output
 '
 
+test_expect_success 'looping aliases - deprecated builtins' '
+	test_config alias.whatchanged pack-redundant &&
+	test_config alias.pack-redundant whatchanged &&
+	cat >expect <<-EOF &&
+	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
+	${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
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
@@ -55,4 +69,30 @@ test_expect_success 'tracing a shell alias with arguments shows trace of prepare
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
2.51.0.274.gdcb64e51a0f

