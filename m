From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Makefile: merge two Cygwin configuration sections
 into   one
Date: Mon, 02 Nov 2009 23:46:28 -0800
Message-ID: <7vk4y8t5ij.fsf@alter.siamese.dyndns.org>
References: <4AE745FB.1060902@ramsay1.demon.co.uk>
 <4AEFDA3F.2070405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>, dpotapov@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5E6R-00043D-Sq
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbZKCHqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 02:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756711AbZKCHqk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:46:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570AbZKCHqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 02:46:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5878290123;
	Tue,  3 Nov 2009 02:46:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AiLJgJmqUWY5QTl3zGFoIcVxqOM=; b=hrClf3
	bFKskkvA0+7jJ9ee1fUXFAlGDRP/fFGSnSRREtfKiCheMvkya+Gh7BuMIHPffs8C
	+2XZHivzJy8NbDCuPyHXKUGVkid1Hy+4nLi96vreDaeCakIdxvqKIbg5E9PZmb5j
	y1YtLBfOeUs22KaiobYHVsn1WvJRaB7pkA14g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhWO+PHaH2eDMXTjA1GjGXWW7ANC3F9j
	A5Qj8IzJeRd4Vp3OZbEbarPbReIaO8vR3YWKdXahYrlfoufr1cPsE6ZiwhC0XzU6
	7T1WndOpVaXWlHiukAJIKtbRN/aJIlxsUTQLeiwwhtwIe8dgHXR0yJ4HQstl9vRy
	kFOu+B56VCE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 165C490122;
	Tue,  3 Nov 2009 02:46:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F1BDC90121; Tue,  3 Nov 2009
 02:46:29 -0500 (EST)
In-Reply-To: <4AEFDA3F.2070405@viscovery.net> (Johannes Sixt's message of
 "Tue\, 03 Nov 2009 08\:22\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0474DBA6-C84D-11DE-88C3-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131953>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Ramsay Jones schrieb:
>> diff --git a/Makefile b/Makefile
>> index fea237b..8e1cfc5 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -782,6 +782,8 @@ ifeq ($(uname_O),Cygwin)
>>  	NO_MMAP = YesPlease
>>  	NO_IPV6 = YesPlease
>>  	X = .exe
>> +	COMPAT_OBJS += compat/cygwin.o
>> +	UNRELIABLE_FSTAT = UnfortunatelyYes
>>  endif
>>  ifeq ($(uname_S),FreeBSD)
>>  	NEEDS_LIBICONV = YesPlease
>> @@ -891,10 +893,6 @@ ifeq ($(uname_S),HP-UX)
>>  	NO_SYS_SELECT_H = YesPlease
>>  	SNPRINTF_RETURNS_BOGUS = YesPlease
>>  endif
>> -ifneq (,$(findstring CYGWIN,$(uname_S)))
>> -	COMPAT_OBJS += compat/cygwin.o
>> -	UNRELIABLE_FSTAT = UnfortunatelyYes
>> -endif
>>  ifdef MSVC
>>  	GIT_VERSION := $(GIT_VERSION).MSVC
>>  	pathsep = ;
>
> I think this an obviously good change even outside this series.

Thanks; I think this one makes sense.
