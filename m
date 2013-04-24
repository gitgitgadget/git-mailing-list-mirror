From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 10:49:10 -0700
Message-ID: <7va9ones4p.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<20130424164003.GB4119@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:49:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3ok-0007FV-BV
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab3DXRtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:49:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756673Ab3DXRtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:49:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF4619D3C;
	Wed, 24 Apr 2013 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FfyXPdqyD1Ii19w6vEarmQj4PxE=; b=CbYDtP
	Uvwn67odDkjFBoASEXcgSecRLIozyvc2KWtXx5KzAgaFtIW07WqZufEe/ntF2uiQ
	uSn7qqMd/q/SA/AHz5kk1CftNPXXZssqAyu3BovHlAzVBD54IEk4rqI5EZOBPA2d
	2397Dk7fWqad2i/tgblhtMeKzTY9pFpva26GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A9Q4xRT8VYrM4zO0+isSARk47k0Nnh8x
	61Ri3fSKkO7spq2ARfOrmL2SusSZGW0UZt+IWlTbrKxsCF7PJDmcrOcdNusLrUhV
	Lmnks60vkCTHWcI2lqQ4yYmq3D0Gn1MZyf1JU3JGsxZ/YXnOA+PjbN6+UHvAdMtC
	WWBMGnzykws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72FA619D3B;
	Wed, 24 Apr 2013 17:49:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3B5E19D3A;
	Wed, 24 Apr 2013 17:49:11 +0000 (UTC)
In-Reply-To: <20130424164003.GB4119@elie.Belkin> (Jonathan Nieder's message of
	"Wed, 24 Apr 2013 09:40:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 459BFC20-AD07-11E2-863F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222279>

Jonathan Nieder <jrnieder@gmail.com> writes:

> What would it mean for A..B to be treated as a revision range?

Nonsense is what it means ;-)

> Suppose I do a revision walk and come up with the commits x, y,
> and z.  What is the resulting diff?
>
> The common syntax is just a mnemonic: in the same situations as I
> might use "git log A...B", it can be handy to use "git diff A...B".

I wish it were the case, but a very common complaint that I agree
with is that

	git log origin..HEAD

is a way to show what *I* did since I forked, while saying I am *not*
interested in what they did in the meantime.  And

	git log -p origin..HEAD

is a way to view the same history as a series of individual patches,
while that output would not match what you would get from

	git diff origin..HEAD

It would be much closer to

	git diff $(git merge-base origin HEAD) HEAD

which is very often useful and got its own short-hand "origin...HEAD".

And it does not match "git log origin...HEAD" which gives both sides
of the symmetric difference of the history.  To match it, you have
to say "git log --right-only origin...HEAD" or something.
