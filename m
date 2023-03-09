Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E5C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCIRUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjCIRT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:19:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056D0E826C
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:19:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id bo22so2741457pjb.4
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678382376;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iAU87akhgAIMMrvjFTRP4ygeZOICtUO2y5mH+UjSOAI=;
        b=UStySIV17XnR+aLc9A8SLUjUC//IzGL9q5mcZ9MTg/mQud2yOGYd4HWU8Dk4L43WeZ
         REYhcqTLInjmSArEdLrqQGswhE9U5W6yBIQNA4iVPUeZwdlbkM8RyTYOYJZsDcpZ+1js
         9o//Rob0c3HJP0sgcUb181Tn6tV7JwUuhiGvj+Qhj3mD0Bbk4Rpl8i+rqPqD0z+vFMBz
         /p/5nnFObtYTfh/Ez7/G6VRdJXgSeS0oaS/2wweIHsscYYlj4mrfXHwJej0qYdU9Dqjt
         pQo5ZpLA3cDB+WdPV34jXRoiDUuJbqLM30XJCFxVeejARTp21ieixPVDTrYcuSQNorgN
         eiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382376;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAU87akhgAIMMrvjFTRP4ygeZOICtUO2y5mH+UjSOAI=;
        b=sN6V85XBptgoAZozjty/nQ5iojidcjIWb/1yftEVumJ4ka7jGFoj2lc6YX5vmAkuUu
         175lUKYA5dCqzCDrjbelP4K6psFw+Bt7oPf7VgGppGdHEzCqYbD5o/Wpxb+/AATGfzl0
         9eDMofvxy167GZzPrfDsIXrOi+fAcUEW4CKaQL9F2m0PmTCof1blwd9l38Ta6jiUIhnU
         U9+Uk0eeiGmHUhk27OvQQORtcjfMOhnfu4dXsefviBYjbeXgWN5tTCzhKMbP/Ht7UWP+
         wMPM+IRV5g9/tbhtkVYQ2ChGdB1NOGAI3fdUt5yD8l54mCnrphQHzRipQindZj0QX+n/
         fh0A==
X-Gm-Message-State: AO0yUKVX5haupe/3ulH7Bx6Kusf4/kZZ3f72ONK+aG23/esqQOaHy4fh
        WgqTunA9ibpbKcUwlaDruVBd2gpiOuqsBA==
X-Google-Smtp-Source: AK7set8ps1vq0yFBf+miK2bgPKT8oQyG3DFVEcmz9h6i5K7o27/XleunQFNmUdPaXAfkyQWy+XKTcg==
X-Received: by 2002:a17:90b:3ec9:b0:237:ae7c:15b9 with SMTP id rm9-20020a17090b3ec900b00237ae7c15b9mr23637084pjb.36.1678382376381;
        Thu, 09 Mar 2023 09:19:36 -0800 (PST)
Received: from ?IPv6:::1? ([2401:4900:2587:68bc:87e5:83e7:3df:3f2d])
        by smtp.gmail.com with ESMTPSA id j10-20020a63550a000000b00502e918fee3sm10969257pgb.60.2023.03.09.09.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 09:19:35 -0800 (PST)
Date:   Thu, 09 Mar 2023 22:49:32 +0530
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
CC:     Victoria Dye <vdye@github.com>,
        Hariom verma <hariom18599@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: GSoC 2023
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP8UFD20=SScM3XA4mjiNs=rHJY3i_9MOcL8uxsFT-mn1-JH1A@mail.gmail.com>
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com> <CAP8UFD20=SScM3XA4mjiNs=rHJY3i_9MOcL8uxsFT-mn1-JH1A@mail.gmail.com>
Message-ID: <07423D73-8CD9-498B-89E7-7241AC6490D3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,


On 9 March 2023 3:47:51 pm IST, Christian Couder <christian=2Ecouder@gmail=
=2Ecom> wrote:
>
>Today is supposed to be the deadline for each project to have at least
>2 Org Admins for GSoC 2023, but it looks like I am the only one and
>cannot add a second one because of the bugs=2E
>

I suppose you should now see me as an Org admin for the 2023 program=2E

I thought I was already in as an Org Admin but I somehow have missed compl=
eting the process=2E Sorry about that=2E

>I have emailed gsoc-support@google=2Ecom to get support and will see what=
 happens=2E
>
>Let me know if you have ideas about this=2E
>

The thing is potential mentors need to login to the GSoC portal and accept=
 org member agreement and program rules=2E After you (or any Org Admin) sho=
uld be able to add that person to the program=2E Here's the relevant snippe=
t from Google's mail:

-- 8< --
Trying to invite Mentor and Org Admins from GSoC 2022 to the GSoC 2023 pro=
gram?

If a person was a Mentor or Org Admin for your org in 2022 then they just =
need to log in to=C2=A0g=2Eco/gsoc=C2=A0and click on the 2023 bar which wil=
l show them the 2023 Program Rules and Org Member agreement that they need =
to read and agree to=2E Once they have done that they will appear in the Or=
g Admin's dropdown of folks to add to the 2023 program=2E

-- >8 --

Hope this helps=2E

Victoria and Hariom,

Do kindly log into the portal and complete the process and let us know=2E =
Once that's done, we'll add you as mentors to the 2023 GSoC program=2E

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
