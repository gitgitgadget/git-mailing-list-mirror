From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Wed, 01 May 2013 15:54:52 -0700
Message-ID: <7vfvy648g3.fsf@alter.siamese.dyndns.org>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-2-git-send-email-artagnon@gmail.com>
	<7va9oe5y6k.fsf@alter.siamese.dyndns.org>
	<CALkWK0nL+UvjsUKh6v4x_MaWJmsU6Uh_gh82iE7UT0UE-ZMt0g@mail.gmail.com>
	<20130501211613.GA15392@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 02 00:55:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfvQ-0002LT-KI
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757786Ab3EAWy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:54:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757467Ab3EAWyz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:54:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C92791BEF8;
	Wed,  1 May 2013 22:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rlkpzO23ETCwk+/xEg052X3SkUQ=; b=VJxlC5
	iOR3cUJh3iSCqMPGbmi6DQSpqwF6eKEE9BuLiAUd/y5gjiXpR1MXOzNIpdqs383V
	tljk6kj1Ij/fIOK0rOYYJXmzDjMkY7Huez9n+gYwH9/eNfLdImHbX/Kzj9jUgFXs
	0gdr3M5wR5mhDVcv7oVcjRL8AJu/40IDO6Xqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GRy7LgJLyZmDM870cEPGaLN4pwEiDz5v
	s7SCXv5AQThxxLA/jyOJIqpkj7mC8hXTEQJo4kTD8gB+5Id3D7k7nYO7kpYJsr6Z
	rk6z8c/o17qGrokQMhyhyPP2BzhLmyrUU93bdDYizlt3/L5ngZUsqnZzJdMLhn4p
	2v7yvnHbkQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFF901BEF7;
	Wed,  1 May 2013 22:54:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 380261BEF4;
	Wed,  1 May 2013 22:54:54 +0000 (UTC)
In-Reply-To: <20130501211613.GA15392@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 1 May 2013 17:16:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2366B5CC-B2B2-11E2-9F01-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223161>

Jeff King <peff@peff.net> writes:

> On Thu, May 02, 2013 at 02:34:01AM +0530, Ramkumar Ramachandra wrote:
>
>> Junio C Hamano wrote:
>> > Just making sure.  HEAD@{$n} and @{$n} for non-negative $n mean
>> > totally different things.  @{0} and HEAD@{0} are almost always the
>> > same, and @{1} and HEAD@{1} may often happen to be the same, but as
>> > a blanket statement, I find "Since HEAD is implicit in @{}" very
>> > misleading.
>> 
>> When will they be different?  I'm looking at this from the parser's
>> point of view: when the part before @{} is missing, we dwim a "HEAD".
>
> The difference is that HEAD@{} refers to HEAD's reflog, but @{} refers
> to the reflog of the branch pointed to by HEAD. For example, try:
>
>   git init repo && cd repo
>   git commit --allow-empty -m one &&
>   git commit --allow-empty -m two &&
>   git checkout HEAD^ &&
>   git commit --allow-empty -m three &&
>   git checkout master &&
>   for i in 0 1 2; do
>     echo "HEAD@{$i}: $(git log -1 --oneline HEAD@{$i} 2>&1)"
>     echo "    @{$i}: $(git log -1 --oneline     @{$i} 2>&1)"
>   done
>
> which produces:
>
>   HEAD@{0}: 1fbb097 two
>       @{0}: 1fbb097 two
>   HEAD@{1}: 42f3f4d three
>       @{1}: 1089d0e one
>   HEAD@{2}: 1089d0e one
>       @{2}: fatal: Log for '' only has 2 entries.
>
> Unless your reflogs are screwed up, the 0th reflog should always point
> to the same commit (since you just moved HEAD there), but beyond that
> there is not necessarily any relation. And even for the 0th reflog
> entry, the reflog information is not the same. Try this on the repo
> above:
>
>   echo "HEAD@{0}: $(git log -g -1 --format='%gd %gs' HEAD@{0})"
>   echo "    @{0}: $(git log -g -1 --format='%gd %gs'     @{0})"
>
> which yields:
>
>   HEAD@{0}: HEAD@{0} checkout: moving from ... to master
>       @{0}: master@{0} commit: two
>
> -Peff

Thanks for helping with a basic education I found no time for
myself today.
