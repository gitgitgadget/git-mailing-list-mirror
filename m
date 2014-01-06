From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 06 Jan 2014 13:21:43 -0800
Message-ID: <xmqqwqichkm0.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
	<xmqq1u0kj16h.fsf@gitster.dls.corp.google.com>
	<20140106205526.GC643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 22:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0HcP-0005xd-RX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 22:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140AbaAFVVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 16:21:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354AbaAFVVt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 16:21:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E22985F50D;
	Mon,  6 Jan 2014 16:21:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iIIGmRERR5pJX0znVT9tdGxFYYs=; b=GI1cTd
	U5aI6IaFcQxEvAe89Lmzg9c12ztjiFokxT5s1sJT5ZqObgP8cjqsefQqtHld0cfi
	2bqBsBdW4dcYPcVg22fciDuraRTHvHYA9FnlrQw0+AVnmPXE0+D8mglVr7x0eT48
	D8MCTWVvZllv4AiIyn7s+FM6ghL89A22spWpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dji0hSdw/AGKLiWVJZUr6ichT6zwfnsb
	IyfwinXgRzXGPBh1CSwkk+qdEn2bLfI5l77gRQ8H/9WjbtfiEz3W1ZZa5OmbMiZ0
	vC15Cy7hP4DmwHqT39XtQRSp90xsZr49z1SqRVL8rX30T5mGnN1iqOgFECeaGCvf
	ntCiLfLeyIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C50D05F50C;
	Mon,  6 Jan 2014 16:21:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 045CB5F50B;
	Mon,  6 Jan 2014 16:21:46 -0500 (EST)
In-Reply-To: <20140106205526.GC643@sigill.intra.peff.net> (Jeff King's message
	of "Mon, 6 Jan 2014 15:55:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C6F243E-7718-11E3-9AB9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240066>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 06, 2014 at 12:38:30PM -0800, Junio C Hamano wrote:
>
>> > I wonder if it is too late to try to clarify this dual usage. It kind of
>> > seems like the push config is "this is the place I publish to". Which,
>> > in many workflows, just so happens to be the exact same as the place you
>> > forked from. Could we introduce a new branch.*.pushupstream variable
>> > that falls back to branch.*.merge? Or is that just throwing more fuel on
>> > the fire (more sand in the pit in my analogy, I guess).
>> >
>> > I admit I haven't thought it through yet, though. And even if it does
>> > work, it may throw a slight monkey wrench in the proposed push.default
>> > transition.
>> 
>> Yeah, when I say "upstream", I never mean it as "where I publish".
>> Your upstream is where you get others' work from.
>
> That's my thinking, as well, but it means the "upstream" push.default is
> nonsensical. I've thought that all along, but it seems like other people
> find it useful. I guess because they are in a non-triangular,
> non-feature-branch setup (I suppose you could think of a central-repo
> feature-branch workflow as a special form of triangular setup, where
> the remote is bi-directional, but the branch names are triangular).
>
> If we want to declare "push -u" and "push.default=upstream" as
> tools for certain simple bi-directional workflows, that makes
> sense.  But I suspect it may cause extra confusion when people
> make the jump to using a triangular workflow.

I do not think there is no "want to declare" involved.  If I
correctly recall how "push -u" came about, it was merely a way to
appease those who complained that their new branch created by
running "checkout -b branch origin/branch" has already set up the
branch.*.remote and branch.*.merge configurations nicely for them
and allow them to immediately go ahead and start using the
centralized "I merge from their 'branch' and push to that", but when
they create a new branch on their own and want to make the branch of
the same name at the origin to be the "upstream", they have to futz
with the configuration.  The declaration was made long time ago when
we started using @{upstream}, and there is no new extra confusion.

>> For a "push to somewhere for safekeeping or other people to look at"
>> triangular workflow, it does not make any sense to treat that "I
>> publish there" place as an upstream (hence having branch.*.remote
>> pointing at that publishing point).
>
> You _might_ treat it the same way we treat the upstream, in some special
> cases. For example, when you say "git status", it is useful to see how
> your topic and the upstream have progressed (i.e., do I need to pull
> from upstream?). But you may _also_ want to know how your local branch
> differs from its pushed counterpart (i.e., do I have unsaved commits
> here that I want to push up?).

Correct; I am not saying "where do I publish" is never relevant.  It
is just it is not something useful for "format-patch" to use as the
default fork-point.

> So having two config options might help with that. Of course, your "push
> upstream" (or whatever you want to call it) does not logically have one
> value. You may push to several places, and would want to compare to
> each.

Yes.  But most likely, if you always push a single branch to
multiple places, it won't be like you push it to only one of the
places today and another one tomorrow, leaving everybody out of
sync.  Unless there is a site that is temporarily down, in which
case that one may stay behind, the normal state would be that all of
them point at the same commit (that is how I publish to multiple
places anyway).

>> Once you stop doing that, and
>> instead using branch.*.remote = origin, and branch.*.merge = master,
>> where 'origin' is not your publishing point, @{u} will again start
>> making sense, I think.
>> 
>> And I thought that is what setting "remote.pushdefault" to the
>> publishing point repository was about.
>
> If that were sufficient, then we would just need "push.default =
> current", and not "upstream" (nor "simple"). I lobbied for that during
> the discussion, but people seemed to think that "upstream" was
> better/more useful. Maybe it was just because remote.pushdefault did not
> exist then.

Yeah, I think in the 2.0 world with pushdefault (i.e. triangular),
the default 'simple' turns into 'current'.
