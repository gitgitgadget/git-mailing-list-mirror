From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Fri, 17 Aug 2012 10:18:25 -0700
Message-ID: <7v1uj5wi72.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
 <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
 <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
 <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
 <7vipcj2w9f.fsf@alter.siamese.dyndns.org>
 <7vehn72vyl.fsf@alter.siamese.dyndns.org> <87pq6rw77l.fsf@thomas.inf.ethz.ch>
 <502CC4E7.5060508@alum.mit.edu> <87k3wzujuy.fsf@thomas.inf.ethz.ch>
 <7v628i3jiu.fsf@alter.siamese.dyndns.org> <874no1hnfg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2QBw-0003sI-Ma
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab2HQRSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:18:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab2HQRS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:18:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A92372DC;
	Fri, 17 Aug 2012 13:18:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JKh7dCuNxT0Zm+F7GZntTNmbqEw=; b=DMzvaa
	ED6FKk3x5HZfgIwPwIj5VyLJhy4Ltx2t+QGugkgrZ2ZVNiU2LS2ze7P/j6gOFn2Q
	x3ArkVCpdK9qvL8btxPMWOSjRAqaHTl23AX2oTtWDjTvLlc/uD2HXQqeCBlBVNGQ
	f9Ute4JqqkTNbhCts/Qa6MsicPgypMGrv5akA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIf5vVkL7zMipj+BjxmJmLsp7uFtGkan
	bFOq4I0lULfSVyfiU+MhD5cipCoBwlHvdJICjO6OrWtOGR5ukft0xtQWXmkvVC9P
	8/QwqZAt7w3MoG6TiMVLwPLOW2p/sKXRbCbqcvxDESubOGE4QWegc6fCNcvMewZS
	9yJ++DqmJas=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5816C72D3;
	Fri, 17 Aug 2012 13:18:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2EEF72D2; Fri, 17 Aug 2012
 13:18:27 -0400 (EDT)
In-Reply-To: <874no1hnfg.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 17 Aug 2012 11:34:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F1BCD4A-E88F-11E1-92FC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203625>

Thomas Rast <trast@inf.ethz.ch> writes:

> However, suppose we knew generation numbers.  I haven't actually looked
> into the old threads again, but my understanding was that they are
> numbers g(C) attached to each commit C such that
>
>   g(C) = 1 + max(g(P) for P a parent of C)   for non-root commits
>
>   g(C) = 0                                   for root commits
>
> They are invariant given the commit, so they can be cached.
> ...
> I hope I got that right.  The order of commits is still entirely
> determined by the choice of "any tentative source", but the algorithm
> should now stream nicely once the generation numbers are known.

That matches the definition of generation number I remember from the
old discussion.  Now look at the illustration in this discussion
again:

      ---A---B---C---D
                      \
    ---1---2---3---4---* = HEAD

and an excerpt from the message you are respoding to:

  Think of the sample history above, and imagine
  that the numbered ones are based on the current 'master', but that
  the alphabet ones are based on an ancient maintenance release that
  is 1000 generations behind (think of me running the command after
  finishing the day's integration cycle, sitting at the tip of 'pu',
  where the last topic merged is meant to be eventually merged to
  maint-1.7.9).  All of the commits depicted in the picture will have
  the commit timestamps in the past few hours.  Ancestors of A and 1,
  not drawn in the picture, were made yesterday or before.

The numbered commits 1 2 3 4 are building on top of recent "master",
while alphabetized A B C D are building on aged maintenance track.
The difference in generation numbers between 1 and 2, 2 and 3,... A
and B, B and C, C and D are all one, and HEAD (the tip of 'pu') would
have generation number of commit 4 plus 1, as commit 4's generation
number would be a thousand or more ahead of that of commit D.  And
there are a thousand ancestors of '1' with larger generation numbers
than 'D'.

When the user runs "git log" (i.e. the casual "the last few commit"
macthes), the expectation of the user is "I want to see what I did
recently".  If you substituted the commit timestamp with such a
generation number, how would that expectation satisified?

Generation numbers is a clean solution to avoid giving an incorrect
range result when there are clock skews (cf. the use of SLOP in
revision.c::still_interesting()), but it is not a good substitute
when the user is more interested in absolutely correct topology (in
other words, the user is more interested in both rougly wallclock
time order and seeing the result soon --- which brings us back to
the original "short latency is vastly preferred _as long as_ it
produces the result the user wants to see").
