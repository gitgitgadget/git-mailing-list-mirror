Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9B720958
	for <e@80x24.org>; Sat,  1 Apr 2017 18:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbdDASbm (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 14:31:42 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33162 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdDASbk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 14:31:40 -0400
Received: by mail-lf0-f54.google.com with SMTP id h125so56331394lfe.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RCoveCzC7tX/Q56bPRUA0Huzu0HyPBl22bJK2s6QEzU=;
        b=nnFQENVIap4uofEfwDVPCzmvrPPrEzy7BfQ7PUpAvTTvVvFds4JwTQFsfugHdXFmht
         jtXfuGtoCwmxKhgJFNbflXKFFi1L8S+R7meUJ6n3OQWniUDj5Zy0HwhnljizclnnXucx
         0ourXL77RffgRi3tCPyjyxI1+u6CGVdD0d0lCht32kPIK2AeBPvbsi/CrlnNNjTzfUOf
         2cJKTe/DaHLIH2D3IejL1SaTRf1P3T6Dg1pwXAJ9Ef3YG9S+E38KbsZodUckCuI/XBjJ
         MOPBuwhMO4fBmVoKL2gZoWSBGu4yyIA+e4051gNJ4uEIp8lSd0FD0Uru2E2PyvPJPTMC
         aONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RCoveCzC7tX/Q56bPRUA0Huzu0HyPBl22bJK2s6QEzU=;
        b=GiQmel4+pHo2K84moxzZ+VKGa/NLJOfqcAUWFodtzg/M2pMDtK3lr7JSwh8qjHBzlY
         4EUtMn72Jc1phoCh6L0kdUtnNNcgXvaF2LW7/ODNmn49NkTbSlx5uKSjZ1Za5P47eFEN
         1Js6kEzs10epni6L8700zE1cxD8DWw2VG0oBFyOiwcLu7uwt09m86QT8DAUWcLFCkarm
         7RemXQ41WVduNf8fXgcxHWMIqlxD6oc90vJeRyYGqWUJqaUMhxGIF5KhdtNOCny7KSAr
         dY2vSIgapUQVxpc8DkB5lV1mFXB56u66z+VWF+RwJLPDyzGBWQxkkIEnUCDenRY/hbz7
         od+A==
X-Gm-Message-State: AFeK/H07TE5IoxGLUy24wjP5spXhxofDfUg3vKUjXgWOf9qBcuPPZcMcBktZPeRp72NYkA==
X-Received: by 10.25.76.193 with SMTP id z184mr2486070lfa.43.1491071499024;
        Sat, 01 Apr 2017 11:31:39 -0700 (PDT)
Received: from [192.168.1.26] (abpo61.neoplus.adsl.tpnet.pl. [83.8.56.61])
        by smtp.googlemail.com with ESMTPSA id q71sm1609895lfe.40.2017.04.01.11.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Apr 2017 11:31:38 -0700 (PDT)
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
To:     Jeff King <peff@peff.net>
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
 <20170330200021.c2l5jak3xb5aoxyc@sigill.intra.peff.net>
 <e1a6d44c-b01b-993c-6a22-e6ac0abca03c@gmail.com>
 <20170401060800.hrpqqgdx6t262c7f@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <63eb5546-0dce-2f69-c2f8-1e777b97c532@gmail.com>
Date:   Sat, 1 Apr 2017 20:31:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170401060800.hrpqqgdx6t262c7f@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 01.04.2017 o 08:08, Jeff King pisze:
> On Fri, Mar 31, 2017 at 03:24:48PM +0200, Jakub Narębski wrote:
> 
>>> I suspect in the normal case that git is doing line-ending conversion,
>>> but it's suppressed when textconv is in use.
>>
>> I would not consider this a bug if not for the fact that there is no ^M
>> without using iconv as textconv.
> 
> I don't think it's a bug, though. You have told Git that you will
> convert the contents (whatever their format) into the canonical format,
> but your program to do so includes a CR.

Well, I have not declared file binary with "binary = true" in diff driver
definition, isn't it?

> 
> We _could_ further process with other canonicalizations, but I'm not
> sure that is a good idea (line-endings sound reasonably harmless, but
> almost certainly we should not be doing clean/smudge filtering). And I'm
> not sure if there would be any compatibility fallouts.

Yes, gitattributes(5) defines interaction between 'text'/'eol', 'ident'
and 'filter' attributes, but nothing about 'diff' and 'text'/'eol'.

> 
> So I think the behavior is perhaps not what you want, but it's not an
> unreasonable one. And the solution is to define your textconv such that
> it produces clean LF-only output. Perhaps:
> 
>   [diff.whatever]
>   textconv = "iconv ... | tr -d '\r'"

Well, either this (or equivalent using dos2unix), or using 'whitespace'
attribute (or 'core.whitespace') with cr-at-eol.


P.S. What do you think about Git supporting 'encoding' attribute (or
'core.encoding' config) plus 'core.outputEncoding' in-core?

Best,
-- 
Jakub Narębski
