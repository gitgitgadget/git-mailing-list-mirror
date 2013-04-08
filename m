From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 08 Apr 2013 11:46:46 -0700
Message-ID: <7vwqscx3l5.fsf@alter.siamese.dyndns.org>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
 <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
 <20130408005155.GA24030@sigill.intra.peff.net>
 <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
 <20130408023351.GA32558@sigill.intra.peff.net>
 <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
 <7vtxngyl30.fsf@alter.siamese.dyndns.org>
 <CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:46:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPH5l-0003XT-OP
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935445Ab3DHSqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:46:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759936Ab3DHSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:46:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C055D14190;
	Mon,  8 Apr 2013 18:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LQnpOzmxXQ1myIlOHz888c11U2M=; b=oeYMTo
	lk7JcDScitnoOuXLd2iT/dZwlCKkjsnxZgH9duzUcKlqtC6mwPFH9+EiEHgbmQvp
	9roqhDXWyUlXawVEsth4quQ5mNBz3ldCmZ+2y9XB33KXpy3Z3YvB7+mcAeXJEX0W
	z4kjDWlhJ613krJ+fTzlOamAmH2JSTXiW7Eeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i/AzXceHS2ymvTTAG5MgmZBovelPootE
	ue5cMb8ktdqRuuk9L8UpwegttCqLMaV6tphgVPqSMMVfLoAADg10RI+YRqLTtmoQ
	txHZH/Z8T7T5OtXPcCpO/7mt30rm7Qsi9TAGPgJjBR4bP/k2zBIcOSZLlXHydOEQ
	wvTIob1imxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B75D61418E;
	Mon,  8 Apr 2013 18:46:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8FAA14189; Mon,  8 Apr
 2013 18:46:47 +0000 (UTC)
In-Reply-To: <CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 8 Apr 2013 13:31:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAFF84FC-A07C-11E2-B965-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220490>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I'm not talking about the time it took to come up with the criticism
> below, I'm talking about the comment regarding the commit message. If
> the commit message did indeed provide *zero* explanation, that's
> certainly something that should be immediately visible, no? It could
> have been mentioned six months ago.

Given that all of your log messages tend to be missing or terser
than necessary, I wouldn't be surprised Peff stopped bothering about
it.

But now we know this needs to be better explained, and your v4 has
better explanation that will help you avoid having to repeat
yourself in the discussion, so let's not dwell on it too much.

>> ...  But if we keep
>> helper running, who will be communicating with it via these open
>> pipes?  The process that is calling finish_command() on fast-import
>> and disconnecting from the helper won't be, as read/write to the
>> pipe, even if we do not disconnect from here, will result in errors
>> if the helper has already exited at this point.
>
> Nobody will send any further input, but in theory we could redirect
> the pipe and send more commands. That's how it was designed.

Who does the redirection to whom?  How would the process tree and
piping constructed around the current system?

I am not trying to say it is just theoretical mental exercise (which
I have seen you do not do at all on this list). I am trying to find
out what the practical use case is that you have in mind, because
disconnecting will prove to be not an improvement but a regression
for that use case.  But you do not have to answer this question
directly, because...

> And in fact, I'm thinking doing exactly that, so we can send another
> command to fetch the foreign commit ids and append notes with them.

...we will see the answer in that change anyway.
