Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EC1C433E5
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C4E2070E
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKi0MwDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQK2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQK2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:28:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFFEC061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:28:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 80so8261415qko.7
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiwWJTt8XaqBNINfhOeZBXoRdMuTEAS12V0MQxx6Dgk=;
        b=JKi0MwDH4PeDz24vYZSL9jVo9XsCqHG01torXWSm0gkZotV2A0QW+suDYiJnF1FF3U
         aam+g7jlOY2/y8X5F/sGCIpF5AokKp/3rHJ8XjC+NnD1Gsvzcgzf92GIvsjZeCXbyrE1
         u07scqI93JAc8U2AhnoTrXN7nlcBtB4eJkQMLWAe1n1pc0/k3ZLlFVs08E2U8EswxZSD
         mHmstATGNLciGsoXo7VefTCL/IB9P07GmbOyRnsjKrnfMj5pItNkBTlbMjFLb8HdWo0H
         5ScXkCop3FMjf8GSrPmeJo/yEuRqpnRP92HQsdE8YN4YZe4VZTBMkzKTz0xFiPmJY/sl
         ZhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiwWJTt8XaqBNINfhOeZBXoRdMuTEAS12V0MQxx6Dgk=;
        b=Dq3+XFzKAdmaJyCS4uf5dtgTn0Ka6FYj8Ri5bmdE3KnTdV06jbcF4AIBfluzZU4Kxh
         QbR3UYHeN2m2KYHxZGIi0500c/6rFBpCKo0EV8X4hCZFYbNxP2bJLM/GQKvmKzEt5Pul
         H/AFVSlDPfYE2p3ETEee5cVz+tX4J1ZdSegcK4DbV4Vssh9vRGIwi0kdvB4dhSpgmcve
         75G1dLo+SbqhaMWyOGkmV0hE7zTcfouyUQl4BiE/hCI7hfKvFXBBfTB/sjKFOJgxba8b
         8T7zb7nUn+2wI5tFxj+J1lluLf5j+DaQpTrLUITEoqjqVjKyM+uiOakIdLEK5aqBwZYz
         d1lQ==
X-Gm-Message-State: AOAM531Dv4qksHPYXghGjfnlucqyN4cwu2TqodwtUxlmTBl3zf6Umm8f
        GfeG7Fj4g4JKViC7UnLAguAVCADvfPck3OKKR1+ErK0APgbRBw==
X-Google-Smtp-Source: ABdhPJwb2JhqH65znx9mU2QJincDSpCnIWn5xJP8ZbVr0n/+JDzrSH9Whf99b2SmyiZDWYe6TIbcAOzG/VgTPr1sQWs=
X-Received: by 2002:a37:b141:: with SMTP id a62mr7390674qkf.201.1594981690072;
 Fri, 17 Jul 2020 03:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
 <20200716153159.GA1061124@coredump.intra.peff.net> <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
 <20200717063324.GB1179001@coredump.intra.peff.net> <xmqqd04ufutq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd04ufutq.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Fri, 17 Jul 2020 18:27:59 +0800
Message-ID: <CAAvDm6akPndEmFz3v45zevPkmgmWGMi_kZFyCq_=K3hKOcKuHA@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your reply.

>Perhaps the definition of "distant future" is about 8 years ;-)
>https://lore.kernel.org/git/7vr4q45y65.fsf@alter.siamese.dyndns.org/
I read this post and did the test like this:
git log --grep=12 --grep-and --grep-not \--grep-\(--grep=comments\)
fatal: unrecognized argument: --grep-and

I found it doesn't work for git version 2.7.4.

After reading it carefully again and again, I finally understood what
you mean by
"distant future" is about 8 years. :) (:

Thank you for your attention to this matter.

On Fri, Jul 17, 2020 at 3:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > But none of that is exposed via the command-line of "git log". I think
> > it would be possible to do so, but I'm not sure how tricky it would be
> > (certainly one complication is that "--not" already means something else
> > there, but presumably we could have "--grep-and", "--grep-not", etc).
>
> Perhaps the definition of "distant future" is about 8 years ;-)
>
> https://lore.kernel.org/git/7vr4q45y65.fsf@alter.siamese.dyndns.org/
>
