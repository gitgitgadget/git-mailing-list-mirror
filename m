From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 14:48:56 -0700
Message-ID: <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu> <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
 <20110609200403.GA3955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 23:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV9Zx-00065J-GS
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 23:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139Ab1FJVtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 17:49:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1FJVtN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 17:49:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C523A4ECE;
	Fri, 10 Jun 2011 17:51:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FrVuCeUcbdG+xtUCFNeN0lzz1h4=; b=MCc5yt
	LuUj08xNOo0qFovqIdSQlaDawQDD59/nRI9cScFJbdnK8MTIsvobN3qnDSvbGgu0
	ypfK9JQTH12N2ietWFAHp9emMBHywM16dUdec7vAHa+QigwTcgEG/7BB5nQDFknu
	2YMQi/aHev3hszibFyUoK14OIZ8Avx171B8d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MOB12zkcIMJH4ZKDFpeBPgwTxByWsY+g
	is6ytnJMOMIZzW6HYIv0dg6Ilb7Gv6d04H/52P8LyD+gKl8RG90xxSH+cS+5b3I2
	RpwoARTkoS0hoJ+oHAx9V9SuB5OFdIZP72q5EPhAZVSFGVhlSVsCTeq5T0MFJCIz
	KUgbBjWXgTA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C6174ECC;
	Fri, 10 Jun 2011 17:51:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F25B34ECB; Fri, 10 Jun 2011
 17:51:06 -0400 (EDT)
In-Reply-To: <20110609200403.GA3955@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 9 Jun 2011 16:04:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3AE909A-93AB-11E0-83BE-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175629>

Jeff King <peff@peff.net> writes:

> I think there are actually two questions here:
>
>   1. Will it be easier for people to understand "git diff" if we use
>      tokens to describe non-treeish sources and destinations?
>
>   2. Are there better tokens to use to break down parts of the index?
>
> I don't have a big problem with (1). Allowing things like:
>
>   git diff INDEX WTREE
>
> allows one to explain what is going on with the diff syntax in a very
> clear and verbose manner. I wouldn't want to type that every day, but
> that's OK; "git diff" will always mean the same thing as it always has,
> but can now be explained to people who have trouble seeing it in terms
> of "git diff INDEX WTREE".
>
> There's still a bit of magic in that INDEX is _not_ a tree, but I think
> that's a good thing. When there are no merge conflicts, it will behave
> identically to the proposed NEXT tree. And when there are conflicts, it
> will show you something even more useful.

Thanks. This is exactly why I love to have people like you on the list,
who can say what I wanted to say in a matter that is a lot easier to
understand.

In short, the proposed "NEXT" does not help in a situation with conflicts,
and makes the user experience worse. In order to get the current power of
"git diff" with various options that are specifically designed to help
users to make progress (either working on their own changes, rebasing them
on top of others, or merging other's work in), people _COULD_ introduce
BASE/OURS/THEIRS in addition to "NEXT", throw the existing HEAD and
MERGE_HEAD to the mix, derive the same information by spending mental
effort to choose between which pairs of two entities among these six
possibilities and take pairwise diffs among those pairs, and combine the
results of these diffs (the message I responded to with "is that a useful
question" was an example of that---"Could we pile more kludge on top of
NEXT to have expressiveness equivalent to what the current index-based
system offers?"). Yes, that may be possible, but is there a point in
making users go through that kind of mental contortion by introducing
these new tokens? I find it highly doubtful that it would help new people
understand the situation during conflicted merges.

>   git show INDEX:OURS:Makefile
>
> which is identical to what I wrote above, but is perhaps easier to
> explain.

Why does anybody even want to say :2:Makefile to begin with?

Presumably, you are dealing with a merge conflict at that path and trying
to see how pre-merge version of Makefile looked like, and then the next
thing you may want to do is how pre-merge version of their Makefile looked
like.

Wouldn't it be far more natural to ask for these instead?

    git show HEAD:Makefile
    git show MERGE_HEAD:Makefile

I do not think whoever brought that "you can look at individual stages
with :$n:$path" to this discussion was thinking straight. Yes, it is
something you _could_ do, I've never found that particularly _useful_
unless I was debugging git itself.
