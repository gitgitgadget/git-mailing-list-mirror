From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 13:02:12 -0700
Message-ID: <7vli87bsu3.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<20130424164003.GB4119@elie.Belkin>
	<7va9ones4p.fsf@alter.siamese.dyndns.org>
	<20130424192339.GH29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 22:02:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5tT-0002BR-RD
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546Ab3DXUCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 16:02:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757480Ab3DXUCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:02:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B7C919B14;
	Wed, 24 Apr 2013 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/05V1jOC4dInvgiwa7ii3sA6cMk=; b=oU1hH9
	nzmKCF1rFOx3IIKaiTozFy3hCQTW4IiQ6X1eePixrvDkHPY/kbFm7Fb4l+8EdRvK
	XskUpxhhhmABLVfEWVDdxd2cK66JcIpyojJtkgZ0lL//rzkaEHN71EH0vN+S+NOR
	bjnL4Ro1MRx82X+F1jRmR7uM5NfEXAx64jbFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RmYTEnqzRS9t2biuxjG529b3SbThbZ4v
	rDt+5wIpCwKn74e0yQwn3i8hffZhZtwTx9bcPP5+6gqWpyBjvtRR9md2i4QjLYFN
	p6mW4OQypzXkfhXHyTxbSxhMcy2G57LvcGUc8xuPpvj2IsMFUI5igetAo2TFAz8t
	wFNATOROon8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDB219B13;
	Wed, 24 Apr 2013 20:02:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B180A19B11;
	Wed, 24 Apr 2013 20:02:13 +0000 (UTC)
In-Reply-To: <20130424192339.GH29963@google.com> (Jonathan Nieder's message of
	"Wed, 24 Apr 2013 12:23:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB2B1FCA-AD19-11E2-8676-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222314>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> And it does not match "git log origin...HEAD" which gives both sides
>> of the symmetric difference of the history.  To match it, you have
>> to say "git log --right-only origin...HEAD" or something.
>
> I tend to use --left-right.  All I meant is that with both diff and
> log, ... is a way to get something meaningful when my history and
> someone else's history have diverged.
>
> I agree that it would be easier to explain if there were some
>
> 	git diff --from-merge-base A B

Yeah, I am not strongly opposed to have something like that, and
having a shorter (but not a single letter) option name might make it
more attractive than A...B at least to new users.

> We could say that "git diff A...B" is a mostly meaningless shorthand
> for that.

You may remember but this is not the first time we discussed that
three-dot in log and diff mean different things.

Instead of saying "meaningless", I think in the past discussion the
explanation given was that three-dot means different things between
the context to specify a range (i.e. a symmetric difference) and the
context to specify two endpoints (i.e. base and right end).

Which by the way is nothing new.  "A" means the entire history
leading to the commit "A" in the context of specifying a range, and
the same "A" means a single commit "A" in the context of specifying
a revision.
