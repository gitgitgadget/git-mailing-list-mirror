Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBCDC433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFBF610A7
	for <git@archiver.kernel.org>; Sun, 16 May 2021 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEPSle (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 14:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhEPSle (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 14:41:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F90C06174A
        for <git@vger.kernel.org>; Sun, 16 May 2021 11:40:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 22so3094211pfv.11
        for <git@vger.kernel.org>; Sun, 16 May 2021 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BCZrp0rRmi9xau2A/eYQfqN2kCjyYx3xq0kIR3qezRM=;
        b=hRjW5nuZKK9IgUHIai98TqFo2GE991QWY+a1HAiEk8kpeb2m6KS6LWOgaVkSItPXxr
         t+tHfbwOABsVIUncrlOTX8j6TWBRTkCRIeDDqTsTE3FvGZvA1nQA6xH+CaBwndeKYZe2
         4HVaA9FDfary5iRNJoojv2NwMwFyV36t0UIS0nrCSF4n5t7kRtsrAfdIXHV0u45w3Yan
         BPJsFDzuO0k64xtCOOtmSG6QnjG+3LexsIbFrlsNHzIGTIURhkNZyh/H5esHGiPUK+g+
         zLE/IW4N/Lqz4/+sHe5qH06BoipLKKpPeRkA724poylLEZ5x3cT2kAWunsf77BA35R3t
         HW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCZrp0rRmi9xau2A/eYQfqN2kCjyYx3xq0kIR3qezRM=;
        b=QqrMUCuxOUfhyy/JlRqAv0wxfV8EyfN7eXEXNuhEjunB/we1PEEyTvIkCsJ/NTr/Dt
         e2NWNoTQODueQhA41gBQLT2bcR4o70ZVhBEd9bhb8kcVcvqXe9q3wWAveVdfN4z1wvWo
         XkwyUCtra+ObqG68x6PUTXyt1GBUDaHJsEeo+njZBLxI2C9bvKAFtMYlNXz4U3YuQr/H
         5KGDO2ZS6OROOZhQ/Wz6JSHCEj56XmZICJPwDY/w4D6AvPyIfR+kPen0tg+S3kLS+IQ+
         PzQl5I1HTpT1WRSo/upSdNdvTXGSxakZ+JN284HVCIurmBY5SR5xgQ8tvnc80Z3I7bdJ
         zUVg==
X-Gm-Message-State: AOAM533vJTbr9kPXvPS0lnpNGKZgFDMJN3z83CgwqcxS9Qh4v9o0ykHK
        74DCGzjm9dLWVkqm/12omkra3z8U3b+1DMo8aCE=
X-Google-Smtp-Source: ABdhPJxDbsmAGtw1zo1t0W1yQ8upU2eV1IBi8oODS9C3Uq6gtYmm1wkT8hd6Sgx38EChu9x217KrMiQHvOKLEeArZPg=
X-Received: by 2002:a62:1d0f:0:b029:2d5:3ec2:feb8 with SMTP id
 d15-20020a621d0f0000b02902d53ec2feb8mr14342784pfd.19.1621190418683; Sun, 16
 May 2021 11:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
 <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com> <DB9F1934-C7AF-4F44-853B-136C009910E9@gmail.com>
In-Reply-To: <DB9F1934-C7AF-4F44-853B-136C009910E9@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date:   Mon, 17 May 2021 00:10:07 +0530
Message-ID: <CA+ARAtp9Z_fiXkyRq0oEMSA6cP54xRfxf4uoXpQNbgqDsKoE2A@mail.gmail.com>
Subject: Re: [GSoC][Draft Proposal v2] Finish converting git submodule to builtin
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When quoting, only retain the most relevant portions of the e-mail. That
would help the readers of the e-mail a lot :)

On Fri, May 14, 2021 at 9:30 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Hi all. I wanted to keep you informed, there have been some changes
> in my personal schedule.
>
> > 7 Timeline (using the format dd/mm)
> > ===================================
> >
> >  Periods of limited availability (read: hectic chaos):
> >  - From 13/04 to 20/04 I will be having project evaluations and lab
> >    assessments for five of my courses.
> >  - From 20/04 to 01/05 I have my in-semester exams.
> >  - For a period of two weeks in the range of 08/05 to 29/05 I will be
> >    having my end-semester exams.
> >  My commitment: I will still have time during my finals to help people
> >  out on the mailing list, get acquainted with the community and its
> >  processes, and even review patches if I can. This is because we get
> >  holidays between each exam, and my grades are good enough to that I
> >  can prioritise Git over my studies ;-)
>
> Because of how hard COVID's second wave has hit my place, my exams
> (which happen offline) had been indefinitely postponed. My university
> has since given me the new dates for the finals -- either I give it on
> June 2, or give it on an unannounced date in July. Either way it will
> be happening during the GSoC coding period.
>
> I just want to reiterate that I will be less available in the two weeks
> during which the exams take place. I intend to work half-time on the
> project only for those two weeks, and I don't mind working a little
> extra on the other days to make up for it.
>
> I will send another update for which slot I will be choosing *if* I get
> selected for GSoC. Since the dates are shifting around a lot, according
> to the situation, I will send updates on those as well.
>

Thanks for letting us know.

On a general note, this year's GSoC is unlike previous years. There's
flexibility in the program that should help in situations like these. Some
information about it could be found here:

https://opensource.googleblog.com/2020/10/google-summer-of-code-2021-is-bringing.html

-- 
Sivaraam
