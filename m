Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49FD207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 16:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbcIZQWa (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 12:22:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35070 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422751AbcIZQW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 12:22:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id 133so14893964wmq.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tMzh3Es7ImjxSrdQUZR86nWnFTuyRkeCCQplnYgRdh0=;
        b=mIt37P/geKoezruCdw7EBKGBGoWD7ogD8BjCPA3f2lhfp8wYuTDBL4/OQmh5vrJecU
         9NSzO0+XLfMm3TQBWiv08a4tvx7obsp3EqhEWEGlUZBJ93V77TN1jqjwKJu07/rp4sTQ
         9hNUhd2q6Iwu/iyCc+BLljRIIzvx/EB/Ga/RH2ztQuqnLfnsry2ERpACdKxOLhzYtl3m
         4Aa8rPYSw96XA8/lS2ILn1C/glxPGKJGg/gAd5MNTnGYRgXyzjMWox1gNQkgUZ25jTXd
         mhAlKjGEKD/Yr/CVPrhIBnk+4+SDuYyoMWvo6Yu3Ko+vBWEDaOt2rA2fTr25vX8Y5wA7
         3QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tMzh3Es7ImjxSrdQUZR86nWnFTuyRkeCCQplnYgRdh0=;
        b=JG4ol9Ln1QBiC+8LcsbHuzGsI+DJ4sHY41QL6a+InA5kBeP5b1nnkSpr+2+BvaITqI
         BBp/IURLrqXkNSfgQ0YsGSH0KSG+6rWzRVs3MyGGqA4aI8bUjqMDbAT7enT7TBTkhusX
         u6VlJMrHlgzFu3VB4JAaLKz1NWPFIQ4bm5geoTtt0xYqHBnLBzy5N+1NfMiHrbxp9HWJ
         zDRbX62IQTv6H/2IsEqMJ73rzscDob324sd+05CYR1CqtUuf56GoNWpOJsNHMCD8Gtkg
         WUYkGteJtUs8Q15sRHNB49vOuuByZQEyxUkRs7N9NUn90MRxwmGhCX6GvG264kl7FxIU
         1Hyg==
X-Gm-Message-State: AA6/9RkEKkdE9EDitENrI1PqAaxw11inZ0FG0xghCsgUWzubMSVsZ8VS/1Wurn+NuxeNVXieu0UfH2kMqPV1xA==
X-Received: by 10.28.91.11 with SMTP id p11mr14465483wmb.98.1474906947604;
 Mon, 26 Sep 2016 09:22:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.136.12 with HTTP; Mon, 26 Sep 2016 09:21:47 -0700 (PDT)
In-Reply-To: <4B4255C0-4C0C-45F0-B37D-0C78C2AAFAE9@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-4-larsxschneider@gmail.com> <854ff387-57a4-4c27-4c27-b834f7797694@gmail.com>
 <4B4255C0-4C0C-45F0-B37D-0C78C2AAFAE9@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Mon, 26 Sep 2016 18:21:47 +0200
Message-ID: <CANQwDwd7YMjoyO3Y=FqcX720_vcqa0L=z6veTgYO==LorhqqFQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/11] run-command: move check_pipe() from write_or_die
 to run_command
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 September 2016 at 18:13, Lars Schneider <larsxschneider@gmail.com> wr=
ote:
>> On 25 Sep 2016, at 00:12, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>> Move check_pipe() to run_command and make it public. This is necessary
>>> to call the function from pkt-line in a subsequent patch.
>>
>> All right.
>
> Does this mean I can add your "Acked-by: Jakub Narebski <jnareb@gmail.com=
>" ?

Well, Acked-by makes sense if it is from subsystem maintainer. I can only
claim gitweb subsystem where my ACKs might make sense.

This "All right" is here to note that I have read this patch (and not
skipped it),
and I have't found anything to complain about or nitpick ;-P

Best,
--=20
Jakub Nar=C4=99bski
