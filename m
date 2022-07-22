Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2480C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 10:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiGVKqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiGVKqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 06:46:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375119D527
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 03:46:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g1so5326355edb.12
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lFdzmauNNchYLVEBmucpYjbEnb93MjAFNVCpM7SF/ys=;
        b=LZCiwOYets+4zcEQSpremrIbyr1Q1F1r6XJFG23DhG21z9jVuexeudwicrHgurw+/R
         B+dETenn9lOY+D1E/Qs8WvNWSHDTfG2DlHfUbISf2lnJpRzjNxSKcXeoa2lidPutut2X
         Q/UfXugAd8mk04w0qDf/gKChvS8C80ChVIdz3snoJks31KUBy2M3PYHPn9vUQVQNNEsv
         uwrG4ykt863sH3GmIRxJpHIGYQ7Icc7gp0BXzL72ZnA1ofqma/rgP3Q7QaozCFk5mylB
         LvCERJOzpQTf7NZPKpquvYdK/1tlZIa1SNfws82vI0nxkm0WJvwNJqDaM9cyvYJgUyyv
         fekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lFdzmauNNchYLVEBmucpYjbEnb93MjAFNVCpM7SF/ys=;
        b=MIlt4AYGEN/mzynLLcBnG7HVASfP+ovauaa8KwLphgFDGCvfVeswLpl5VTCZOJiqWJ
         GS5klPIKUigovNwANrwPJzqjw3xxz2Qqzqq9T033CGo/ulzPLPG68DHyY1LGmFMUBqQb
         ey9fPBu9AGMQJSG6yI1dDHfH+f5o7ywdyRIEMHbT5EgB9qG8e2jEbE0anqqqaaMMJdpZ
         lCRfkqtJaO+Y8QXxwmD2daHTfw0HdQR4MSNJztIFiQP4/QpdIxYCEasPZ+62zrJ4qdj8
         9WkW/ayBGV5NnFBPC33l0JRjWSd9OXMtdDUbWz6O8QvjDpGi41QAOvF0C0P2NoTwRgDJ
         dorw==
X-Gm-Message-State: AJIora8+/NaiefCuDGB6u9tmPdd0k3pMB2gaoEV/5eV7rLTipxHY9FpE
        Pjf0lExFfu4rh2OHDoE9ca4DFC/ta74ZHQ==
X-Google-Smtp-Source: AGRyM1ulAyS62a+m0VMq7lTCGCW+K0B1XAK0Ib18egNPmojhQdyhcKsd1Q0lyek2NWgF7LIYg11Ztw==
X-Received: by 2002:a05:6402:48d:b0:43a:cccd:89d9 with SMTP id k13-20020a056402048d00b0043acccd89d9mr3003273edv.257.1658486778207;
        Fri, 22 Jul 2022 03:46:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b00722e50e259asm1878668ejz.102.2022.07.22.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 03:46:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEqAi-005HG3-TR;
        Fri, 22 Jul 2022 12:46:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/7] merge-resolve: abort if index does not match HEAD
Date:   Fri, 22 Jul 2022 12:27:55 +0200
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
 <b79f44e54b9611fa2b10a4e1cb666992d006951c.1658466942.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <b79f44e54b9611fa2b10a4e1cb666992d006951c.1658466942.git.gitgitgadget@gmail.com>
Message-ID: <220722.86sfmts9vr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> As noted in commit 9822175d2b ("Ensure index matches head before
> invoking merge machinery, round N", 2019-08-17), we have had a very
> long history of problems with failing to enforce the requirement that
> index matches HEAD when starting a merge.  One of the commits
> referenced in the long tale of issues arising from lax enforcement of
> this requirement was commit 55f39cf755 ("merge: fix misleading
> pre-merge check documentation", 2018-06-30), which tried to document
> the requirement and noted there were some exceptions.  As mentioned in
> that commit message, the `resolve` strategy was the one strategy that
> did not have an explicit index matching HEAD check, and the reason it
> didn't was that I wasn't able to discover any cases where the
> implementation would fail to catch the problem and abort, and didn't
> want to introduce unnecessary performance overhead of adding another
> check.
>
> Well, today I discovered a testcase where the implementation does not
> catch the problem and so an explicit check is needed.  Add a testcase
> that previously would have failed, and update git-merge-resolve.sh to
> have an explicit check.  Note that the code is copied from 3ec62ad9ff
> ("merge-octopus: abort if index does not match HEAD", 2016-04-09), so
> that we reuse the same message and avoid making translators need to
> translate some new message.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c                          | 20 ++++++++++++++++++
>  git-merge-resolve.sh                     | 10 +++++++++
>  t/t6424-merge-unrelated-index-changes.sh | 26 ++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 23170f2d2a6..13884b8e836 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1599,6 +1599,26 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		 */
>  		refresh_cache(REFRESH_QUIET);
>  		if (allow_trivial && fast_forward != FF_ONLY) {
> +			/*
> +			 * Must first ensure that index matches HEAD before
> +			 * attempting a trivial merge.
> +			 */
> +			struct tree *head_tree = get_commit_tree(head_commit);
> +			struct strbuf sb = STRBUF_INIT;
> +
> +			if (repo_index_has_changes(the_repository, head_tree,
> +						   &sb)) {
> +				struct strbuf err = STRBUF_INIT;
> +				strbuf_addstr(&err, "error: ");
> +				strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> +					    sb.buf);
> +				strbuf_addch(&err, '\n');

At first glance I was expecting this to construct an error message to
emit it somewhere else that stderr, so I wondered if you couldn't use
the "error_routine" facility to avoid re-inventing "error: " etc.,
but...

> +				fputs(err.buf, stderr);

...we emit it to stderr anyway...?

> +				strbuf_release(&err);
> +				strbuf_release(&sb);
> +				return -1;
> +			}
> +
>  			/* See if it is really trivial. */
>  			git_committer_info(IDENT_STRICT);
>  			printf(_("Trying really trivial in-index merge...\n"));
> diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
> index 343fe7bccd0..77e93121bf8 100755
> --- a/git-merge-resolve.sh
> +++ b/git-merge-resolve.sh
> @@ -5,6 +5,16 @@
>  #
>  # Resolve two trees, using enhanced multi-base read-tree.
>  
> +. git-sh-setup
> +
> +# Abort if index does not match HEAD
> +if ! git diff-index --quiet --cached HEAD --
> +then
> +    gettextln "Error: Your local changes to the following files would be overwritten by merge"
> +    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
> +    exit 2
> +fi

(The "..." continued below)

Just in trying to poke holes in this I made this an "exit 0", and
neither of the tests you added failed, but the last one ("resolve &&
recursive && ort") in the t6424*.sh will fail, is that intentional?

I don't know enough about the context here, but given our *.sh->C
migration elsewhere it's a bit unfortunate to see more *.sh code added
back. We have "git merge" driving this, isn't it OK to have it make this
check before invoking "resolve" (may be a stupid question).

For this code in particular it:

 * Uses spaces, not tabs
 * We lose the diff-index .. --name-only exit code (segfault), but so
   did the older version
 * I wonder if bending over backwards to emit the exact message we
   emitted before is worth it

If you just make this something like (untested):

	{
		gettext "error: " &&
		gettextln "Your local..."
	}

You could re-use the translation from the *.c one (and the "error: " one
we'll get from usage.c).

That leaves "\n %s" as the difference, but we could just remove that
from the _() and emit it unconditionally, no?


>  # The first parameters up to -- are merge bases; the rest are heads.
>  bases= head= remotes= sep_seen=
>  for arg
> diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
> index b6e424a427b..f35d3182b86 100755
> --- a/t/t6424-merge-unrelated-index-changes.sh
> +++ b/t/t6424-merge-unrelated-index-changes.sh
> @@ -114,6 +114,32 @@ test_expect_success 'resolve, non-trivial' '
>  	test_path_is_missing .git/MERGE_HEAD
>  '
>  
> +test_expect_success 'resolve, trivial, related file removed' '
> +	git reset --hard &&
> +	git checkout B^0 &&
> +
> +	git rm a &&
> +	test_path_is_missing a &&
> +
> +	test_must_fail git merge -s resolve C^0 &&
> +
> +	test_path_is_missing a &&
> +	test_path_is_missing .git/MERGE_HEAD
> +'
> +
> +test_expect_success 'resolve, non-trivial, related file removed' '
> +	git reset --hard &&
> +	git checkout B^0 &&
> +
> +	git rm a &&
> +	test_path_is_missing a &&
> +
> +	test_must_fail git merge -s resolve D^0 &&
> +
> +	test_path_is_missing a &&
> +	test_path_is_missing .git/MERGE_HEAD
> +'
> +
>  test_expect_success 'recursive' '
>  	git reset --hard &&
>  	git checkout B^0 &&

...I tried with this change on top, it seems to me like you'd want this
in any case, it passes the tests both with & without the C code change,
so can't we just use error() here?
	
	diff --git a/builtin/merge.c b/builtin/merge.c
	index 7fb4414ebb7..64def49734a 100644
	--- a/builtin/merge.c
	+++ b/builtin/merge.c
	@@ -1621,13 +1621,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
	 
	 			if (repo_index_has_changes(the_repository, head_tree,
	 						   &sb)) {
	-				struct strbuf err = STRBUF_INIT;
	-				strbuf_addstr(&err, "error: ");
	-				strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
	-					    sb.buf);
	-				strbuf_addch(&err, '\n');
	-				fputs(err.buf, stderr);
	-				strbuf_release(&err);
	+				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
	+				      sb.buf);
	 				strbuf_release(&sb);
	 				return -1;
	 			}
	diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
	index c96649448fa..1df130b9ee6 100755
	--- a/t/t6424-merge-unrelated-index-changes.sh
	+++ b/t/t6424-merge-unrelated-index-changes.sh
	@@ -96,7 +96,12 @@ test_expect_success 'resolve, trivial' '
	 
	 	touch random_file && git add random_file &&
	 
	-	test_must_fail git merge -s resolve C^0 &&
	+	sed -e "s/^> //g" >expect <<-\EOF &&
	+	> error: Your local changes to the following files would be overwritten by merge:
	+	>   random_file
	+	EOF
	+	test_must_fail git merge -s resolve C^0 2>actual &&
	+	test_cmp expect actual &&
	 	test_path_is_file random_file &&
	 	git rev-parse --verify :random_file &&
	 	test_path_is_missing .git/MERGE_HEAD
	
