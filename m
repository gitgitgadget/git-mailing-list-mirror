Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FC001FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243AbcHJSMy (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:12:54 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62911 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751003AbcHJSMv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:12:51 -0400
X-AuditID: 1207440c-22bff700000008d5-d8-57ab5fce9798
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 12.07.02261.ECF5BA75; Wed, 10 Aug 2016 13:09:34 -0400 (EDT)
Received: from [192.168.69.130] (p5B104255.dip0.t-ipconnect.de [91.16.66.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7AH9Wt5005679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Aug 2016 13:09:33 -0400
Subject: Re: [PATCH 5/8] xdl_change_compact(): fix compaction heuristic to
 adjust io
To:	Jeff King <peff@peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
 <20160804072705.a53mospcccksiz4e@sigill.intra.peff.net>
 <7dea0a1e-a1b4-efe4-c86d-152f6c96604a@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b4c4b955-f461-4828-f83a-7caaf3c3d6be@alum.mit.edu>
Date:	Wed, 10 Aug 2016 19:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <7dea0a1e-a1b4-efe4-c86d-152f6c96604a@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1D0fvzrc4GAjm0XXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4MrY8K6fseCcWMXyC3sYGxj3C3UxcnJICJhIvOn/wdLFyMUhJLCVUWLm30PsEM5Z
	JonzK54CZTg4hAXCJPa+SQJpEBGQlfh+eCMjRM0PRomGjSvYQBxmgeuMErvmLmEEqWIT0JVY
	1NPMBGLzCthL3Nz2kAXEZhFQlThx6CsriC0qECKx7WYDG0SNoMTJmU/AajgFHCQe7roO1sss
	oC7xZ94lZghbXmL72znMExj5ZyFpmYWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKL
	dA31cjNL9FJTSjcxQoKaZwfjt3UyhxgFOBiVeHg3MK0KF2JNLCuuzD3EKMnBpCTKKxyzOlyI
	Lyk/pTIjsTgjvqg0J7X4EKMEB7OSCG9bBFCONyWxsiq1KB8mJc3BoiTOq7pE3U9IID2xJDU7
	NbUgtQgmK8PBoSTByxEH1ChYlJqeWpGWmVOCkGbi4AQZzgM0fDZIDW9xQWJucWY6RP4Uo6KU
	OO+rWKCEAEgiozQPrheWdF4xigO9IsybBdLOA0xYcN2vgAYzAQ1OUl0BMrgkESEl1cA4saJf
	g5/LzuWtlvBS1l1vOdfdSVLXlVf+ekdU/NEb5ekONQLJ6sH/a5f4iHz7fTaWofIIl7l+8L0J
	+bp/TvIHF2vU8mp+eDT12y4lk2kdJhoL5z26Xcajto/f3JNPfedq6XVLbm9/yb3LfOej4BJ3
	A49Vst8SnSrX8q+z2FOcKXBL7rvvlwglluKMREMt5qLiRADwhZ6AFQMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/10/2016 06:58 PM, Michael Haggerty wrote:
> On 08/04/2016 09:27 AM, Jeff King wrote:
>> On Thu, Aug 04, 2016 at 12:00:33AM +0200, Michael Haggerty wrote:
>>
>>> The code branch used for the compaction heuristic incorrectly forgot to
>>> keep io in sync while the group was shifted. I think that could have
>>> led to reading past the end of the rchgo array.
>>>
>>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>>> ---
>>> I didn't actually try to verify the presence of a bug, because it
>>> seems like more work than worthwhile. But here is my reasoning:
>>>
>>> If io is not decremented correctly during one iteration of the outer
>>> `while` loop, then it will loose sync with the `end` counter. In
>>> particular it will be too large.
>>>
>>> Suppose that the next iterations of the outer `while` loop (i.e.,
>>> processing the next block of add/delete lines) don't have any sliders.
>>> Then the `io` counter would be incremented by the number of
>>> non-changed lines in xdf, which is the same as the number of
>>> non-changed lines in xdfo that *should have* followed the group that
>>> experienced the malfunction. But since `io` was too large at the end
>>> of that iteration, it will be incremented past the end of the
>>> xdfo->rchg array, and will try to read that memory illegally.
>>
>> Hmm. In the loop:
>>
>>   while (rchgo[io])
>> 	io++;
>>
>> that implies that rchgo has a zero-marker that we can rely on hitting.
> 
> I agree.
> 
>> And it looks like rchgo[io] always ends the loop on a 0. So it seems
>> like we would just hit that condition again.
> 
> Correct...in this loop. But there is another place where `io` is
> incremented unconditionally. In the version before my changes, it is via
> the preincrement operator in this while statement conditional:
> 
> https://github.com/mhagger/git/blob/a28705da929ad746abcb34270947f738549d3246/xdiff/xdiffi.c#L502
> 
> After my changes, the unconditional increment is more obvious because I
> took it out of the while condition:
> 
> https://github.com/mhagger/git/blob/39a135da93834fd72ee923d95d0cebfe525dfe7a/xdiff/xdiffi.c#L541
> 
> (BTW, I think this is a good example of how patch 2/8 makes the code
> easier to reason about.)

Actually, for the case that no more sliders are found in the file, the
key lines where io is incremented unconditionally are

https://github.com/mhagger/git/blob/a28705da929ad746abcb34270947f738549d3246/xdiff/xdiffi.c#L438

before the change (note that the post-increment happens even if the
while condition returns false), and

https://github.com/mhagger/git/blob/39a135da93834fd72ee923d95d0cebfe525dfe7a/xdiff/xdiffi.c#L443-L444

after the change. (The lines I mentioned in my previous email are also
unconditional increments, but those are only executed in the case that
more sliders are found.)

Michael

