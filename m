Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4C41FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 16:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755962AbcIKQBS (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 12:01:18 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33587 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755875AbcIKQBR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 12:01:17 -0400
Received: by mail-oi0-f54.google.com with SMTP id y2so257885716oie.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HJUHL10vxMeHVgK3qzQkkFun0X84n3gDdSTVoEnduwA=;
        b=DZJA9AIc+16i4iqWxvYmpI4opvcUGPyVIpYPVeJ1PWLloGPCLQ6tf6u0xfuha8Bn19
         fY/2ILfm0O9c6izrHjMvAi2eFrAQVHxV2cRuHCIUgzf/SgxM3a3tFkpoTNLWmuzkleYW
         pm6DrV9K/rIapKtSKu3TQ00yUAFauxthh89s//kmSYMaYDdX4sYn0JzJ6k/sJztNzsv2
         QG1980C5kCxMgygHajasisk+IhguB5hEelxZo1qJdWH3c8ySWtu5xyzBJG3l8E2Fmzam
         vzWGWYLvGvBgoTKW1Zp00/Dg6twAYA7jSpKfg19eZKY2vrbCnYIamt9Rz7dqlnG+9iVp
         Xe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HJUHL10vxMeHVgK3qzQkkFun0X84n3gDdSTVoEnduwA=;
        b=hxWLl0I7Mlua/rJCok05gjDvwq5paC02e3/ai3x7Qz2NEQzoGl4BjTn4Yu1hQZQZzR
         U+VCWoPfbWx5qEe1owMdNB8rAzo7utqiWfRQ/gVrXeGxQXY48XcVjsWFk6FO+ndkxpAk
         QTWeJ4LR7cMujaV9zh38ULF7YxPlqg+kR5D8V2VNex0mzX442HVvUHOHf8HEWyfPxZVU
         riNsNyeE99tKErMjHWB68uNVZk3YsjpUHM7U2Fajo672FnCvuin3WzHZPU6ER9KH7Y0P
         EMPnnmfFbAnCwxVAnViavpHDJP2qqb94A+xLBemWe/vzMDLHO1eT4/AAG2/fQUwml3K3
         i0Kg==
X-Gm-Message-State: AE9vXwNc1qpACt8+dY5Tm7WxIdirC4Zwsj1r43hYopiJ9Qx7j8kpkx767WPP3KzQjav7k2alPqE87yIqccOi8vxi
X-Received: by 10.202.227.148 with SMTP id a142mr18971980oih.50.1473609676504;
 Sun, 11 Sep 2016 09:01:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sun, 11 Sep 2016 09:01:16 -0700 (PDT)
In-Reply-To: <714C1346-6A7D-4A8B-AAA2-BA936EB6B739@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
 <20160908182132.50788-4-larsxschneider@gmail.com> <CAGZ79kY0GaWuuh_MzKL6FZ7KWF2Kwhfh9qnEYd-qX8VDQWNmCQ@mail.gmail.com>
 <714C1346-6A7D-4A8B-AAA2-BA936EB6B739@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 11 Sep 2016 09:01:16 -0700
Message-ID: <CAGZ79kZaRdJqbjfacdxT5eqOaK-RObJo+AddZ8heaU-KzWCOwQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] pkt-line: add packet_write_fmt_gently()
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2016 at 4:36 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:

>>
>>    call check_pipe from write_or_die here instead of
>>    reproducing that function?
>
> Yes, might be better. I wasn't sure because the check_pipe is
> not public.
>
> Where would you declare check_pipe? In cache.h?

IIRC, once upon a time the community decided to not
clutter cache.h any more as it is like a dirty kitchen sink,
piling up all unrelated things, but on the other hand that
would be handy.

> Maybe it would be more suitable to move check_pipe to
> run-command.h/c?

That's certainly possible.
I don't have a strong opinion, where the code actually
resides, but I do have a strong-ish opinion on code
duplication. ;)
