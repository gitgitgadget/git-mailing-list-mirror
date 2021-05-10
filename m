Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881DC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBF361369
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbhEJMwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 08:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347183AbhEJMdg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 08:33:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6558EC0610EC
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:26:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y26so18468759eds.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=u8ZM8Sc0EO5DKHvrBCZuIjC58qhuptn5qvZdkWqM9zA=;
        b=uAZFizg9uOBTptySIaJtgWJv9JbMpiW8XNoBILwFZ8WcdgCxYauObkustbrGuYr6dV
         eSsx8QKlnt1WDGudhDoFvyuDf5DMVj6TI1tpF9aiRUmbmXy4ep6efNvRqlHg9Zl5+JGo
         uoBXoSFiQ4kSdkUFFqvQuNxqlPgZePMU0LN8CCfI41uKQcUWLqMSIHqeDAvRFHO/cGQC
         gvjVwil5+6UIVi0m7s9IRe7AywPjkMCObzCzJRQFnr0fuUvAED9hb2SW2HrzgWJbaBhN
         l0/sBJ2OrVSRZQm7Vu5WC84zib/6yrXLfpzB397dRY4tigtVzx8Ux+jpywyeAYrEsG/7
         OyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=u8ZM8Sc0EO5DKHvrBCZuIjC58qhuptn5qvZdkWqM9zA=;
        b=ZMdCSLV+EQtMkw5SyJYZQm94Y9i8AJb0wkKaWXKhrEfSj7R0OQex5U9lZnqgiwAoz2
         kekaD/LnW1OFpEFSrHv+2oxtKMu7twt0eEvuIlVS6WI4fivOTOExvccT152fTWik1QUv
         W9yQQCHNJLDt1RuvmGjfJQ4936b2osEPGf4nAzv8i5qKlxljKCppIyB3Jkn/U0r07rU+
         4nvyM889nFCqkLRzHuQ2TJGovMtVJhzd2oj91Ecl310GbFIla+2+T9ePefYKTSQY3Qcq
         uxOxayR6crLQ7snvWf6Vqw/FMh0I4cPlrnWAKwRFgKHQ+GKOkkjurad01O0yH2IM4a62
         7CDg==
X-Gm-Message-State: AOAM530wIKZHoQg2ZACqarrYAn5fJj+5cnfgMhCx7oN/sdUAral2SWaW
        awlXM+CGWnsq5VMvEzeVtQpvDtVnQwKP3A==
X-Google-Smtp-Source: ABdhPJxNcgj90eKwYWZN+jAHPX2lgzZDFK317nOYpwkMpffqPVutHlN0f2/B17Z5ugXDuOWtyum5Aw==
X-Received: by 2002:aa7:c495:: with SMTP id m21mr29011298edq.123.1620649613994;
        Mon, 10 May 2021 05:26:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lx20sm8902200ejb.31.2021.05.10.05.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:26:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Is the sha256 object format experimental or not?
Date:   Mon, 10 May 2021 14:22:00 +0200
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
Message-ID: <87lf8mu642.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 09 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-05-08 at 02:22:25, dwh@linuxprogrammer.org wrote:
>> Hi Everybody,
>> 
>> I was reading through the
>> Documentation/technical/hash-function-transition.txt doc and realized
>> that the plan is to support allowing BOTH SHA1 and SHA256 signatures to
>> exist in a single object:
>> 
>> > Signed Commits
>> > 1. using SHA-1 only, as in existing signed commit objects
>> > 2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
>> >   fields.
>> > 3. using only SHA-256, by only using the gpgsig-sha256 field.
>> > 
>> > Signed Tags
>> > 1. using SHA-1 only, as in existing signed tag objects
>> > 2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
>> >   signature.
>> > 3. using only SHA-256, by only using the gpgsig-sha256 field.
>
> Yes, this is the case.  We have tests for this case.
>
>> The design that I'm working on only supports a single signature that
>> uses a combination of fields: one 'signtype', zero or more 'signoption'
>> and one 'sign' in objects. I am thinking that the best thing to do is
>> replace the gpgsig-sha256 fields in objects and allow old gpgsig (commits)
>> and in-body (tags) signatures to co-exist along side to give the same
>> functionality.
>
> You can't do that.  SHA-256 repositories already exist and that would
> break compatibility.

From memory this is at least the second time you've brought up this
point on-list.

My feeling is that almost nobody's using sha256 currently, and we have a
very prominent ALL CAPS warning saying the format is experimental and
may change, see ff233d8dda1 (Documentation: mark
`--object-format=sha256` as experimental, 2020-08-16).

I agree with the docs as they stand, and don't think we should hold back
on changing the object format for sha256 in general if there's a
compelling reason to do so.

Whether this suggested change has a compelling reason is another matter
(I haven't reviewed it).

But it seems to me that if the main person pushing the sha256 effort
disagrees with the content of
Documentation/object-format-disclaimer.txt, we'd be better off at this
point discussing a patch to change the wording there to something to the
effect that we consider the format set in stone at this point.
