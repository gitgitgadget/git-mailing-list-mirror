Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329181FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbcHJVbu (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:31:50 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62843 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751378AbcHJSBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:01:25 -0400
X-AuditID: 1207440c-217ff700000008d5-f6-57ab5d21c0a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D2.46.02261.12D5BA75; Wed, 10 Aug 2016 12:58:09 -0400 (EDT)
Received: from [192.168.69.130] (p5B104255.dip0.t-ipconnect.de [91.16.66.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7AGw6fk004905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Aug 2016 12:58:07 -0400
Subject: Re: [PATCH 5/8] xdl_change_compact(): fix compaction heuristic to
 adjust io
To:	Jeff King <peff@peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
 <20160804072705.a53mospcccksiz4e@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <7dea0a1e-a1b4-efe4-c86d-152f6c96604a@alum.mit.edu>
Date:	Wed, 10 Aug 2016 18:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160804072705.a53mospcccksiz4e@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1FWMXR1usGu1lUXXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4Mo4v/01c8E8kYobS1+yNTAuEuhi5OSQEDCRmPrqDksXIxeHkMBWRokLcyazQzhn
	mSRaXr1g7mLk4BAWCJPY+yYJpEFEQFbi++GNjBA1hxglDvQdAWtgFrjOKLFr7hJGkCo2AV2J
	RT3NTCDNvAL2Evdv5IKEWQRUJfb9W8YEYosKhEhsu9nABmLzCghKnJz5hAXE5hRwkfj9dw1Y
	nFlAXeLPvEvMELa8xPa3c5gnMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+bl
	pRbpGurlZpbopaaUbmKEhDTPDsZv62QOMQpwMCrx8G5gWhUuxJpYVlyZe4hRkoNJSZRXOGZ1
	uBBfUn5KZUZicUZ8UWlOajHQ6xzMSiK8bRFAOd6UxMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU
	7NTUgtQimKwMB4eSBO/GaKBGwaLU9NSKtMycEoQ0EwcnyHAeoOFsIIt5iwsSc4sz0yHypxgV
	pcR5N0cBJQRAEhmleXC9sJTzilEc6BVhXlaQdh5guoLrfgU0mAlocJLqCpDBJYkIKakGRq2/
	29beYtm18zTvxj/T/XIPd6zJEdj5+u281lCxX2dEeOev1Zn0edf5pKwJRpb8y/emrf4WeuTO
	0Q/2N2MvS/MGMOoz/T3WdvyQQkL/+jrH2d7z0mdHHDm6Oah10dxLFytq14ZmN1/YqNIp+ZxH
	7/7rBAnhmwZG3R9XuYfuEPuxVCLw3Ux+HSUlluKMREMt5qLiRADtidypFAMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 09:27 AM, Jeff King wrote:
> On Thu, Aug 04, 2016 at 12:00:33AM +0200, Michael Haggerty wrote:
> 
>> The code branch used for the compaction heuristic incorrectly forgot to
>> keep io in sync while the group was shifted. I think that could have
>> led to reading past the end of the rchgo array.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> I didn't actually try to verify the presence of a bug, because it
>> seems like more work than worthwhile. But here is my reasoning:
>>
>> If io is not decremented correctly during one iteration of the outer
>> `while` loop, then it will loose sync with the `end` counter. In
>> particular it will be too large.
>>
>> Suppose that the next iterations of the outer `while` loop (i.e.,
>> processing the next block of add/delete lines) don't have any sliders.
>> Then the `io` counter would be incremented by the number of
>> non-changed lines in xdf, which is the same as the number of
>> non-changed lines in xdfo that *should have* followed the group that
>> experienced the malfunction. But since `io` was too large at the end
>> of that iteration, it will be incremented past the end of the
>> xdfo->rchg array, and will try to read that memory illegally.
> 
> Hmm. In the loop:
> 
>   while (rchgo[io])
> 	io++;
> 
> that implies that rchgo has a zero-marker that we can rely on hitting.

I agree.

> And it looks like rchgo[io] always ends the loop on a 0. So it seems
> like we would just hit that condition again.

Correct...in this loop. But there is another place where `io` is
incremented unconditionally. In the version before my changes, it is via
the preincrement operator in this while statement conditional:

https://github.com/mhagger/git/blob/a28705da929ad746abcb34270947f738549d3246/xdiff/xdiffi.c#L502

After my changes, the unconditional increment is more obvious because I
took it out of the while condition:

https://github.com/mhagger/git/blob/39a135da93834fd72ee923d95d0cebfe525dfe7a/xdiff/xdiffi.c#L541

(BTW, I think this is a good example of how patch 2/8 makes the code
easier to reason about.)

I didn't do the hard work to determine whether `io` could *really* walk
off the end of the array, but I don't see an obvious reason why it
*couldn't*.

> Anyway, I'd suggest putting your cover letter bits into the commit
> message. Even though they are all suppositions, they are the kind of
> thing that could really help somebody debugging this in 2 years, and are
> better than nothing.

Good idea. Will do.

Michael

