Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E84C11F68
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 07:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9F061469
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 07:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhF3HID (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 03:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhF3HIC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 03:08:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE4C061766
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 00:05:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg14so2422535ejb.9
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 00:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QhxmkATq46Q0Kw1aagD+iIvw2HGyNz5AD0728BDOGO4=;
        b=ApdZRyZuvffZBNTdryDByikahvkOipS0rLqL6q0UR7Q3VK4kPsWBlHJXhvLzkFiZeS
         0Rqw98bh3U7EcrK8LtcYt1GB63QYH6CbozKHrmVqCjfrxvYlNroVaWG0C1f53Wtkrw3J
         NWFa58BV2h/uX21rs3i/+yC64s+/6yFfMHjZn26POzOP8H1yPYWKzqWApn5W3J2wJGBp
         tQqeACRhmw9n8973h3acNUmHQhCnJikl6i5D/6EI8ZA0LiVw1NOSfjnQyCG3hCwKo8lB
         qYn6GhJqQAgxO/wo/3Du2wSZ0vLs1WiUv/6iskfec3lu55rwI4jV3mgTJGKbLJvRB+Uh
         QjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QhxmkATq46Q0Kw1aagD+iIvw2HGyNz5AD0728BDOGO4=;
        b=NB+oGyOVnppAd4aqvQn5V1MmkqnjdgnF2nkOmn6K5dtqkUoz0zFb4TerCyjUZlX60Y
         xx1AAIxtsIQ8sEWeUN35L2OjyTrNC2NC+6tPL/6z1OUOe2TYeQxhB/kCZt+pmMmhSHBW
         2FbxcbTavsR2j9o1sXs8KKGp5OT6fN0nw3IISsP1OxzBmWOe1kkLIEtu3ndmiVzALXyM
         2WW5t7Z5PSyCYEYaToO3v+lxYB0PtVdHdyzQ6DlCXnJjKF4Zx0LEYhiI/N8zxhIpZSCL
         2mmkI26zzBFwmCcqSCRsvhiIeqRqLWzaGVWeOrXafe5KC/IotVcZCuj8KfwGsZxdaFix
         ldrw==
X-Gm-Message-State: AOAM533GLPCG+sFmu5Xd4FZ/EiN7VZUEspDZ1dFT13pn80fl5CNXc1IX
        pbXJ7cBvuCwSQt1KGpmHZgE=
X-Google-Smtp-Source: ABdhPJxUD1rKkSvpenM2nTiVhBBmCSu/iKqo/gRfDEejqNL/SAcYVzqfOJuxakbIDf2uCvRER/3dzw==
X-Received: by 2002:a17:906:4786:: with SMTP id cw6mr34739752ejc.353.1625036732232;
        Wed, 30 Jun 2021 00:05:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x1sm5542176edd.25.2021.06.30.00.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 00:05:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 0/8] test-lib tests: split off subtest code in t0000
 into lib-subtest.sh
Date:   Wed, 30 Jun 2021 09:04:35 +0200
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
 <xmqq35tjzwz2.fsf@gitster.g> <87czsb1r85.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87czsb1r85.fsf@evledraar.gmail.com>
Message-ID: <877dibg7d2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Jun 15 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> This refactors the testing of test-lib.sh itself in t0000 into a
>>> lib-subtest.sh, fixing duplicate setup, bugs and various shell nits
>>> along the way.
>>> ...
>>> I thought it was better to submit this now anyway, while
>>> this code is fresh in people's minds.
>>
>> Any time you send it anew is the time it is fresh in people's minds
>> if they read it, no?  I am not sure I understand the reasoning.
>>
>>> I'm hoping Felipe will take some variant of my
>>> http://lore.kernel.org/git/8735tk22if.fsf@evledraar.gmail.com and
>>> perhaps review this series & base his patch on top of these changes,
>>> but alternatively they can go in independently with Junio solving the
>>> conflict.
>>
>> I'd rather not if it can be avoided.  Please scale the process by
>> coordinating among contributors yourselves.
>
> Per Felipe's reply and his
> https://lore.kernel.org/git/20210615183157.104999-1-felipe.contreras@gmai=
l.com/
> I don't think there's any conflict anymore, so this series should apply
> on master without any conflicts.
>
> It would be great to have it picked up, it's another set of test
> cleanups I need for a subsequent series...

Junio, just a reminder about this series: It has no conflicts with
"seen", and that WIP patch it would have conflicted with it was replaced
by another approach.

I've got some other non-testing changes queued on top of this, it would
be great to have it picked up. Thanks!
