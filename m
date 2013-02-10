From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git prompt
Date: Sun, 10 Feb 2013 14:54:02 -0800
Message-ID: <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@MIT.EDU>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fn8-0002LO-Go
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab3BJWyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:54:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997Ab3BJWyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:54:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BAF1C954;
	Sun, 10 Feb 2013 17:54:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K4SLab1ZPvH3sx+due0GuHo5aoo=; b=LNVCut
	iWV5PMSqQZx8m22JljRLn2KWxVGANNH6PnTDSsVCus62p6m0kErhmAsVewtzpb8p
	zSr+bl6qWCBpjhsHkyt0iB5174zPSUmRYh+rWwLntOwQzM202aQpPs8zSWVrs6uy
	oYQy4gHd7jHsdUfX/Hw4nldOEp+5DKWRxHOUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C9JBuvX+3bWZrohsAE7RfYKl4k78nnyt
	h6Uh3cLADELde98hSJ5hEhaQzKr8Wk9Kw/RGo8aZfUjtC0mErTxSevsS6WvNVeS5
	Cpd4ai1/3IUgWmVpn137EDlQ9DtCaBDI83r8OWj8jE72kTik/TdVQh+j5oyvZoAO
	qc9CvwtXpw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E1C3C951;
	Sun, 10 Feb 2013 17:54:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81B92C940; Sun, 10 Feb 2013
 17:54:09 -0500 (EST)
In-Reply-To: <20130210224345.GA32318@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 10 Feb 2013 17:43:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7BAB014-73D4-11E2-9AFF-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215966>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 10, 2013 at 01:25:38PM -0800, Jonathan Nieder wrote:
>
>> Ethan Reesor wrote:
>> 
>> > I have a git user set up on my server. It's prompt is set to
>> > git-prompt and it's git-shell-commands is empty.
>> [...]
>> > How do I make the git user work like github where, upon attempting to
>> > get a prompt, the connection is closed?
>> 
>> I assume you mean that the user's login shell is git-shell.
>> 
>> You can disable interactive logins by removing the
>> ~/git-shell-commands/ directory.  Unfortunately that doesn't let you
>> customize the message.  Perhaps it would make sense to teach shell.c
>> to look for a
>> 
>> 	[shell]
>> 		greeting = 'Hi %(username)! You've successfully authenticated, but I do not provide interactive shell access.'
>> 
>> setting in git's config file.  What do you think?
>
> I think something like that makes sense. To my knowledge there is no way
> with stock git to customize git-shell's output (at GitHub, that message
> comes from our front-end routing process before you even hit git-shell
> on our backend machines).
>
> The "username" in our version of the message comes from a database
> mapping public keys to GitHub users, not the Unix username.  But I
> suspect sites running stock Git would be happy enough to have
> %(username) map to the actual Unix username.

Yeah, that greeting is cute---I like it ;-)
