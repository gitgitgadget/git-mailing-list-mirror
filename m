From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 0/21] pack bitmaps
Date: Thu, 14 Nov 2013 23:09:40 +0000
Message-ID: <52855834.3080608@ramsay1.demon.co.uk>
References: <20131114124157.GA23784@sigill.intra.peff.net> <5285224A.2070606@ramsay1.demon.co.uk> <20131114213320.GA16466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 15 00:09:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh62m-00022q-Is
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 00:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab3KNXJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 18:09:45 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:60633 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751939Ab3KNXJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 18:09:44 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 381AA384082;
	Thu, 14 Nov 2013 23:09:42 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 0321E38407C;
	Thu, 14 Nov 2013 23:09:42 +0000 (GMT)
Received: from [192.168.254.6] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu, 14 Nov 2013 23:09:41 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131114213320.GA16466@sigill.intra.peff.net>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237882>

On 14/11/13 21:33, Jeff King wrote:
> On Thu, Nov 14, 2013 at 07:19:38PM +0000, Ramsay Jones wrote:
> 
>> Unfortunately, I didn't find time this weekend to finish the msvc build
>> fixes. However, after a quick squint at these patches, I think you have
>> almost done it for me! :-D
>>
>> I must have misunderstood the previous discussion, because my patch was
>> written on the assumption that the ewah directory wouldn't be "git-ified"
>> (e.g. #include git-compat-util.h).
> 
> I think it was up for debate at some point, but we did decide to go
> ahead and git-ify. Please feel free to submit further fixups if you need
> them.

Yep, will do; at present it looks like that one-liner.

> 
>>>   - the ewah code used gcc's __builtin_ctzll, but did not provide a
>>>     suitable fallback. We now provide a fallback in C.
>>
>> ... here.
>>
>> I was messing around with several implementations (including the use of
>> msvc compiler intrinsics) with the intention of doing some timing tests
>> etc. [I suspected my C fallback function (a different implementation to
>> yours) would be slightly faster.]
> 
> Yeah, I looked around for several implementations, and ultimately wrote
> one that was the most readable to me. The one I found shortest and most
> inscrutable was:
> 
>   return popcount((x & -x) - 1);
> 
> the details of which I still haven't worked through in my head. ;)

Yeah, I stumbled over that one too!

> I do think on most platforms that intrinsics or inline assembler are the
> way to go. My main goal was to get something correct that would let it
> compile everywhere, and then people can use that as a base for
> optimizing. Patches welcome. :)

Indeed, I can happily leave that to another day (or to someone else
more motivated ;-)

ATB,
Ramsay Jones
