From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 01/11] Documentation: document post-rewrite hook
Date: Tue, 16 Feb 2010 16:29:13 -0800
Message-ID: <7v4olgvh5y.fsf@alter.siamese.dyndns.org>
References: <cover.1266361759.git.trast@student.ethz.ch>
 <8ee58b83a10dcb302a33136768039729fbebae53.1266361759.git.trast@student.ethz.ch> <7vd404zq88.fsf@alter.siamese.dyndns.org> <201002170118.53639.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:29:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXnJ-0001nu-Pl
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678Ab0BQA32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 19:29:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933399Ab0BQA31 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 19:29:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09B829A4B7;
	Tue, 16 Feb 2010 19:29:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qyNGXwz3gzNK8wFa+IRSI/Mw6ww=; b=n0rKlE
	Nwnt+Do4gNrFMpM9F2hNuBDuvIZ/QN+zfBTXaPDfTRk3DTfk2p9jNJde+WgDLvvm
	vK2eiGSaiQnEpeOWJ9kOZ1N2yTv7da2zLaHJ7/FbnvlfYofykJGk7g7HhZRhihmW
	WQ+/gHU9esjenDr2ixIUcEBG8BN0aXxqbEwUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vWrxXkwgdGg9dobk0xpOchjLG3HnmmWk
	IddyKNtJHMaqzpBok1ZH8VoEpyve0Rdqh7G9DXmESOJeDXWJAPi9HEdY7SbObmjc
	sdiLVTtZmcHuttZwnfqZLbnm8mIdHAJk4+oJ3oxO1Ehn2Y/kt0NzIBzrmemPRVob
	KZK1Gj6sCUQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8A659A4B6;
	Tue, 16 Feb 2010 19:29:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A72119A4B5; Tue, 16 Feb
 2010 19:29:14 -0500 (EST)
In-Reply-To: <201002170118.53639.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 17 Feb 2010 01\:18\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7CFB81E0-1B5B-11DF-8529-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140192>

Thomas Rast <trast@student.ethz.ch> writes:

> On Wednesday 17 February 2010 00:59:51 Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>> 
>> > +rebase::
>> > +	For the 'squash' and 'fixup' operation, all commits that were
>> > +	squashed are listed as being rewritten to the squashed commit.
>> > +	This means that there will be several lines sharing the same
>> > +	'new-sha1'.
>> 
>> Similar to filter-branch being silent on dropped commits, I presume
>> "rebase -i" will stay silent if a pick is removed, or rebase --skip is
>> given.
>
> Indeed.  Due to the way that rebase works, it would be a hassle to
> report '00..00' (or so) for dropped commits, so I'm not too keen on
> going there.  (My intended use-cases don't require it.  Do you have
> one that does?)  Documenting this absence wouldn't hurt though.

I was solely interested in the documentation at this point.  I don't see a
reason to report "old -> nul"; somebody else may, but I don't.

>> Is the order of input lines guaranteed in some way?  For example, if I run
>> rebase to make A B C into A' and B+C, do we get these three lines:
>> 
>> 	A -> A'
>>         B -> B+C
>>         C -> B+C
>> 
>> in some known order?  If so, should we document that order?
>
> Currently they're in the order that they were rewritten, but what
> would the hook learn from that?

For example, a user may say "I _always_ make a big commit that describes
everything at the beginning, and then follow-ups are irrelevant", in which
case the user may want to say "notes for B carries to B+C but discard
anything attached to C" in _his_ hook.

Another example.  A build-bot may attach "builds fine" note to C but B may
have "failed to build" note without the fix-up in C.  B+C will want to
have the "builds fine" note from C (you would probably also need to verify
that C^{tree} == (B+C)^{tree} before moving the note, but the point is you
do not even want to consider moving it from B to B+C).

These become possible if the output at least guarantees topological
ordering for things that are squashed into one.

But again I am just thinking aloud.  I don't know how much benefit will
such a guarantee give us in practice.
