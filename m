From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] difftool: Disable --symlinks on cygwin
Date: Thu, 26 Jul 2012 12:04:20 -0700
Message-ID: <7vhasu739n.fsf@alter.siamese.dyndns.org>
References: <1343186064-49350-1-git-send-email-davvid@gmail.com>
 <1343186064-49350-4-git-send-email-davvid@gmail.com>
 <CABPQNSZ=yWxVivadJfh9BMPtqiiGyyEL0vZu+fvsu_Zzhd7yhw@mail.gmail.com>
 <CAJDDKr4z_ddwe7s8dY80dZJMNP=75VK6NjOV0WCqFL_LDuMpBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Tim Henigan <tim.henigan@gmail.com>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:04:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuTMM-0006Dl-BN
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 21:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab2GZTEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 15:04:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab2GZTEX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 15:04:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B29568FFD;
	Thu, 26 Jul 2012 15:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+OmlgLWhYwxwFSQR6x2T3hBn3VE=; b=L0sU5u
	ozQ7/Ykf5NbFNJw6DQ/nGNU8ItmSSGhkCNNnCraN2vr8wVdRvRn7lgsvBDFBvMWo
	6YVSvEdY5yF1BM6F1q5WHCq8IpUB6cPH76+IRWaxAz+1IL43WrZ1uNJtPVDF2PjC
	xSm7JsYKbsVH6Ta19D260QfjgQexvcBbMrZZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pzd622+KmRG2qknDR+WppTxYBvbGNNCx
	fH9KYM8LYg1nkVuI1Me2AJegPbxRKb8Ae9NEZTcs0eYYMEHFIJWIvdHZBWghVK/r
	DorTMTbOM33l4RJhRKs0Br/6ZqwjPG5/i9ioZTsf/cC6g44rxjKkfaEoKPaHEIDE
	PcU0yHpxi6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0A288FFC;
	Thu, 26 Jul 2012 15:04:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0CE98FFB; Thu, 26 Jul 2012
 15:04:21 -0400 (EDT)
In-Reply-To: <CAJDDKr4z_ddwe7s8dY80dZJMNP=75VK6NjOV0WCqFL_LDuMpBA@mail.gmail.com> (David
 Aguilar's message of "Thu, 26 Jul 2012 10:39:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B57D728C-D754-11E1-B8DE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202292>

David Aguilar <davvid@gmail.com> writes:

> On Thu, Jul 26, 2012 at 4:31 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Wed, Jul 25, 2012 at 5:14 AM, David Aguilar <davvid@gmail.com> wrote:
>>> Symlinks are not ubiquitous on Windows so make --no-symlinks the default.
>>>
>>> Signed-off-by: David Aguilar <davvid@gmail.com>
>>> ---
>>> I don't have cygwin so I can't verify this one myself.
>>> Is 'cygwin' really the value of $^O there?
>>>
>>>  git-difftool.perl | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/git-difftool.perl b/git-difftool.perl
>>> index 591ee75..10d3d97 100755
>>> --- a/git-difftool.perl
>>> +++ b/git-difftool.perl
>>> @@ -291,7 +291,8 @@ sub main
>>>                 gui => undef,
>>>                 help => undef,
>>>                 prompt => undef,
>>> -               symlinks => $^O ne 'MSWin32' && $^O ne 'msys',
>>> +               symlinks => $^O ne 'cygwin' &&
>>> +                               $^O ne 'MSWin32' && $^O ne 'msys',
>>
>> I thought Cygwin supported (their own version of) symlinks? What's the
>> rationale for not using it by default there?
>
> I am not a Cygwin user so I cannot verify whether it is a good or bad idea.
>
> I have a few questions regarding symlinks on Cygwin:
>
> Do the symlinks work consistently with the Perl symlink() function?
> Can we always rely on this capability being available?
> Do all win32 filesystems support it?
> Do all builds of cygwin perl support it?
>
> If any of these answers are "no" or "maybe", then an improvement
> beyond this patch would be to perhaps support a `difftool.symlinks`
> configuration variable so that the user can tell us what to use as the
> default.

I would think it is an independent topic that can be used by people
not on Windows.  It is good to be conservative by disabling symlinks
by default.

Thanks.
