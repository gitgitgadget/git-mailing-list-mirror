Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D225C433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 17:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6890B22512
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 17:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgL0R3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 12:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL0R3v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 12:29:51 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A831EC061794
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 09:29:11 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 9so9439826oiq.3
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=94jHEdmavUsPfVxd5xgifUJpkP28BQxIGQH3RRuWVkA=;
        b=VLxsy4Cp0gKyXNMvGmAlLEnIKvm/WgL1tHtpAjN5bmTpisDHf333hr3fh+H0ZDPtpu
         L6mym77ec0kew7a0pN3Bjn0osSNzdgaXXh9/I1aqplbe+vmgHDwd2eCxQUYUlcUdAmLJ
         6UHm/laZV2OWak9THoR4S5w6BWwmqtE9p4Imm8INpNcK0X+zCOf1MQFH3BlZpmI2yoz8
         DUz/XHLeQTl596dd1X1Nm3T3NWA0EwHaZnntqqYiuVFJdsagcWLz4LSRH7aU1a2/WXle
         KnNlreJnEoJpSR5UVTHZNTbN2rx5oICfGS4hDekJLI0u2946lNTtAXd3O1qgJk4wVOfN
         sTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=94jHEdmavUsPfVxd5xgifUJpkP28BQxIGQH3RRuWVkA=;
        b=Pxn2bm5hCJTafTJmaMeMCzjdTnmvDkDPwKDKQRumO9YSyn+8QkPCfFkn3tjsJUMg/n
         fnN9AnUm5PXYNuhsL0BACrLiGkAw5cfi2yafWB5Qtc8V12AlRE8fe1to6MYSVcV23QMq
         dKXZdbcNm9dj2CwAVBCUWjCHASKUGKDKzsmdwHBwhfEukzPiI9i4lGXXolI2frgiHtDh
         5uGk2gr772U7Mw3oU8XeCIwAJ4j3L4FM84XLR6nAf5nnf8a8wplQThYTjZEmbO+R7rq4
         ztRyqmeQdz6KZR0JYql7k5WDn8P26cnvEhxNS2TBt5EG+391m1ZBxU5VScpT6nfwIweU
         4YCQ==
X-Gm-Message-State: AOAM530MS37Okvsk2GbmP/htDFtx9PNSFgzBW7LBFBK4KBD/9B3Owk0N
        recCPaOc3Ozjzy4CVpxHjxI=
X-Google-Smtp-Source: ABdhPJzUZFtWGLKc+K9gnhaDQkfzOb1uSHLu502jDN4mxSJOWdKKCofAc0NysWU+U2k2EDoyhSLZUA==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr9787709oiz.81.1609090151110;
        Sun, 27 Dec 2020 09:29:11 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 65sm8690754otp.35.2020.12.27.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 09:29:10 -0800 (PST)
Date:   Sun, 27 Dec 2020 11:29:08 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe8c464bc190_e22d2086a@natae.notmuch>
In-Reply-To: <xmqqtusa24oa.fsf@gitster.c.googlers.com>
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
 <87r1ngufmf.fsf@evledraar.gmail.com>
 <5fe424d0528a2_7855a208d3@natae.notmuch>
 <87o8ijv124.fsf@evledraar.gmail.com>
 <5fe4b33dbc028_19c920834@natae.notmuch>
 <xmqqtusa24oa.fsf@gitster.c.googlers.com>
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
> >> Not "I signed off on my subjective approval of this patch & what it's
> >> for etc.", which seems to be closer to your interpretation.
> >
> > Why does it have to be only one meaning?
> >
> > Junio doesn't sign off on a patch that he doesn't think is good.
> > Same happens with all the lieutenants of Linux.

> The reason why some patches do not carry sign-off might be because
> the sender does not wish to certify and that's OK.

That's one reason.

> But if you are arguing that when you write "Signed-off-by:" your
> sign-off can mean something other than what DCO says it means,

The DCO has clause (d), which clearly states the developer must agree
that a record of his/her contribution is maintained indefinitely (and
that includes his/her sign off).

So there's at least two meanings in the DCO itself.

Additionally, that's the meaning of the phrase "sign off" in English; I
approve of this.

-- 
Felipe Contreras
