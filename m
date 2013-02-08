From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Fri, 08 Feb 2013 12:27:44 +0100
Message-ID: <5114E130.6060902@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net> <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net> <20130206223656.GF27507@sigill.intra.peff.net> <51136E75.5060002@drmicha.warpmail.net> <20130207092640.GC15727@sigill.intra.peff.net> <5113784B.10103@drmicha.warpmail.net> <20130207095533.GA17110@sigio.peff.net> <5113827A.40801@drmicha.warpmail.net> <7v4nho9f28.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 12:28:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3m7j-0006WN-Mp
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 12:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946274Ab3BHL1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 06:27:44 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57937 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946244Ab3BHL1o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 06:27:44 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8DFDB20C2A;
	Fri,  8 Feb 2013 06:27:43 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 08 Feb 2013 06:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=9HDmLJFpT68cwiByiWPtGX
	ecTSM=; b=ArNBpE7aejf7r48GSGarqhIZ6all+cV4CP8gaSiOcCJbZ74nQh704C
	jobRk4wZH1LMsXedDzpsgB4vWtb+A1zYKrD3tiWj0cbjmVat9j8eQLuNTEBGySjp
	/RN4hByz6M4rN1sls9iP28x6AJUCGT584hf18HvGimPWhUQ+PL4HA=
X-Sasl-enc: XJEhXMhefLS21ZXR97u8AdqRYYW/aERVaRAKFmdHvpJu 1360322863
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C1FE0482524;
	Fri,  8 Feb 2013 06:27:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7v4nho9f28.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215773>

Junio C Hamano venit, vidit, dixit 07.02.2013 19:03:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>>> (cd t && git grep GET_SHA1_QUIETLY HEAD:../cache.h)
>>>> ../HEAD:../cache.h:#define GET_SHA1_QUIETLY        01
>>>
>>> Yuck.
>>
>> And even more yuck:
>>
>> (cd t && git grep --full-name GET_SHA1_QUIETLY HEAD:../cache.h)
>> HEAD:../cache.h:#define GET_SHA1_QUIETLY        01
>>
>> Someone does not expect a "rev:" to be in there, it seems ;)
> 
> I think stepping outside of $(cwd) is an afterthought the code does
> not anticipate.
> 

Well, we do resolve relative paths correctly, and there are even some
"chdir" in the code path. It's just that the output label is incorrect.

Michael
