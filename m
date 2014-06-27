From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Fri, 27 Jun 2014 15:50:59 +0200
Message-ID: <53AD76C3.3060702@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net> <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net> <20140613080229.GJ7908@sigill.intra.peff.net> <539ACA8A.90108@drmicha.warpmail.net> <20140613110901.GB14066@sigill.intra.peff.net> <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com> <20140616195428.GB24376@sigill.intra.peff.net> <xmqqk38gpp9v.fsf@gitster.dls.corp.google.com> <20140616203956.GA3546@sigill.intra.peff.net> <53AD640A.9060006@drmicha.warpmail.net> <53AD685A.1030401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:51:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0WYV-0001zy-Hf
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 15:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbaF0NvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 09:51:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52083 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753435AbaF0NvB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 09:51:01 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9B16B21AB9;
	Fri, 27 Jun 2014 09:51:00 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 27 Jun 2014 09:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=5CpcGca5REn5ScV1S49wO8
	yUbXE=; b=QDkY+qUHj59DyAqrG6w4jDnkXMN9bIm0neMWleN/qp/sdx4M8yulUL
	jc0qvLQHPlJDEV76FbtUVI6rnYrhLcSzeRrSXHz2srVZccxI/8zi3YbmY1lvOcha
	rdi94zI5wW2S7zvOV9XW+f8vrLEq8BjPCfKSfzn/7uPIj2s9qF+Dc=
X-Sasl-enc: v+o57YQ2dNFL1otmlwe5Be8IwbBQJ+0UZtPDQwRgfTgN 1403877060
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EDE976801C6;
	Fri, 27 Jun 2014 09:50:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53AD685A.1030401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252551>

Michael J Gruber venit, vidit, dixit 27.06.2014 14:49:
> Michael J Gruber venit, vidit, dixit 27.06.2014 14:31:
>> Jeff King venit, vidit, dixit 16.06.2014 22:39:
>>> On Mon, Jun 16, 2014 at 01:34:20PM -0700, Junio C Hamano wrote:
>>>
>>>>> Your middle example above did make me think of one other thing, though.
>>>>> As you noted, we actually have _three_ signature types:
>>>>>
>>>>>   1. signed tags
>>>>>
>>>>>   2. signed commits
>>>>>
>>>>>   3. merges with embedded mergetag headers
>>>>>
>>>>> We already have a tool for (1). Michael is adding a tool for (2). How
>>>>> would one check (3) in a similar way?
>>>>
>>>> Hmph, somehow I misread the patch that it was for both 2 & 3 X-<.
>>>
>>> I was just assuming it handles only (2) without checking further, so I
>>> may be wrong. But I do not think it makes sense to conflate (2) and (3).
>>> A merge commit may have both, and they are separate signatures.
>>>
>>> For that matter, is there a way to expose (3) currently, besides via
>>> --show-signature? It does not trigger "%GG" and friends (nor should it).
>>> It may make sense to add extra format specifiers for mergetag
>>> signatures. Though I do not use them myself, so I am not clear on what
>>> the use case is besides a manual, human verification of a particular
>>> merge.
>>
>> I'm afraid I'm on a weekly git schedule at best, sorry. Just trying to
>> catch up on this:
>>
>> Admittedly, I simply don't know about "3.". I know only 1. and 2. (and
>> don't remember why they are implemented differently).
>>
>> Are they documented/decribed somewhere?
>>
>> Meanwhile, I'm rebasing on top of the %G related patches by Junio and
>> Jeff and hope to send out a v4 later today.
>>
>> Michael
> 
> OK, found the two commits which "git log -Smergetag" outputs, but no tests.
> 
> A merge commit with embedded signed tag it is, then.
> 
> The commit could carry it's own commit signature, couldn't it?
> That would suggest that we use "git verify-tag" to verify the embedded
> signed tag of a merge commit and "git verify-commit" to verify the
> commit signature.
> 
> OTOH I would like these basic commands to be as strict as possible,
> including type-checks. Does that mean having "git verify-mergetag" which
> verifies that it is being used on a merge commit with embedded mergetag?

... or an extension <ref>^{mergetag} to our machinery, defaulting to the
tag object containing the mergetag for the 2nd parent, with an optional
version <ref>^{mergetag}<n>?

OTOH, verifying a mergetag involves both looking at the signed tag and
the parent list of the commit. We probably should require signed (merge)
tags on all but the first parent. Oh Can of Worms, oh Can of Worms ("Oh
Can'o'Worms" to the tune of "Oh Canada").

Michael
