Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518CE1F859
	for <e@80x24.org>; Mon,  8 Aug 2016 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbcHHLbx (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 07:31:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36363 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbcHHLbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 07:31:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id x83so14815240wma.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 04:31:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ONI1e28E/UYyM6SetkrKxxyE4EJhSukVtDLVI3/Aewg=;
        b=tsRMuGvE/O2wo8zRDwPjlJz23kdwWJYx2OrD8WhUVEIYqtWZC/7ZhpTMFK70GrIFG4
         fPIOc08AeiLS6yvGr6wHKKA59xUHuekEOWd8veb0rzXl3W7AR/DT9dQyaYSMKJqbG+EC
         Bx8X3rwiQWSQrCy+/zcBWNrtgxjKK8SZZ69WsROJWErnS4u+EnBNmV2iy0v31DbqjsSO
         ykzYPePnST3LKf9rxWnebX0nWEvuXPkXClzv0j3gdiQof3dwSLcgx1TbaFvfb76D6Tud
         ah5RX3STuuU+bxL6K4QYt4+8+W8R53d+y2TUq4rIWs194Qi/czZQr4psj8XIxa7UZ2ze
         UwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ONI1e28E/UYyM6SetkrKxxyE4EJhSukVtDLVI3/Aewg=;
        b=GdUARZiMXFjVyytfrz+tXe1bDpoNxSnnPzYXO48hkl72MAi06ioRgsMO///2j5xLug
         8je2AoKzGh6ka96u7y32qPDcX5l0qKFExOuRvEJ9uOqSnFUi1d5Ji01l1CosdbySUBlR
         rAuvNTIfqzymNswwE5pKJZhFrYq7Z8tO7nFUT7EIpdFnFB61NVdQ/LK1dsy4d43P4Xzo
         J5PlZoWkpvvYrWeCPgw5wCl7q5R7VBsb8mCAeOEo1bmaCzNvBou8lgrpsnBIQ7DokvNS
         ZUeSudKzOx7N0RylXngfBUj28sS10HruC9DJR1K6ppJ8C2GVBuq18+uOP3gKy5xczSo9
         LbMg==
X-Gm-Message-State: AEkooutm/1BTFIQPAG7/HQwyH9fGoMSQQwUjmIw7q09FfgdhRR2iI79yAO9bfbI1Q2r4MTY0A21I9grsQCGoTQ==
X-Received: by 10.194.38.9 with SMTP id c9mr21607103wjk.78.1470655911119; Mon,
 08 Aug 2016 04:31:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Mon, 8 Aug 2016 04:31:50 -0700 (PDT)
In-Reply-To: <CAGZ79kYpm=X2nTdif+Sz3K_cHBqWq2Pu4AmiKrgZ38aDDyTNjA@mail.gmail.com>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
 <20160730172509.22939-40-chriscool@tuxfamily.org> <CAGZ79kYpm=X2nTdif+Sz3K_cHBqWq2Pu4AmiKrgZ38aDDyTNjA@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 8 Aug 2016 13:31:50 +0200
Message-ID: <CAP8UFD17CqpjZFo__tJjRKjsLva5oVBezDsaKpFa52mq=93euQ@mail.gmail.com>
Subject: Re: [PATCH v9 39/41] apply: change error_routine when silent
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 6:58 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Jul 30, 2016 at 10:25 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> +       /* This is to save some reporting routines */
>
> some?
>
> In case of a reroll could you be more specific?
> Specifically mention that we use these for the
> muting/when silence is requested.
> e.g.
> /* These control reporting routines, and are used e.g. for muting output */
>
>> +       void (*saved_error_routine)(const char *err, va_list params);
>> +       void (*saved_warn_routine)(const char *warn, va_list params);

I used the following instead of your suggestion:

    /*
     * This is to save reporting routines before using
     * set_error_routine() or set_warn_routine() to install muting
     * routines when in verbosity_silent mode.
     */

Thanks.
