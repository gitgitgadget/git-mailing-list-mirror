Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927761F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeDMVo2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:44:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44257 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDMVo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:44:27 -0400
Received: by mail-wr0-f195.google.com with SMTP id u46so11454233wrc.11
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xMi4jcXFAQzbmskF+mDH0RgrCOpYkwC3OpzpPGsGWCY=;
        b=F3XavaX3hKAihMP6lp3eHeuNCQ3hsrLuTmn/7vsFqaMKV5QyVH123DhjIiHFXgUTmu
         f+Uh6MfYhq8z/hctNV+l8/U7118HvabcBO1yWD8QscBatTUjiDXyf8hY/3ritdSHM9EX
         Rj5pfF60idjBAM5cFbwcAR4ho8KRVg7gI2T0b0lq9wM89dKDFxy24poo3jWnb7hqWx0m
         2zozXhZxo/WZwlsRrrWi5hBbj+MIsODoPbMSRxHRTQ2HWQsDUMdl6Zfete+ZYOG5lOni
         0IDl8Q1E6mtPwvOOQYPziMw2KCqvRrSHIS/MhRtPNdPNUBkoNynChLMm9dw0/7gH8el9
         6gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=xMi4jcXFAQzbmskF+mDH0RgrCOpYkwC3OpzpPGsGWCY=;
        b=lXYErfyKfcMyPjqT9A2uKhJa/qe9vC4NZqKI3eyx9VPPXh161cz5Ex+nGrp0OY31ko
         wxyZqrSq8M7gaL1o4ASu/J0h8PaPFHCkk42w3aY9XO6y1HJj8R+NuNGkpKwHSaQinE6s
         jozaAHTO8082ukXRyLX0MlR0dT6KChkA5bOzsEvpEGk7aqY+BAxnWaFwXzdbNxWLxLFM
         cTv8x1lQ9asc1sIML1dOA0H4CB/lIz7nqkYLUYO6qepDRqeEZo0SiLnCD9gHzIdjumNG
         WBkBmYzy46KOYJaqWlpPZv0KZueDd6dtg7MvXu/wqxhiFYVKCvun3u3+meP1wageARjn
         iFvw==
X-Gm-Message-State: ALQs6tDS0HBFbrNMSbtkNmqxdq4tfR91AgGISUMAgmJ+ipm6ark+4yq2
        V2YQmPPRXT8Ic5qA8leG/jiTGIg4
X-Google-Smtp-Source: AIpwx49xvWEkk9Y9pA0c1czFHDYayY8RLFvrdOdRQSvx04GeotiOPyEDjZDVMSvrkZ2CSqEDEXUXGw==
X-Received: by 10.28.156.4 with SMTP id f4mr4983731wme.79.1523655865851;
        Fri, 13 Apr 2018 14:44:25 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrf152.neoplus.adsl.tpnet.pl. [83.8.99.152])
        by smtp.gmail.com with ESMTPSA id y100sm7674779wmh.2.2018.04.13.14.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 14:44:24 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
        <20180413103005.671-1-szeder.dev@gmail.com>
Date:   Fri, 13 Apr 2018 23:44:20 +0200
In-Reply-To: <20180413103005.671-1-szeder.dev@gmail.com> ("SZEDER
 \=\?utf-8\?Q\?G\=C3\=A1bor\=22's\?\=
        message of "Fri, 13 Apr 2018 12:30:05 +0200")
Message-ID: <86604un5mz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> To get the names of all '$__git_builtin_*' variables caching --options
> of builtin commands in order to unset them, 8b0eaa41f2 (completion:
> clear cached --options when sourcing the completion script,
> 2018-03-22) runs a 'set |sed s///' pipeline.  This works both in Bash
> and in ZSH, but has a higher than necessasry overhead with the extra
> processes.

Typo: necessasry -> necessary

>
> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
> builtin command, which lists the same variables, but without a
> pipeline and 'sed' it can do so with lower overhead.

What about ZSH?

--=20
Jakub Nar=C4=99bski
