Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36404C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 06:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiD3GVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 02:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiD3GVP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 02:21:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4816CFB8C
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 23:17:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p12so8599592pfn.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bW5mxgm0EtK4QgrVwBnAWKkWJVD1YNcle5E6MJ2HmZY=;
        b=TxN9QcWs1zJumpgCDtYlsqdCXs9KBigbRYXhwqHUL/ZWuqsCKlbQJqnX7Edp+4u6P5
         gR0UxdZP4ZaVpLSDixdzO7e9KaTd8HOpLloh1DjkhzniZO+cikUCPJjoyIDDgGaHQ6Pl
         8E/8E3u+uKqCc0STKV+55Bsa+sry8V5N+Aoa0LkbHbXVOZZxT5oK6FTkxi/+xKgJ3F6y
         uA+yfnzxlBNxCmnxz8/2ni+S0N+iJrSwgtYHS7WoKh0JVcFOPM0LR5LaoXKPpNkmbZ2L
         Ve5BqYQSPhPHP6Z4FLXftoM2y3f1469XmixmoDDnKehqYhtbtwBR9nR2FWMroV+Ej62g
         uBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bW5mxgm0EtK4QgrVwBnAWKkWJVD1YNcle5E6MJ2HmZY=;
        b=UWgUJEgtfsdzFH+s8HsP5pl8M8/q9aymnQZ+x/5fbKBsiY8mnhgeR25QzI0Lq/MW8C
         /g4ZCykdaMmcK1ZPSw5W7pRH3Y9lCxgX4WhN5P13P39nsL6pECeZ1UXpIV5LWYQeriNX
         kJZ5J37VxeemB4HCttE0AgTWgjhqEiFEsSYnwWcgOHwoCScHAUP6JINPN5v/v81TwMRj
         bnY6r/Ld0lY6PMxaCVm2keXmgdjTPwB0d9cWDB5fygQkqz1PYgMwjlrnK1ncKRv7AfLR
         WDvYGgqh0iQW0Dz5Dnq/zXWCdcI0EB5de7FtnIFe/P+Jh1FLIMTbkMPvTAq/Z+0YXch4
         0tzA==
X-Gm-Message-State: AOAM5310a5Uuk8cKQ3SLNS/9oyQwEeSUQwzeYnU62pFj/dltXDuLcBVL
        iCpkoKIGQOGJfbGa99O474Hnr9wUZH4=
X-Google-Smtp-Source: ABdhPJyY/O7onjW2T/z1X5c/JK455yEhDQADk3EKqhtchqXP+eEDNXlJ9cU6P2oBaZPSyCo6CTZFfQ==
X-Received: by 2002:a65:6942:0:b0:378:9365:5963 with SMTP id w2-20020a656942000000b0037893655963mr2140124pgq.142.1651299473033;
        Fri, 29 Apr 2022 23:17:53 -0700 (PDT)
Received: from localhost (subs03-180-214-233-14.three.co.id. [180.214.233.14])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902bd0600b0015e8d4eb2d5sm624208pls.287.2022.04.29.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 23:17:52 -0700 (PDT)
Date:   Sat, 30 Apr 2022 13:17:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/3] Documentation: explain how safe.directory works
 when running under sudo
Message-ID: <YmzUirQlDR1942rH@debian.me>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-3-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428105852.94449-3-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2022 at 03:58:51AM -0700, Carlo Marcelo Arenas Belón wrote:
> In a previous patch, the behavior of git was changed so it will be able
> to find the "effective uid" that is required when git was invoked with
> sudo to root, for example the internal calls made to git when calling
> the following in git's own repository:
> 
>   $ sudo make install
>

That is building Git, right?

-- 
An old man doll... just what I always wanted! - Clara
