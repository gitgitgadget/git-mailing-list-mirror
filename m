Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CAE62047F
	for <e@80x24.org>; Wed, 20 Sep 2017 01:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbdITBnb (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 21:43:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36412 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbdITBna (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 21:43:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id f84so569445pfj.3
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5rKmZLrQz1rFSdznFYJKUlMoZP4MCRteyTDuZh+IxJc=;
        b=Gy9TQ58odcp7WYxoxZFuoQFPjbmndnTbO7yjRhf3FuoX9+tJ5+KQAz9d1nJNXxxplk
         mCLFUBCILh8h4wpxDlsz4c9ffKWmRYg5zhRmUTGFOR1QxdbqVVeKNCCIFvEtrjbzTLN1
         cxaDeGfCcv6YLFfAmFciExtg/+9nBPru0CidxqhNmjZzc5RyzHWrEGiypCMp4dgZSa0l
         kU9+Iie66DY+eDRiIHBRbMvvRIDdq6zHHlUJ6gchgKW7bXUfxXQ1VdVasA5Hkl/3Ew0/
         Q4h6U/UElQe7smOa/OwwAuMUN7WYjAB3RWtfG7xBqAy4FRvi4qdIkgUfF95v3Uz/GKSY
         elPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5rKmZLrQz1rFSdznFYJKUlMoZP4MCRteyTDuZh+IxJc=;
        b=X2SI4czGRy/dqw9K9A86rlzeBpPUW+NH4Rp2sTvTr8/DLPZ+qM/QZWtSZxpG1z+Zx0
         wCNSt+AKb4PKsoMSD61xGmkRPrO4S+HsEja74Ozt0cRWQH27BwrWcPxllwsMwxFJ8xX2
         xhl3Yc9II6parj7I40972cvQzaJSAJAHaeexE0LLm0J6uj8OEci/Ee0MQcpO49vYYAIe
         p/aFvyR4hkUlMBiwrvY6Bc5ULMAJA8AvSz0+g17VPJnYgvBgdw9obun2Qpn30CgY+CDZ
         46kg8L96BpvPNM6SLzL1F4tVUsvoMIgsOjcu79kGIa89TKjVQacZznF3Jhuw/gojb49J
         7s+g==
X-Gm-Message-State: AHPjjUhJDHocmglRaAgqA0s51taJqt5YTnIrUJBgD7nah5bOuJSsxuxM
        wSZXnERMm7XErJ1wsGA7OSHnR56k
X-Google-Smtp-Source: AOwi7QCEyNc50QnT//QWdOIylqB4i3sDFrcjOPndOhwEU7TSUajh9Lz62a9OKroze9gT9KGTtTUnIA==
X-Received: by 10.99.110.12 with SMTP id j12mr513998pgc.163.1505871809917;
        Tue, 19 Sep 2017 18:43:29 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ed67:93b4:3411:bf26])
        by smtp.gmail.com with ESMTPSA id e20sm4228250pgn.68.2017.09.19.18.43.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 18:43:29 -0700 (PDT)
Date:   Tue, 19 Sep 2017 18:43:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
Message-ID: <20170920014305.GA126984@aiede.mtv.corp.google.com>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
 <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
 <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
 <xmqq4lryqhcw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lryqhcw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>> On Saturday 16 September 2017 09:36 AM, Michael Haggerty wrote:
>>> Jonathan Nieder wrote:

>>>> Does the following alternate fix work?  I think I prefer it because
>>>> it doesn't require introducing a new global. [...]
>>>>   #define for_each_string_list_item(item,list) \
>>>> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
>>>> +	for (item = (list)->items; \
>>>> +	     (list)->items && item < (list)->items + (list)->nr; \
>>>> +	     ++item)
>>>
>>> This is the possibility that I was referring to as "add[ing] overhead to
>>> each iteration of the loop". I'd rather not add an extra test-and-branch
>>> to every iteration of a loop in which `list->items` is *not* NULL, which
>>> your solution appears to do. Or are compilers routinely able to optimize
>>> the check out?
>>
>> It seems at least 'gcc' is able to optimize this out even with a -O1
>> and 'clang' optimizes this out with a -O2. Taking a sneak peek at
>> the 'Makefile' shows that our default is -O2.
>
> But doesn't the versions of gcc and clang currently available do the
> right thing with the current code without this change anyway?  I've
> been operating under the assumption that this is to future-proof the
> code even when the compilers change to use the "NULL+0 is undefined"
> as an excuse to make demons fly out of your nose, so unfortunately I
> do not think it is not so huge a plus to find that the current
> compilers do the right thing to the code with proposed updates.

I think you and Kaartic are talking about different things.  Kaartic
was checking that this wouldn't introduce a performance regression
(thanks!).  You are concerned about whether the C standard and common
practice treat the resulting code as exhibiting undefined behavior.

Fortunately the C standard is pretty clear about this.  The undefined
behavior here is at run time, not compile time.  As you suggested in
an earlier reply, the 'list->items &&' effectively guards the
'list->items + list->nr' to prevent that undefined behavior.

I'll send a patch with a commit message saying so to try to close out
this discussion.

Thanks,
Jonathan
