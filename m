Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6273AC4332E
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 01:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AA222517
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 01:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgLXBK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 20:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgLXBK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 20:10:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E36C0611D0
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 17:09:53 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 11so659886oty.9
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 17:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=aVtpXJ7JmWYLC3y2V7ANojDd8/Faok+fXV4tt1+QxRU=;
        b=nauNe6PqX+e5t3GonVf26auaO2pMYMRY2J0uitPSYqVm4YliyB+9n8g+z3GAGijF/U
         Yz5i40bSxvi42sN0yhX6SJArCv5SsUUOKV374YfoWJjbZcsvfpWzGQLtv+SNqj3YnxwH
         3OmpFCyufZ83ro6jY/3XaIuNpxI2t/6MiDDBnIkqzNLYcstLfxwRTUbicqlbHI23LZ9v
         xod+qOXOV4fiUhsB9qs0ZPlYZHwCamJiqRb1WEc7n86m+1c3ZE94prHyZI9igX28tdBs
         kYIcweeeTMmppl8J7yfcEDfS/o/qUivGosSeQMSq2lrB5bk7c3Nxl6LsvUl8eIw95lb9
         NHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=aVtpXJ7JmWYLC3y2V7ANojDd8/Faok+fXV4tt1+QxRU=;
        b=llZlGO7mDA77otTf4wWiFVFhO1hwwO5ozo9WzTypQmBABiRmL8PS3oct9061LYzhab
         X87VodZMvu/rqXEtRliyDxEb90gPzuuQb8dLwNPuz76cd7S4T3KP23gIF5P0Xi85qSJq
         bgfNnjh8yjEM7xodsGwD5VYpIwqn7BbSZgY/Pd1HegNc2a6RgrDsiaMf1rul5QcELlM7
         zSgxC7wb9HsXgl1dNiHgoWpbU8FMhv+SxU65NRD5kRHMte4WVdbRZ3KPuXY58HElrPZC
         3/espV0aY+52knnrL84B9j80/UzkX3qnN4qE3gZjIIysv6wiXCTNWklS/e/P4fKibum/
         qOiQ==
X-Gm-Message-State: AOAM530lxI2ejfRRwiqO2u9pCmoriPXvBMu7+/tDufKkNbQcZn3xRaQI
        ptery0LRbg74EWlzghTfO4o=
X-Google-Smtp-Source: ABdhPJy1eiUWqfc9iUkHWvmHGEvErlSbLK6SbdjCM+C85QCuq0aA6w6SQ2QIzogVE5iRkh38SxX2dw==
X-Received: by 2002:a9d:3e42:: with SMTP id h2mr21890565otg.275.1608772192660;
        Wed, 23 Dec 2020 17:09:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h26sm6901138ots.9.2020.12.23.17.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:51 -0800 (PST)
Date:   Wed, 23 Dec 2020 19:09:50 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe3ea5eb3f5b_7855a208c6@natae.notmuch>
In-Reply-To: <xmqqpn306y3a.fsf@gitster.c.googlers.com>
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
 <5fe2c64bd3790_17f6720897@natae.notmuch>
 <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
 <5fe2d89c212e8_18dc12083e@natae.notmuch>
 <xmqqzh248sy0.fsf@gitster.c.googlers.com>
 <5fe36790793ae_2354120839@natae.notmuch>
 <xmqqpn306y3a.fsf@gitster.c.googlers.com>
Subject: Re: Nobody is THE one making contribution
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> You are not THE one making contribution.
> >
> > When I'm sending a patch, I have the role of "contributor".
> 
> Yes, you are a contributor, but there are other contributors to the
> change under discussion.

There are other people _contributing_, but typically they are not
assigned the role of _contributor_.

This has been my experience in all the open source projects I've worked
on.

My guess is that semantically the role of contributor is different
because they are the ones bearing the brunt of the work (thinking the
idea, coding, testing, cleaning, sending the patch, addressing comments,
re-coding, re-testing, re-cleaing, sending another patch... etc).

Of course everyone contributes, but in any given patch series, the
"contributor" contributes the most.

> > In your own release notes [1] you say:
> >
> >   New contributors whose contributions weren't in v2.29.0 are as
> >   follows.
> >
> > Presumably these are the people who contributed patches, not reviews.
> 
> If I said "These community members have their name as an author of a
> patch for the first time since v2.29", would that mean those who do
> not have any commit under their name are not community members?

No. It would just mean they had other roles (not contributor).

For example, when a company pays their employees to contribute to the
project, the company can be considered a contributor (e.g. Google).

> > I don't know why you feel the need to explain that to me. I have been
> > contributing to open source projects for more than 20 years.
> 
> Because you are acting as if you don't know and have to always be
> the right one no matter what.  You may not mean to do so, but that
> is how your behaviour appears to me (note that I did not know say
> "to others").

Yes, but you do not read minds, and you can't know what is happening
inside mine.

Attempting to do so is usually not a good idea [1].

> I won't have time to respond to your word games after I send this
> message.

Words are the only tool we have to communicate among minds.

There's a reason why linguistics is an entire field of study; some
people are trying to really understand what other people are really
trying to say.

I for one don't understand why you would change the subject of the
thread to "Nobody is THE one making contribution", and then not be
interested in understanding what others understand by the word
"contribution".

But I'm not going to read into it something you didn't attempt to say.

I don't read minds.

Cheers.

[1] https://cogbtherapy.com/cbt-blog/common-cognitive-distortions-mind-reading

-- 
Felipe Contreras
