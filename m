From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 08 Feb 2013 09:16:48 -0800
Message-ID: <7vobfu3ev3.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com> <7v38x766b2.fsf@alter.siamese.dyndns.org>
 <20130208074813.GA7337@elie.Belkin> <7v622343uy.fsf@alter.siamese.dyndns.org>
 <5114D5B0.5080906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3rZf-0007Nr-Rg
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946768Ab3BHRQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:16:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946749Ab3BHRQu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:16:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 270DAB4F3;
	Fri,  8 Feb 2013 12:16:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUAkEcwwmR5UlgjaP6pWbkBBOuU=; b=JQp6AV
	r25Qi/rjAaJru4+5GpYFPinZ5qiyPddIdPBrtZ2+ISGh4R1oLAjFOj0hwOPP1WRy
	0w+IkeEcCs1o7yED42G4y4EQPmHmZd44nenQybmtbodoxo+cZQAx0wJG2b6ze2OV
	KnnpZP6sSRtI3aM9y/5VElwvoG6JJizO7S8q4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gIMECPy6ngvI+hMPWKfYcgYZZ9bu0YLa
	RmgK+mP317FumYBbG+PYg/35J7KD/HHXgRSv3KI9HVaPhCzUtU7vew+2K6r6yiIX
	uJtZw/K/L/XcF+TzSe1AOwLQgfhBbbnpU8Fu5eGzaLRoJao/7UdbN6BCiwQOgTM9
	pqO0z6sYSEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 165F3B4F2;
	Fri,  8 Feb 2013 12:16:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85247B4F1; Fri,  8 Feb 2013
 12:16:49 -0500 (EST)
In-Reply-To: <5114D5B0.5080906@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 08 Feb 2013 11:38:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52E9DDD6-7213-11E2-8EBC-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215784>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 08.02.2013 09:16:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>>> "Wait, why did the remote rewind?"
>> 
>> Oh, I am very well aware of that glitch.
>> 
>> "git push" has this hack to pretend as if the pusher immediately
>> turned around and fetched from the remote.
>> 
>> It shouldn't have been made to do so unconditionally; instead it
>> should have been designed to give the pushee a way to optionally
>> tell you "I acccept this push, but you may not see it to be updated
>> to that exact value you pushed when you fetched from me right now".
>> 
>> The hack is not my design; it was not even something I accepted
>> without complaints, so I can badmouth about it all I want without
>> hesitation ;-)
>> 
>> More importantly, we could fix it if we wanted to.
>
> And this seems to be more natural, too. It can keep the internals (the
> auxiliary ref on the server side) hidden from the user.

Fixing that misfeature to always pretend it immediately turned
around and fetched may have a different benefit, too.

A straightforward and simple solution to Ram's original problem may
be to define pushurl to point at his publishing repository after
all, and teach "git push" not to pretend it immediately fetched with
the same "fix".

	[remote "origin"]
        	url = ... where Ram fetches and pulls from ...
                pushurl = ... where Ram pushes to ...
                fetch = refs/heads/*:refs/remotes/*
		updateTrackOnPush = no

Then "git fetch" (or "git pull") will update the remote tracking
branches Ram fetches from, and once his topic is finished, he can
push to his publishing location, which won't touch the remote
tracking branches used to keep track of the place he fetches from.
