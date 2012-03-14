From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Wed, 14 Mar 2012 13:59:33 -0700
Message-ID: <7vsjhaoq4q.fsf@alter.siamese.dyndns.org>
References: <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <7vfwddskon.fsf@alter.siamese.dyndns.org>
 <20120313213045.GD27436@sigill.intra.peff.net>
 <7v62e8t8m5.fsf@alter.siamese.dyndns.org>
 <20120314135009.GA934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 21:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7vIL-0006vA-8l
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 21:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812Ab2CNU7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 16:59:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758550Ab2CNU7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 16:59:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 496C3614E;
	Wed, 14 Mar 2012 16:59:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ont5gSflOPfZf5UjUNQeVeKZsJI=; b=XoUCFS
	MWuLlUtqfmFKyEogHhxRX48I78533QCKjamGFWKGa/umdiQQJ0L/pQN/uNbvurOT
	eTZ1mCnj55NNKGwiCnygMJNgFe/6cdi2yaxq+GikZMKfK31VbjW8FHsWHvqnHbh/
	wuDgkGqNKDp7wu9/C4qNuZfkoy9Z1QIKumXro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2EVTD6d80ylaQ5whNQMEUuPkgZv261v
	XZ4wDAvcnUvVdtAX82Cr3RLVeTqljZDJD5Ow9gwb2tXe/BWo3jmdP0JAF8FVUK2x
	fAfGhDUnxAW6PaHBlM7ZqQEmdHpYHhMyf8jILWUBOcv9JsW6owcE5HnhAJB/TwZ2
	GVSONYGosw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 406DD614D;
	Wed, 14 Mar 2012 16:59:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B21B6143; Wed, 14 Mar 2012
 16:59:34 -0400 (EDT)
In-Reply-To: <20120314135009.GA934@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Mar 2012 09:50:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A661A4E-6E18-11E1-854D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193162>

Jeff King <peff@peff.net> writes:

> Two caveats before I go further:
>
>   1. You might argue that the real problem is that I'm building the
>      tentative change somewhere inappropriate.

No, that is completely normal for a developer to start into one direction
and then later realize something and change his course.  In fact, many
parts of Git strive to help you avoid being bound by premature commitments
(e.g. "checkout [-m] <branch>" takes local changes with you).  I think
this discussion is only showing that the @{upstream} part wasn't as
carefully designed as other parts of the system.

>   2. I really just want everything based off of origin/master, because
>      that is an implicit part of my workflow for this project.

I think this probably shows that "autosetupmerge" mechanism is not
polished enough.  Perhaps it can take, in addition to "true/false", a ref
in refs/remotes namespace, or something.  If you have "these branches are
to be off of this, this other set of branches are to be off of that", it
may need to become more elaborate.

> I think that would perfectly fit my workflow. But I'm not sure if other
> people would be confused by these operations changing the upstream
> config (e.g., if you expect "jk/bug-fix" to have an upstream of
> "origin/jk/bug-fix", when such a change would not be welcome).

Yeah, the above is starting to sound a bit overengineered black magic.

>> Perhaps this can be a good sample entry for the experimental "tracker"
>> thing to keep track of to see how the workflow will evolve around it;
>> unless neither of us would get to work on it immediately, it is very
>> likely to be forgotten, as this is a tangent in the overall discussion,
>> even though the bug is real and solution is clear.

Heh, I find myself already forgetting what this "clear bug" was and having
to look up in your message (the issue is "git push $there" when $there
does not match branch.$current.remote, it should error out).

> I agree this is a candidate for that. But this is where the concept of
> the tracker breaks down. Who is supposed to update it? You or me? Some
> volunteer who agrees to migrate email discussion into the tracker?  I
> suspect the latter will not work for a point buried so deeply in a
> thread.  Which leaves you and me.

That is why I think any demand (I wouldn't call it "proposal" or
"suggestion") to this project to use tracker fundamentally is flawed.

> I specifically stayed out of the tracker discussion this time around
> because all I had to contribute was "please no, web-based tools are an
> abomination". But now that we see a potential use-case in practice, I am
> realizing that I would not mind at all making a note in a todo file, or
> even sending an email. But the thought of filling out a structured
> problem report to go into a web-based database makes me not want to
> bother.

I agree with this 100%.  If it takes more than just adding an email
address to Cc: line to either a tracker bot or a human project secretary,
I cannot be bothered to spend extra 10 minutes to go to an extra web site,
log-in and fill the form fields.
