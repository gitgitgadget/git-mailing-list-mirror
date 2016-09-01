Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BE21FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 07:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbcIAHlF (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 03:41:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36801 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbcIAHlE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 03:41:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so11269615wmf.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R4Rv6QBed7rFrHYEjEPI1+xdQf0sDOJcowceMFwuwR4=;
        b=WCXRmOGj7TEu8NPM6PyWT18a/fTt+DIO9yJAoj4qBCB4XvQzK32Jjmist7Q1p4Y2nd
         P2a9y80jydbDya3hczPtj0wkYblOqewrypa1ipJalfkiZSDa6IW9iSI730ERvmWYep+U
         8ok68jUsnRe3Y7ru3RFaCNJz2w6cP/fss4dusV6wNxIGwBRac6XaBTPT+7M6gXPIzpi2
         cYr5HwGYa2T11x0w73UUBy240qCuFkBekF3lXfE9R568F+g2Gmr5yB2xZ2nMkm+ODtOo
         KDCmeRWNTHQy97vjQR7QpbiNkHj2XuaIo9+ksvhPa2/XoU8RZg6Eh4L/m4GTitFFwq+3
         uiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R4Rv6QBed7rFrHYEjEPI1+xdQf0sDOJcowceMFwuwR4=;
        b=HUmuBFm7U17a+ZKVTqcjhRiTnMd3DYtV4wmXv3OPxI0ZSCxz/nnQx4+7O3zXtDpQyY
         fXKFkPPR9IKnu+RcIIVZb620RmyDeN0XSwaBf4lXzeas2BqXNbQ/0SYLppjMpelcQtGr
         lkctQTIPGOHChr0keB+Tm/ZYctv83NHfpDt6WrpkSIZz+P6E1JA77xxdAD9sip0RwemL
         dHATeZvKjmEAsvYbbdl9MQwAuCToSO0cGbhX6TtPm3MiaQVuow71YZr8e0v156tmgojn
         34MxeL3z08/FP/CuCMzG/PCFHockGQaUiybQQhlF2EHjNQF6Txw1XwXqK7pm2IFzEcAo
         29qg==
X-Gm-Message-State: AE9vXwPsPhpfdjx9zHfQEEenPjCBM5BoE2c0iS1QFbae6CgInnzmQH54MJzg2Yr7te4V4fY1QBkbM1Po57tEGQ==
X-Received: by 10.28.175.79 with SMTP id y76mr2453073wme.98.1472715663116;
 Thu, 01 Sep 2016 00:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Thu, 1 Sep 2016 00:41:02 -0700 (PDT)
In-Reply-To: <CAGZ79kZcK-QxMUa7A0FJbzq=ZQ=prWzJu4K69jaW8E-rwme=oQ@mail.gmail.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-15-chriscool@tuxfamily.org> <CAGZ79kZcK-QxMUa7A0FJbzq=ZQ=prWzJu4K69jaW8E-rwme=oQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Sep 2016 09:41:02 +0200
Message-ID: <CAP8UFD2C_y91+nYBoavq_cPWrUcoJ97jDvs64sBabL6kbpjehw@mail.gmail.com>
Subject: Re: [PATCH v13 14/14] builtin/am: use apply API in run_apply()
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 12:33 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> +
>> +       if (opts_left != 0)
>> +               die("unknown option passed thru to git apply");
>
> Through and thru are different spellings of the same word.
> Thru is the less preferred form, however, and it might be
> considered out of place outside the most informal contexts.

Ok I will change to "through"...

> [Source: The Internet]
>
> "git grep thru" confirms we only use it in comments or function
> names, both are not exposed to our dear users.

...but I find it strange to use different kind of language for our
users, who by the way are likely to be developers, than for our own
developers.

> The rest looks good.

Thanks for your review,
Christian.
