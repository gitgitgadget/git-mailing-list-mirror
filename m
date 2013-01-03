From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] NetBSD 6?
Date: Thu, 03 Jan 2013 08:17:58 -0800
Message-ID: <7vvcbew895.fsf@alter.siamese.dyndns.org>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
 <rmipq1numzj.fsf@fnord.ir.bbn.com> <7vd2xnypt6.fsf@alter.siamese.dyndns.org>
 <rmi8v8av05d.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 17:18:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqnUs-0003or-6u
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 17:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab3ACQSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 11:18:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37648 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab3ACQSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 11:18:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7035DAC53;
	Thu,  3 Jan 2013 11:18:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+SLmpEupAmn6qbBXEsxKT2aKa+A=; b=bzLZ3V
	VUjLd9sDc+q6TFOvCHBN/7KSQoqNutqUfbicg0s6Bcptuz8wNo8GR3L8XHzm6OHh
	Igto3rsKAjzlnusPfKU3RLfbvmMsGAwhVH9dBsmD8GSG0ci4qR6g18CG6feegLUK
	iFNMaiiaRGmtsDzs0yuo/goha8x+gmPkYUQjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YzVycq1PUVGP6F3wIbyIvBTDh7+ZNJD7
	x4gs6rYXo0ZbKdMXZBbp4W6OFureZ3wT8Sc8mGQy//bgxVwMIFndLcA+wjPSzyx1
	FpThr+3ZdahLXZQSIXeDV21kYE+15SgcsH5vDWq6J/8B+YQCLOfqN4HgQuwhT3hF
	Amjz0PYdCtw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 607ADAC52;
	Thu,  3 Jan 2013 11:18:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5EACAC51; Thu,  3 Jan 2013
 11:17:59 -0500 (EST)
In-Reply-To: <rmi8v8av05d.fsf@fnord.ir.bbn.com> (Greg Troxel's message of
 "Thu, 03 Jan 2013 08:58:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 241DD868-55C1-11E2-80D4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212595>

Greg Troxel <gdt@ir.bbn.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Greg Troxel <gdt@ir.bbn.com> writes:
>>
>>> I realize a README.foo file for N different systems could be clutter,
>>> but having these checked in would provide the concise help that people
>>> on any of those platforms need.
>>
>> Our Makefile documents knobs people on various platforms can tweak
>> (PYTHON_PATH and OLD_ICONV are two examples of them), sets default
>> values for them based on $(uname -S), then includes config.mak file
>> the user can optionally create to override these platform defaults.
>> This infrastructure is used across platforms, not just for NetBSD.
>
> If you have to choose a single PYTHON_PATH, the one you picked is right
> (for now, and likely will be right for a long time).
>
> But as a general rule, I think configure tests are preferable to
> OS-specific variables.

I forgot to mention that we also ship configure (and keep track of
configure.ac) so that optionally people can let autoconf machinery
to create config.mak.autogen to be included at the same place as
handcrafted config.mak in their build process.  I do not offhand
know if we do "for p in python python2.6 python2.7; do ..." kind of
thing, though.

> A large number of people on NetBSD use git, but almost all of them get
> it via pkgsrc (which is also where they get perl, emacs, svn, and
> everything else you didn't find in /usr/bin).  The exception would be
> people that want to hack on git itself.

Yeah, that much I figured ;-)

> People who want gnu libiconv can install the libiconv package from
> pkgsrc.  (I'm guessing OLD_ICONV means "POSIX iconv", without GNU
> extensions (iconvctl?).)

It refers to the type of the second parameter to iconv(); OLD_ICONV
makes it take "const char *", as opposed to "char *", the latter of
which matches

  http://pubs.opengroup.org/onlinepubs/9699919799/functions/iconv.html

> So, it doesn't matter too much for pkgsrc what you change, because it
> can be patched anyway (once, for all users).

Yes.  The values in the Makefile are fallback defaults, and matters
only to people who build from the source.
