Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EE9C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 01:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF12606A5
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 01:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhDQBSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 21:18:03 -0400
Received: from avasout02.plus.net ([212.159.14.17]:41337 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQBSC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 21:18:02 -0400
Received: from satellite ([195.213.6.1])
        by smtp with ESMTPA
        id XZaWlONtS7QW9XZaZlAePG; Sat, 17 Apr 2021 02:17:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1618622256; bh=Tx4K8jJyrWgYtnmS5eh4P1GgxsrWOzn4B/27E3KxeZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lNpr5XvTPRv+fdg0Q4Uc9SmhP9QYKBsBTKelj2EQsp0ftaQm+QodWVMRafhWj6OOd
         7OfMOTBdUiESd0ZT6CBUo6vh+3YGVFrEuVbLnrtqgHFvAVE43lzdTNA7dbF+VtJWEN
         ENTt6p/CbJ0jHaHNXIb0PM8I0NDF9n+s/ETZ0LQl9J7tvoodp5oO3cMvaI2yKwKg74
         q65tcjAq5rgtaE3U3OxdPVQh0DTRYnOzEIkdsH1c6Z8aETOrIXPEbekrHZL04Wf2eQ
         5uCKUPJkTvY0EVO7Lpsykima1ZiMEpDLjRVWwkRmhotBqWHhUbkUKLMvjp+26xPsFN
         tK/LIwnbkuVTQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=H+BAP9Qi c=1 sm=1 tr=0
 a=v1fZ9eGmBRQ2oAddCs0ezw==:117 a=v1fZ9eGmBRQ2oAddCs0ezw==:17
 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=UlqV6C1OAAAA:20 a=XIrub0NXh_JgTC8vgP0A:9
 a=CjuIK1q_8ugA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Date:   Sat, 17 Apr 2021 02:17:32 +0100
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <YHo3LO2RKfe0W/z7@satellite>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
 <YHVQ9RPLk8/r+8mS@ncase>
 <YHgKiXRMq/1Fpg2x@coredump.intra.peff.net>
 <xmqqlf9hkhpp.fsf@gitster.g>
 <xmqq4kg5kehw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kg5kehw.fsf@gitster.g>
X-CMAE-Envelope: MS4wfJCsbgSCXhCvNQYnyqb97Gcr+E0ojPOFqImAl0rxft06FNON+BsQrdWAMDIxX7+fQMrNgjv04vbhlDCnaF7KvkGu5v8L+b+UuELEIUJlG/k7pSwClVPz
 mEZwGQu6lL4dLG6/oxMpUOgNIX0zonJ9irl2udgXAMBhJTVCSqhc+r14
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 04:15:39PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think the only remaining issues are the comments on 5/8 on tests,
> > then?  Hopefully we can have one more iteration to finalize the
> > topic and merge it down to 'next'?
> >
> > Thanks.
> 
> I guess not.  I am guessing this topic is responsible for
> 
>   https://github.com/git/git/runs/2366364023?check_suite_focus=true#step:4:115

Yes, I noticed this a few days ago, and tried the obvious fix (ie to
#include "cache.h" at the start of the list-objects-filter-options.h
header file) which does indeed work fine. However, I then thought that
moving the definition of 'enum object_type' (along with the TYPE_BITS
#define) to the 'object.h' header file (and #include "object.h" into
cache.h) would be a better idea...

Having done that, I wondered how many '#include "cache.h"' could be
replaced by "object.h", and ... well, that was a few days ago and
something came up...

ATB,
Ramsay Jones

