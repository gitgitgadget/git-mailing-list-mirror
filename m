Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB56C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A51610E5
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhFHRxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:53:04 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:40811 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhFHRxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:53:04 -0400
Received: by mail-oo1-f52.google.com with SMTP id j17-20020a0568200231b029024900620310so3947560oob.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=APNm+tB2mFmo8+IWM4efx4JgofaROoyKPQrO2FWcblY=;
        b=khioT42ta+3dQHYqNRf6GIFRnvPWe70p8wmHTDrEbAZ3LyB4pLELtCjRRcyjcPhmx0
         0yzrtjxvABiTg2bNYU6s52LaVLsJpwNo1PWr0W4w5gVmuWiFHyv+kCg4VLGd2EiKPC0p
         4o1ufF3lbn9tbVHc4ibDOjmzUS2YY7ErXOaAyXuYos8Bq6qnJQW+WdSbuVXAIocGyVxC
         MyKnfQp11Gd1kEeg6uSVzzqpEYRik8QqCIwl8f+zriFz9tsFfYSpjvmwML13hslofHTU
         zIfRCVlPXfEBMSrX23gnsMgCtBNXw+ctn0XhCWTR+EbJ3uKtjcCHDZhznbfDBCzf50Ll
         zG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=APNm+tB2mFmo8+IWM4efx4JgofaROoyKPQrO2FWcblY=;
        b=KLU2fwRNkC6i8zGhs/4dKyuawJ3sUPajNlI7Cctad6xp0aJacMUKyHDh6VA1jRI7b2
         NjeDS28pujCZ/xpcS9kKAAWDfq262qJGQ/yvJc5ZfMhkhYbXT5fw4nc8fgFK1OJ7+i/3
         7tvWnU15NMvdVa+vouslxnbacQLGfIeJ6XsqJ12am6H/ArwcekktrY9hJ4nmAPdeLq9f
         BZaPG8/TLfBNv2j6/iHxkH4X2Kr1kOY82llkCq1iD2Zb3t4Wz9SZp2eHfDSNHHNGOUNT
         R3wYcm00ORP5dbSf8OlapyvvoV0EE05UbndvaT3ZS/DhcoHxn+cVaqjrEEYH1IRLEBDB
         5WSA==
X-Gm-Message-State: AOAM530UMRpm6dWsJz6OipCERLhzrGiwo/yvPDOZr4IWoJJZNgnzBhVf
        oIW/ElM3aqbDlLZE8TpBq009GwzmSAm8YA==
X-Google-Smtp-Source: ABdhPJxcdJM0u0QgwY387xbZ2sH1HXNGYPfZ2BpepjwkhtyNVXJkKs1QTkOMOXxgs4zfOicN9yPCtw==
X-Received: by 2002:a4a:be86:: with SMTP id o6mr18432372oop.67.1623174594432;
        Tue, 08 Jun 2021 10:49:54 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r25sm2954085oos.44.2021.06.08.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:49:53 -0700 (PDT)
Date:   Tue, 08 Jun 2021 12:49:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Message-ID: <60bfadc0aca09_1abb8f208fd@natae.notmuch>
Subject: How dow we educate our users to configure less?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been suggested that we "educate our users" to configure less in
the right way, instead of colorizing man pages ourselves [1].

The question is *how*? Nobody has answered that.

This is a continuation of the thread below.

Felipe Contreras wrote:
> Jeff King wrote:

> > Moreover, I think that if they like colorized manpages, they'd probably
> > want them when running "man" themselves.
> 
> This doesn't matter.
> 
> The user might have "configured" man like this:
> 
>   man() {
>       LESS_TERMCAP_md=$'\e[01;31m' \
>       LESS_TERMCAP_me=$'\e[0m' \
>       LESS_TERMCAP_so=$'\e[01;44;33m' \
>       LESS_TERMCAP_se=$'\e[0m' \
>       LESS_TERMCAP_us=$'\e[01;32m' \
>       LESS_TERMCAP_ue=$'\e[0m' \
>       command man "$@"
>   }
> 
> Git isn't going utilize that.
> 
> Arch Linux recommends the above, and so does many online resources.
> 
> So even if it's the case what you said, that they want colorized man
> pages, *and* they have man configured, that doesn't matter.
> 
> In addition, not everyone is a Linux guru. Some might want colorized man
> pages, but not know how to get them.
> 
> I myself only learned it was possible to configure that about a year ago
> when reading Arch Linux's installation guide. Luckily I clicked "Color
> output in console", even though I thought I already had most console
> software configured.
> 
> I have 20 years of experience using Linux. Some people have less.
> 
> You presume too much of our users.
> 
> And you still haven't explained how they can properly configure
> colorized man pages for both man and git, in a way that works in all
> distributions.
> 
> [1] https://wiki.archlinux.org/title/Color_output_in_console

I am still waiting for an explanation.

How does the user properly colorize man pages for both man and git in a
way that works in all distributions?

Cheers.

[1] https://lore.kernel.org/git/20210523054454.1188757-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
