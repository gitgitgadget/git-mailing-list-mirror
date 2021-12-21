Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C5DC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhLUXDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhLUXDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:03:17 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF5C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:03:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so2378337edc.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MR0qlHuV+TcvmGskfT2exZzdQyXlnbAgffwMHLoQoHQ=;
        b=drlmpLQkfU7c0R+SKCccRaY0WBFkPiKctPU2gvjCFDVtUYOfU0DpiQbL/QClqCLAxi
         X9PPM8GyTW9FpUOadAFHNOH+r4MOMecgZOqTciHk6OHK1CR+NhOG8yef/Ma0UhYvO3GM
         2njfnloTDMd/zLXR0wfIQfOyKUuiZjq/s1c2PUJw1wUwSHOgaMuIB8V3l028foN0XC/T
         O4MiH/1w5X0/PpI1MdVmgDvjcqbJvp0Ew4bpi69B1Kp8qtUmtcZ3RZcnvPCoZo2F9Wh7
         I/FSgSbt03dwK7q0qeYiBVGxYlpX6S3caR48izd/pMpaWqphtYm/37h5G1drhVaUDrHp
         7Nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MR0qlHuV+TcvmGskfT2exZzdQyXlnbAgffwMHLoQoHQ=;
        b=A9lG9V5aMjkDtqD7NrmeHprqrqN4ROz6Rgfo9UnmY84iSbuYhPvop4V2tgIgIxvagF
         Opu73hFUzN9m1z8nxe+9QPtfsusF5D0LFrsjkSWwrrexS1EvFVeJ7/cbbOFOLND+j4e9
         H4RUrlXM4j5VvDr7oDpk51M4OHLNefobS2AVyNuK17pr02aXnLQI+EkMrK+r1A1hq1Sa
         gSxuTxgaCrqqKT8sCfBlbjlJp0+HmEP0LX/iHS7oB7//4gY0u76hMvc0aTgIE0qRBXRc
         LFtsXU3XlaKw9KmO5p+JLaouaPYZAqRWe9GMZd1mr5DO5e56uHYtqSyNep6Hvw7Swzm9
         LQCw==
X-Gm-Message-State: AOAM533JhwugxYiqu4/VtXvhtkELwAdOT8WiAHwA1tCM9P2d0b2MHpD2
        YldpBICBUdS6Nu2HBXBP0asqAkMda1M=
X-Google-Smtp-Source: ABdhPJzqO8tme7/5HmwJultVzvTly45AcwUkfkQ3gm49R0wNX0CinnOPQfY3Wp8CofdfHNKAcoA0Sw==
X-Received: by 2002:a05:6402:274e:: with SMTP id z14mr388690edd.369.1640127795613;
        Tue, 21 Dec 2021 15:03:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ga12sm75926ejc.11.2021.12.21.15.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 15:03:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzoA6-000zQU-PJ;
        Wed, 22 Dec 2021 00:03:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 2/9] ll-merge: make callers responsible for showing
 warnings
Date:   Wed, 22 Dec 2021 00:02:54 +0100
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <d022176618d76943743940da0787291d51c9b4f0.1640109948.git.gitgitgadget@gmail.com>
 <211221.868rwdr6wc.gmgdl@evledraar.gmail.com>
 <CABPp-BHZH=hdEZ=iYQK_Gg+3aXmJj4uv4SZcJB=J4_K=TTKwHQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHZH=hdEZ=iYQK_Gg+3aXmJj4uv4SZcJB=J4_K=TTKwHQ@mail.gmail.com>
Message-ID: <211222.86v8zhpnm5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Elijah Newren wrote:

> On Tue, Dec 21, 2021 at 1:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:
>>
>> > From: Elijah Newren <newren@gmail.com>
>>
>> > +     if (status =3D=3D LL_MERGE_BINARY_CONFLICT)
>> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
>> > +                     "base", "ours", "theirs");
>>
>> This & other messages in the series have warning/BUG etc. starting with
>> upper-case.
>
> Yes, but I'm not introducing a new message here; I'm merely moving an
> existing one.  It's important to me that readers of this patch be able
> to verify that I have made no functional changes in this patch, so
> fixing the case should definitely be a different patch from this one.
> I kind of think that fixing the case distracts a bit from the point of
> the series, and the series is already kind of long, but do you feel
> strongly that I should fix the case with a new patch inserted into the
> series?

I just missed the bit where it was moved from below in the diff. Sorry
about the noise.
