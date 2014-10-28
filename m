From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand on impact of threads on memory consumption.
Date: Tue, 28 Oct 2014 09:57:50 -0700
Message-ID: <xmqqvbn43ze9.fsf@gitster.dls.corp.google.com>
References: <3F70E0BBE32F764BA89060B84135BD471850D9E1@TVTEX10.tvt.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Robert de Bath <robert@tvisiontech.co.uk>
X-From: git-owner@vger.kernel.org Tue Oct 28 18:24:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjAVF-0000gj-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 18:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbaJ1RYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 13:24:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750786AbaJ1RYN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 13:24:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B93418C44;
	Tue, 28 Oct 2014 13:24:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aDeOJDGpCS+2rb9HsVZWMd70qys=; b=BHENgc
	0qukmimCe//ajBEAJ25v0vj/AUrLXDM4+jDj4+qdP4tBC+T6nVDn5cehrNablIfL
	UscjrE4n8OAVrXhbSOCxTi8mQPzdG4Lhj5oHDL25xr95FKaiZ7NQ2v4F34Z4hXrO
	g5RHegiyMp6pGhLArYcSiMIKnUKOl4+AwRgfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W7p+GqtmpO7cMsNdXm/ZEE1tUcQRE3tS
	a4GEBvjOAeulGWPE9tiCbORGqSxA1YXpz0hd0edO3+LVzHzYPRkEOfq/FisPxLC9
	6EQlkDMJPpz3fSdVUQEdYT1GRPaNnB4tA3Y+bMJRVgYrNcR8yBiobF232Fr2w3Zl
	XR5z2geFkDU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4364418C43;
	Tue, 28 Oct 2014 13:24:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 959FD184AE;
	Tue, 28 Oct 2014 12:57:51 -0400 (EDT)
In-Reply-To: <3F70E0BBE32F764BA89060B84135BD471850D9E1@TVTEX10.tvt.local>
	(Robert de Bath's message of "Fri, 24 Oct 2014 17:51:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8DA87FB0-5EC3-11E4-80AB-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert de Bath <robert@tvisiontech.co.uk> writes:

>> ... text unnecessarily opaque ...
> Yes, that's quite likely. 
> However, I think you should continue to have a similar form to the
> previous 'pack.window' and
> 'pack.depth' descriptions... perhaps:
>
>     The maximum size of memory that is consumed by each
>     thread in linkgit:git-pack-objects[1] for pack window memory
>     when no limit is given on the command line.
>     The value can be suffixed with "k", "m", or "g".  When left
>     unconfigured, there will be no limit.

OK, let's go with that wording.

Thanks.

>
> Though, I suspect the existing wording is trying to avoid saying there's a 'default' and 
> another 'default' which would be covered by your rewording.
>
> So I have no real problem either way.
>
> Robert.
>  
> ________________________________________
> From: Junio C Hamano [gitster@pobox.com]
> Sent: 24 October 2014 18:27
> To: Robert de Bath
> Cc: git@vger.kernel.org
> Subject: [NOTWHITELIST] Re: [PATCH] Expand on impact of threads on memory consumption.
>
> Robert de Bath <rdebath@tvisiontech.co.uk> writes:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index c55c22a..6384038 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1828,7 +1828,10 @@ pack.depth::
>>
>>  pack.windowMemory::
>>       The window memory size limit used by linkgit:git-pack-objects[1]
>> -     when no limit is given on the command line.  The value can be
>> +     when no limit is given on the command line.  This limit may be
>> +     allocated individually by each thread doing delta compression
>> +     so the total memory allocated by linkgit:git-pack-objects[1] can
>> +     be this multiplied by the number of threads.  The value can be
>>       suffixed with "k", "m", or "g".  Defaults to 0, meaning no
>>       limit.
>
> I sense that this change makes the resulting text unnecessarily
> opaque by avoiding touching the first sentence.  Wouldn't something
> more concise like this sufficient?
>
>     The default maximum size of memory that is consumed by each
>     thread in linkgit:git-pack-objects[1] for pack window memory.
>     The value can be suffixed with "k", "m", or "g".  When left
>     unconfigured, there will be no limit.
