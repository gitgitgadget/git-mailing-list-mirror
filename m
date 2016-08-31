Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B5F1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 22:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbcHaWdO (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 18:33:14 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:37630 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbcHaWdO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 18:33:14 -0400
Received: by mail-it0-f50.google.com with SMTP id e124so35318668ith.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LwFiUePFOeOVfa65BZhoQrTmZwUGvoQIoeHCWT6DDio=;
        b=NGDDwFrdzFBtenuGYgZL7YtM9+W88+yE9se4OnDMYJ/T8gVNHwerl00m/Cl2ggptcs
         vGq1NnxEVsk2mLSrAr//y99/rYJIqLaYf2dDPKnboBtRMqQcvFHq5BSoxgd4CiNmwch4
         wjvfyEi7pegIs72Flsw1HtmjTxDThf5O1ZcLpgmGEL3qei+v25d7qTA0+wO/uUf8t6oG
         qLdJUPrO4jjqyXcz/f53/3lftBrP7DUIqA90PWBfluCjDzDtQ2Uxe/RC2pTACgdupGBX
         nYsrcGRjQnWPuC8G5u3KvFDWI/ob1L9M0KqYJ03Y1pHqq051QsS1Q83CuM7x3LtWuC/q
         4dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LwFiUePFOeOVfa65BZhoQrTmZwUGvoQIoeHCWT6DDio=;
        b=lY/wN6Htn9YRaHVx0FXyltcxluldIyjbuxq2/ZiRyZM2bnL5PXglfeKqVMjqaVrmKV
         P9QMRwLqQAqpOv5qbsdoqN6omoM4jtTNjZ4Ln3VBlLc+lr7ezqWDJgvWSgOv7acrfiW/
         ozFEymjmf1VelMlHaKZa8FL2mhSl1shm+HidE7MnZFK9A5jZMRMR3RvnbbveM6OylxBJ
         hVFDSXrinc0pEGh0PZTo9lylASLh7Wwlt/aiDG69rY+GCUERbnDHKpnezEhGd+vW/0Bp
         kpjfNLujApjD2LvCcuosUoLsp78qDJO9ewuAp7kQLXTYvoRWxQHbmFezEJ6ivFNeayM1
         SXQQ==
X-Gm-Message-State: AE9vXwP72TR5MHvFYUX75itQDItfxvMpiiznVwa09wwbHbFNdlJUIkDvNRoHShCEDk2RqHQxJPKeoj7DSRx3KAh1
X-Received: by 10.36.123.199 with SMTP id q190mr13946972itc.46.1472682793046;
 Wed, 31 Aug 2016 15:33:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 15:33:12 -0700 (PDT)
In-Reply-To: <20160827184547.4365-15-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org> <20160827184547.4365-15-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 15:33:12 -0700
Message-ID: <CAGZ79kZcK-QxMUa7A0FJbzq=ZQ=prWzJu4K69jaW8E-rwme=oQ@mail.gmail.com>
Subject: Re: [PATCH v13 14/14] builtin/am: use apply API in run_apply()
To:     Christian Couder <christian.couder@gmail.com>
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

On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> +
> +       if (opts_left != 0)
> +               die("unknown option passed thru to git apply");

Through and thru are different spellings of the same word.
Thru is the less preferred form, however, and it might be
considered out of place outside the most informal contexts.

[Source: The Internet]

"git grep thru" confirms we only use it in comments or function
names, both are not exposed to our dear users.

The rest looks good.
