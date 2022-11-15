Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C68CC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 22:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKOWgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 17:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKOWgb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 17:36:31 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4CE7644
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 14:35:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id t25so39778902ejb.8
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 14:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKV0a6ukQhmu3V1+JOgz/89E7Ma1hvo46BazuJU3oGc=;
        b=OYvf6n678YYq58IsguDtblpbZgwxxoUurKz+gajU7eB4TvsdMIOtglEdaFXyukzP2m
         ft1MSQ9ld58f00+g2bW66LpGmJsYOEf1sYQR43QcW8FWwMy6FuI3AHnzPTdfEjwNAfci
         jeWzpixJUHGf11n+FJ62OM0KZKdBfd9H0Y3dfdyUAagtZ4bjN6goOvI9ae+91yFgEtV7
         nsYQKZSXK/+E+TbAMFTeIbFPAoLFQvIlsTYLRW68f+fq8TUOWqGdYbDqentuvW9wmdah
         XZefBnswOMVwjLnQEhoUpqul9sYsiIcOKC4RuEad8zklWbfT1ohiUUjA/Z6I6Vspf63A
         G3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKV0a6ukQhmu3V1+JOgz/89E7Ma1hvo46BazuJU3oGc=;
        b=qs2a8siZYazOmULbb0mpDn2KItm050OLAMnWMj/AA5aUe4YZekksKZs+oTaAN93ieA
         9kJrtUXkiuasSlKHvdUvnDY++QA+qigdwKLvVzpKNhLq/nKwaUuWSBvn4ahnp04RIjfM
         awp1qcKpUneHS2zbPdj2ZDMorX12ByxR0u7s83jxUarhppo1S/hnLMtgAmswXpd4ULdQ
         vzRgoV6uC4+5DFbBLXdE9eU0in0rtOtthujYKezHTFZOJsNyz+FMexJDgwUi9ILvpqKM
         dV8I6qlNAQ4sm+vOY8QDILzPfOeDFGHHpEpHJb0noUpMJ+uM+zvsSo94VS4Cs+5l5ReZ
         KV+A==
X-Gm-Message-State: ANoB5pkeVke9v+UDWLHLjYvceuoALzPt6IkT89IAGZCCMmhFNU6W8YSD
        AJB91YL2AjpEKTiga9r57/gGa1XuANbekw==
X-Google-Smtp-Source: AA0mqf5qg3mBE8PXacSmNd0yYNV10ES6bUfrwMiWde4fgiy0Mhp8o1g5yFjAd1paoO66mKiAmmjJEQ==
X-Received: by 2002:a17:906:280c:b0:7ad:88f8:761f with SMTP id r12-20020a170906280c00b007ad88f8761fmr14801496ejc.417.1668551749251;
        Tue, 15 Nov 2022 14:35:49 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906328300b007aec1b39478sm5976474ejw.188.2022.11.15.14.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:35:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ov4Wy-003nWM-14;
        Tue, 15 Nov 2022 23:35:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Date:   Tue, 15 Nov 2022 23:09:29 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221110233137.10414-3-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221110233137.10414-3-jacobabel@nullpo.dev>
Message-ID: <221115.86edu3kfqz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 10 2022, Jacob Abel wrote:

So, on a second read-through...

>  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
> -		   [[-b | -B] <new-branch>] <path> [<commit-ish>]
> +		   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]

This synopsis is now at least partially wrong, and ....

> +--orphan <new-branch>::
> +	With `add`, create a new orphan branch named `<new-branch>` in the new
> +	worktree. See `--orphan` in linkgit:git-switch[1] for details.
> +
>  --porcelain::
> ....
>  #define BUILTIN_WORKTREE_ADD_USAGE \
>  	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
> -	   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")
> +	   "                 [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]")


...here we say the same, but surely it's only:

	git worktree add --orphan new-branch /tmp/orphan

And not e.g.:

	git worktree add --orphan new-branch /tmp/orphan origin/next

Or whatever, but it's incompatible with <commit-ish>. I think this on
top should fix it up:
	
	diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
	index 1310bfb564f..3afef985154 100644
	--- a/Documentation/git-worktree.txt
	+++ b/Documentation/git-worktree.txt
	@@ -10,7 +10,9 @@ SYNOPSIS
	 --------
	 [verse]
	 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
	-		   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
	+		   [[-b | -B] <new-branch>] <path> [<commit-ish>]
	+'git worktree add' [-f] [--lock [--reason <string>]]
	+		   --orphan <new-branch> <path>
	 'git worktree list' [-v | --porcelain [-z]]
	 'git worktree lock' [--reason <string>] <worktree>
	 'git worktree move' <worktree> <new-path>
	diff --git a/builtin/worktree.c b/builtin/worktree.c
	index 71786b72f6b..2b811630b3a 100644
	--- a/builtin/worktree.c
	+++ b/builtin/worktree.c
	@@ -17,7 +17,10 @@
	 
	 #define BUILTIN_WORKTREE_ADD_USAGE \
	 	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
	-	   "                 [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]")
	+	   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]"), \
	+	N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
	+	   "                 --orphan <new-branch> <path>")
	+
	 #define BUILTIN_WORKTREE_LIST_USAGE \
	 	N_("git worktree list [-v | --porcelain [-z]]")
	 #define BUILTIN_WORKTREE_LOCK_USAGE \
	@@ -668,6 +671,9 @@ static int add(int ac, const char **av, const char *prefix)
	 	if (opts.orphan_branch && !opts.checkout)
	 		die(_("'%s' and '%s' cannot be used together"), "--orphan",
	 		    "--no-checkout");
	+	if (opts.orphan_branch && ac == 2)
	+		die(_("'%s' and '%s' cannot be used together"), "--orphan",
	+		    _("<commit-ish>"));
	 	if (lock_reason && !keep_locked)
	 		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
	 	if (lock_reason)
	diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
	index 93c340f4aff..47461d02115 100755
	--- a/t/t2400-worktree-add.sh
	+++ b/t/t2400-worktree-add.sh
	@@ -326,6 +326,10 @@ test_expect_success '"add" --orphan/--no-checkout mutually exclusive' '
	 	test_must_fail git worktree add --orphan poodle --no-checkout bamboo
	 '
	 
	+test_expect_success '"add" --orphan and <commit-ish> mutually exclusive' '
	+	test_must_fail git worktree add --orphan poodle bamboo main
	+'
	+
	 test_expect_success '"add" -B/--detach mutually exclusive' '
	 	test_must_fail git worktree add -B poodle --detach bamboo main
	 '

> -	if (ac < 2 && !new_branch && !opts.detach) {
> +	/*
> +	 * As the orphan cannot be created until the contents of branch
> +	 * are staged, opts.orphan_branch should be treated as both a boolean
> +	 * indicating that `--orphan` was selected and as the name of the new
> +	 * orphan branch from this point on.
> +	 */

I've re-read this a couple of times, and I honestly still don't see what
point is trying to drive home.

So, "--orphan" is an OPT_STRING(), so it always has a value:

	$ ./git worktree add --orphan 
	error: option `orphan' requires a value

But we init it to NULL, and above we just used it as a boolean *and*
below.

I.e. this comment would seem to me to fit with code where the reader
might be surprised that we're using "opts.orphan_branch" as a string
from then on, but we're just copying that to "new_branch", then we
always use "opts.orphan_branch" as a boolean for the rest of the
function.

I may be missing something, but I think this would probably be better
just without this comment. E.g. we use "--track", "--lock-reason"
etc. in similar ways, and those don't have a comment like that.


> +	if (opts.orphan_branch) {
> +		new_branch = opts.orphan_branch;
> +	}
> +
> +	if (ac < 2 && !new_branch && !opts.detach && !opts.orphan_branch) {

In general we shouldn't combine random "if"'s just because a a
sufficiently smart compiler could discover a way to reduce work.

But in this case these seem to be inherently connected, we always want
the not-DWIM behavior with "orphan", no?

So shouldn't this just be:

	if (opts.orphan_branch) {
		...
	} else if (ac < 2 && !new_branch && !opts.detach) {
		....
	}

?
