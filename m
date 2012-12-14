From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Declare that HP NonStop systems require strings.h
Date: Fri, 14 Dec 2012 15:17:00 -0800
Message-ID: <7vy5h0usur.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7mSOe6gs8JqkewYV=CXt78Y68nTFbFEfEOuCzaV5-DO8A@mail.gmail.com>
 <50CB8C80.6040802@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael <fedora.dm0@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 00:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjeVY-000276-Je
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 00:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898Ab2LNXRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 18:17:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932811Ab2LNXRH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 18:17:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B815B97B7;
	Fri, 14 Dec 2012 18:17:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i92GP3ohth+Ju6sLA30ciTnDV34=; b=oHmBUf
	SdEoPHpv8DqhydLLlq0O54I4O7pUCNX6aSUrPUGeGMcERkp7D6gHuKFQAuv7kZ6w
	ZtWif0fxoUUUrI7kbsf18pQJhaYTTVNjhJbsHatyKmhYvnB7Oduc25KI8ATxeTF2
	L4ii/iL9tJ+B1WC4plyrEYma81GtKZ9e8BFFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sskC2ty/kiwBWuGJdU+ntRkgnxzT8bOw
	w9KZl82zRKbAsY5OYJTyK1SdHmgqzCknRzhYl4yihtSeWiOj0lLdM7zIcFt+3Si1
	heJcxmdzP6AeISQxkj/h8RIY9kK1d79qCLqngKcRnyvYWCSfdv1h41QbzSNfZSdW
	q25JT3mEHV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A4D97B6;
	Fri, 14 Dec 2012 18:17:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74FB197B4; Fri, 14 Dec 2012
 18:17:05 -0500 (EST)
In-Reply-To: <50CB8C80.6040802@kdbg.org> (Johannes Sixt's message of "Fri, 14
 Dec 2012 21:30:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FE17A76-4644-11E2-9F5B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211512>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 14.12.2012 20:57, schrieb David Michael:
>> This platform previously included strings.h automatically.  However, the
>> build system now requires an explicit option to do so.
>> 
>> Signed-off-by: David Michael <fedora.dm0@gmail.com>
>> ---
>>  Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Makefile b/Makefile
>> index fb78f7f..e84b0cb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1357,6 +1357,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>>      # Added manually, see above.
>>      NEEDS_SSL_WITH_CURL = YesPlease
>>      HAVE_LIBCHARSET_H = YesPlease
>> +    HAVE_STRINGS_H = YesPlease
>>      NEEDS_LIBICONV = YesPlease
>>      NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
>>      NO_SYS_SELECT_H = UnfortunatelyYes
>
> If NONSTOP_KERNEL is the platform that defines __TANDEM, then this
> should be squashed into the previous patch, shouldn't it?

Correct; otherwise 3/4 would break build on that platform.
