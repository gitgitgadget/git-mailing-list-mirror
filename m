Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727E0C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 09:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbiDEJyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348783AbiDEJsf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 05:48:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD9070856
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 02:35:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so18347585ejd.9
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=W1/3/BU54Ax3+OJjcR6gxUvcy5TJs0ClIBQDLB47VBc=;
        b=A8zEoy9/Oatpe/lFgXXazS4kJ2p387du/t4XbTPRAHR2KwTbptFeoBsCUVFfpXDL1j
         lBJyRejxq+VbPp9R+2OlcJLcSS+JpbHFG5kG4bFblyReYAjQCiIazg8aLlm4xFystpwv
         SUTo4F17Q1mo5x5xtURDXddef1kLEWHVrUgdYM9ftt5GwFvE76jA/BtbvwdyBMfvc45W
         9x4CcJd4AwXykT8gUv4+M5swG1KcU/YzsZI2T0c+aB3lh5Aa46F1GNdugAE6qEhZ+IcQ
         Rb7JXvcZDYsJzkuzdkBxw+uQNAgvqsGRrhwHJQs0xEDQSsub+VrygkZgMJym9AEiMRHG
         /ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=W1/3/BU54Ax3+OJjcR6gxUvcy5TJs0ClIBQDLB47VBc=;
        b=wBMLmEQaBh+XZrDJ+x+EOzIv1tPAplbdI2VQLGuwxWlnf1n/4pn4jnqIvWK7wuepJ9
         MII8cXqUIboQFY+Mp7QS/fKQYjXpuq4LRaFggDhTRQHJP6mBMNl20w3iFV9IhXfbdWfQ
         5ZKKWGTMXv6AdEac3RuwvWTGNXlJ+vLmV9wb1SWTcFGyR7EWlXiBuFtHgZjxJjnIC+w2
         qMMr721getcgEKQh2ls7QEQthbVX7ZDbP0fO5wKSkrSeZs9mtD8bUZQa6/4XvY2j5Gy9
         h4/giMmA1Z/ATLgFTgVL3DNjqwBod9Jr45vx7L2yOIw3uHMuiL1ozOasrxeomkbnuYjd
         0UFA==
X-Gm-Message-State: AOAM5324uIWPZqC1vZltU/uxnfBSF/MD2JfM6ATmaA3+QZSD7ZOi6yvM
        LBYtyjXtwFNe95GwhC8oWwAHlWoTgerwvA==
X-Google-Smtp-Source: ABdhPJxzum5bQxN3d0w8gc5JannGS0OxL2f4TiptyMHlfusMAZI6h+Ew+CfiO9Jj/toP1Rl+bHnTag==
X-Received: by 2002:a17:906:6a1f:b0:6df:9189:7ac7 with SMTP id qw31-20020a1709066a1f00b006df91897ac7mr2631375ejc.727.1649151309496;
        Tue, 05 Apr 2022 02:35:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709062a5700b006ccd8fdc300sm5193700eje.180.2022.04.05.02.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:35:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbfae-002s5Q-3z;
        Tue, 05 Apr 2022 11:35:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        prohaska@zib.de, eyvind.bernhardsen@gmail.com,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2] convert: clarify line ending conversion warning
Date:   Tue, 05 Apr 2022 10:45:51 +0200
References: <20220405053559.1072115-1-alexhenrie24@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220405053559.1072115-1-alexhenrie24@gmail.com>
Message-ID: <220405.86sfqrlvoz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 04 2022, Alex Henrie wrote:

Friendly hint: just for the future: Please use the --in-reply-to of
git-format-patch when submitting re-rolls, so threading with the
original thread won't be broken.

> The warning about converting line endings is extremely confusing. Its
> two sentences each use the word "will" without specifying a timeframe,
> which makes it sound like both sentences are referring to the same
> timeframe. On top of that, it uses the term "original line endings"
> without saying whether "original" means LF or CRLF.
>
> Rephrase the warning to be clear about when the line endings will be
> changed and what they will be changed to.
>
> On a platform whose native line endings are not CRLF (e.g. Linux), the
> "git add" step in the following sequence triggers the warning in
> question:
>
> $ git config core.autocrlf true
> $ echo 'Hello world!' >hello.txt
> $ git add hello.txt
> warning: LF will be replaced by CRLF in hello.txt
> The file will have its original line endings in your working directory
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> v2:
> - Quote the confusing warning in the above commit message
> - Move the file name to the beginning of the warning message

In case that's in response to my v1 review, I was pointing out pretty
much the opposite, i.e. try with this:
	
	diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
	index 7f80f463930..26b939566d4 100755
	--- a/t/t0027-auto-crlf.sh
	+++ b/t/t0027-auto-crlf.sh
	@@ -100,7 +100,12 @@ commit_check_warn () {
	 	do
	 		fname=${pfx}_$f.txt &&
	 		cp $f $fname &&
	-		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
	+		cp $f $fname &&
	+		cp $f $fname.1 &&
	+		cp $f $fname.2 &&
	+		cp $f $fname.3 &&
	+
	+		git -c core.autocrlf=$crlf add $fname*
	 	done &&
	 	git commit -m "core.autocrlf $crlf" &&
	 	check_warning "$lfname" ${pfx}_LF.err &&

Then run with -vixd, we'll without your change emit e.g.:
	
	+ git -c core.autocrlf=true add crlf_true_attr__CRLF_mix_LF.txt crlf_true_attr__CRLF_mix_LF.txt.1 crlf_true_attr__CRLF_mix_LF.txt.2 crlf_true_attr__CRLF_mix_LF.txt.3
	warning: LF will be replaced by CRLF in crlf_true_attr__CRLF_mix_LF.txt.
	The file will have its original line endings in your working directory
	warning: LF will be replaced by CRLF in crlf_true_attr__CRLF_mix_LF.txt.1.
	The file will have its original line endings in your working directory
	warning: LF will be replaced by CRLF in crlf_true_attr__CRLF_mix_LF.txt.2.
	The file will have its original line endings in your working directory
	warning: LF will be replaced by CRLF in crlf_true_attr__CRLF_mix_LF.txt.3.
	The file will have its original line endings in your working directory

But with your change applied:

	+ git -c core.autocrlf=true add crlf_true_attr__CRLF_mix_LF.txt crlf_true_attr__CRLF_mix_LF.txt.1 crlf_true_attr__CRLF_mix_LF.txt.2 crlf_true_attr__CRLF_mix_LF.txt.3
	warning: In 'crlf_true_attr__CRLF_mix_LF.txt', LF will be replaced by CRLF the next time Git touches it
	warning: In 'crlf_true_attr__CRLF_mix_LF.txt.1', LF will be replaced by CRLF the next time Git touches it
	warning: In 'crlf_true_attr__CRLF_mix_LF.txt.2', LF will be replaced by CRLF the next time Git touches it
	warning: In 'crlf_true_attr__CRLF_mix_LF.txt.3', LF will be replaced by CRLF the next time Git touches it

Now, the existing message really sucks, we should really should
buffering this up somehow and saying "here's the problem with these N
files\n<list of N>".

See Tao's recent e4921d877ab (tracking branches: add advice to ambiguous
refspec error, 2022-04-01) for an example

But having a message in the form of:

    %s blah blah

As opposed to:

    blah blah %s

Where %s is going to be expanded as a path is IMO worse, because both
are repetative, but at least with the latter the constant part of the
message is aligned.

But anyway, while I'm still iffy about this change because it seems like
a bit of improvement and a bit of regression.

Especially as we don't offer the working directory advice at all, and
because the clear explanation about what happens to the file has been
replaced by some "the next time Git touches it" suggestion.

Which, if I wasn't looking at the pre- and post-image would completely
confuse me.

Anyway.

I'd much rather have us focus less on re-arranging the deck chairs on
the Titanic here.

The real issue is that we're emitting this long message in a loop. Now,
I was expecting that it would be painful to do something like Tao's
change since we're deep in the guts of convert.c, but if I set a
breakpoint on warning in gdb I'll get:
	
	(gdb) bt
	#0  warning (warn=0x77ed12 "In '%s', LF will be replaced by CRLF the next time Git touches it") at usage.c:285
	#1  0x0000000000572479 in check_global_conv_flags_eol (path=0x8a1e84 "LF", old_stats=0x7fffffff7af0, new_stats=0x7fffffff7ac8, conv_flags=18) at convert.c:207
	#2  0x000000000056fd49 in crlf_to_git (istate=0x855f70 <the_index>, path=0x8a1e84 "LF", src=0x8a21b0 "$Id: ", '0' <repeats 40 times>, " $\nLINEONE\nLINETWO\nLINETHREEHREE", len=73,
	    buf=0x7fffffff7bf8, crlf_action=CRLF_AUTO_CRLF, conv_flags=18) at convert.c:537
	#3  0x000000000056f88d in convert_to_git (istate=0x855f70 <the_index>, path=0x8a1e84 "LF", src=0x8a21b0 "$Id: ", '0' <repeats 40 times>, " $\nLINEONE\nLINETWO\nLINETHREEHREE", len=73,
	    dst=0x7fffffff7bf8, conv_flags=18) at convert.c:1428
	#4  0x0000000000619a4b in index_mem (istate=0x855f70 <the_index>, oid=0x7ffff7bfda98, buf=0x8a21b0, size=73, type=OBJ_BLOB, path=0x8a1e84 "LF", flags=1) at object-file.c:2179
	#5  0x0000000000616650 in index_core (istate=0x855f70 <the_index>, oid=0x7ffff7bfda98, fd=4, size=73, type=OBJ_BLOB, path=0x8a1e84 "LF", flags=1) at object-file.c:2265
	#6  0x000000000061621c in index_fd (istate=0x855f70 <the_index>, oid=0x7ffff7bfda98, fd=4, st=0x7fffffff7e88, type=OBJ_BLOB, path=0x8a1e84 "LF", flags=1) at object-file.c:2313
	#7  0x000000000061682e in index_path (istate=0x855f70 <the_index>, oid=0x7ffff7bfda98, path=0x8a1e84 "LF", st=0x7fffffff7e88, flags=1) at object-file.c:2334
	#8  0x0000000000657b26 in add_to_index (istate=0x855f70 <the_index>, path=0x8a1e84 "LF", st=0x7fffffff7e88, flags=0) at read-cache.c:830
	#9  0x0000000000658183 in add_file_to_index (istate=0x855f70 <the_index>, path=0x8a1e84 "LF", flags=0) at read-cache.c:863
	#10 0x000000000040a48a in add_files (dir=0x7fffffff8020, flags=0) at builtin/add.c:469
	#11 0x0000000000409aa1 in cmd_add (argc=428, argv=0x7fffffff8518, prefix=0x0) at builtin/add.c:681
	#12 0x0000000000407cbb in run_builtin (p=0x8237f0 <commands>, argc=429, argv=0x7fffffff8510) at git.c:465
	#13 0x0000000000406772 in handle_builtin (argc=429, argv=0x7fffffff8510) at git.c:719
	#14 0x0000000000407696 in run_argv (argcp=0x7fffffff83bc, argv=0x7fffffff83b0) at git.c:786
	#15 0x0000000000406531 in cmd_main (argc=429, argv=0x7fffffff8510) at git.c:917
	#16 0x000000000051202a in main (argc=432, argv=0x7fffffff84f8) at common-main.c:56
	(gdb)

Which was a pleseant surprise, i.e. here we're dealing with the "struct
index_state" all the way down to the warning caller.

So that seems like a good candidate for this. Let's try:
	
	diff --git a/builtin/add.c b/builtin/add.c
	index 3ffb86a4338..189a7337fa1 100644
	--- a/builtin/add.c
	+++ b/builtin/add.c
	@@ -447,6 +447,11 @@ static int add_files(struct dir_struct *dir, int flags)
	 {
	 	int i, exit_status = 0;
	 	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
	+	struct string_list crlf2lf = STRING_LIST_INIT_NODUP;
	+	struct string_list lf2crlf = STRING_LIST_INIT_NODUP;
	+
	+	the_index.crlf2lf = &crlf2lf;
	+	the_index.lf2crlf = &lf2crlf;
	 
	 	if (dir->ignored_nr) {
	 		fprintf(stderr, _(ignore_error));
	@@ -480,7 +485,26 @@ static int add_files(struct dir_struct *dir, int flags)
	 		exit_status = 1;
	 	}
	 
	+	if (crlf2lf.nr) {
	+		struct string_list_item *item;
	+
	+		warning("ohes noes crlf2lf:");
	+		for_each_string_list_item(item, &crlf2lf)
	+			warning("\t%s", item->string);
	+	}
	+	if (lf2crlf.nr) {
	+		struct string_list_item *item;
	+
	+		warning("ohes noes lf2crlf:");
	+		for_each_string_list_item(item, &lf2crlf)
	+			warning("\t%s", item->string);
	+	}
	+
	 	string_list_clear(&matched_sparse_paths, 0);
	+	string_list_clear(&crlf2lf, 0);
	+	string_list_clear(&lf2crlf, 0);
	+	the_index.crlf2lf = NULL;
	+	the_index.lf2crlf = NULL;
	 
	 	return exit_status;
	 }
	diff --git a/cache.h b/cache.h
	index 6226f6a8a53..3538cdebd61 100644
	--- a/cache.h
	+++ b/cache.h
	@@ -341,6 +341,8 @@ struct index_state {
	 	struct progress *progress;
	 	struct repository *repo;
	 	struct pattern_list *sparse_checkout_patterns;
	+	struct string_list *crlf2lf;
	+	struct string_list *lf2crlf;
	 };
	 
	 /* Name hashing */
	diff --git a/convert.c b/convert.c
	index 733e581cb98..e1f8386185a 100644
	--- a/convert.c
	+++ b/convert.c
	@@ -185,8 +185,11 @@ static enum eol output_eol(enum convert_crlf_action crlf_action)
	 }
	 
	 static void check_global_conv_flags_eol(const char *path,
	-			    struct text_stat *old_stats, struct text_stat *new_stats,
	-			    int conv_flags)
	+					struct text_stat *old_stats,
	+					struct text_stat *new_stats,
	+					int conv_flags,
	+					struct string_list *crlf2lf,
	+					struct string_list *lf2crlf)
	 {
	 	if (old_stats->crlf && !new_stats->crlf ) {
	 		/*
	@@ -194,18 +197,20 @@ static void check_global_conv_flags_eol(const char *path,
	 		 */
	 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
	 			die(_("CRLF would be replaced by LF in %s"), path);
	+		else if (conv_flags & CONV_EOL_RNDTRP_WARN && crlf2lf)
	+			string_list_append(crlf2lf, path);
	 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
	-			warning(_("In '%s', CRLF will be replaced by LF the"
	-				  " next time Git touches it"), path);
	+			BUG("unreachable");
	 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
	 		/*
	 		 * CRLFs would be added by checkout
	 		 */
	 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
	 			die(_("LF would be replaced by CRLF in %s"), path);
	+		else if (conv_flags & CONV_EOL_RNDTRP_WARN && lf2crlf)
	+			string_list_append(lf2crlf, path);
	 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
	-			warning(_("In '%s', LF will be replaced by CRLF the"
	-				  " next time Git touches it"), path);
	+			BUG("unreachable");
	 	}
	 }
	 
	@@ -534,7 +539,8 @@ static int crlf_to_git(struct index_state *istate,
	 			new_stats.crlf += new_stats.lonelf;
	 			new_stats.lonelf = 0;
	 		}
	-		check_global_conv_flags_eol(path, &stats, &new_stats, conv_flags);
	+		check_global_conv_flags_eol(path, &stats, &new_stats, conv_flags,
	+					    istate->crlf2lf, istate->lf2crlf);
	 	}
	 	if (!convert_crlf_into_lf)
	 		return 0;

Which, with the test change above emits:


	$ git reset; ~/g/git/git -c core.autocrlf=true add *
	Unstaged changes after reset:
	M       .gitattributes
	warning: ohes noes lf2crlf:
	warning:        CRLF_mix_LF
	warning:        LF
	warning:        crlf_true_attr__LF.err.expect
	warning:        tmp

Now, obviously that's crappy WIP code as far as the message goes., and
the BUG() will be hit by the other caller in diff.c (which hooks in just
before a call to convert_to_git(), or we'd fall back on that.

Also, i18n with _() is needed, and the message needs to be prettier, but
with just a tiny bit of polishing (hint hint!) this would be sooo much
better.

You could even use e4921d877ab as a template to add advice() output for
this, so we could save ourselves the verbosity/output for users who'd
like to configure this away.

Maybe that's all a bit too much, sorry. I just get excited about
improving some of the crappy parts of our UX sometimes. If you don't
want to run with this I suppose it could be done as a follow-up.
