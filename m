Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58EF200B9
	for <e@80x24.org>; Tue,  8 May 2018 05:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754018AbeEHFh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 01:37:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38287 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeEHFh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 01:37:56 -0400
Received: by mail-wr0-f195.google.com with SMTP id 94-v6so29592610wrf.5
        for <git@vger.kernel.org>; Mon, 07 May 2018 22:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xpI7BLNE3eVdBAs+eeE0vvxFj0V7XdDeNTwL5WF2WAI=;
        b=mXC751IfBZFvgnS6VM0R50+40wqwpnUaMLw/My9uUHWphPDZIAyGViIyormDkJYRDP
         B3krOl1ZUZaw4lOkped83A4QhUggghu8pd0BiB+ce0YA8xxGlG8OBiv5q5t1oNBf1dCG
         Ez8LUFI9++avfhB2JN4TFD2XfHdz89G+eDP1odjseANxd+ua+6QioMuTF/4FMHgPuroD
         O9Yx2R2mndLAthJwPKEF8dsMguEmlVdn+xE5VvsNBgEPTT3c1u04PBkPJH4nopsbkWrE
         DeNhlLq/nMwzZxzq0iijVCV1ClsNVspPWGaMqbBb5CyZ/0vIT0FvCvlsdgwWwWhVqhFI
         BCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xpI7BLNE3eVdBAs+eeE0vvxFj0V7XdDeNTwL5WF2WAI=;
        b=Zvq/Gpcwl5WFdnpVsAUGmaaScmXcoUMOCJnDj3cJx+sysvGIB9Ui5e5/wnu5BIE+Zt
         noWn9BgDwGEBfloO4A7Y/AddxqU+WypAY6qcJVP/mqzoR41InYAnPzXCjiBIjE9H5LMs
         VxXyCeHWrD5xiRBOHOK6OrE9kS+Q6ESL2ZoP/iHUwz77b4RloE9djl7l/krJzVMb+VtZ
         DNZZZS/KltpJqZnK/60waPpOwF6Iu+wZnkya25jwYrjR2dEhbVFNYwau7KTQyelvLmA7
         cC1SUNizOWest4E3gX1ABQjhQXTHPHUiftUVcPdE3caNY5BDCMfM1aW3UxBRWP6bvym8
         Eucg==
X-Gm-Message-State: ALQs6tDywXc3fgQkp0CRcHQ1+p6w5CgG9kYg7+001GJqSpPrhcKxvVY9
        C8ajnCAD+ZiYwyTe6FTAkoA=
X-Google-Smtp-Source: AB8JxZoXfj2CTPVtgz9xwT7ioMwXV8DGoTHzML01EtLGy71EyrlKTMmPv7DyGYim16Ka50Cy9RdNRQ==
X-Received: by 2002:adf:88c2:: with SMTP id g2-v6mr31146438wrg.78.1525757874632;
        Mon, 07 May 2018 22:37:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x70-v6sm11299621wma.9.2018.05.07.22.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 22:37:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] fetch: stop clobbering existing tags without --force
References: <20180429202100.32353-1-avarab@gmail.com>
        <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
        <20180429202100.32353-9-avarab@gmail.com>
Date:   Tue, 08 May 2018 14:37:53 +0900
In-Reply-To: <20180429202100.32353-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 29 Apr 2018 20:21:00 +0000")
Message-ID: <xmqqvabylnbi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>     > Tags need not be pointing at commits so there is no way to
>     > guarantee "fast-forward" anyway.

The observation the above statement makes is not incorrect per-se,
but it does not justify "anything goes".  "nothing is allowed unless
forced" is equally a logical consequence of the observation.

> That comment and the rest of the history of "fetch" shows that the
> "+" (--force) part of refpecs was only conceived for branch updates,
> while tags have accepted any changes from upstream unconditionally and
> clobbered the local tag object. Changing this behavior has been
> discussed as early as 2011[1].

Thanks for a pointer.  We didn't keep reflog on tags as we wanted
tags to be fixed points and made --tags a refspec without leading
'+' because we didn't want this local clobbering.  I'd say it is
just a buggy implementation, and we should just implement a simple
rule "refs/tags/* is never updated unless forced".

> I the current behavior doesn't make sense, it easily results in local

s/I the/To me, the/, or s/I the/The/.

> tags accidentally being clobbered. Ideally we'd namespace our tags
> per-remote, but as with my 97716d217c ("fetch: add a --prune-tags
> option and fetch.pruneTags config", 2018-02-09) it's easier to work
> around the current implementation than to fix the root cause,

I do not think they are the same problem.

You can have refs/remote/$name/v1.0 and have look-up rules to peek
at various places in refs/* hierarchy for v1.0, and you may have
*solved* the "oops I overwrote and the meaning of v1.0 suddenly
changed" issue, but if you fetched to a location in refs/* that has
higher precedence, then "oops, the meaning of v1.0 suddenly changed"
issue itself is *not* solved at all.

> so this
> implements suggestion #1 from [1], "fetch" now only clobbers the tag
> if either "+" is provided as part of the refspec, or if "--force" is
> provided on the command-line.

Good.  Regardless of the issue of separate namespace that is
overlayed at the look-up time, this makes tons of sense.

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 8631e365f4..5b4fc36866 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -49,11 +49,16 @@ endif::git-pull[]
>  
>  -f::
>  --force::
> -	When 'git fetch' is used with `<rbranch>:<lbranch>`
> -	refspec, it refuses to update the local branch
> -	`<lbranch>` unless the remote branch `<rbranch>` it
> -	fetches is a descendant of `<lbranch>`.  This option
> -	overrides that check.
> +	When 'git fetch' is used with `<src>:<dst>` refspec it might

Nice to see attention to the detail here.  s/might/may/, I would
say, though.

> +	refuse to update the local branch as discussed

> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index c579793af5..672e8bc1c0 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -32,12 +32,22 @@ name.
>  `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
>  it requests fetching everything up to the given tag.
>  +
> -The remote ref that matches <src>
> -is fetched, and if <dst> is not empty string, the local
> -ref that matches it is fast-forwarded using <src>.
> -If the optional plus `+` is used, the local ref
> -is updated even if it does not result in a fast-forward
> -update.
> +The remote ref that matches <src> is fetched, and if <dst> is not
> +empty string, an attempt is made to update the local ref that matches
> +it.
> ++
> +Whether that update is allowed is confusingly not the inverse of
> +whether a server will accept a push as described in the `<refspec>...`
> +section of linkgit:git-push[1]. If it's a commit under `refs/heads/*`
> +only fast-forwards are allowed,

Perhaps correct.  It is unclear what happens when it is fetching
non-commit to refs/heads/* in the above sentence.

> but unlike what linkgit:git-push[1]
> +will accept clobbering any ref pointing to blobs, trees etc. in any
> +other namespace will be accepted, but commits in any ref
> +namespace. ...

I cannot quite parse this.

> +... Those apply the same fast-forward rule.

Who are "Those"?  refs/poo/*?

> +... An exception to
> +this is that as of Git version 2.18 any object under `refs/tags/*` is
> +protected from updates.

OK.

> +If the optional plus `+` is used, the local ref is updated if the

Tighten "is used" to claify that you are talking about the '+'
prefix that signals a forced push/fetch.  We do not want to hear
from people who complain their "git fetch origin master+" does not
work.

> -	OPT__FORCE(&force, N_("force overwrite of local branch"), 0),
> +	OPT__FORCE(&force, N_("force overwrite of local reference"), 0),

Good.  This is long overdue.

