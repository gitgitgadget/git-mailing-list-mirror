From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Thu, 16 Aug 2012 09:10:17 -0700
Message-ID: <7v628i3jiu.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
 <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
 <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
 <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
 <7vipcj2w9f.fsf@alter.siamese.dyndns.org>
 <7vehn72vyl.fsf@alter.siamese.dyndns.org> <87pq6rw77l.fsf@thomas.inf.ethz.ch>
 <502CC4E7.5060508@alum.mit.edu> <87k3wzujuy.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T22eg-0000Iz-VZ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 18:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199Ab2HPQKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 12:10:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757434Ab2HPQKU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 12:10:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2F389F35;
	Thu, 16 Aug 2012 12:10:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PM2O+RDA/UF0PD97C4VlSUJLVGs=; b=kz3qQj
	E3rgz+1yS1BLRPmLW8fxKiCTBErvbU0inY9R1SNUS/ltKduDxYLLzdsi355T4sMA
	9qgGYqnHjCVYO9W2OeXVZYcKD/j7HkiKCe+VjCsFOfP5bS14Hj87jNThh8c621Ej
	AvvjTl/ysW9hVSCleCBHx7QkFyCuzr7nR2vVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IP8bTctQgNQOLqtm42xbRhWoLirIl5+h
	h/lBQPJmqqgAeE6JjWkim+UyfcYB1Bqiel48NBHOMNzboELMKqHtaaM995/rcM+a
	qEnv5NUSlh9d66KVn0lNjxfC4uhtf2QZoUfrsoLHB+JReIVAAJux4J4hOW/q3A9X
	Damrn+OYzI8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFFE39F34;
	Thu, 16 Aug 2012 12:10:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06E5F9F31; Thu, 16 Aug 2012
 12:10:18 -0400 (EDT)
In-Reply-To: <87k3wzujuy.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 16 Aug 2012 14:00:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFAD488E-E7BC-11E1-87C2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Rast <trast@student.ethz.ch> writes:

>> Why not turn the behavior on its head:
>>
>> * Change the default behavior to be something well-defined, easy to
>> document, and convenient for humans, such as "topological order with
>> ties broken by timestamp" or "approximate timestamp order, but
>> respecting dependencies".
>>
>> * Add a new option, --arbitrary-order, that explicitly chooses
>> efficiency instead of a defined order.
>
> I think that would be a rather bad decision, largely because (taking my
> git.git as an example):
>
>   $ time git log | head -1
>   $ time git log --date-order | head -1

You are correct to point out that introducing "--arbitrary-order"
and force sorting by default is stupid for one reason, but forgot to
stress the other equally important reason, I think.  Even though you
came close to it here:

> ... if you just use 'git log' to quickly see the last
> few commits.  At least to me, the optimization makes perfect sense.

you may not have fully internalized that other reason yourself, I
suspect, for the reason I mention in my last two paragraphs below.

When you run "git log", you are asking only to see "the last few"
commits.  The size of "few" actually depends on the occasion and the
user, but the important thing to notice is that the definition of
"the last" is fuzzily defined.  In such a request over a history
like this:

      ---A---B---C---D
                      \
    ---1---2---3---4---* = HEAD

the user does not care the exact order, as long as the ones "closer"
(again, a fuzzy definition) to HEAD come out earlier than the ones
"farther" (and all of them have to come out eventually but that goes
without saying).

In the case of the above sample history, even with clock skews, the
ones labeled with alphabets appear in the expected order among
themselves, and the ones labeled with numbers also do, with or
without sorting.  And all three orders match the use case of "git
log" to view "the last few" commits just fine.  When we have the
default, topo and date orders, all of which would give us output
suitable for the purpose of showing "the last few", picking the one
with the least latency is the right thing to do.

In other words, latency is important, but a short-latency solution
is acceptable and preferred only if it gives a reasonable result.
Giving useless output with small latency is not what we are aiming
to do.

> The right fix would be to dig up Peff's work on generation number
> caching, and modify the algorithm to take generation numbers into
> account.

I think you are totally wrong here, unless you are talking about a
generation number that is different from what I recall from the
older discussion.  Think of the sample history above, and imagine
that the numbered ones are based on the current 'master', but that
the alphabet ones are based on an ancient maintenance release that
is 1000 generations behind (think of me running the command after
finishing the day's integration cycle, sitting at the tip of 'pu',
where the last topic merged is meant to be eventually merged to
maint-1.7.9).  All of the commits depicted in the picture will have
the commit timestamps in the past few hours.  Ancestors of A and 1,
not drawn in the picture, were made yesterday or before.

The current "default" output will give all of the depicted commits
before showing the older commits that are not in the picture, and
that is absolutely the right thing to do when you ask "git log" to
view "the last few" commits.  Imagine what you will see if you used
generation numbers instead of the commit timestamp.  You will see
commits on the maintenance topic that can later be merged to an
older codebase, only after you saw all the development history on
the master branch since 1.7.9 release.  I do not think we want to
call such an output "the right fix".
