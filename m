Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357BFCD37AE
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 21:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbjIOVMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbjIOVMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 17:12:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD76A1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 14:12:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so49741107b3.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694812327; x=1695417127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbBdoRX5Sybn+8t+C552i/nkx6EzTsYCvw5wweMwi+s=;
        b=Yp1ZqykZyLHGILddfzBBluBFmJ6K3Mo74GcrELNX5GGhpsBsIqI4TkYc29JS5s4Evw
         Q8t8feGaPbTQ62Xe+fpOQGIomJr9zqPXBLPJJmymQ0b9Ups+OSZDLhyz8hAnlq+6GrXY
         9LzCOe+pGY+hz8V1WdOsrQz9Q/yKgE5QJ7ptx4+UEoU9pZ/mJaX0zyZ7DbpKOL0Ey2U8
         lH5iWS2TAJRS3NAK3HbEk61z9Me6+4ewQyenw+LZMgBXgHFVP4LjaSEn5Z7Hdb2n02iB
         pOe7VlwY6fPmOWgj4eicBFU0hOQ7ZWq9sIAAL1PaXOZDQLsDvubr/uDjqXa4tgh13mH1
         gIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812327; x=1695417127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbBdoRX5Sybn+8t+C552i/nkx6EzTsYCvw5wweMwi+s=;
        b=lFcGoMG2x/jPFHD0ZQ6oVEyXhxM+y/QoM2fOjrCAg0pgfwLXJC8IUVmTvR/INzcyC6
         bafFOydLwGgTVpBVd7k7igbr0KUHDfrfPTv+ckMbKjRCjHc1yoDRqX29DMUrGP9I9+2l
         3AYIwfCsnI+xLLHO0+ifxGr5Xs1FS+sdjOV72jCrJd5QROwyj27Oc6P7f8TGzES6NmxX
         mHG4zHr6Ew3NMnpZ4u4jFH1jhCKsAmYijRWHtHGO244KXjJ7XVdUhXgr/5COg1TjNj+Z
         iyFlbpfJF6GZw6bNK/TPZXzLbVaBQSNpUFE8/ZiOFPs+Q4iHyj4FqVu6MrTXCp2qGceK
         qtoA==
X-Gm-Message-State: AOJu0Yx83OqVk9Ho9Fycc0VkO6z0nn9capiij9OWjqqJmFuEiTRZCmUo
        PPxoHIR6ATvnmVO5sI+5IBxlULm52s8=
X-Google-Smtp-Source: AGHT+IHVexsKWfAcqXtbQQNUlr8ZMuW+7TghCkoG9c6fYU2XhGEQ5Dxp2gR89kwgyvqJkzEBMQaLJs3gy6Q=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:290b:b0:59b:b0b1:d75a with SMTP id
 eg11-20020a05690c290b00b0059bb0b1d75amr172167ywb.4.1694812327215; Fri, 15 Sep
 2023 14:12:07 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:12:00 -0700
In-Reply-To: <xmqqh6nvfi2p.fsf@gitster.g>
Mime-Version: 1.0
References: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
 <xmqqzg1oinq1.fsf@gitster.g> <owlyedj0jok7.fsf@fine.c.googlers.com> <xmqqh6nvfi2p.fsf@gitster.g>
Message-ID: <owlya5tnjg4f.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] doc: pull: improve rebase=false documentation
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> Aside: interestingly, there appears to be a "--no-rebase" option that
>> means "--rebase=false" (see cd67e4d46b (Teach 'git pull' about --rebase,
>> 2007-11-28)):
>>
>>        --no-rebase
>>            This is shorthand for --rebase=false.
>> ...
>> How about adding something like this instead as the very first paragraph
>> for this flag?
>>
>>     Supplying "--rebase" defaults to "--rebase=true". Running git-pull
>>     without arguments implies "--rebase=false", unless relevant
>>     configuration variables have been set otherwise.
>
> Phrase nit.
>
> 	$ git pull origin
>
> does run the command with arguments.

Ah, good catch.

> What you mean is "running
> git-pull without any --rebase arguments implies --no-rebase",

Right (modulo your "--rebase arguments" -> "--rebase option" correction
in your follow-up email).

> but
> that is saying "not giving --rebase=<any> and not giving --rebase
> means not rebasing", which makes my head spin.

Me too.

> "--no-rebase" as a command line option does have use to defeat
> configured pull.rebase that is not set to "false"

Yes, I noticed this too after digging around a bit more after I sent my
message. Thanks for clarifying for the record.

> and allowing
> "pull.rebase" to be set to "false" does have use to defeat settings
> for the same variable made by lower-precedence configuration file.

Indeed! I did not think of this. IOW, Git can be configured in
multiple places (the "pull.rebase" setting in ~/.gitconfig can be
overridden by the same config in ~/myrepo/.git/config).

> "--rebase=false" does not have any reason to exist, except for
> making the repertoire of "--rebase=<kind>" to be complete.

Agreed. In a sense, the docs for "--rebase=false" should say that it is
a synonym for "--no-rebase" (because "--no-rebase" came first,
historically), and not the other way around (that "--no-rebase" is
shorthand for "--rebase=false").

> So, I am still not sure if saying "'git pull' (no other arguments
> and no configuration) is equivalent to 'git pull --rebase=false'"
> adds much value.

Fair point. That is, there are so many gotchas and "edge case"-like
behaviors to consider here, so the statement "'git pull' (no other arguments
and no configuration) is equivalent to 'git pull --rebase=false'" is an
oversimplification that can be misleading. I agree.

> If --no-rebase and --rebase=false are explained in terms of why
> these options that specify such an unnatural action (after all, you
> say "do this" or "do it this way", but do not usually have to say
> "do not do it that way") need to exist.
>
> If I were writing this patch, I would rearrange the existing text
> like so:
>
>  * Update the description of "--no-rebase" *NOT* to depend on
>    --rebase=false.  Instead move it higher and say
>
>    - The default for "git pull" is to "merge" the other history into
>      your history, but optionally you can "rebase" your history on
>      top of the other history.
>
>    - There are configuration variables (pull.rebase and
>      branch.<name>.rebase) that trigger the optional behaviour, and
>      when you set it, your "git pull" would "rebase".
>
>    - The "--no-rebase" option is to defeat such configuration to
>      tell the command to "merge" for this particular invocation.
>
>  * Update the description of "--rebase=<kind>" and move the
>    paragraph that begins with "When false" to the end, something
>    like:
>
>    - `--rebase` alone is equivalent to `--rebase=true`.
>    - When set to 'merges'...
>    - When set to 'interactive'...
>    - See `pull.rebase`, ..., if you want to make `git pull` always
>      rebase your history on top of theirs, instead of merging their
>      history to yours.
>    - `--rebase=false` is synonym to `--no-rebase`.

I think this captures the finer details while still preserving the
spirit of Dragan's original patch, so SGTM.

@Dragan if you are OK with doing the (much more substantial) change as
suggested, please do. Thanks!
