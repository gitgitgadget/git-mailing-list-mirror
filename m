Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864DF20248
	for <e@80x24.org>; Thu, 21 Mar 2019 11:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCULnS (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 07:43:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42507 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCULnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 07:43:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id j89so4679708edb.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=M/YZUlpM9pXjU5vA99QYpo5wg1kQtjsHaVGJVGLVKOk=;
        b=sixuzAVPH0G2UT5rcJKs/hXpeuPWD2DKiDvN4FXL8mkkQAbsF7N4cfq7ZVjuy7JJCo
         CmIc+UAW1jO1JyR5O5nbuc2DCI3pKHM+V84vwvNpINX8KXbJ2uQuIZ6c/mfe1WLy9NwI
         ITUpifX6eWHH4ZBhy7VPQBFEYOTW26UjAwI2bRqClGTDUWOSAIAxOTNtldk8DLkyh/mf
         oLU06DFV/AykQOnxOWAqGMTTAvC6APy9oGHUaIWrD4pSfL4tRaqT2+sMNDfGBAgKK3F5
         hp1oDabVGYw6nBRQx1shYXsMCFjzE0kGOjJwtX42MTd6fYtRPHltCNvDafzENRn2eTcy
         zvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=M/YZUlpM9pXjU5vA99QYpo5wg1kQtjsHaVGJVGLVKOk=;
        b=ebjxZt+3gJ/CBQfSRlYstgyBxsUVXLifeC6FVUJrf110oMGXg0zn6TpsySRIUhdJJo
         cFLfT5xTZa9D9Q/ZMnxpdzkLKGhzspXZhpmdkx7udbaOVuaCOjwQdVffvsjcLPB2/VUM
         SAaixZlFYL7v00NJc+6A04RLJIZ5fBj1TQ2q4UG10tM17IRqinUVXOSgdroKYz6eZP5k
         YfUog7iSQzusHF3ozc0oQKenrpRqNenW0UzoVcWcYY0mHpn//F/6ii2Mg8MUFl7EepOZ
         lpMmOOFJfalgPSIpsxSTyqEfqoljmLLVrkt+uXAjOalupBQxr4LDGo1I6SBVrR/e/8UN
         G8Uw==
X-Gm-Message-State: APjAAAXlnoVh4HOseG1KYnEqonpmShN4yR0pDdXbQMdgLQQxdWzEhu4b
        ekr6aUsPQ2KNiL7+PuAmDoo9BhRH
X-Google-Smtp-Source: APXvYqz7pCXXnjI4TxfAK5S3rcmppCqQ2201DdW37pcPcwqz0LFFWrW1ywF7d9W3g2eI7P5/4mCl6g==
X-Received: by 2002:a50:a8a4:: with SMTP id k33mr2191160edc.261.1553168595965;
        Thu, 21 Mar 2019 04:43:15 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id n5sm1616128edd.33.2019.03.21.04.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 04:43:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>, git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
References: <875zsdu41d.fsf@fifthhorseman.net> <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com> <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 12:43:13 +0100
Message-ID: <87r2b0cv1q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 21 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  * "git tag -v $(git rev-parse v1.0.0)" should work, but the command
>
> Sorry, forget about this part of my message.  I completely forgot the
> discussion we had a few years ago:
>
> https://public-inbox.org/git/CAPc5daV9ZvHqFtdzr565vp6Mv7O66ySr-p5Vi8o6bd6=GyVELg@mail.gmail.com/
>
> In short, "git tag -v TAGNAME" does not take an arbitrary object
> name, TAGNAME does not go through the usual ref dwimming rules
> (i.e. checking for .git/%s, .git/tag/%s, .git/heads/%s, ... to find
> one) but only looks at refs/tags/TAGNAME alone.  So we always have
> the refname it came from when inspecting tag contents that tells
> what tagname the tag has.
>
> The other point still stands; there are legitimate reasons people
> would want to have a tag with v1.0.0 tagname in somewhere that is
> not refs/tags/v1.0.0 and an extra validation must need to make sure
> it won't error out, even though warning is probably acceptable.

One such example, which I don't know is actually used, but we might be
careful to break is:

 * Someone (e.g. Junio) is producing signed tags of a project like
   git.git

 * Someone else has a git repo where only upstream (signed by Junio)
   releases are allowed, but they decide *which* release.

 * Some system auto-deploys whatever the latest sorted tag in that repo
   is, after verifying that Junio tagged them.

Thus e.g. v2.21.0 might be pushed as refs/tags/2018-03-21, and if it
doesn't work out a new refs/tags/2018-03-22 might be tagged tomorrow
using the v2.20.0 tag.
