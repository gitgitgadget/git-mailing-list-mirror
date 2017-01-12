Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C2C1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbdALVRf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:17:35 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33255 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdALVRd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:17:33 -0500
Received: by mail-pf0-f179.google.com with SMTP id y143so18882442pfb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 13:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netskope.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YtbZKRo39hNcW1hSrzdlqsfyprSvhkWsV8mYqFtIuig=;
        b=a/p+/Vhm7rdiLMzIvhIwPNqvGfwJc2h+ehG+Mj6xA/Re929JMhVfArFLw1RjELazZ0
         csp9p4pcy1DwwdXEPOv6W7n6ASEc6VLT+Xk+fKdVDAERbalE6YJXzNMZ+NJSbzWQxOVC
         BP89L0fEmyZDGRHX9+NglhS1uLtza8eVOZox8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YtbZKRo39hNcW1hSrzdlqsfyprSvhkWsV8mYqFtIuig=;
        b=tD3G6jlpnFFJAW3AdCHf7InXWEuGBQzsi+no74p87uJD72jN3wOeKsRPUe41DDk7R9
         i9KmnjxGX9BDGp+vgChKiYxOkUGrWvjAwRbd+eimRViUJqlvOkCzpNfu5UrH2TpfjOxj
         AlpysbLRh/8wy6v8ZSKuR2g3G6j/gHc8XzoRyz8gMXUEfZf9DfPFLZRuM0XI2b6qeaks
         ArYHEJEBzzSXy/1dAlq4uxJnwdELVf26c3B/RAKVwrltV2lC7J/7LJ2LSB3AptdmAJA8
         pQ10PETkLPVRGQEuV9q/XqVmmZBAkMLRxp8hyI7+I7dWZYMTzSeGrRyYUENKnksJ/XYb
         2kbg==
X-Gm-Message-State: AIkVDXLUxLYwJ9bLYRu0x1Yj6f+FUtEo92MKDrrlF7trtfYktRh4bYXPxJ4dvhpFm3Q6iVt2
X-Received: by 10.84.217.2 with SMTP id o2mr24263481pli.99.1484255836083;
        Thu, 12 Jan 2017 13:17:16 -0800 (PST)
Received: from [192.168.65.161] ([216.38.152.90])
        by smtp.gmail.com with ESMTPSA id j7sm11004551pfe.84.2017.01.12.13.17.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 13:17:15 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Bug report: Git pull hang occasionally
From:   Kai Zhang <kai@netskope.com>
In-Reply-To: <xmqqy3yghtio.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 12 Jan 2017 13:17:16 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <62D2BA2E-9A15-4D6E-B232-1FDFEC1B9033@netskope.com>
References: <9B7DCFB3-73A4-40DE-8FC6-867C5016EF95@netskope.com> <xmqq8tr9huc0.fsf@gitster.mtv.corp.google.com> <xmqqshphge7o.fsf@gitster.mtv.corp.google.com> <E9196161-995C-4575-9560-D7E7B9A6B43D@netskope.com> <xmqqy3yghtio.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Jan 12, 2017, at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Kai Zhang <kai@netskope.com> writes:
> 
>>> On Dec 21, 2016, at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> ...
>>> 
>>> I wonder if the latter is solved by recent patch 296b847c0d
>>> ("remote-curl: don't hang when a server dies before any output",
>>> 2016-11-18) on the client side.
>>> ...
> 
>> After apply this patch, hanging did not happen again. 
> 
> Thanks for confirming.
> 
>> Would this patch go to release in near future?
> 
> I see 296b847c0d in the message you are responding to (by the way,
> do not top-post to this list).  
> 
> Let's check it together.
> 
> 	$ git log master..296b847c0d
> 	$ git merge-base master 296b847c0d
>        296b847c0d6de63353e236cfbf94163d24155529
> 
> Yup, it already is in master.  
> 
> Using a third-party script "when-merged" [*1*], we can easily find
> that it was merged a few days ago to 'master', after cooking in
> 'next' for a handful of weeks:
> 
> 	$ git when-merged 296b847c0d next
> 	refs/heads/next 3ea70d01afc6305b88d33b8585f1fc41c486a182
> 	$ git when-merged 296b847c0d master
> 	refs/heads/master d984592043aec3c9f5b1955560a133896ca115b5
> 	$ git show -s --format='%cI' 3ea70d01af d984592043 
>        2016-12-05T11:38:03-08:00
>        2017-01-10T15:24:25-08:00
> 
> Unless people find regressions caused by this change (in which case
> we may have to revert it), this will be included in the release at
> the end of this cycle.  http://tinyurl.com/gitCal tells us that the
> current cycle is expected to complete early February.
> 
> 
> [Footnote]
> 
> *1* git://github.com/mhagger/git-when-merged

Thank you for your help!
