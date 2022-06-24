Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF9C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 13:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiFXNQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiFXNQC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 09:16:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64D50E1C
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 06:15:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cf14so3415764edb.8
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NrsUM6WQZ7P3cuRo90JvJNvTpaN8f4hOhj9Gs4QO3ME=;
        b=k+Fi0MgQ723/D7bKllVqJuYQTJivdfkiCcdixfnDC5vUPPRlSRxDLNJNAEhjdqygVK
         lsfhoBzEYEUCnwEZLRQ1meO9fHZm0mgQfII2feGCaHYLa39QsedCmxC+JFAHGk5Umxwa
         pAxuV+cAjDw/lTph/7rkkfy7R9KW0i8241/tOmqx8bpBNkbkB+BxXvEAmSsCbmmmEy4o
         RPpPus3MDROx78U4DmrgETf8o6r2IciH/LBonkkrrrYgPHT6PI6w+PTMpT+lWs1JGwD/
         BUV1bI7q5rbfDj0WKsC+hm2Tt7QLk5Gnnb9bjC3kdpQlhDe1zvTMs8UCJwHEfcdQHmRO
         53/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NrsUM6WQZ7P3cuRo90JvJNvTpaN8f4hOhj9Gs4QO3ME=;
        b=VaM0d9fZ7xi0ZIeW7csgLq0bMAB/2fxMbosVTTB/qieNbVNrWvWvUfUwrP8VU6j2ca
         lgRjm1LnAVP2ZohwwDCc8nsdEhcin9ClNg37kOAX47muH/KGLlIbrdYF1iF/DU03P03D
         UuUy301WIHRzEz5Nc8ueOkTWDsyp7pCRzql86EYDv1k3Zx/SBrw9c0El+tJ+NPRxUIOE
         jvNPXLM4r5o1PQ4V98VBXVWVizn5IlYErT71w4GP5+S/gEzYf45vsn5Pt5mWO0YArLIU
         B4y6FBHROOXKW/Fby9iYV0G24b3eoF4yazGavZNv3fKthw6YORdMUOQ3ScpSXN5GsU2C
         zENA==
X-Gm-Message-State: AJIora9KFucrDoEs7P7LP3+b5i0aM7d+UkYZXzxCFE3O5Grmr2pcyJLZ
        AUqccUa3IMgb1HyKXCsf7thZ2qBjqXHDzg==
X-Google-Smtp-Source: AGRyM1sbO6Suk6TNaDjo98RabyKA41TWbUu/PwCK2u44QAduG0v8n8aHxjd6UbFNUVhJ+BpIGHd6Mg==
X-Received: by 2002:a05:6402:40c3:b0:435:c020:552d with SMTP id z3-20020a05640240c300b00435c020552dmr13519781edb.387.1656076557901;
        Fri, 24 Jun 2022 06:15:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm630271edv.36.2022.06.24.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 06:15:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4jAC-001JeC-4S;
        Fri, 24 Jun 2022 15:15:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tim Chase <git@tim.thechases.com>
Cc:     git@vger.kernel.org,
        Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
Subject: Re: stashing only unstaged changes?
Date:   Fri, 24 Jun 2022 15:09:51 +0200
References: <20220621142618.239b02cd@bigbox.attlocal.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220621142618.239b02cd@bigbox.attlocal.net>
Message-ID: <220624.86tu8ai4mr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 21 2022, Tim Chase wrote:

> I recently had composed a commit with some `git add -p` leaving some
> portions unstaged. I wanted to stash the unstaged changes to make
> sure that the staged code ran as expected, so I did  a `git stash`
> only to find that it unstaged my staged changes and stashed
> *everything*.
>
> Using `git stash --saved` does the opposite of what I want (stashing
> the index, not the difference between the index and the working-copy)
>
> So I carefully re-`git add -p`'ed everything and tried `git stash
> --keep-index` which sounded promising (my index remained the same),
> but popping my stash ended up causing conflicts because it had
> stashed the diff of HEAD..working-copy, not INDEX..working-copy.  A
> `git stash show -p` confirmed that the stash included things that I
> had already staged.
>
> So I carefully re-`git add -p`ed everything yet again, but then got
> stuck trying to convince `stash` to save a snapshot of only the diff
> in my working directory. To work around it, I did a `git diff >
> temp.patch` to obtain the stuff I'd wanted to stash, a `git reset
> --staged` to clear out those changes, ran my code to verify
> (eventually committing it), and then applied the `temp.patch` back on
> top of my changes.  It worked, but felt convoluted.
>
> I did see the `git stash -p` option, to manually choose the inverse
> bits, but for what I was doing, it was more sensible to `git add -p`
> and try to stash the rest.
>
> So is there some option I've missed to tell `git stash` to stash only
> the delta between the uncommitted-index and the working-copy?

Is what you want equivalent to:

    # save the "git add -p"'d chunks
    git stash push --staged
    # save the "uncommitted"
    git stash push
    # pop the previously staged
    git stash pop --index stash@{1}

?

I.e. this (ab)uses the stash itself to juggle the two around. I don't
think there's a way to do this in one step, but I'm not very familiar
with git-stash.

If that is what you want (and we don't have a way to do it) perhaps we
should have a a:

    git stash push --unstaged

Which could start out as an alias for the above sequence, with e.g. an
optional "--include-untracked" being passed to the second "git stash
push" command above.

I also found this past thread (CC'd the author, in case it helps), which
seems to be asking the same question:
https://lore.kernel.org/git/CAC4jX8GEg5=9BPepYLntGRG7n_84ju7rTSYO82SQyuiiff0UcQ@mail.gmail.com/
