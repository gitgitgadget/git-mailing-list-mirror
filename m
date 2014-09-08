From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] headers: include dependent headers
Date: Mon, 08 Sep 2014 10:50:20 -0700
Message-ID: <xmqqfvg2ngrn.fsf@gitster.dls.corp.google.com>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com>
	<1410031211-14599-2-git-send-email-davvid@gmail.com>
	<540B7AA3.1090201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:50:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR35C-0006q9-Pr
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 19:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbaIHRu0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2014 13:50:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55391 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754248AbaIHRuZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2014 13:50:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C45D37555;
	Mon,  8 Sep 2014 13:50:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gDHEYkmjiesD
	IungwgGOZW6lhHM=; b=Nk/1NQ7+i4EbnTYV9EvIxh3lOnpBaRFmej/X+sJY6a19
	O0pxPCme1K98DG9HMnp5Tj2XHDDUAnKygLtMrE1vsyHlibUB3bQd5Or//5/W68l1
	ASFURN87TChg5ws0v84kX03A8GmLk0VlgiAeJ/VxkWDLSFlZSxl3R5zQgNAnFcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=L985H6
	ggIqF/9G4J5CoCj30pIIQR6BnwpRsEOalC8fWYDLaFQk16lvC0o8gND+ququVt3V
	d/B5X8WD0VOFoslVJJiytPmYr6UGI7/Mi8O4xL976koJeALw+jc7p+6s0ou/GRRA
	jV6HPMM1OHXzoYHwVcp6FjlaeVuVZkS5WDdkk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5005A37552;
	Mon,  8 Sep 2014 13:50:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B6CCC37551;
	Mon,  8 Sep 2014 13:50:22 -0400 (EDT)
In-Reply-To: <540B7AA3.1090201@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 06
	Sep 2014 23:20:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9B3A5546-3780-11E4-93FC-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256662>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 06.09.2014 um 21:20 schrieb David Aguilar:
>> Add dependent headers so that including a header does not
>> require including additional headers.
>>
>> This makes it so that "gcc -c $header" succeeds for each header.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>
>> diff --git a/branch.h b/branch.h
>> index 64173ab..a61fd1a 100644
>> --- a/branch.h
>> +++ b/branch.h
>> @@ -3,6 +3,9 @@
>>
>>   /* Functions for acting on the information about branches. */
>>
>> +#include "cache.h"
>> +#include "strbuf.h"
>
> cache.h includes strbuf.h, so the line above isn't necessary.

True, but is "gcc -c $header" something we want to please in the
first place (not an objection, but request for opinions)?
