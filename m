Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ABEEE3F01
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 05:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjIOF7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 01:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjIOF7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 01:59:11 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674222710
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 22:59:05 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1694757542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iW2B7ham7rJrR+aAHczg9s3dETfnvnCFpOAD8EwL1jY=;
        b=i/eDfTK/5FPtECXl9q8I3k2qhK071vFZMxf0+VI3oyk75/x56bPbfFjvrx9Hy94SsOnVGj
        LcucKOziUJ86gHxyEpeUq7C8Q6Pz7p5nPzPxks/voywInQLMsex/2h+A5nchSby2sp3HJx
        BRzWOSjjR+t4oTL7H3uJ4/Fg27pA1/4khngvBgYLQ4wGJuV3HZRoMMvV36SdOXw1x3aRiL
        fogEe/ixUcV+2U9Fwm4xCNgucMimjUHiYNE2lpT2OOGmiZROtVoeN2lVwGtMz7d6rSHKRg
        EmgNoftKEflP6gfUScxEgCsqnTScniV1/zlrO9DaSEUYPnJ6Bszyw32YAiFIUA==
Date:   Fri, 15 Sep 2023 07:59:01 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Linus Arver <linusa@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: pull: improve rebase=false documentation
In-Reply-To: <owlyedj0jok7.fsf@fine.c.googlers.com>
References: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
 <xmqqzg1oinq1.fsf@gitster.g> <owlyedj0jok7.fsf@fine.c.googlers.com>
Message-ID: <8ef73354809fac3ebb344b8de8513c46@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-15 01:57, Linus Arver wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> Mention in the documentation that --rebase defaults to false.
>> 
>> I am not quite sure if this is an improvement, though.
>> 
>> It is true that, if you do not have any of your own funny
>> configuration, your "git pull" will *not* rebase.
>> 
>> But that is "if you do not give the --rebase option, you do not
>> trigger the rebase action".  Which is quite natural, but it is
>> different from what you wrote above, isn't it?
>> 
>> When people say "the default for `--rebase` is false", they mean
>> this:
>> 
>>     I can say "git pull --rebase=<kind>" to specify how my current
>>     branch is rebased on top of the upstream.  But if I do not
>>     specify the <kind>, i.e. "git pull --rebase", the command will
>>     act as if I gave 'false' as the <kind>.
>> 
>> At least, I would think that is what the word "default" means.
>> 
>> And I would be surprised if the "default" in that sense is 'false';
>> isn't the default <kind> 'true' --- meaning "perform the plain
>> vanilla 'git rebase'", unless you explicitly asked for 'merges',
>> 'interactive' or 'false'?
>> 
>> After the context of the hunk your patch touches, there is a
>> description on `pull.rebase`.  Down there, if you do not set
>> `pull.rebase` or `branch.<name>.rebase` for the current branch at
>> all, the system acts as if you had `false` for these variables.  In
>> other words, the default for these variables is `false`, meaning "do
>> not rebase, just merge".  But the default option argument for the
>> `--rebase` option given without argument would not be `false`, I
>> would think.
> 
> I think there are two reasonable interpretations of the word "default"
> here.
> 
> (1) "git pull": This is equivalent to "git pull --rebase=false". So one
> could say that "git pull" defaults to "--rebase=false".
> 
> (2) "git pull --rebase": This is equivalent to "git pull 
> --rebase=true".
> So one could say that the "--rebase" flag (when it is used as 
> "--rebase"
> without the "=..." part) defaults to "--rebase=true".
> 
> I assume Dragan was thinking of only the meaning in (1). The alternate
> meaning of (2) which you brought up makes sense too.
> 
> I think both flavors of "default" are reasonable interpretations 
> because
> most (if not all) Git users will start out with (1) in mind as they get
> familiar with how "git pull" works without any flags (i.e., the
> "default" git-pull behavior). Eventually they'll learn about (2) and
> realize how the <kind> defaults to "true" with the "--rebase" flag.
> 
> Aside: interestingly, there appears to be a "--no-rebase" option that
> means "--rebase=false" (see cd67e4d46b (Teach 'git pull' about 
> --rebase,
> 2007-11-28)):
> 
>        --no-rebase
>            This is shorthand for --rebase=false.
> 
> For reference here is a more complete view of the docs for this flag:
> 
>     -r::
>     --rebase[=false|true|merges|interactive]::
>         When true, rebase the current branch on top of the upstream
>         branch after fetching. If there is a remote-tracking branch
>         corresponding to the upstream branch and the upstream branch
>         was rebased since last fetched, the rebase uses that 
> information
>         to avoid rebasing non-local changes.
>     +
>     When set to `merges`, rebase using `git rebase --rebase-merges` so 
> that
>     the local merge commits are included in the rebase (see
>     linkgit:git-rebase[1] for details).
>     +
>     When false, merge the upstream branch into the current branch.
>     +
>     When `interactive`, enable the interactive mode of rebase.
>     +
>     See `pull.rebase`, `branch.<name>.rebase` and 
> `branch.autoSetupRebase` in
>     linkgit:git-config[1] if you want to make `git pull` always use
>     `--rebase` instead of merging.
> 
> How about adding something like this instead as the very first 
> paragraph
> for this flag?
> 
>     Supplying "--rebase" defaults to "--rebase=true". Running git-pull
>     without arguments implies "--rebase=false", unless relevant
>     configuration variables have been set otherwise.
> 
> This way, we can discuss what "true" and "false" mean first to get 
> these
> two flavors of "defaults" sorted out (perhaps also mentioning
> --no-rebase while we're at it). Then we can discuss the other <kind>
> values like "merges" and "interactive".

I'm really, really happy to see such a detailed approach to refining the 
git documentation!  Both Junio's and Linus's feedback are highly 
appreciated.

I totally agree about adding the above-proposed text as the opening 
paragraph for this option.  It's much better than just saying "this is 
the default", which is admittedly confusing and somewhat misleading.
