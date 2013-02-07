From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Thu, 07 Feb 2013 11:35:17 -0800
Message-ID: <7vd2wb7w96.fsf@alter.siamese.dyndns.org>
References: <201301271557.08994.tboegi@web.de>
 <5113F1B1.3010102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, j6t@kdbg.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:35:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3XG4-0003n8-8P
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 20:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182Ab3BGTfV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 14:35:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758962Ab3BGTfU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 14:35:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3C64D256;
	Thu,  7 Feb 2013 14:35:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/RvWSgHN7np1
	us1SzCW5Hn6zuGA=; b=XKPlPkNDaDZv4tU45ahmlpVXr8tiKCes6mOoN3gWsatg
	Z8+ULxMRbRFeJg/bnc2NmNONwIzWQHAXitpDFl/SVp9vsWLUX+cuDxXMrbBB8Kc6
	XTt5NOnReVSJn514vhLNGpPw8pRirDfcJPug/PiI1PcyQ/+3pXmKBTZprhCLSB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OtGeu2
	gCg330UWv52XOdWXMm/cR0iAihLk5K87d9VyIXUwM+zNN+KDabAhNc66gzHWYtzH
	rgthOLMRYimbrEWnFxod925NsIvRgRsd8+Ypoa4L+5E3GsHgf4gf1yNjuPu6EVF6
	foKIELz9atJf2ZHWOr0QG2/pkNFl3mmk/OwkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E76D5D255;
	Thu,  7 Feb 2013 14:35:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FE33D252; Thu,  7 Feb 2013
 14:35:19 -0500 (EST)
In-Reply-To: <5113F1B1.3010102@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Thu, 07 Feb 2013 18:25:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 818433D2-715D-11E2-92DB-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215716>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Torsten B=C3=B6gershausen wrote:
>> t0070 and t1301 fail when running the test suite under cygwin.
>> Skip the failing tests by unsetting POSIXPERM.
>
> t1301 does not fail for me. (WIN XP (SP3) on NTFS)

Others run Cygwin with vfat or some other filesystem, and some of
them do not cope will with POSIXPERM, perhaps?

Not having POSIXPERM by default for Cygwin may be a saner default
than having one, if we have to pick one.

It may be debatable to have this default as platform attribute,
though.

>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>>  t/test-lib.sh | 1 -
>>  1 file changed, 1 deletion(-)
>>=20
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 1a6c4ab..94b097e 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -669,7 +669,6 @@ case $(uname -s) in
>>  	test_set_prereq SED_STRIPS_CR
>>  	;;
>>  *CYGWIN*)
>> -	test_set_prereq POSIXPERM
>>  	test_set_prereq EXECKEEPSPID
>>  	test_set_prereq NOT_MINGW
>>  	test_set_prereq SED_STRIPS_CR
>>=20
>
> So, I'm not in favour of this, FWIW.
>
> ATB,
> Ramsay Jones
