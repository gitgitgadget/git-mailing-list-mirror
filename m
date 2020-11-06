Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD5EC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C333821D7F
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="dbQNqBlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgKFTiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:38:10 -0500
Received: from avasout03.plus.net ([84.93.230.244]:50792 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgKFTiK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 14:38:10 -0500
Received: from [10.0.2.15] ([80.189.83.69])
        by smtp with ESMTPA
        id b7YkkNCla99nqb7YlkhsMS; Fri, 06 Nov 2020 19:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604691489; bh=eTqIvFWCgejjAo29iB7496TErT046JG3WUcNSkwkCuE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dbQNqBlLfe2m2db1yUeS5UYaq4wTsN+4bBhXHCVZMsYAnEnAd9arne30V19WhUV0u
         4erb8nlfCCxHc3nOVv9kmzhI670NPgbZ35G89W/qs9c49AB+Yakqn8MWjbkBhhvMwy
         VLcNPFJutCNB1hS30vIEcXZJdDkXAFB1J5+W8kxFgxM2HfO/pVDPuWL3ePwvL8ONDa
         CovszDPoKd9q8quhWqiN34qZS+JlGO3aJnTx+BsfMvhLMSVk1RmxVVf3g147+Wbmrn
         SEXJWxvRypiqzMlpnK8/5o4tcxkTpZbIVnlFH/pb/LHYtn48hw/CMn1zTUv+xxBByK
         DndP+ZtbWQMwA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=VKYMt3kHM3Z9lWmoeJedNA==:117 a=VKYMt3kHM3Z9lWmoeJedNA==:17
 a=IkcTkHD0fZMA:10 a=2x_x23Z1_iWSknDRxiEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/8] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
To:     Jeff King <peff@peff.net>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
 <20201106181804.GA183267@coredump.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a654c95f-2367-5805-d4f8-56c466a141d4@ramsayjones.plus.com>
Date:   Fri, 6 Nov 2020 19:38:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106181804.GA183267@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfODkacZpb/XCVxYwUraeQF9J5HgYXwmExzoEBoNH4NPg8SYI1W7Kpq+vjKHnmVAuysklKj2p4ufDa9J4sc1TITp5Q5MEzMcNIOCo9cCPGxMtQ9Qehjpl
 sv3wciGZqlVCr4lweW3dcippRsgdNFIQW8o5ixWUyWAImgkt213QQKiZmM8Vd17/KwY17YypAnoS1w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/11/2020 18:18, Jeff King wrote:
> On Thu, Nov 05, 2020 at 09:03:49PM +0000, Ramsay Jones wrote:
> 
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 652d57a1b6..5c680024eb 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -272,7 +272,9 @@ install-html: html
>>  ../GIT-VERSION-FILE: FORCE
>>  	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
>>  
>> +ifneq ($(MAKECMDGOALS),clean)
>>  -include ../GIT-VERSION-FILE
>> +endif
> 
> Calling out "clean" here specially feels somewhat backwards to me, in
> terms of Makefile design. In an ideal world we provide all of the
> dependencies to "make", and based on the targets we are building, it
> decides what needs to be done.
> 
> This works with normal targets, obviously, but also with variables. If
> we do:
> 
>   FOO = $(shell do-the-thing)
> 
> then we execute that command only when $(FOO) is needed[1].
> 
> But "include" here is tricky. It is loaded regardless of whether the
> values it contains are needed or not. I wonder if we could do better by
> giving make more information about what we're expecting to get from it.
> I.e., if we wrote:
> 
>   GIT_VERSION = $(shell awk '{print $3}' GIT-VERSION-FILE)
> 
> Then "make clean", not needing the value of $(GIT_VERSION), wouldn't run
> that shell snippet at all. Of course there's a catch; we are also
> relying on the include to trigger the dependency. So it is really more
> like:
> 
>   GIT_VERSION = $(shell make GIT-VERSION-FILE && awk '{print $3}' GIT-VERSION-FILE)
> 
> I'm not sure how bad that is. Re-invoking make seems like it could get
> expensive, especially for the common case that we're building actual
> binaries and we _do_ need the version. But we could probably cut "make"
> out of the loop entirely. Generating GIT-VERSION-FILE is already a FORCE
> target, so really:
> 
>   GIT_VERSION = $(shell ./GIT-VERSION-GEN)
> 
> would be equivalent-ish (with some output changes, and possibly we'd
> want to stash the value in a file for any other scripts to make use of).
> 
> This is all just stuff I've written in my editor and not tried. I won't
> be surprised if there are some gotchas. But it at least seems like a
> conceptually cleaner path.
> 
> -Peff
> 
> [1] Variable assignment actually has a slight problem in the opposite
>     direction: it wants to run the shell snippet every time the variable
>     is referenced. There's a trick to get around that described in
>     0573831950 (Makefile: avoid running curl-config unnecessarily,
>     2020-04-04).
> 
>     It's built around evals. In fact, I suspect you could build a
>     function around eval that actually works similar to include, but
>     lazy-loads the file only when one of its stubs is referenced. I.e.,
>     something like:
> 
>       GIT_VERSION = $(eval include GIT-VERSION-FILE)
> 
>     would probably work (and for other includes, multiple variables
>     could mention the same file; as soon as it gets included, it
>     overwrites the stubs).
> 

Heh, in another reply in this thread, I mentioned that I had an alternate
patch I was toying with. If I tell you it was inspired by your commit
0573831950 (Makefile: avoid running curl-config unnecessarily, 04-04-2020),
you would probably not be surprised that it looks similar to what you
outline here. I had only just started looking at this approach, but it has
some wrinkles, so I thought I would look at it after submitting this series
'because this is an easy win'! ;-)

I hadn't done so yet, but I had planned to modify the GIT-VERSION-GEN script
(with -v parameter, say) to just output the version to stdout, because it
would save a sed invocation. It currently looks something like this:

  diff --git a/Makefile b/Makefile
  index 372139f1f2..f166fbe067 100644
  --- a/Makefile
  +++ b/Makefile
  @@ -493,7 +493,11 @@ all::
 
   GIT-VERSION-FILE: FORCE
          @$(SHELL_PATH) ./GIT-VERSION-GEN
  --include GIT-VERSION-FILE
  +
  +ifeq ($(wildcard GIT-VERSION-FILE),)
  +$(shell ./GIT-VERSION-GEN)
  +endif
  +GIT_VERSION = $(eval GIT_VERSION := $$(shell cat GIT-VERSION-FILE | sed -e 's/^GIT_VERSION = //'))$(GIT_VERSION)
 
   # Set our default configuration.
   #

Ignore the 'ifeq' for now (I had several versions, including getting rid
of the GIT-VERSION-FILE rule, but that caused problems without changing
the Documentation/Makefile, and several others ... (including in contrib)).

So, I haven't worked everything out yet, but I had planned to look at
this next.

ATB,
Ramsay Jones


