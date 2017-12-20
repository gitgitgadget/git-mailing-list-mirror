Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6DC41F406
	for <e@80x24.org>; Wed, 20 Dec 2017 00:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbdLTABx (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 19:01:53 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36760 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbdLTABw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 19:01:52 -0500
Received: by mail-pg0-f49.google.com with SMTP id k134so11223916pga.3
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 16:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2MTaWzqOmwYqJGUROcPrBGOpF2rwWu/L6XoJla3iJaM=;
        b=FKnPQPKpfasi013qxMi3fOHHIl10GFHLxq7TsgFbroF7RF480iiQaLMEXePSHU2IEC
         rS+EAmyJcXhovWkEhLmDyquejiSNUsD7YvpZPU6mUYPMgiRcpJDtYFm3j1qUJrwwoYW5
         Ua1O/g3c2ZgWM2q3rez7WpdIven4mc384tMBSPeCF32Q5MwvNFfdvz9uzTnoMrJ7V9Z9
         P2D+RH7ytZbcVYRW/vaLt5ETBeBeWIS4HNUbyRSLj+bzoERds3ogxYLvN3PcZEESD6Dm
         2WoBEZi7BgQXLud4Mb/nZSR1alojiA4yEZo94MV4K91P0aEfY8iHppxzixpyZkc3yC2I
         ktDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MTaWzqOmwYqJGUROcPrBGOpF2rwWu/L6XoJla3iJaM=;
        b=GtnftmRvPXFkV4GsTiVg2LMwNylCFjSvdcRqSVBT9jue9yM8SqmE4JMGMI7Ieq6Qkp
         wiUAlnk60sp5o3aAnOB9xTaGJ7LJmtYOigf4vtsiIxl1MRm1Qedip/RIlnB1PeYiPsxt
         Cvwi59FpAicifv+bf3Ms71UOfV53f27QhjMARfV+S84MBeNVjY8ye3FRleTbQ+OyYXqS
         MPVC/WV2eIAoSCj5Ep9zk19UzW/8zQ4Ogg2Rqfco3ZF+M6amfBCUWwYkZ6zE+YBLrHal
         3Ez/wBGopM2JTagdBfZ73iElTLM3V9AwVGdP5jbAiHoJS9kpsWKuiqRP4yOarhqdOomR
         MGjA==
X-Gm-Message-State: AKGB3mJVt4NxPckOrViF32CmuvicL/ghZPxEbw+y2Ueqo+O8ScmiKVQT
        FGviL20Wx6XeyO2+TrSBNanyb2Lj
X-Google-Smtp-Source: ACJfBoui2wfAVRU88z3lDhnBMmgmU//BHQDp0zFm2XY4nxz1c7F811IugKjHCIyo8WmcNVIGaVshAg==
X-Received: by 10.101.97.75 with SMTP id o11mr4366897pgv.363.1513728111267;
        Tue, 19 Dec 2017 16:01:51 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t8sm14485588pgf.31.2017.12.19.16.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 16:01:50 -0800 (PST)
Date:   Tue, 19 Dec 2017 16:01:48 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] submodule: submodule_move_head omits old argument in
 forced case
Message-ID: <20171220000148.GJ240141@aiede.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171219222636.216001-6-sbeller@google.com>
 <20171219224431.GG240141@aiede.mtv.corp.google.com>
 <CAGZ79kake8k2dM=NPwNoqB5Vkxy+k67PACz01-aXx6-njcisgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kake8k2dM=NPwNoqB5Vkxy+k67PACz01-aXx6-njcisgQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Tue, Dec 19, 2017 at 2:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>   checkout -f
>>         I think I would expect this not to touch a submodule that
>>         hasn't changed, since that would be consistent with its
>>         behavior on files that haven't changed.
[...]
> I may have a different understanding of git commands than you do,
> but a plain "checkout -f" with no further arguments is the same as
> a hard reset IMHO, and could be used interchangeably?

A kind person pointed out privately that you were talking about
"git checkout -f" with no further arguments, not "git checkout -f
<commit>".  In that context, the competing meanings I mentioned in
https://crbug.com/git/5 don't exist: either a given entry in the
worktree matches the index or it doesn't.

So plain "git checkout -f" is similar to plain "git reset --hard"
in that it means "make the worktree (and index, in the reset case)
look just like this".  checkout -f makes the worktree look like the
index; reset --hard makes the worktree and index look like HEAD.

In that context, more aggressively making the submodule in the
worktree get into the defined state sounds to me like a good change.

Hopefully my confusion helps illustrate what a commit message focusing
on the end user experience might want to mention.

Thanks again,
Jonathan
