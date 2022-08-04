Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EADC19F2B
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 07:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiHDHzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbiHDHzX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 03:55:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E241276F
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 00:55:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e13so5328241edj.12
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=WAIGEO480DxzCRb1+m3LHtcE0+qZUPTDYoJC6jfcp14=;
        b=iOM1En0daMFrUg1f3kojFqyAN7xgCM5Vf7dFj0Wg9zkYBM2PaljPXFeFbwvDOFz+Mj
         glD+XEUjtsAvJtIw5BAdSOw+ACeoQYT72NxrB+TiqDGlXKaCGftdLmA0MFzlBjYms5np
         JFA3pDSvVZrMLdti3tIq/9PJcEFYs+mtbjnEEVxge/4giMLSzApAT2zI5q0C/wwspFkM
         md9SFvyU9ZMpGnJzB7fJpfQvtHO45NvuxnS5dtQi8QfLzEYFVOhETU7Pu+CPp+ea5rv1
         Ny+VKaQ/QCylyU2WTs1MCEwX+NdNxKzz6U7Y/1Xmb5lWVr6JVm2tLf0MjmGnWQtp9el5
         iAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=WAIGEO480DxzCRb1+m3LHtcE0+qZUPTDYoJC6jfcp14=;
        b=eE/jj2qPMy0Kx8WbYyrRaEnyaLS2isNreeCXeU76y7B59KUyFo5q4KlgDmcr3T1c8b
         5MaYq1Hzn1Tw/AACTNPT+4nRSzsVSDIXmG3nevl8Y0hUTf0p2uOwlTwoO1NOYpogd2R2
         UT0XMJYRQEsczu13DEBpC1BXzbl2g4IY3p9h7xm7q8RYySYNFWkYtc/hLkg3sMmc3YXG
         Xbsbv7B9XWPL4V84juHXNl6sRQvKBFd6LiSHjxmaWj9CQYTaUQmtBC10S6baBU9tDu1D
         dZncyHS+UTScTttuNQZEjh26fLQWgPkst21mbSC/MMolRr4ZbSXiqWRTwB4maobf8qFb
         pkOA==
X-Gm-Message-State: ACgBeo1R7yXK/n/AR5TopzNdbEst3hh5HuOEUzANrDSxcK0Tng4ZJtB4
        iE7z0qGp66/x01EXh812KRvn1wq/bm4=
X-Google-Smtp-Source: AA6agR5cpzWXM0IU/+uR2Zu5U3o7JY99Lf9lT/0evvCijnhPhyzeC0xFgOZeM6WzHMP5EVM/bo9o7g==
X-Received: by 2002:a05:6402:23a1:b0:43d:9477:4d57 with SMTP id j33-20020a05640223a100b0043d94774d57mr772639eda.168.1659599719570;
        Thu, 04 Aug 2022 00:55:19 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kx16-20020a170907775000b00724261b592esm36051ejc.186.2022.08.04.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:55:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJVhO-009g54-0l;
        Thu, 04 Aug 2022 09:55:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] log: refactor "rev.pending" code in cmd_show()
Date:   Thu, 04 Aug 2022 09:51:41 +0200
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
 <patch-v3-4.6-fd474666e7c-20220802T152925Z-avarab@gmail.com>
 <xmqqo7x19pif.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo7x19pif.fsf@gitster.g>
Message-ID: <220804.865yj8e93t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 03 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Refactor the juggling of "rev.pending" and our replacement for it
>> amended in the preceding commit so that:
>> ...
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Helped-by: Jeff King <peff@peff.net>
>
> List trailer lines chronologically, please.

Willdo.

> I may have said this earlier, but once we start using the "prepare a
> blank one, copy it to clear another" pattern, we should stop using
> memcpy() and use structure assignment, especially if we are trying to
> make our intent clear.

Yeah, I saw that. I took it as we should consider changing this more
generally (e.g. with coccicheck etc.).

This was mentioned in one of the original threads about the memcpy()
idiom, but IIRC there was some reason to think that it wasn't as widely
supported, or in any case we'd want to re-rest that the compilers we
care about similarly optimize it.

So I think it's best to just use the more widely used pattern for now,
and if we'd like change them all in some follow-up change...

