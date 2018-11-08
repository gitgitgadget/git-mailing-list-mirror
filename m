Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43EB1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeKHOKT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:10:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40737 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbeKHOKT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 09:10:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id i17-v6so19701259wre.7
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 20:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YgXBIo7HtO9HrTpjtQ0u5cV6Uxyh1FVcLAhuooPK37M=;
        b=PwcIwMqlsMnxM8Fq6oOMRnuYSbjpHMj8DaVzx49L2nmQQ7JrlbdxJt/VqtHsXbCO80
         HXMnbX8ioLhSfDwKUVRJHGy/YK0oV1BzL5gV3WObmMILR4vb1UZDtSjaKcfwqtW2wzWI
         wVKxK/TlZ+fkebharqI0wzEDuaImxWYyDCU0BPn+8L6494BzEb7aZUa4gAPJLtNhf/A0
         xCxsvZP0EYhU/OTLNbzqmLv2V3X14pjpS7aZeBS2qklmw+cIQIHivdHA5NpQhEchUYap
         YOaNwql7FZKQBzL1g35teZMiYbEmx/99WIgKNKBL0y/SvnLXgL/ANLv2xohfEUhVqyz1
         gH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YgXBIo7HtO9HrTpjtQ0u5cV6Uxyh1FVcLAhuooPK37M=;
        b=hKQGjDZFANZ74k28+FONq1xYpkQYcmqFTVyk2x2TBY4saGX+VKUuSRvXcY2a252796
         XrtKH3vCoczzxEVGSgH/PlkLuW/Dz5GLxHoxa0UzAWEIPkS7SuShX6b7zExge/Ky5Lbd
         DRm39xHHfbgXTc5XyQaP6uiA/gxrQ2KQSLBG9g8zweUaZaRw8hDHC5qEjpe8YFKMZZ26
         ytHTQj8S7h9giktCR2VYqL1rb5+krlQvjKeCO7cNIC28CfuRXIVMaq2V/tFBBhWSAg1O
         7dOZ+e3uf7zDrIpLKdNcN7e/sh64T93+t3wiALguULj4CeJorBcfvcd2vAFUquBotaYx
         s4tw==
X-Gm-Message-State: AGRZ1gLvCYClyWMAgNF9Dt04seqEe9f7LZOXcA/Lxrca4ZJOUBj5R7Mq
        jd6ExndS7YRiT+ZdV4LZms9aJD4N
X-Google-Smtp-Source: AJdET5fO6z2rSY9g9wHXpeTOPdHceYMMsoSSD2l5RsqDkxDApXRCpGsJf0rFV5302Kjr2Hk0955/QA==
X-Received: by 2002:a5d:4e01:: with SMTP id p1-v6mr2675193wrt.320.1541651802566;
        Wed, 07 Nov 2018 20:36:42 -0800 (PST)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id 67-v6sm2617419wrm.32.2018.11.07.20.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 20:36:41 -0800 (PST)
Date:   Thu, 8 Nov 2018 04:36:21 +0000
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     daniels@umanovskis.se, git@vger.kernel.org
Subject: Re: [PATCH] branch: make --show-current use already resolved HEAD
Message-ID: <20181108043621.izmneiyjvgzd22uc@rigel>
References: <20181025190421.15022-1-daniels@umanovskis.se>
 <20181107225619.6683-1-rafa.almas@gmail.com>
 <xmqqa7mk9xw9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa7mk9xw9.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did something that resulted in the mailing list not being cc'd.
Apologies to Junio and Daniels for the double send. :(

On Thu, Nov 08, 2018 at 10:11:02AM +0900, Junio C Hamano wrote:
> I'd prefer to see scriptors avoid using "git branch", too.
> 
> Unlike end-user facing documentation where we promise "we do X and
> will continue to do so because of Y" to the readers, the log message
> is primarily for recording the original motivation of the change, so
> that we can later learn "we did X back then because we thought Y".
> When we want to revise X, we revisit if the reason Y is still valid.
> 
> So in that sense, the door to "break" the scriptability is still
> open.
> 

Over at #git, commit messages are sometimes consulted to disambiguate or
clarify certain details. Often the documentation is correct but people
dispute over interpretations.

If someone came asking if `git branch` is parsable, I would advise
against and direct them to the plumbing or format alternative. But if
someone came over with a link to this commit asking the same question,
I suspect the answer would be: it's probably safe to parse the output of
this specific option because the commit says so. Thanks for clarifying
this is wrong.

> >  
> >  static const char *head;
> >  static struct object_id head_oid;
> > +static int head_flags = 0;
> 
> You've eliminated the "now unnecessary" helper and do everything
> inside cmd_branch(), so perhaps this can be made function local, no?
> 

I was not sure if these 3 lines were global intentionally or if it was
just an artifact from the past. Since it looks like the latter, I'll
make them local.

--
Rafael Ascensão
