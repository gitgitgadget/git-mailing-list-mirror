Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4899AC4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 11:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKSLxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 06:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSLw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 06:52:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BF384806
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 03:52:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x2so10486536edd.2
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 03:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UhXHZWv7M6wasI+rD06Rwoe2hvmeNL4KrhTDTCzp3Lw=;
        b=RsuYqbXohV5TVtEvMgSJBy11j9UQ6apeQK/Jlgqf/9i0IBsNmR1MFUKIFs+Bbw0JE7
         g0EbrAKC9o41EmyRpywg53NebRKjqWcoluLjcWTvjdC+FjV/88fR8EtGpFrrEyYRsiG0
         PH4q5WUpgiBEXM6pPHycxK4/+IUUiRqMXnnF/X/JEzlAAaF5kBoeLhYumoLVZne8mEtJ
         p1BIw1D/wZFA300P821ltZxwuWiqUB2m1eQWkgAo1fXaEK5D+G5lES2TR/TrsrcLq7V3
         DFxroj5DW5uA/T8SMN/cvEvsbPrWM8nPefRmCY+/luGh7zvssPpJjmQt/4hRJRgnPQCs
         MFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhXHZWv7M6wasI+rD06Rwoe2hvmeNL4KrhTDTCzp3Lw=;
        b=s87UFwctfuVAT1F7ApFQPvB5ahCCEJ+s1wMDsPB2VGvdPuV/ebT1CEUuySKf0a7+7V
         SaQlI/DtnTx+hHHPOtl58bqFI/xbILEXtyEp0PIYzgcbwVpzY2dAE65R3Htnl3u0UMU/
         JGNZ5opigtwiTWNmrDqYNmLlQEnpamoCEjMnMQG8g+l8Kg6S5HFOHO/7x7dOS1Z1hD6H
         QGMgmRWm+ooklojUvEeWgEXZfBYtgIRU4HBxaiwFyGwvVNFCcnlIqeiNYi02KCoYyyFi
         4TMihnxmcot8ANPkKcaQc66+TU43b0ZMg7UQoy6+3XHJnJfMP33oWFa65I7SsZCk+H06
         EURA==
X-Gm-Message-State: ANoB5pmLZv0kEJFFFCGMKEVoEbcgYVS4OA+fSAhQIq8My+K3Vqs0Stzw
        Aqxs4ayFJDaebNbzcymffVE=
X-Google-Smtp-Source: AA0mqf4e27tr4G6VjdY515v+4+oUdoIvNtm/uULzRlomBmGSXb/YLG1bfl2qyFRzYvfZbz4o0etK6w==
X-Received: by 2002:a05:6402:4311:b0:458:c66a:3664 with SMTP id m17-20020a056402431100b00458c66a3664mr1223646edc.79.1668858775004;
        Sat, 19 Nov 2022 03:52:55 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090624cb00b007877ad05b32sm2749737ejb.208.2022.11.19.03.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 03:52:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1owMOz-006AgO-2Y;
        Sat, 19 Nov 2022 12:52:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Date:   Sat, 19 Nov 2022 12:50:58 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221110233137.10414-3-jacobabel@nullpo.dev>
 <221115.86edu3kfqz.gmgdl@evledraar.gmail.com>
 <20221119025701.syuscuoqjuqhqsoz@phi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221119025701.syuscuoqjuqhqsoz@phi>
Message-ID: <221119.861qpzf9ey.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 19 2022, Jacob Abel wrote:

> On 22/11/15 11:09PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Thu, Nov 10 2022, Jacob Abel wrote:
>>
>> So, on a second read-through...
>>
>> >  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]
>> > -		   [[-b | -B] <new-branch>] <path> [<commit-ish>]
>> > +		   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
>>
>> This synopsis is now at least partially wrong, and ....
>>
>> > +--orphan <new-branch>::
>> > +	With `add`, create a new orphan branch named `<new-branch>` in the n=
ew
>> > +	worktree. See `--orphan` in linkgit:git-switch[1] for details.
>> > +
>> >  --porcelain::
>> > ....
>> >  #define BUILTIN_WORKTREE_ADD_USAGE \
>> >  	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason =
<string>]]\n" \
>> > -	   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")
>> > +	   "                 [[-b | -B | --orphan] <new-branch>] <path> [<co=
mmit-ish>]")
>>
>>
>> ...here we say the same, but surely it's only:
>>
>> 	git worktree add --orphan new-branch /tmp/orphan
>>
>> And not e.g.:
>>
>> 	git worktree add --orphan new-branch /tmp/orphan origin/next
>>
>> Or whatever, but it's incompatible with <commit-ish>. I think this on
>> top should fix it up:
>>
>> 	diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
>> 	index 1310bfb564f..3afef985154 100644
>> 	--- a/Documentation/git-worktree.txt
>> 	+++ b/Documentation/git-worktree.txt
>> 	@@ -10,7 +10,9 @@ SYNOPSIS
>> 	 --------
>> 	 [verse]
>> 	 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <str=
ing>]]
>> 	-		   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
>> 	+		   [[-b | -B] <new-branch>] <path> [<commit-ish>]
>> 	+'git worktree add' [-f] [--lock [--reason <string>]]
>> 	+		   --orphan <new-branch> <path>
>> 	 'git worktree list' [-v | --porcelain [-z]]
>> 	 'git worktree lock' [--reason <string>] <worktree>
>> 	 'git worktree move' <worktree> <new-path>
>> 	diff --git a/builtin/worktree.c b/builtin/worktree.c
>> 	index 71786b72f6b..2b811630b3a 100644
>> 	--- a/builtin/worktree.c
>> 	+++ b/builtin/worktree.c
>> 	@@ -17,7 +17,10 @@
>>
>> 	 #define BUILTIN_WORKTREE_ADD_USAGE \
>> 	 	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <=
string>]]\n" \
>> 	-	   "                 [[-b | -B | --orphan] <new-branch>] <path> [<com=
mit-ish>]")
>> 	+	   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")=
, \
>> 	+	N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
>> 	+	   "                 --orphan <new-branch> <path>")
>> 	+
>> 	 #define BUILTIN_WORKTREE_LIST_USAGE \
>> 	 	N_("git worktree list [-v | --porcelain [-z]]")
>> 	 #define BUILTIN_WORKTREE_LOCK_USAGE \
>> 	@@ -668,6 +671,9 @@ static int add(int ac, const char **av, const char =
*prefix)
>> 	 	if (opts.orphan_branch && !opts.checkout)
>> 	 		die(_("'%s' and '%s' cannot be used together"), "--orphan",
>> 	 		    "--no-checkout");
>> 	+	if (opts.orphan_branch && ac =3D=3D 2)
>> 	+		die(_("'%s' and '%s' cannot be used together"), "--orphan",
>> 	+		    _("<commit-ish>"));
>> 	 	if (lock_reason && !keep_locked)
>> 	 		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
>> 	 	if (lock_reason)
>> 	diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
>> 	index 93c340f4aff..47461d02115 100755
>> 	--- a/t/t2400-worktree-add.sh
>> 	+++ b/t/t2400-worktree-add.sh
>> 	@@ -326,6 +326,10 @@ test_expect_success '"add" --orphan/--no-checkout =
mutually exclusive' '
>> 	 	test_must_fail git worktree add --orphan poodle --no-checkout bamboo
>> 	 '
>>
>> 	+test_expect_success '"add" --orphan and <commit-ish> mutually exclusiv=
e' '
>> 	+	test_must_fail git worktree add --orphan poodle bamboo main
>> 	+'
>> 	+
>> 	 test_expect_success '"add" -B/--detach mutually exclusive' '
>> 	 	test_must_fail git worktree add -B poodle --detach bamboo main
>> 	 '
>
> Yep, you are right. I applied the patch as part of this 2/2 patch and will
> include it in v4. When it comes to attribution, is there a preferred way =
to
> handle this?

Feel free to add my:

	Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

I'm also fine with no attribution, but we add that for copyright
reasons, and this is *probably* significant enough to qualify, but I'm
no lawyer etc. Anyway, probably better to add it when in doubt...

>>
>> > -	if (ac < 2 && !new_branch && !opts.detach) {
>> > +	/*
>> > +	 * As the orphan cannot be created until the contents of branch
>> > +	 * are staged, opts.orphan_branch should be treated as both a boolean
>> > +	 * indicating that `--orphan` was selected and as the name of the new
>> > +	 * orphan branch from this point on.
>> > +	 */
>>
>> I've re-read this a couple of times, and I honestly still don't see what
>> point is trying to drive home.
>>
>> So, "--orphan" is an OPT_STRING(), so it always has a value:
>>
>> 	$ ./git worktree add --orphan
>> 	error: option `orphan' requires a value
>>
>> But we init it to NULL, and above we just used it as a boolean *and*
>> below.
>>
>> I.e. this comment would seem to me to fit with code where the reader
>> might be surprised that we're using "opts.orphan_branch" as a string
>> from then on, but we're just copying that to "new_branch", then we
>> always use "opts.orphan_branch" as a boolean for the rest of the
>> function.
>>
>> I may be missing something, but I think this would probably be better
>> just without this comment. E.g. we use "--track", "--lock-reason"
>> etc. in similar ways, and those don't have a comment like that.
>>
>
> Originally the new orphan branch's name was passed into
> `add_worktree(path, refname, opts)` via the `orphan_branch` field in `opt=
s` and
> the branch which was to be checked out first(to mimic `git checkout --orp=
han`)
> was passed in via `refname`.
>
> Now that the behavior was changed to use `git switch`, that
> "checkout then make orphan" behavior was unneeded and `refname` also cont=
ains
> the name of the orphan branch.
>
> For `make_worktree_orphan(opts, child_env)` however since I used the same
> function signature as `checkout_worktree(opts, child_env)`, `refname` was=
n't
> passed in and I used `opts->orphan_branch` to access the branch name from
> that scope.
>
> I can change `make_worktree_orphan(opts, child_env)` to
> `make_worktree_orphan(ref, opts, child_env)` instead and then `orphan_bra=
nch`
> would be able to be treated as a boolean like those other flags.

I think nothing needs to be changed here on my account, just pointing
out that I found the comment a bit confusing. Do with that what you will
:)

>>
>> > +	if (opts.orphan_branch) {
>> > +		new_branch =3D opts.orphan_branch;
>> > +	}
>> > +
>> > +	if (ac < 2 && !new_branch && !opts.detach && !opts.orphan_branch) {
>>
>> In general we shouldn't combine random "if"'s just because a a
>> sufficiently smart compiler could discover a way to reduce work.
>>
>> But in this case these seem to be inherently connected, we always want
>> the not-DWIM behavior with "orphan", no?
>>
>> So shouldn't this just be:
>>
>> 	if (opts.orphan_branch) {
>> 		...
>> 	} else if (ac < 2 && !new_branch && !opts.detach) {
>> 		....
>> 	}
>>
>> ?
>
> Yes. I've updated that for v4.

Nice!
