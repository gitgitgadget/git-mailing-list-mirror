From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 10:35:39 -0800
Message-ID: <7vsk8ycryc.fsf@alter.siamese.dyndns.org>
References: <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100218013822.GB15870@coredump.intra.peff.net>
 <alpine.LFD.2.00.1002172350080.1946@xanadu.home>
 <7vocjnqf5c.fsf@alter.siamese.dyndns.org>
 <5DDD89A9-900F-40AD-8F3F-F756D6E0AD6C@wincent.com>
 <20100218161843.GB11733@gibbs.hungrycats.org>
 <20100218181247.GA1052@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiBEW-0002t0-0O
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab0BRSgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 13:36:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab0BRSgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 13:36:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AC019A101;
	Thu, 18 Feb 2010 13:36:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+PYgXHZLlKTcgHnZxCfA2dFHRtM=; b=T2F2+P
	N+PGvopJBF/4fZoy7tExxWV7JHZ7urj8S6Z9DeuxqXa8CZAwjKUn1Jj3x7vPkfqg
	NsTiFGY+b1EIgQDIDVe4Lk42D4ZGrERD0y6uEEsu6I37+Dkms2QjNkK7X6rcogAW
	Oj9j8s5Q6ptiAU/9Qmut6KIl3Y9g17ruR/avE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Snih9B0h215KBbKpKb+ine8/xsFLfRMc
	N0vHL7xX3TgHtHHL9dLmnJbWBBjlDTR782IXxrJDijmfu1tR55dhF0a0NzlaHBwE
	2AgNjRo5ntp92LtjaXxYiaFJ1wQgduGfVw5LDba7/MVcWVd075Qx0VIiuJOD0eeP
	zqshZa0RRYU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BAF569A0F6;
	Thu, 18 Feb 2010 13:35:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F28CF9A0E4; Thu, 18 Feb
 2010 13:35:40 -0500 (EST)
In-Reply-To: <20100218181247.GA1052@progeny.tock> (Jonathan Nieder's message
 of "Thu\, 18 Feb 2010 12\:12\:47 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7173A066-1CBC-11DF-B1E5-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140357>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Zygo Blaxell wrote:
>> On Thu, Feb 18, 2010 at 08:27:28AM +0100, Wincent Colaiuta wrote:
>>> Shouldn't a switch that hurts performance and is only needed for
>>> insane use cases default to off rather than on?
>>
>> While I don't disagree that default off might(*) be a good idea,
>> I do object to the categorization of this use case as 'insane'.
>
> FWIW I think default off would not be a good idea.  This talk of
> insane uses started from the idea that git is not so great for taking
> automatic snapshots,...

But git is not so great for taking automatic snapshots, and that is a
fact.  You shouldn't be expecting such a thing, but more importantly, we
shouldn't be dishonest about it either.  git fanboys who spread "you can
use it to snapshot automatically" without thinking are actively doing
disservice to the users by making them even more confused.

If we make this "safety" an opt-in feature, it would give people an excuse
to claim that git _by default_ stores a corrupt object, and when they make
such a claim, they may not reveal that it happens only when they abuse git
in a way it it was not designed to be used to begin with.  And it may not
be because they are malicious, but merely because they are uninformed.

The approach to use paranoia by default is to regard "safety" as not about
protecting the users from such an abuse of their own, but primarily as a
way to protect us from potential FUD.

What Wincent suggested would work very well if there are only honest and
informed people around in the world.  People who use git as intended would
not have to do anything special.  People who abuse git for their special
use case would be very aware of the fact that they are abusing git, and
more importantly, would also be honest about it.  They would not complain
that "git will store corrupt objects by default", and just flip the option
that is designed to support their use case, and they will get their
desired result.  Everybody is happy.

But such a happy ending would happen only in an ideal world, in which
sadly we do not live in.  It is not 2005 anymore, and the risk of FUD
arising from uninformed abuses is very real.
