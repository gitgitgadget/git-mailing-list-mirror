Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623561F453
	for <e@80x24.org>; Mon, 21 Jan 2019 07:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfAUHNK (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 02:13:10 -0500
Received: from fed1rmfepi108.cox.net ([68.230.241.139]:53128 "EHLO
        fed1rmfepi108.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfAUHNI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:08 -0500
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190120221125.XEUN4136.fed1rmfepo103.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Sun, 20 Jan 2019 17:11:25 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id D51A6B81710;
        Sun, 20 Jan 2019 15:11:24 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090204.5C44F20D.001C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=OtL7NB3t c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10
 a=_wg1dRi1RyNdmxHK2esA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 4/5] Add `human` format to test-tool
Date:   Sun, 20 Jan 2019 15:11:24 -0700
Message-ID: <3086071.UFgDplIbgl@thunderbird>
Organization: Personal
In-Reply-To: <xmqqtvi5kctv.fsf@gitster-ct.c.googlers.com>
References: <20181231003150.8031-1-ischis2@cox.net> <20190118061805.19086-5-ischis2@cox.net> <xmqqtvi5kctv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, January 18, 2019 12:03:40 PM MST Junio C Hamano wrote:
> It is a shame that you introduced a nicely reusable get_time()
> mechanism to let external callers of show_date() specify what time
> to format, instead of the returned timestamp of gettimeofday(),
> but limited its usefulness to only testing "human" format output.
> If somebody wants to extend "test-tool date" for other formats, they
> also have to add a similar "show_date_XXX" hack for their format.
> 
> How about doing it slightly differently?  E.g.
> 
>  - Get rid of show_date_human().
> 
>  - Keep get_time(), but have it pay attention to GIT_TEST_TIMESTAMP
>    environment variable, and when it is set, use that as if it is
>    the returned value from gettimeofday().
> 
>  - If there are gettimeofday() calls in date.c this patch did not
>    touch (because they were not part of the "human-format"
>    codepath), adjust them to use get_time() instead.
> 
>  - Have "test-tool date" excersize show_date() directly.
> 
I did follow the pattern set for relative (which is why I created 
show_date_human() to mimic show_date_relative() ) as had been suggested.   I 
like this pattern better.

Why don't I create a second patch set after I git this one to next for 
relative to match your suggestion.  I don't like the idea of conflating two 
topics.

sps


