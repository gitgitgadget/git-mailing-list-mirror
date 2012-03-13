From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Tue, 13 Mar 2012 15:54:26 -0700
Message-ID: <7v62e8t8m5.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <7vfwddskon.fsf@alter.siamese.dyndns.org>
 <20120313213045.GD27436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 23:54:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7abz-0006FP-KR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 23:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760411Ab2CMWya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 18:54:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760333Ab2CMWy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 18:54:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A2D17DCC;
	Tue, 13 Mar 2012 18:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TzmnyN+m/Axj33XRlJusKmN0CYk=; b=gUx3jl
	YU9AtrCK3Zzi+PrlZVTOirhXTDDTqH1NRTllzzUXSmwbN/Fv7p7F9lqMrO2MQzk0
	G7S4Zl5nx2VzVrb6sfba/7+o4nl0q8ebAYiOVP5RonMYjZn7+oKdOylR65j1i5jR
	RdGvJuySav3kjaWMGYO/4pKu7OYRWGdhCL66g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nniJFbpjNXYfLXzJu1m6Ia5/Ye/xYtAB
	ApV7dghOrIFeB10DK88KlTRBxQ8EC9MtnTYJ4czw2OsWaf2WdhyFTPhpLAPiPNqH
	e8DgCkQhZo3MiwTxRfqj1GuQAMKiXi50Y6XMoRtDqhW4mUnrbkol80Y/Ggo/PcXr
	DOj+5nfbgL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0D8C7DCB;
	Tue, 13 Mar 2012 18:54:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 586977DCA; Tue, 13 Mar 2012
 18:54:28 -0400 (EDT)
In-Reply-To: <20120313213045.GD27436@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Mar 2012 17:30:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CF7B67A-6D5F-11E1-9212-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193077>

Jeff King <peff@peff.net> writes:

> The branch.*.pushRemote you mentioned would help with that. But for me,
> I would much rather have simply push.defaultRemote.

I would think that is a natural way to extend it. Don't we already have
something similar that is per repository default that can be overriden
with per branch configuration?

> Speaking of which, I often get annoyed at the per-branch
> auto-configuration of upstreams. For example, I find myself doing this:
>
>   [get an idea, read a bug report on the list, etc]
>   $ cd git
>   $ hack hack hack
>   [oh, this is turning into something real. Let's make a branch]
>   $ git checkout -b jk/bug-fix
>   $ git commit -m 'fix bug'
>
> but now my bug-fix branch is based off of wherever I was (which is
> usually some private topic-integration branch I run most of the time).

What in "checkout -b jk/bug-fix" makes jk/bug-fix a downstream of
origin/master?  I admit my brain is not working very well today, but I
would have expected the branch to have either your local private topic
integration branch as its @{u}, or no @{u} defined for it at all.  Perhaps
there is a design error of some sort around that code?

> Which makes me wonder if perhaps people are using "upstream" to mean
> several different thing. I use it to say "this is the branch that this
> topic is based off of", which makes "git log @{u}.." helpful, "git
> rebase -i" just work, and gives some meaning to the ahead/behind message
> (it shows how my topic relates to the main project).
>
> But I think people also use upstream to mean "this is the definitive
> version of this branch in some central repo". So they would say that
> "jk/bug-fix" is based on "origin/jk/bug-fix". And the ahead/behind
> message is about "do I have any local work that needs pushed, or any
> remote work that needs pulled?"

I think that is the more common interpretation.  Earlier you said
ahead/behind gives "some meaning", but compared to this "how many more do
I have, how many more do others have while I was looking the other way", I
am not sure what kind of cue that "some meaning" would give us.

> And I wonder if this is where some of the debate for
> push.default=upstream comes from. Whether that is useful to you or not
> would depend on how you set up your branches. In the latter model, I
> would think pushing to the upstream would be the right thing.

No question about the conclusion in the last sentence, but at the same
time, I do not think the push.default is about making things work smoothly
for people who configure everything right.

>> Because "upstream" is meant to be "For the branch I am on, you know
>> how the branches map between the remote repository, so you already
>> know what the right thing to do---do it" mode, the correct "guess"
>> in your case is to error out and say "Nah, you are not talking with
>> your upstream, so I do not have any clue what branches you want to
>> push out and how. As you said that the push.default is upstream, not
>> matching, I refuse to even do the matching push in your case.  This
>> is an error. Be more specific".
>
> Yeah, I agree that is the only sane thing to do.

Perhaps this can be a good sample entry for the experimental "tracker"
thing to keep track of to see how the workflow will evolve around it;
unless neither of us would get to work on it immediately, it is very
likely to be forgotten, as this is a tangent in the overall discussion,
even though the bug is real and solution is clear.
