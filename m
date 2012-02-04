From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Push from an SSH Terminal
Date: Fri, 03 Feb 2012 23:47:11 -0800
Message-ID: <7vwr83hwg0.fsf@alter.siamese.dyndns.org>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
 <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
 <CAG94OYxbOYCjd5qNBh8EF2gyezHWMqX1-R2MYgk8gkFYcrMjuQ@mail.gmail.com>
 <34592.38.96.167.131.1328289027.squirrel@mail.lo-cal.org>
 <20120203213654.GD1890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	Neal Groothuis <ngroot@lo-cal.org>,
	Feanil Patel <feanil@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 08:47:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtaLA-0002n7-5M
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 08:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab2BDHrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 02:47:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab2BDHrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 02:47:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2AD23B0B;
	Sat,  4 Feb 2012 02:47:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5sXPnCo5jCo8toXxP7Vyhryb+7c=; b=FiWnf0
	v8EW/7vYLKXWTdICUZ2Zu+HI5CJKsgcuOkzX7n+ps8d8AeuEl4GUEgccBzUd4X5A
	s9LYv6xbb79KHk8hLYE7LjGwG5FUuBASJZtbvjJZXZhzt4wi6yBRY9zLk3nT+P+u
	+kVqMf8VNeF+JzXKKreVQK9N3M1p39krMA0ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hgRatdLbDd4lflkHzWznrWScKQUNPjgR
	tuMEzN+VVyXnE0HSRQcaZOEjtCEnniT7bhP0mmvcEm0LGBf/sDhSmu3gg73vv+KK
	F4KMBghk9/PJpNeSloUyrXXBpHbGHZUEbxaRlDrtjsGRKN9/JHBrL0YoHC6PFCUv
	DG7jIym9/jg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA2D43B0A;
	Sat,  4 Feb 2012 02:47:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67D073B08; Sat,  4 Feb 2012
 02:47:13 -0500 (EST)
In-Reply-To: <20120203213654.GD1890@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Feb 2012 16:36:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 738897EA-4F04-11E1-9BBB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189856>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 03, 2012 at 12:10:27PM -0500, Neal Groothuis wrote:
> ...
>> Check to see if the GIT_ASKPASS and/or SSH_ASKPASS environment variables
>> are set, and if the core.askpass config variable is set.  If any of these
>> are set, unset them.  Git should fall back to a simple password prompt.
>
> Hmm, yeah that is likely the problem. I was thinking git would fall back
> to asking on the terminal, but it does not. We probably should.

How well would it mesh with the goal of the ss/git-svn-prompt-sans-terminal
topic, which is now stalled [*1*]?  I do not mean this change and the other
topic textually conflict with each other---but the philosophies of this
topic and the other one seem to conflict.  Not falling back to the terminal
that is not available and failing the command outright might make more
sense.

I dunno.

[Footnote]

*1* Will the topic see any action soon?  I am inclined to throw the topic
into "not even the original author is not interested" category otherwise.
