Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B860F20986
	for <e@80x24.org>; Fri,  7 Oct 2016 13:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbcJGNbp (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 09:31:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35153 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbcJGNbn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 09:31:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id f193so3015721wmg.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=akfLCkclphBffBPBt7IjAbDKBDkM7rbqgerX8fnp+dw=;
        b=I2e+HXkzfD5qDvZsCuXllXqLmF3dbyhqqtDxTIeznnwgWlypUhtD+mYilrbwtghuyK
         BniNUqEQ4YaJ2KmvLFoGti9yxzLh6TApnvpl6BidWGuB0lgV7V25YTIpLPuK+z7na9Pe
         KNABlQUJGxQo9ycW9Q073KDs3hYUIQWH4GGkkJ/UJH36Jo814dW41dzPcwEkbi3ajLIX
         peSqwHOLXxTmQHnoKQ+oTGAKu+K2uvDhw0ekITubIIuJ7WxX8pgBeBAfoOcXOOfryZms
         /LCu3wbqAvxXFBt6ZizzVVD6e5x/a+30vxPewOJN9e6uAkUGAF5lU7Je02/wp9fCpgs2
         zNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=akfLCkclphBffBPBt7IjAbDKBDkM7rbqgerX8fnp+dw=;
        b=AveKeBioUcYfgmdfcLkcJ5O9jXuiTo+RUwIiRDVdGfMQoE7JXDv7GgMHV6SQFcJTSb
         8JrmHa/ob3Ky2lIqt6fX23S9epoDvnDmdBOcsTxLUQa4C6JWszIBbgjORgIBJkmlrkzb
         Fu4q5wAieXC1XCuhEf0NZfvizAZCC0U1njaiQe1Z+A/npl24tUKc994BP5qoBBMKhiiL
         ECIjvErWaDI1wrphAS3L9B6tMTfhvj5ZUWL8BHzB19zJleHoNZBPJ7NqjTR/OEnLiZuS
         NxmMPspm3KPa7dn5YEvBeuNV8Bt69Qa7XF8F7NSkdhmf913aLRvYIRfrtVWGD2HbDdQ4
         wlgA==
X-Gm-Message-State: AA6/9Rm/Tzk97Geei3JKMFpkQt/RtWPnyzPzFlCjWBRXRVD8rCVT6BJ2pO8NiXUi6RiisQ==
X-Received: by 10.194.115.38 with SMTP id jl6mr16879164wjb.28.1475847102373;
        Fri, 07 Oct 2016 06:31:42 -0700 (PDT)
Received: from [192.168.1.26] (dat198.neoplus.adsl.tpnet.pl. [83.23.19.198])
        by smtp.googlemail.com with ESMTPSA id 4sm3069031wmu.2.2016.10.07.06.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 06:31:40 -0700 (PDT)
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e1b432bc-97b4-15be-aa44-71921c64cd15@gmail.com>
Date:   Fri, 7 Oct 2016 15:31:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1610071319520.35196@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Johannes

W dniu 07.10.2016 o 13:20, Johannes Schindelin pisze:
> On Thu, 6 Oct 2016, Junio C Hamano wrote:
>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>
>>> Throwing something at the mailing list to see if anybody is
>>> interested.
>>>
>>> Current '!' aliases move cwd to $GIT_WORK_TREE first, which could make
>>> handling path arguments hard because they are relative to the original
>>> cwd. We set GIT_PREFIX to work around it, but I still think it's more
>>> natural to keep cwd where it is.
>>>
>>> We have a way to do that now after 441981b (git: simplify environment
>>> save/restore logic - 2016-01-26). It's just a matter of choosing the
>>> right syntax. I'm going with '!!'. I'm not very happy with it. But I
>>> do like this type of alias.
>>
>> I do not know why you are not happy with the syntax, but I
>> personally think it brilliant, both the idea and the preliminary
>> clean-up that made this possible with a simple patch like this.
> 
> I guess he is not happy with it because "!!" is quite unintuitive a
> construct. I know that *I* would have been puzzled by it, asking "What the
> heck does this do?".

Well, "!" as a prefix is not intuitive either.

Perhaps "!.", because "." is current directory, and the "." command
(that is, alias to "source") doesn't make sense in git aliases.

Note that we would have to teach git completion about new syntax;
or new configuration variable if we go that route.
-- 
Jakub Narębski

