From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2012, #06; Wed, 23)
Date: Thu, 24 May 2012 10:01:55 -0700
Message-ID: <7vlikhy0l8.fsf@alter.siamese.dyndns.org>
References: <7vmx4yzgce.fsf@alter.siamese.dyndns.org>
 <4FBDC8FA.9050501@lsrfire.ath.cx> <4FBDCE26.1080904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 24 19:02:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXbQK-0001t7-0M
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 19:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933757Ab2EXRB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 13:01:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549Ab2EXRB6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 13:01:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 248F88F10;
	Thu, 24 May 2012 13:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gmtPzQFSzM1q
	ewOUeFY1ARjl9IQ=; b=t0pg4dLILWuJKHAHmdqFRhfZPXv31qWwFuje9sfEGi6A
	hAs69njaW98GzfF0lXZbP2Vkc+mT7/mTQ7ev3bxRA/j/ncFh53lWWW7oEGDHXoJ3
	f9caf3P542VE+SNg/nM/EcfEklrDkYXM8HnM5J8W9T/cuWlXjTvgr8lf1/4TrFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KUpMRx
	gnXSeJlUfyW4omwemV2Q3cmQWUu044U1aOpfHfHzsGugwXlQD/Uqq8K6agA5H+cs
	ggCyBpuUc1+79sgU+Yu9+aI7CpRs5DLxvpQOggy4rEA7qkEuz7+INmZXbkeQxE4+
	zkuHBma7Lz36eSbAoTLWzKb56rh8hLFuQL3yk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16E5F8F0F;
	Thu, 24 May 2012 13:01:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7163E8F0C; Thu, 24 May 2012
 13:01:57 -0400 (EDT)
In-Reply-To: <4FBDCE26.1080904@viscovery.net> (Johannes Sixt's message of
 "Thu, 24 May 2012 07:59:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BCA975E-A5C2-11E1-870F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198393>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/24/2012 7:36, schrieb Ren=C3=A9 Scharfe:
>> Am 24.05.2012 00:24, schrieb Junio C Hamano:
>>> * rs/maint-grep-F (2012-05-21) 4 commits
>>>    (merged to 'next' on 2012-05-23 at b24143c)
>>>   + grep: stop leaking line strings with -f
>>>   + grep: support newline separated pattern list
>>>   + grep: factor out do_append_grep_pat()
>>>   + grep: factor out create_grep_pat()
>>>
>>> "git grep -F", unlike the case where it reads from a file, did not =
treat
>>> individual lines in the given pattern argument as separate patterns=
 as it
>>> should.
>>=20
>> This is not specific to -F; grep(1) accepts newline-separated patter=
n
>> lists with -E etc. as well, as does git grep with the patches above.
>
> Shouldn't we worry that this change breaks existing users?
>
> Consider a script that generates a pattern that sometimes contains NL=
=2E
> Yes, it would not match anywhere, but what if that is a deliberate ch=
oice
> of the script writer? With this change, the script would now observe
> spurious matches where earlier there were no matches.

While I prefer to be conservative, and the scenario above may be
theoretically possible, I personally find this particular "breakage" of
backward compatibility is very well defensible, as the original behavio=
ur
is clearly buggy and unintuitive.
