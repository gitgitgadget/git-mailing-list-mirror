Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FFB1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 21:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeJZFnC (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:43:02 -0400
Received: from avasout03.plus.net ([84.93.230.244]:56505 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJZFnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:43:02 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id FmrygGISqO2g2Fms0ggQSS; Thu, 25 Oct 2018 22:08:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=Xa4Gbh7psVhIqun5MPkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 3/3] commit-slab: missing definitions and forward
 declarations (hdr-check)
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de
References: <20181025110427.13655-1-carenas@gmail.com>
 <20181025110427.13655-4-carenas@gmail.com>
 <b6fe7e58-5b3f-f139-be8d-210526a26767@ramsayjones.plus.com>
Message-ID: <d5b54ed8-689b-6f12-5888-fb598db8f083@ramsayjones.plus.com>
Date:   Thu, 25 Oct 2018 22:08:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b6fe7e58-5b3f-f139-be8d-210526a26767@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIYCPNHeShaycoNyzB77+eSOCBq9SYIXyjpPMm/2NYYBKSOyIle8piV8UN2lKllneXmK4Hf0FoJo26jNSsY8HMIcPpXKywTGFJ9oX+ZQ45jVljC5JOl0
 zQTtGYQcauA12kqCybVdiUyQjB3zjVpZD1I/wDmcJ3Dy/Mvpj+LgtLg/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/10/2018 19:54, Ramsay Jones wrote:
> 
> 
> On 25/10/2018 12:04, Carlo Marcelo Arenas Belón wrote:
>> struct commmit needs to be defined before commit-slab can generate
>> working code, object_id should be at least known through a forward
>> declaration
>>
>> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>> ---
>>  commit-slab-impl.h | 2 ++
>>  commit-slab.h      | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/commit-slab-impl.h b/commit-slab-impl.h
>> index e352c2f8c1..db7cf3f19b 100644
>> --- a/commit-slab-impl.h
>> +++ b/commit-slab-impl.h
>> @@ -1,6 +1,8 @@
>>  #ifndef COMMIT_SLAB_IMPL_H
>>  #define COMMIT_SLAB_IMPL_H
>>  
>> +#include "commit.h"
>> +
>>  #define implement_static_commit_slab(slabname, elemtype) \
>>  	implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)
>>  
>> diff --git a/commit-slab.h b/commit-slab.h
>> index 69bf0c807c..722252de61 100644
>> --- a/commit-slab.h
>> +++ b/commit-slab.h
>> @@ -1,6 +1,8 @@
>>  #ifndef COMMIT_SLAB_H
>>  #define COMMIT_SLAB_H
>>  
>> +struct object_id;
>> +
>>  #include "commit-slab-decl.h"
>>  #include "commit-slab-impl.h"
>>  
>>
> 
> Hmm, sorry, I don't see how this patch has anything to do
> with the other two patches! ;-)
> 
> Also, I have a patch to fix up the 'commit-reach.h' header
> (it was part of my original series, just had to update the
> commit message), which adds these very #includes and forward
> declarations when _using_ the commit-slab.
> 
> I haven't tried applying your patches yet, which may answer
> my questions, so I am a little puzzled.

So, having now applied your patches, I still don't see what this
patch has to do with the others! I suppose it is dependent on the
compiler/version? (the most up-to-date version of clang available
to me is 5.0.1).

Yes, this will 'fix' the 'commit-reach.h' header (not surprising),
but I prefer my patch. ;-)

Still puzzled.

ATB,
Ramsay Jones

