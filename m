Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F611C433E9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C19664EAC
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBKH6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhBKH4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:56:40 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1DBC061788
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:56:43 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id v6so1628853ljh.9
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htlixC268bVNhtad8IUsjTQN+t984AeN1OlkNvyowuk=;
        b=WY5ClHeGjXPC4iEu1nIdslj5DiSuu50UYPPmiyKEeo29YQuRj0E7UqkHV2MBma8au4
         rrdjX919Uevfo7Bnq2FaOoI2Mq6pKUq65xIBqpAENWu++R+B6VSsZCWUw2H6phaBC2Wj
         h35Nx8zG5OBkcskUd/wcZueQ/SYGXwc0kb3+KjI4ET2ZXVry28vUQAR481FS79javotr
         VJms/Pr1GLCnZ+eQX0yWeDeeW2LkjOb9rcryPSk3hUsz1I37mSMsHocGGYV6dPrdbKXX
         u1n7kSKF/G3Vkm+oiABM7AEQ1DG25Gpy8yZUczeE8d/GZHJ03QoyBwyPwDpl167+gKL4
         fpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htlixC268bVNhtad8IUsjTQN+t984AeN1OlkNvyowuk=;
        b=N2ZDxIoQ30NBp7ekKH7ulUrQ4hb9B95XBRGqW+L3Y9Dd5LCNEwiHOFfhGHRpJY97y6
         R6nPztfez6bzUMp5vAMMzDp0UDa/zxJVln1rreH+/SV/rLtZzpI21hWroBYS1BptyeJU
         uS0DjJ19dbWbi62t4eeZHLUTmAZ52XNAi3InaSujF7JLGkS8nGms9rZev5xxxVk/fWl2
         4Vs9MYDJ+mIP+nxcHzBEi+MKOD8w0ojfCmuV6r0la/bQ8Co9uBfdb1DjrSMq+FlePVdp
         U5FTqE0Yaua4QafCOHoFLY0Hn56jIgyo0kCpioWv+SVMXuJgvbwLx1xnSt5tIjg+CuSc
         WH8Q==
X-Gm-Message-State: AOAM530x0y5ic57KKQLC3FVxYMBq1NNdVxN2Vs7tQfa+OgjfEqoIxkKC
        C4JkrVPPjJyFmLJt1pjFR+MaBYe9R05Et0c7izY=
X-Google-Smtp-Source: ABdhPJy3bpz8Ptcj1maB0Rn2+ncy4/9aVOPBVF2WN1uZBJeUkZjvQxQ58Juy5R7Qm7vyw4aSVS0jK/5Ls8qbYlv0iYc=
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr4525115ljo.114.1613030201586;
 Wed, 10 Feb 2021 23:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20210209173254.17712-1-shubhunic@gmail.com> <xmqqy2fwyhjy.fsf@gitster.c.googlers.com>
 <CAPig+cSXi7Ct48gqkBVvBtOm6bMqDhPcxXeiK3ZytAitZXNT5Q@mail.gmail.com> <xmqq35y3ys0w.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq35y3ys0w.fsf@gitster.c.googlers.com>
From:   Shubham Verma <shubhunic@gmail.com>
Date:   Thu, 11 Feb 2021 13:26:30 +0530
Message-ID: <CAD=kLpvfAz7wkvBfakbc6woNWdyOxrYn0XKgSPkmTNz2RCNkKw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Modernizing the t7001 test script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank You Eric and Junio.

Sorry I forget about spelling.
Okay I will correct it and send a new patch series today.

Thank You!


On Thu, Feb 11, 2021 at 1:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Tue, Feb 9, 2021 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> shubham verma <shubhunic@gmail.com> writes:
> >> > In this patch series modernize the t7001 test script by changing the
> >> > style of its tests from an old one to the modern one and by cleaning
> >> > up the test script.
> >> >
> >> I would have used test_write_lines instead of here-doc in 9/10, but
> >> that is such a minor preference thing that it is not worth going
> >> back and replace.  Nothing else stood out during my cursory scan.
> >
> > I read over the entire series and likewise didn't find anything to
> > comment on, thus consider it in good shape. For what it's worth,
> > consider this series:
> >
> >     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>
> Yup, this one looked good to me.  Thanks.
>
> Except that the author's name were spelled in all lowercase, unlike
> v1, which made me wonder if it was intentional, that is.
