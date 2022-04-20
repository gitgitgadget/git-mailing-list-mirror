Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F0C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 13:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356416AbiDTNTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378833AbiDTNTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 09:19:42 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BF427F8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 06:16:55 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q22so1784269iod.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63XRYm9ykyy2fJ9fXUx55xozJYAteYPq5unEv0MZtDU=;
        b=jjS9BrVuiZr/UQKpH+bEgSoG3SmMoEzYBNG6EeygfmB1gw+ehY0sGu4NcnM6r5n6Ph
         uWN4DZ1a5XIQiTev8zATTSlwkxmISUBdD8BtgSnOfQef5ufLkP2j5GfH99/Y1P6L4VxE
         bmRDhZw44KExpKP82cq3bOs3HPhxxo1x3Bu1dglTYt+SHSd2wCvpfVZEHFWWm2x6nWhi
         /EDxhD9bDwV4QT56oVXLnILCn07UhofGCTCAv1KBcmykPWM/WYwjw1zt1InEA+ZpGJL7
         3cxRXtjQJikspJk1qy6Tr9BC851Q0Bm+0iDINLnf98dvG6YZ43WjJUM8iwgT+ijWjhm5
         hg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63XRYm9ykyy2fJ9fXUx55xozJYAteYPq5unEv0MZtDU=;
        b=5F1C9CLVEM8sxNxvbSiX2MW+RSbndUHiJqRLUhBYIphiU5PEKdCWFkxPykI2Qcpm5O
         /qU5rTEvP0qzaEVIc9yTj8OgwRhYBL6ZFu2IQSGcSrQkNyj1hg+otApy0YUy9fZfwcTr
         DpVOfH0mTNBnCt9wWycHx3HqavYmpOU67tW+jduYLyjAr2gQ0ITjePDNkGcbdPcVdy4P
         5oX6/s0yrOIvro7pZLHyae6T+MOd7ccXpCjA92qv9AMHbDF47mBw8J//ZqAOj1w0rEYy
         DvCHbyzGUJXcKhfkqVI9ghu/mQn3GG2isgGJ0TS1u0HrD5r4ttWnuhZyDw/W3p3bXlrE
         bYkg==
X-Gm-Message-State: AOAM530AjHFggg+ftAcySFhkuwdB1F4672vfQNdaEVAgALzYDRzD+A0W
        cvbNqPuE+02VjFMRJ5jEOaRylLxpXNup66GG0ig=
X-Google-Smtp-Source: ABdhPJzmdPMYXk2U+2f7P1TpgmbeSrwOLPA8fSo8do1Dwg/6lkXbWzl7zBSmgQu/WE+0WtyYY3TvKDSg68trsEE+qv4=
X-Received: by 2002:a05:6638:22d2:b0:32a:934e:8a62 with SMTP id
 j18-20020a05663822d200b0032a934e8a62mr526071jat.138.1650460614815; Wed, 20
 Apr 2022 06:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com> <E6525E16-10E8-4C08-A596-6C16AD31F62A@gmail.com>
 <CANsrJQcq-nWPaCyM3qR1d_u4U8wERdKbxFKMVK6Db9uWtyoFfQ@mail.gmail.com> <6ab769f8-92da-774f-9d33-4ab5c1eaab6b@gmail.com>
In-Reply-To: <6ab769f8-92da-774f-9d33-4ab5c1eaab6b@gmail.com>
From:   Labnan Khalid Masum <khalid.masum.92@gmail.com>
Date:   Wed, 20 Apr 2022 19:16:41 +0600
Message-ID: <CAABMjtFw3dXd8kp82Hqz_NDMxV-U4mDD5y_MrxPj2bvinR3OXQ@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Jayati Shrivastava <gaurijove@gmail.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jack McGuinness <jmcguinness2@ucmerced.edu>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I shall not be able to participate in GSoC this year. I'll try to contribute
and understand the codebase more instead and try to participate next
year hopefully.

Regards,
Khalid Masum

On Tue, Apr 19, 2022 at 11:40 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi Jayati,
>
> On 19-04-2022 18:46, Jayati Shrivastava wrote:
> > Due to time constraints I shall be unable to participate in GSOC this
> > year, but I'll continue
> > to contribute to Git and invest time in understanding its codebase and
> > hopefully apply
> > next year as a GSOC applicant.
> >
>
> That's understandable. Thanks for letting us know. Hoping to hear from
> you on the mailing list :)
>
>
> Others,
>
> Thanks for submitting the proposals on time.
>
> --
> Sivaraam
