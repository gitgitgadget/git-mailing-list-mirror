Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4832C433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 06:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FA264EE0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 06:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhBTGMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 01:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhBTGMr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 01:12:47 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AF2C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 22:12:07 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d7so7192773otq.6
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 22:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AgzN7bewzv5UjtWUjrTtZjZa1QntE9qU+kZUEG4sPVc=;
        b=LlRPFqEhBgc4OVXKQVHxcyXlWVOYXw6wfd+flrV+aIBgXtnGEToIH7phD1xvLv1hX5
         VwP7cq7XOflg1uJuZQO7cIQ4yZu+Gk05Xbb7Mti363hVoY73tQBajBmQamhEgZTlqtyL
         2lnmaRRNITq+FNsTwxk17hWLizbJ7x299Z/Zp/kVD2AUlXvZYLhlNtPY7uUcPlTV3WSe
         YxgH/G+KIT5s1fJMqCc5gHHQY2UEm1+b7tQQN58P/mgXnrRnSny/v86Zu/SUrlYEOzAA
         UXni3x1OnlP2RZeXfU+0epXqcyQO8roiZETZDdvTUfrcxIKRHIC0QBw+qm+5kPcvTXs0
         voNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AgzN7bewzv5UjtWUjrTtZjZa1QntE9qU+kZUEG4sPVc=;
        b=QhjPwD3h4JpuhLPBlnQPY89f1zKs2yso4bef7sOWRhv9lbQ2lBV01IxfQ36j4gOb1l
         pA56Zzwgq3hGS5TOsDG2ARlLlgGbk0RWc3YM1NJ70BewjGw16glOpwEpOmAp4Jl+ZoTp
         3VNcp8xPEVEVSfOoAIZ0fatCPGk9yCM4/x5aILjMQwwuW+l5l1g7Sz0iqeR338y71DDe
         WLywWNl2GZIpcri7QVtdtisIZ369qHVkzFWbIZclX7TkbFP08XcgoA3Zz7Ohp7ErgkEQ
         fZygYUUsNfPjpcnAn5e75FTSwolMB8WgZJJs0nOF/I8z2o4WHFcPyovjfa1A1l5hft4U
         XAtA==
X-Gm-Message-State: AOAM531OrRFWLMZvc9wna4VSNwtG81GsHXl+pN8VWurIXwp8unfu1pzc
        yb8YVbGr11icM1bdP8aMe1MCN2mWxqImasophhc=
X-Google-Smtp-Source: ABdhPJzUsJvGK6Wk0oeslhx8mz4a/O0TzaYu+iDvGGF30T3UFBilA2/+w9AhI0vNWgvrFqPXWBngA241/vFnTbjLQCQ=
X-Received: by 2002:a9d:21ca:: with SMTP id s68mr9749434otb.164.1613801526457;
 Fri, 19 Feb 2021 22:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
 <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
 <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com>
 <CAOLTT8RAuS5-PgTj4YdvakFV8uA1mfKa-gxBOxnWPcL5Sv0VHg@mail.gmail.com> <CA+CkUQ9nK3KyrXTTQifs1eFM-mWiR39Yt_FAbxwfjoiN5CghLg@mail.gmail.com>
In-Reply-To: <CA+CkUQ9nK3KyrXTTQifs1eFM-mWiR39Yt_FAbxwfjoiN5CghLg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 20 Feb 2021 14:11:54 +0800
Message-ID: <CAOLTT8Szxt3GkcSTogpjy6UApY5mbmdR3Nm6RNraMCM-H7M89g@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8820=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=882:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Fri, Feb 19, 2021 at 10:39 PM ZheNing Hu <adlternative@gmail.com> wrot=
e:
> >
> > Hi,Hariom verma,
> > I am very glad that you can serve as a possible mentor for GSOC this ye=
ar!
>
> Yeah, possible co-mentor. Thanks :)
>
> > I am very interested in this "Use ref-filter formats in `git cat-file`"=
.
> > Where should I start learning? :)
>
> That's great. Maybe you can start by learning:
> - What is cat-file?
> - How cat-file works?
> - What is ref-filter?
> - How ref-filter works?
> - What logic previous students came up with to unify these?
> - How much work has been done?
>
Thank you for your guidance, I will try to see the relevant code
implementation and documentation.
> Note: here at Git, we usually prefer inline replies. So, please avoid
> top posting.
>
OK, I'll be more standardized in the future.
> Regards,
> Hariom.

--
ZheNing Hu
