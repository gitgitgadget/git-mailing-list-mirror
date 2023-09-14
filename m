Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4636FEEAA7A
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 23:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjINX7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINX7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 19:59:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E291FD6
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 16:58:57 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c3fa9a27ffso15391475ad.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694735937; x=1695340737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=27AmqoboAX+eZQOcIk8JHw1Fh5jy280r9BrMGWjfRp4=;
        b=EzwkhBkyoPCy7ueISpqAbNGMOPtMlgLiIDSZDrXc74PlKwl7NIsNRWrVwRCNRhnSu/
         ahi59U0Z6JwO85HDa9xv+93TukuwcfsWwrqtyUSKRTHXHVYn0o4lxIhp3YWwpop15tLE
         ZV16PSSXFzUTV3z0n+erp5zpqZRj01UcnUMM+m4B8fpqVPpjAgroCOlphjkEB2wm2QHH
         L2izkLtLUJZ0lak/CU3OERPlnguMghSTHlfT3kIlqLlJfBi+n9C84k2+k4NW4WgKbvop
         sTPqDY71b4lRlvIe0UP6IPLP6Iyr7auBgUpexnwfRHn2Mn4a/B1bno5f98pYn7xJLkpy
         BdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694735937; x=1695340737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27AmqoboAX+eZQOcIk8JHw1Fh5jy280r9BrMGWjfRp4=;
        b=O8KHwRxC/tFiNUnbsoONdjC25MLmR0bLGXcv0oHxXKeFPvJcqhJB+cxzkXBLtQ5azj
         q5RYk45R96meSkSWleq9whjiGBQIjAfCslt8Kjr2GbzHPXDEIpnhQ/wjAKe0wob/BBeD
         8poJbcd6z6MmkEWPXn1ULCnjg9fAMlCKWWMHjgw4lyFnQ+uuyFvcwJrdL9vzUTicnCIe
         MGlFJv19jbdVeUi9YZeCCjb9DpM03s7TmCJjsLKcuTlmhnXkNp45k2yZA0NaD2CgoG60
         GFTsllYripCUjGR/PjSv82i1axWoKqpYTmnVAMUU7Tc8f5Ua9RTqXuDltt7MD94+JWF3
         p3Og==
X-Gm-Message-State: AOJu0YzZy8AJ8Jg0+q7LOy9P94KCFLtSHnb/TOWRrzI9w1huDRPdOPrq
        ExL0VZjFeqZ53fdadPX4vsXuUaLmvVM=
X-Google-Smtp-Source: AGHT+IG03tRFmKB8Lf5s8pRU+WrrvdVHGnCnOOaOYrqlDLSA8aNxaT5Z8Z4Eza19YdZYgDtG+VNNgL/YgGE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:1c5:b0:1bc:4c3d:eb08 with SMTP id
 e5-20020a17090301c500b001bc4c3deb08mr2415plh.8.1694735936905; Thu, 14 Sep
 2023 16:58:56 -0700 (PDT)
Date:   Thu, 14 Sep 2023 16:57:28 -0700
In-Reply-To: <xmqqzg1oinq1.fsf@gitster.g>
Mime-Version: 1.0
References: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
 <xmqqzg1oinq1.fsf@gitster.g>
Message-ID: <owlyedj0jok7.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] doc: pull: improve rebase=false documentation
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Dragan Simic <dsimic@manjaro.org> writes:
>
>> Mention in the documentation that --rebase defaults to false.
>
> I am not quite sure if this is an improvement, though.
>
> It is true that, if you do not have any of your own funny
> configuration, your "git pull" will *not* rebase.  
>
> But that is "if you do not give the --rebase option, you do not
> trigger the rebase action".  Which is quite natural, but it is
> different from what you wrote above, isn't it?
>
> When people say "the default for `--rebase` is false", they mean
> this:
>
>     I can say "git pull --rebase=<kind>" to specify how my current
>     branch is rebased on top of the upstream.  But if I do not
>     specify the <kind>, i.e. "git pull --rebase", the command will
>     act as if I gave 'false' as the <kind>.
>
> At least, I would think that is what the word "default" means.
>
> And I would be surprised if the "default" in that sense is 'false';
> isn't the default <kind> 'true' --- meaning "perform the plain
> vanilla 'git rebase'", unless you explicitly asked for 'merges',
> 'interactive' or 'false'?
>
> After the context of the hunk your patch touches, there is a
> description on `pull.rebase`.  Down there, if you do not set
> `pull.rebase` or `branch.<name>.rebase` for the current branch at
> all, the system acts as if you had `false` for these variables.  In
> other words, the default for these variables is `false`, meaning "do
> not rebase, just merge".  But the default option argument for the
> `--rebase` option given without argument would not be `false`, I
> would think.

I think there are two reasonable interpretations of the word "default"
here.

(1) "git pull": This is equivalent to "git pull --rebase=false". So one
could say that "git pull" defaults to "--rebase=false".

(2) "git pull --rebase": This is equivalent to "git pull --rebase=true".
So one could say that the "--rebase" flag (when it is used as "--rebase"
without the "=..." part) defaults to "--rebase=true".

I assume Dragan was thinking of only the meaning in (1). The alternate
meaning of (2) which you brought up makes sense too.

I think both flavors of "default" are reasonable interpretations because
most (if not all) Git users will start out with (1) in mind as they get
familiar with how "git pull" works without any flags (i.e., the
"default" git-pull behavior). Eventually they'll learn about (2) and
realize how the <kind> defaults to "true" with the "--rebase" flag.

Aside: interestingly, there appears to be a "--no-rebase" option that
means "--rebase=false" (see cd67e4d46b (Teach 'git pull' about --rebase,
2007-11-28)):

       --no-rebase
           This is shorthand for --rebase=false.

>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  Documentation/git-pull.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
>> index 0e14f8b5b2..d28790388e 100644
>> --- a/Documentation/git-pull.txt
>> +++ b/Documentation/git-pull.txt
>> @@ -116,7 +116,8 @@ When set to `merges`, rebase using `git rebase --rebase-merges` so that
>>  the local merge commits are included in the rebase (see
>>  linkgit:git-rebase[1] for details).
>>  +
>> -When false, merge the upstream branch into the current branch.
>> +When false, merge the upstream branch into the current branch. This is
>> +the default.
>>  +
>>  When `interactive`, enable the interactive mode of rebase.
>>  +

For reference here is a more complete view of the docs for this flag:

    -r::
    --rebase[=false|true|merges|interactive]::
        When true, rebase the current branch on top of the upstream
        branch after fetching. If there is a remote-tracking branch
        corresponding to the upstream branch and the upstream branch
        was rebased since last fetched, the rebase uses that information
        to avoid rebasing non-local changes.
    +
    When set to `merges`, rebase using `git rebase --rebase-merges` so that
    the local merge commits are included in the rebase (see
    linkgit:git-rebase[1] for details).
    +
    When false, merge the upstream branch into the current branch.
    +
    When `interactive`, enable the interactive mode of rebase.
    +
    See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
    linkgit:git-config[1] if you want to make `git pull` always use
    `--rebase` instead of merging.

How about adding something like this instead as the very first paragraph
for this flag?

    Supplying "--rebase" defaults to "--rebase=true". Running git-pull
    without arguments implies "--rebase=false", unless relevant
    configuration variables have been set otherwise.

This way, we can discuss what "true" and "false" mean first to get these
two flavors of "defaults" sorted out (perhaps also mentioning
--no-rebase while we're at it). Then we can discuss the other <kind>
values like "merges" and "interactive".
