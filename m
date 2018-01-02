Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326C11F428
	for <e@80x24.org>; Tue,  2 Jan 2018 15:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeABPcc (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 10:32:32 -0500
Received: from avasout03.plus.net ([84.93.230.244]:57993 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeABPcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 10:32:31 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id WOYGe5yFtCEdVWOYHeOWWo; Tue, 02 Jan 2018 15:32:29 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Nc2W7yL4 c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=2btJ15sR6H2mbiPwlrUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: Test failure for v2.16.0-rc0 on cygwin
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <519ac918-6b5f-bca3-05a0-0114683b9724@ramsayjones.plus.com>
 <20171230144019.GB29210@dinwoodie.org> <20180102113649.GC29210@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3616d866-9a53-6e32-0a62-488342ae214f@ramsayjones.plus.com>
Date:   Tue, 2 Jan 2018 15:32:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180102113649.GC29210@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPwmcRi1dAy+/W6rTBepiwhLj/wxsF86znCn1Dgy7dhLDIK1ctXA0x5/yi/FEqKsdML3suGxUYYlrRPf9v6D8kB6vsvOVCIusqXxMP5rRvTNb8/lLR/j
 1lgF/8WX/gBm5rqLycXyi8rVcrCRbLOUYnaEk4gCaBZEJ53OxIxvKWt8vUmhBaY4u1J9Pb4g+31/Fw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/01/18 11:36, Adam Dinwoodie wrote:
> On Saturday 30 December 2017 at 02:40 pm +0000, Adam Dinwoodie wrote:
>> On Saturday 30 December 2017 at 02:21 pm +0000, Ramsay Jones wrote:
>>> Hi Junio, Adam,
>>>
>>> Just a quick note about the failure of the test-suite on cygwin.
>>> In particular, test t5580-clone-push-unc.sh #3, like so:
>>>
>>> <snip>
>>>
>>> Adam, are you running the tests on Windows 10?
>>
>> I'm only routinely testing on Windows 10 x86_64, but between holidays
>> various, I've not had the tests running for the past couple of weeks.
>> I'm kicking off a build now in the name of verifying I see the same
>> problem.
> 
> I'm not able to reproduce this: t5580 is passing on both my Windows 10
> test systems on v2.16.0-rc0.

Hmm, interesting. BTW, I should have noted which version I'm on (just
in case it matters): Windows 10 Home, Version 1709, OS Build 16299.125.

I am reasonably up-to-date on cygwin:

  $ uname -a
  CYGWIN_NT-10.0 satellite 2.9.0(0.318/5/3) 2017-09-12 10:18 x86_64 Cygwin
  $ 

[I only recently updated to the creator's update (I'm not signed up to
the 'insider program'), and so could not try out WSL until now. I would
not recommend it to anyone who wants to develop software - a Linux VM
is an _order of magnitude_ faster, so ... ]

> Looking at your output, it sounds like there's something slightly odd
> with your directory permissions.  I agree the mixed slashes look odd,
> but given the test is passing on both my systems, I don't think that can
> be the problem.

The directory permissions look fine to me (except for //localhost/C$).

> I suspect you're going to need to do some more digging yourself given
> this appears to be a permissions issue on your system.  For a start,
> when you get to the failing `mkdir` with a UNC path, are you able to
> create the equivalent directory using Cygwin's `mkdir` but specifying a
> regular non-UNC path, 

yes, this is not a problem.

                        or by opening the UNC path in Explorer and
> creating the directory there?

I didn't get to this because ...

I just tried running the test again by hand, and I can't get it to fail!

Hmm, I have just set off a complete test-suite run, so I won't be able
to report on that for a while ... ;-)

I have an idea: when running the failing tests the other day, I was
remotely logged in via ssh (I have cygwin sshd running on my win10
box), but today I was logged in directly. The sshd daemon is run by
a privileged user, so maybe that could be related ... dunno.

I will have to investigate some more. (If you have any ideas ... :-D )

ATB,
Ramsay Jones

