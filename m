Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADC620A40
	for <e@80x24.org>; Mon, 27 Nov 2017 05:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdK0FCU (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:02:20 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45003 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdK0FCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:02:19 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so31685058wmr.3
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 21:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sZFzVE1PuYAsc/Z1W+g9IXziJwcuOb+Fpj0JPfvFayM=;
        b=vIrONJ8AgmuLpuanEOK+Qr+QcpUzZCTrPsQXqzAPPJsa+GLzb84sklstTSItWvtZGc
         EvmkbNGjebAOv0QTdWbgMY7RW5T6/UmmZ21fbxuERSIni9WxKByHSs9DJ6UeM+N0wrAp
         bdZ1BKsmCnt962GEMC+hcNlFJQ49l49CbaPUaxGw3cWl5o07EhR6KmAc144cq7/wyg3q
         YsQAppXyYJUDt6VC7qdbo7H/9+KW37q4J+3YKmD/C1x4TD6AZS3sHa/QqvCWZSlfQIGX
         WndI7MRCKI6ciqhyByZsBSLfLGuetpJkp3C1itfsD2TxskhuuRDIT+Zeo+a1yisu5wkO
         Q+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sZFzVE1PuYAsc/Z1W+g9IXziJwcuOb+Fpj0JPfvFayM=;
        b=SUIO/uKpYUiHaCsOOJarvm08w1liNZPeOIvOjvqVmNeaJVCCMpdNNgHOD4VLdtydP7
         ANsTbFurqsVGXwLbV7G75fTtNF8e/XHxfowkKZHPdotkapIPA06zgiu7V8l1dxxt3ulO
         hm0rqjh1tAEBxqDWJX4qePbCdUjIGDdawRvE3B2E3U53tb+pPEdfuC+NC2b7IxDLw7YT
         xX9nfDfshrr1deTbcnSkcHKE8cMBoH/CSN8S8g2nrmbbQRJKVfw5jFWoMgEcufUilHdJ
         pGK9MQ8Pc0j0p6GUMr9MY5mHny8wNbCBrrFcRN27A77QQW1Oyqk3egKPer2gInJcAaWL
         hoRA==
X-Gm-Message-State: AJaThX43NcfkFI8ULhSeiJtCO749i6oAKrcsax/zEyiGmd0uHjnn9T9q
        4ftKDkD5Zxswo2COrNHCJMj/i7S/2CI/n/HUits8TA==
X-Google-Smtp-Source: AGs4zMb5FmA1ve9UnbnwGrwsNF5vJhJw9/f84t8N7VXtMFXqeC/WlTlsi6yS9S5nrky+T5stmbvRwm8UZrV+pLAgmSM=
X-Received: by 10.28.73.196 with SMTP id w187mr5121778wma.17.1511758938077;
 Sun, 26 Nov 2017 21:02:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.203.140 with HTTP; Sun, 26 Nov 2017 21:01:36 -0800 (PST)
In-Reply-To: <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
 <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com> <20171127043740.GA5994@sigill> <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
From:   Takuto Ikuta <tikuta@google.com>
Date:   Mon, 27 Nov 2017 14:01:36 +0900
Message-ID: <CALNjmMo3KH4QXY00ViVaiHdy=pSZ5j0BWRueO1T=sC_r0=3c3g@mail.gmail.com>
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-11-27 13:53 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Jeff King <peff@peff.net> writes:
>
>>> cf. https://public-inbox.org/git/20171120202920.7ppcwmzkxifywtoj@sigill.intra.peff.net/
>>
>> It's funny that we'd get two patches so close together. AFAIK the
>> slowness here has been with us for years, and I just happened to
>> investigate it recently.

Yes, thank you for let me know.
Please ignore my patch, sorry.

>>
>>> The 5-patch series that contains the same change as this one is
>>> cooking and will hopefully be in the released version before the end
>>> of the year.
>>
>> I'd be curious if the 5th patch there provides an additional speedup for
>> Takuto's case.
>
> Indeed, it is a very good point.
>
> IIUC, the 5th one is about fetching tons of refs that you have never
> seen, right?  If a repository that has trouble with everything-local
> is suffering because it right now has 300k remote-tracking branches,
> I'd imagine that these remote-tracking branches are being added at a
> considerable rate, so I'd not be surprised if these "new" refs
> benefits from that patch.  And it would be nice to know how much a
> real life scenario actually does improve.
>
> Thanks.

In chromium repository,  your 5th patch does not improve performance,
took more than 5 minutes to run fetch on windows.
4th patch is very important for the repository in daily fetch.
I hope your 4th patch will be merged.

Thanks.
-- 
Takuto Ikuta
Software Engineer in Tokyo
Chrome Infrastructure (goma team)
