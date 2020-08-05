Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF7C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 06:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC7722B42
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 06:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVEtphYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHEGST (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgHEGSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 02:18:18 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5962C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 23:18:18 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id l184so8565726vki.10
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 23:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jd5UCTriqrtpcbl4wdePkeG/9jRlRwf73HwxwqOaWVk=;
        b=bVEtphYXRxiSL62f/otGoZ8DLbRoh0/l1/LdrNdyV+FABWpuq1pq1Raa6c9UgEl8Ka
         y3sxA+OOOZ1jqY8MsaLI+JR9XUTnTe9/qY9UCXWsE5pKF64v2azL8DcovQKXAB7hGiPK
         EH1gJNYP289uI+KbbqS6YGRLE0R7z/gAZzayuYTQCfN8R6XDKR04hbX2nTHFg2uVO4IX
         SKYzySQvcMSi6DDVyTmDyWsNM1WCl5KkRIjp5S15+m/qru8M+uegXde0VbwkLBvx1OkZ
         4URP6PolvBzZ3EEwa9tUi8ZmsgBYn+JuynddJo3FlEZHat6F8lthx+trdJWyOFI61jzX
         MNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jd5UCTriqrtpcbl4wdePkeG/9jRlRwf73HwxwqOaWVk=;
        b=Xb2XiXL00GkYx5r3KeBzPnr4fehV7BX2ifY6yiS14kEaQBqSgzXgE+wsAbMBNuQn9o
         cxNtcr40bRte+9dCrzYanaI1M1BB+B/NCr96iDeAwhfYeidXDuSy2R4V2TcOdicrhktB
         QzP6IYQqoPc7Mdm5imxfpF1fojQ2jpB1f9UMStnhw6obIsUddmpYcafip3//MW8nG07I
         OGVaoJS9ExXFpGq5DsoFuU9K8CadEoGCSDfGniF8IGV88PS4UDomnptEYH8biAt0HK9F
         mw9hHmdIMEWJtHJZTn7t7s4gTuLKP/NAAdcb0VIIwMhAn3tIBAXmsHsRCBt4yfPL2+yi
         FrFg==
X-Gm-Message-State: AOAM531zgLWhYORKSBOyhKWj5NDY6pyvRFY4kp/KFSjt3/Sqky90fkJ3
        hfzhLrgDr1M181u7r7pCOgk7UeJMzK6ydlZ6yjCZOKQk
X-Google-Smtp-Source: ABdhPJwXIiF2AXSf1d8ARbmo2Y9NBky5HdEMpwW3p+zfND14U8fb+5LjeOT2y8m/BJdG0CXbkunKO+8P+5WZVwx+R2Q=
X-Received: by 2002:a1f:93c1:: with SMTP id v184mr1270282vkd.62.1596608297923;
 Tue, 04 Aug 2020 23:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200801175840.1877-1-alipman88@gmail.com> <20200804220113.5909-1-alipman88@gmail.com>
In-Reply-To: <20200804220113.5909-1-alipman88@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Aug 2020 08:18:05 +0200
Message-ID: <CAN0heSp6rGT1YFFVGzmf=dXQGfi-h9TQRTcKgAsHXyJqs2e7Jg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Introduce --first-parent flag for git bisect
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aaron,

By the way, welcome to the list!

On Wed, 5 Aug 2020 at 00:02, Aaron Lipman <alipman88@gmail.com> wrote:
>
> Martin, thanks for your suggestions - I've moved the commit updating
> "git bisect run" tests to 1/5, updated the commit message, and
> included the changes you provided. (I held off on additional
> indentation corrections, as it kinda felt like unnecessary code
> churn/outside the scope of abstracting platform-specific details.)

Ok, great, I think it's fine to stop there. Those spots really are in a
much better shape now, thanks.

> > (Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>, FWIW.)
>
> I'm still getting used to the conventions - should I add your name as
> a signed-off-by tag, a thanks-to tag, or both?

What I meant was "oh, and here's my Signed-off-by for the record" so
that we wouldn't need a round-trip of "cool, can I have your S-o-b on
that?".  Of course, I expressed that in such a lousy, compact way that
we needed a round-trip *anyway*. :-/

And I'm not even sure we need a "Signed-off-by". I just posted the patch
form of "If you look for chmod, you'll find a few more spots where you
can do the exact same transformation, and you might want to look up
test_expect_code."

I see you added "Thanks-to" and I would have been fine with no mention
at all. I think that patch looks good now, thanks. No need to think
about the trailers for that patch now, I think you can safely focus on
the later patches from now on. ;-)

Martin
