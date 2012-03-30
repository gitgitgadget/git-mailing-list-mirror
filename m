From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 30 Mar 2012 13:25:03 -0700
Message-ID: <7vty15ltuo.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDiNm-0000W2-QN
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760631Ab2C3UZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 16:25:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760592Ab2C3UZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 16:25:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2FED3C82;
	Fri, 30 Mar 2012 16:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZasrYpxKXmIKglnsT4N93H0SAXo=; b=SPaCB8
	CnxhTzQ2blOmPIwfu54BVDMS713iG+YltirP+XDspZM0tOVx6+LvxOoGRB744exE
	+1LWnZh1+J8Q9dWVeaDl6+ub5uBB+itJI+orPojEOpvgMczQ7+uZAiso1a2k1bOS
	XMo6KGUIvh3EhnBsDNGGowA6r0kVhkJSNsmHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CGHHM2JV5RKfTxd+0gFWJDE7JMal12n1
	ohUL7i19il7qVVF1mB5ymbBobXt4Vj8wtmDElMAvzSiMHw+leLXb5XLN7dkWqOPZ
	7MlC45dsc/RSZEW4OSYXJB395gbk/ilNvDWyl/zqRi7xFH6AKTxgl5LtMgDecp9d
	ZjK1QyaW2Ww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9E933C81;
	Fri, 30 Mar 2012 16:25:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D6353C7B; Fri, 30 Mar 2012
 16:25:05 -0400 (EDT)
In-Reply-To: <20120330071358.GB30656@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 30 Mar 2012 03:13:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F8F3E32-7AA6-11E1-83CD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194400>

[dragging Matthieu, an advocate for "upstream", into this]

Jeff King <peff@peff.net> writes:

> OK. Then I think we shouldn't switch to upstream, and I'm ready to
> debate it. :) I already posted my arguments earlier in the thread[1].
> What do you think?

Honestly speaking, I do not care too deeply either way.  The difference
between "mixed" and "current/upstream" is a very deep-rooted one and has
much more to do with how "batchy" person you are, than if you are pushing
to a shared or your own repository.

The underlying assumption for the original push semantics of "mixed" (or
use of remote.$there.push configuration) is that the way you work is to
prepare all your branches to be pushed $there ready by the time when you
push $there.  Concentrate perfecting your local work, perhaps even being
oblivious to what others do in the meantime, and then push out everything
in one go.  The "oblivious to what others do" part is obviously harder to
arrange if you are pushing into a shared repository, but the connection
between the "shared repository workflow" and "push everything in one go"
is not fundamental.

On the other hand, both "current/upstream" are for people whose work habit
is to complete _only_ the current branch; when you push it out $there, it
does not matter if the other branches that will eventually be pushed out
to the same repository are ready.

And this "only the doneness of the current branch matter" is fundamentally
different from "push everything in one go", and I am already happy to see
that future Git is moving in this direction, which also matches the way
vast majority of people seem to work.  So in that sense, I do not care
which one we picked between "current" and "upstream".  Obviously the
former is much simpler to explain and understand, as people do not have to
learn upstream tracking before doing their first "push".

> I think we can deal with my first issue (some workflows will cause "git
> push" to error out without doing anything) with targeted advice for each
> situation.

Yes.  I think that is up to the people who favored "upstream" over
"current" to share their anecdotes to polish such advice messages.

> But I still worry about the "implied merge" concern I
> raised, and I think the only way to fix that is to have a new mode that
> is almost but not quite "upstream" (like the upstream-current hybrid I
> mentioned).

... which is this.

> my two concerns is that this:
>
>   $ git clone ...
>   $ git checkout -b topic origin/master
>   $ hack hack hack
>   $ git push
>
> will try to implicitly fast-forward merge your commits onto master.

And the reason why it is surprising to the beginners is?  Because "topic"
and "master" (of "origin/master") are not the same name?

If you strip default features out of fear that it may be surprising to the
beginners, you would end up telling them to always explicitly say what
they want to push and to where, so we would need to draw a line somewhere.
I tend to think that this is on the "understandable" side of the line
(after all, I said "Let's start a topic to be merged to origin/master"
when I started the topic, and I've been rebasing the topic up to date from
time to time), but obviously you don't think so.

And I think your aversion to the "implicit fast-forward" will lead you to
teach beginners to do this instead:

   $ git clone ...
   $ git checkout -b topic origin/master
   $ hack hack hack
   $ git checkout master
   $ git merge topic
   $ eyeball, test, think
   $ git push

which arguably is a more disciplined way, but I do not know if we can
expect that people can be trained to be _that_ well disciplined.

> Has somebody volunteered to make the necessary fixes to "push.default =
> upstream" in the first place? At the very least we need the fixes you
> mentioned in your mail[2] before it can become the default. So maybe
> doing those is a good first step (of course we are in release freeze,
> and it would be nice to settle this before v1.7.10 ships, so maybe there
> is not time).

If we were to take "upstream", as long as we commit to make it ready by
the time we switch, I do not see it as much of an issue.  Of course, the
"will change to 'upstream'" message may need to be rephrased to say that
the idiotic usages that would trigger bugs in the current "upstream"
implementation I listed in the message you are referring to (which were
actually taken from your earlier message, IIRC) are not supported and
currently give undefined results, but will be fixed by the time we
actually do the switch.

> [1] http://article.gmane.org/gmane.comp.version-control.git/194299
>
> [2] http://article.gmane.org/gmane.comp.version-control.git/194295
