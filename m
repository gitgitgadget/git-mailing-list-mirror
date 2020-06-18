Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB14C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 19:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CAB20786
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 19:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4Ue/A6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgFRTzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgFRTze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 15:55:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB3CC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 12:55:34 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u17so5502374qtq.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gW6mWKQzWC8/OGz+wh2E82aOy1ys1X8qu9B86WtO+Cs=;
        b=m4Ue/A6g4Xq4muuysjErPv+CYuqYPMjPLewW3KgSNRTRIC0ht8QRu/4VpBUuYjCGdn
         XnhfYsIN3FeLwz07htKmzUp3OR6ymt2BBjwrzIBwVLqW+K/ebXkVh3ppnYL0rxitgMkb
         rff22bjhZlWSw5w/MEFNQ630vkrotwPXEEBLjg1Sjt95LlUCb32Wngqev+dkJbK5qnzv
         AnlLbht5XsMXkxjjil7lA1PlcWeBwQIenixuXdY7cQh5g1uHFoY2XJKiaBUJelQ4a+ll
         gouvCY+lKp1E9567OK3LUeBJW71AmJlSHpJkakb4qYXlElfsfjvMk+HQn85D7HSh346Q
         6XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gW6mWKQzWC8/OGz+wh2E82aOy1ys1X8qu9B86WtO+Cs=;
        b=RsLq2pKxs9c4wfCGIQXPrIacw9NEU+iU/SVFOxLYStOPvj5927OCMzoMEQoJzgwDeb
         NVnki5aqu/XWutqXX0JORNpxKRC9ANFKLqkY5Z8Kdd5rHPbMiaWflDDoFE/8m2Lyo8Me
         2dtr4k5+8RCmTkBvqCNYztMrIgZWBRz1mExEYddiQSc5G5Sz5az4sYawE5MV6uDrlK0D
         C0tmJgjwiORU/LhC2HnfHsS3GanBonU9vRFI4I/fFpbGD0TXW4+JdaEVPn28JZFQu7Vz
         F0BydrrULqUqOZlWyRLAGdDL8TJC45f0wBwQMMBOm2DDoocOa3LuD1cq3OmueiarQ7Km
         PJUA==
X-Gm-Message-State: AOAM532m4/fVpBZ64ev653HKNwuPWcjtjfaxgUwwxrfgY4uz53aY30MC
        0VQWXS+Tjm+fbCtzHyGhlgcblidhGvbzrQCNW5g=
X-Google-Smtp-Source: ABdhPJwmKY/WKHEaXox32yxPBygjXxJiKZ2HCpfptqg78JsCHjv98iJoBMdS9XWYaCjviI7VRfbPjhQZzvI8pDZu5/8=
X-Received: by 2002:ac8:2bc4:: with SMTP id n4mr6241772qtn.222.1592510133173;
 Thu, 18 Jun 2020 12:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <549f0cd5fffef38e8d85246a9aa2593674aad68c.1591986566.git.gitgitgadget@gmail.com>
 <20200615140349.1783-1-oystwa@gmail.com> <CAKiG+9X66yf_F8F3XuYFdFyBWiFRZ_rf0Y1mE5LVCjsi-AzKbg@mail.gmail.com>
 <xmqq8sglq8zn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sglq8zn.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Fri, 19 Jun 2020 01:25:22 +0530
Message-ID: <CAKiG+9VZUqDi=EbbqY2vLAiD6LEFMfR_2UHE+gbt_RpKNanUCA@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] cmake: support for building git on windows with mingw
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 10:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
> > On Mon, Jun 15, 2020 at 7:33 PM =C3=98ystein Walle <oystwa@gmail.com> w=
rote:
> >>
> >> > +if(WIN32)
> >> > +     set(EXE_EXTENSION .exe)
> >> > +else()
> >> > +     set(EXE_EXTENSION)
> >> > +endif()
> >>
> >> You can probably use CMAKE_EXECUTABLE_SUFFIX here. See:
> >> https://cmake.org/cmake/help/latest/variable/CMAKE_EXECUTABLE_SUFFIX.h=
tml
> >>
> >
> > Could have done it that way, will try to change it once the patch
> > series gets merged with next or master.
>
> If it is something that makes the result even simpler than the above
> quoted 5 lines, I do not see a reason to postpone it and use that
> simpler way from the beginning.
>

Since this patch series has been merged with pu, I didn't know whether
I should wait till the patch gets merged into 'next' or do the change
immediately.
If I do this change should I fixup the commit that introduced
EXE_EXTENSION or commit on top of HEAD? Please tell. I will do the
changes immediately and submit another PATCH series.

One more thing, there is an issue with the scripts' permissions when
run in Linux. They don't have execute permissions.
Since the main focus of the CMake build is to help windows devs,
should I defer this modification until a later time, or should I do
them immediately.
The changes will involve adding a line of code to each of the script
varieties(sh,perl,python) so 3 more lines of extra code.

Thank You,
Sibi Siddharthan

> Thanks.
