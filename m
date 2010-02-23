From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix a signal handler
Date: Tue, 23 Feb 2010 13:48:20 -0800
Message-ID: <7vmxyzfwt7.fsf@alter.siamese.dyndns.org>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de>
 <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net>
 <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net>
 <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de>
 <7veikib96d.fsf@alter.siamese.dyndns.org> <4B82744B.4060805@web.de>
 <7v1vgdgm02.fsf@alter.siamese.dyndns.org> <4B839811.6040109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:48:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2cM-00056c-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab0BWVsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:48:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab0BWVs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:48:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FBE99CE6E;
	Tue, 23 Feb 2010 16:48:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zUJ3QBFHlKu8QDcD35cBtq174ao=; b=o/bfzB
	0cSAWOH1VlPQWb97gUTsoAL9XBEIAcb+3pnrOrv97WEbpKeKnUWnFMooVRSPImsa
	2NbZ1xJzzhoHPL6VxHYrF+7UelmrBg7W/lcBgib3oVKqMp5MllaG/5lTTBw6Z0D+
	QVeWpKk+7DneCRRIy4pLdxZYYA6lcLCHeqduo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgrQIeQAC2oxF8XFgTMRwMWpgIeSLtt3
	ao8ywu+RhFjqN09ds0rlVaROvhixQLeU9wu2Z8vR6VIMRR1OqTHr99CL2ntKpkAa
	qicgy1bdYl1/iqHQwf0eJQ0c+lFbd1nLQvwKhYkdX6G8ULuHgdKTBMgGBVcHeWBs
	QVvRfK0+1iA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BAB59CE69;
	Tue, 23 Feb 2010 16:48:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D0709CE68; Tue, 23 Feb
 2010 16:48:21 -0500 (EST)
In-Reply-To: <4B839811.6040109@web.de> (Markus Elfring's message of "Tue\, 23
 Feb 2010 09\:55\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B7489F6-20C5-11DF-88A4-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140846>

Markus Elfring <Markus.Elfring@web.de> writes:

>> According to POSIX, "s-e-o" has to be "volatile sig_atomic_t".
>
> How do you think about informations from a discussion on a topic like 'Is
> "volatile sig_atomic_t" redundant'?
> http://groups.google.de/group/comp.lang.c/browse_frm/thread/da3118a2d2c0737c/718dc093b83e03f8?#718dc093b83e03f8

Honestly I don't care; you are the one who are interested in being
pedantic, and you are welcome wasting your time on that endeavor.  Don't
ask me to waste my time by joining your mental masturbation.

>> Also we do not explicitly initialize bss variables to zero or NULL.
>
> If we would like to insist on the implementation of a strictly conforming
> program,...

We don't.

The thing is, we do not like to insist any such thing.  We are practical
bunch who are interested in getting git work well on real platforms used
by real people.  Portability across platforms people care about is one of
the goals and standard conformance for us is merely a tool to achieve it.

Name one platform you tried to port git to and had trouble with because
the platform did not initialize variables in bss segment to zero, or
perhaps on that platfor NULL had a bitpattern different from all zero, and
after you initialized them explicitly to zero or NULL, you managed to make
everything work perfectly.

Name one platform you actually got a segfault in the early-output codepath
on it, because a function pointer on that platform is not of an atomic
type, and the assignment from show_early_output to show done in
limit_list() picked up a pointer half-written by the signal handler, and
we ended up calling a garbage address, and you managed to make everything
work perfectly with your fix.

Just name one.

Standard conformance by itself is never a goal for us, unless it helps to
solve real world problems.  And until you understand that, you wouldn't
understand why this patch deserves to be labelled with "pedantic fix".
