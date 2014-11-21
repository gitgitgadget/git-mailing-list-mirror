From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFD/PATCH] add: ignore only ignored files
Date: Fri, 21 Nov 2014 16:39:51 +0100
Message-ID: <546F5CC7.8060904@drmicha.warpmail.net>
References: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net> <20141119191502.GC9908@peff.net> <xmqqbno2rhlz.fsf@gitster.dls.corp.google.com> <546DB778.2000000@drmicha.warpmail.net> <20141120155621.GA30273@peff.net> <xmqqegsx4whi.fsf@gitster.dls.corp.google.com> <20141120182012.GD2559@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 16:40:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrqJS-0006HQ-GD
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 16:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761AbaKUPjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 10:39:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60433 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758710AbaKUPjx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 10:39:53 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9717020EF4
	for <git@vger.kernel.org>; Fri, 21 Nov 2014 10:39:52 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 21 Nov 2014 10:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=j/cL1tex05D5Kq6M6JgL2E
	jl1so=; b=AkLAhTH98O81IwTp8pmLlnfgh8YpJAx17tg1kktAsRF/ROx1LBR4re
	KD7+kz6SSwn4l+mfQ7z+RZxn2mxVsJi8S6XJX/bfDYhT1mZjiF4aR/qOi2u4iJ6x
	odUaV+t7S8KnZiI/XdJeW5QnVDMS4D7EycSeIV1U3uCLNVr/9evRg=
X-Sasl-enc: ZWETJrHCFh/yencND16Shp2xN6Rf2HReAygTgHSfDS0K 1416584392
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 046AB6800A2;
	Fri, 21 Nov 2014 10:39:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141120182012.GD2559@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King schrieb am 20.11.2014 um 19:20:
> On Thu, Nov 20, 2014 at 09:23:21AM -0800, Junio C Hamano wrote:
> 
>>> diff --git a/builtin/add.c b/builtin/add.c
>>> index ae6d3e2..1074e32 100644
>>> --- a/builtin/add.c
>>> +++ b/builtin/add.c
>>> @@ -284,7 +284,7 @@ static int add_files(struct dir_struct *dir, int flags)
>>>  		for (i = 0; i < dir->ignored_nr; i++)
>>>  			fprintf(stderr, "%s\n", dir->ignored[i]->name);
>>>  		fprintf(stderr, _("Use -f if you really want to add them.\n"));
>>> -		die(_("no files added"));
>>> +		exit_status = 1;
>>>  	}
>>>  
>>>  	for (i = 0; i < dir->nr; i++)
>>>
>>> It needs a tweak to t3700.35, which expects the "fatal:" line on stderr.
>>> But other than that, it passes all tests. So it must be good, right? :)
>>
>> ;-)
>>
>> It indeed is a behaviour change, but I do not expect it would be too
>> heavy a change to require us a transition period or major version
>> bump.  But because that is just my expectation, which is not what
>> real world users would expect, so I'd prefer to cook such a change
>> for at least a cycle and a half in 'next'.
> 
> Oh, definitely. Showing the patch at all was my not-so-subtle attempt to
> convince Michael to take over the topic so I did not have to worry about
> such things. :)

Well, given that I figured out how to do it with the option, it may come
at no additional surprise that I figured out how to do it without the
option, as well.

The real extra surprise is - not only that test fix is in my tree
already - it even comes with a test that actually tests the new intended
behavior. Whoaaa!

I'll resend it soon so that Jeff can take over and adjust the commit
message ;)

Michael, just kidding
