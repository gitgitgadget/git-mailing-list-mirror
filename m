From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Mon, 20 Aug 2012 09:53:55 -0700
Message-ID: <7v4nnxld24.fsf@alter.siamese.dyndns.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
 <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
 <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
 <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
 <7v628epzia.fsf@alter.siamese.dyndns.org>
 <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
 <7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
 <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:54:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3VEr-0005Sc-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400Ab2HTQyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:54:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755514Ab2HTQx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:53:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC9F67DEB;
	Mon, 20 Aug 2012 12:53:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BC8T/HrvL9pYDL6HBot0cFqufEE=; b=nGov2o
	LR/3lfpafV02vhoU6dKOIClqhtdU/m7A6HFUVjWdDK7LCJTAUJBVBOTo/ca7MRPE
	CsSGVEe+s9SSf6nos843dO9sEeyme4dUIQHEwkhTUtjQNtnt6A52SnVZ/9nk4s85
	HpTgzKQFgxC5WPzPzwFmyeN+7ocDTwT3WFkLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BC6b5mygU0S6busyGbZG+vS6KGLf2Raq
	ASAmKwBBr1KfODVTn8l7zGgdsgpKJ7RelaXjgNYoVkdwmufQiSkdraAOaMcMPsqT
	popnOTYkz5mfHj7IWe7NGVA5XKcVy528PByniOQr7EoldNV6UQxXj2Iv8f74OylU
	4ZexbP/2yAA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9AC47DEA;
	Mon, 20 Aug 2012 12:53:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0431F7DE3; Mon, 20 Aug 2012
 12:53:56 -0400 (EDT)
In-Reply-To: <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Mon, 20 Aug 2012 18:09:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1C5B91A-EAE7-11E1-B408-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203857>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> I haven't found any other to be needed. Well, poll, maybe, but with only
> minor tweaks for the win32 one works for me (and those tweaks are compatible
> with win32
>
>> A separate file, compat/tandem/mkdir.c, is fine, though.

If you wouldn't have dozens of them, so compat/tandem/mkdir.c is not
suitable; compat/tandem.c would be good, then.

>> > I'll go for git_mkdir(), similar to other git wrappers, (like for
>> > mmap, pread, fopen, snprintf, vsnprintf, qsort).
>> 
>> Again, no.  Your breakage is that having underlying system mkdir that does
> not
>> understand trailing slash, which may not be specific to __TANDEM, but
> still is
>> _not_ the only possible mode of breakage.
>
> Well, it is the only one GNUlib's mkdir caters for and I'd regard that an
> authoritative source...

I suspect that you may be misunderstanding what compat/ is about, so
let's try again.

Platform difference in mkdir may not be limited to "on this
platform, the underlying one supplied by the system does not like
path ending with a slash".

What I am saying is that it is unacceptable to call something that
caters to that specific kind of difference from what the codebase
expects with a generic name such as "git_mkdir()".  Look at mingw's
replacement.  The platform difference over there is that the one
from the system does not take mode parameter.  Imagine that one
was already called "git_mkdir()".  Now we have two different kind of
differences, and one has more officially-looking "git_mkdir()" name;
yours cannot take it---what would you do in that case?  Neither kind
of difference is more officially sanctioned difference; don't call
yours any more official/generic than necessary.

Your wrapper is not limited to tandem, but is applicable to ancient
BSDs, so it is fine to call it as compat_mkdir_wo_trailing_slash(),
so that it can be shared among platforms whose mkdir do not want to
see trailing slashes.  If you are going that route, the function
should live in its own file (without any other wrapper), and not be
named after specific platform (should be named after the specific
difference from what we expect, instead).  I am perfectly fine with
that approach as well.

>> Squatting on a generic "git_mkdir()" name makes it harder for other people
> to
>> name their compat mkdir functions to tweak for the breakage on their
>> platforms.  The examples you listed are all "the platform does not offer
> it, so
>> we implement the whole thing" kind, so it is in a different genre.
>
> Nope, git_fopen() definitly is a wrapper for fopen(), as is git_vsnprintf()
> for vsnprintf().

I was talking more about mmap() and pread().

For the two you mentioned, ideally they should have been named after
the specific breakages they cover (fopen that does not error out on
directories is primarily AIX thing IIRC, and snprintf returns bogus
result are shared between HPUX and Windows), but over these years we
haven't seen any other kind of differences from various platforms, so
the need to rename them away is very low.

On the other hand, we already know there are at least two kinds of
platform mkdir() that need different compat/ layer support, so
calling one "git_mkdir()" to cover one particular kind of difference
does not make any sense.

Besides, an earlier mistake is not a valid excuse to add new
mistakes.
