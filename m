Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2AE120986
	for <e@80x24.org>; Fri,  7 Oct 2016 15:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757070AbcJGPpV (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 11:45:21 -0400
Received: from blade12.connectinternetsolutions.com ([193.110.243.152]:40430
        "EHLO blade12.connectinternetsolutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756979AbcJGPpQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Oct 2016 11:45:16 -0400
Received: from [192.168.1.111] (rklrkl.plus.com [84.92.54.184])
        (authenticated bits=0)
        by blade12.connectinternetsolutions.com (8.13.8/8.13.8) with ESMTP id u97Fj81t003178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 7 Oct 2016 16:45:09 +0100
Subject: Re: Systems with old regex system headers/libraries don't pick up
 git's compat/regex header file
To:     Jeff King <peff@peff.net>
References: <9f43a2f1-5d7e-3a2e-5a83-40e92ab0d7b5@connectinternetsolutions.com>
 <20161006191127.2vjtmxl7ygjeqcbk@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
Message-ID: <4ac0ce84-ca6c-3650-ef5e-e13c54c60504@connectinternetsolutions.com>
Date:   Fri, 7 Oct 2016 16:45:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161006191127.2vjtmxl7ygjeqcbk@sigill.intra.peff.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Company-Sig: added
X-MD-Spam-Report: score=0.919 required=8 tests=SPF_FAIL
X-Scanned-By: MIMEDefang 2.70 on 172.25.243.152
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (blade12.connectinternetsolutions.com [172.25.243.152]); Fri, 07 Oct 2016 16:45:10 +0100 (BST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/16 20:11, Jeff King wrote:
> Junio mentioned the NO_REGEX knob in the Makefile. If that works for
> you, the next step is probably to add a line to the HP-UX section of
> config.mak.uname, so that it just works out of the box.

This doesn't work because the check in git-compat-util.h only looks
for REG_STARTEND being defined (if it isn't, it #error's out).

That define is not mentioned anywhere else other than in the
compat/regex tree, which is why I used -Icompat/regex to pick up
<regex.h> from there - this was the "easiest" solution for me on
HP-UX 11.

Note that with this inclusion change, the source compiled and linked
fine on HP-UX 11 and git passed its tests, including the regex-based ones.

Richard K. Lloyd,           E-mail: richard.lloyd@connectinternetsolutions.com
Connect Internet Solutions,    WWW: https://www.connectinternetsolutions.com/
4th Floor, New Barratt House,
47, North John Street,
Liverpool,
Merseyside, UK. L2 6SG




>
> -Peff
>




-- 
This e-mail (and any attachments) is private and confidential. If you have 
received it in error, please notify the sender immediately and delete it 
from your system. Do not use, copy or disclose the information in any way 
nor act in reliance on it.

Any views expressed in this message are those of the individual sender,
except where the sender specifically states them to be the views of Connect
Internet Solutions Ltd. This e-mail and any attachments are believed to be
virus free but it is the recipient's responsibility to ensure that they are.

Connect Internet Solutions Ltd
(A company registered in England No: 04424350)
Registered Office: 4th Floor, New Barratt House, 47 North John Street,
Liverpool, L2 6SG
Telephone: +44 (0) 151 282 4321
VAT registration number: 758 2838 85
