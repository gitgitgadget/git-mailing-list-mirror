From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 05 Dec 2010 13:07:24 -0800
Message-ID: <7vk4joszcj.fsf@alter.siamese.dyndns.org>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
 <20101205021837.GA24614@burratino>
 <AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
 <20101205170919.GA7913@burratino>
 <AANLkTikL4BWtzNgx1+MBYxRRdfL=Gu71KPjaiKXprvnb@mail.gmail.com>
 <AANLkTinjJpGW2OiXM3edWYaNhS+w4qNLrvg-0aBwsL=x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 22:07:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPLo6-0002Xk-IM
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 22:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411Ab0LEVHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 16:07:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0LEVHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 16:07:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADA1B3B62;
	Sun,  5 Dec 2010 16:07:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KHGi74aNyKRx+mRX/TJrrn4ODcc=; b=Kwjazm
	VM6uWKOnt45ulSJ7i5jma680s3WkTRwLCJfaMo9KpimbKeliNxEgRkhZUlPkBXrX
	+5wBqkYnZe5rxPtX5oyNlc+60UMU+ASol6nkUPjEFzN7yGAflm5v7NWSPfMJkbNt
	5k5ywNRUa2az/6zAVvFOsAaREd7at7wKw2zN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfMk8cs+Oj0EbMy7NlkRcVx1yLNXobSe
	SWhNmoABWDx5khr/MhzFkqzfSZ41jl8bhGxsAXH+ffqzIYABlT7k7QGp2B7vw7Kb
	7cj1gkELsDcoPqc5vO23dpXeWXml/tShIOB2I+EZN7As/bxJiZz1FzusMjo6vWDw
	7EGokFhPbXY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7E1213B61;
	Sun,  5 Dec 2010 16:07:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3ACF53B60; Sun,  5 Dec 2010
 16:07:46 -0500 (EST)
In-Reply-To: <AANLkTinjJpGW2OiXM3edWYaNhS+w4qNLrvg-0aBwsL=x@mail.gmail.com>
 (Thiago Farina's message of "Sun\, 5 Dec 2010 15\:32\:18 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B87248CE-00B3-11E0-967B-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162963>

Thiago Farina <tfransosi@gmail.com> writes:

> Also I thought that as Junio already picked up the other patch. It's
> was a hint that the other functions that has "struct commit_list *l"
> as its parameters could be renamed as well.

You took a wrong hint and I think that is because you didn't think about
what naming is for.

"insert-by-date" does not say _why_ you want things to be inserted by date
(neither "sort-by-date").  They are pretty generic looking names for any
function that deal with a list of elements that record date.  It makes
sense to anticipate there will be many other such functions that deal with
different kinds of lists that hold date-recording things, and naming one
of them "this deals with list of COMMITS" by saying "commit_list_foo"
makes quite a lot of sense, as "insert-by-date" does not give sufficient
information to the reader.

On the other hand, "reduce-heads" is with quite a higher level of
semantics than "insert-by-date" and friends.  The caller has a set of
commits and wants to remove the ones that can be reached by other commits
in that set, typically because it wants to come up with a list of commits
to be used as parents of a merge commit across them.  It has much stronger
"why" associated with it; unlike "insert-by-date" and friends, there can't
be many other such functions that deal with different datastructures that
hold commits to reduce the heads the same way.

A related tangent.  There are two ways to name functions with richer "why"
component.  Some people name them after what the caller expects them to do
(e.g. they would name "compute merge parents" the function in question),
and others names them after what they themselves do (e.g. it is about
reducing the set of heads by removing redundant parents, and it does not
question for what purpose the caller wants to do so).  In general, it is
preferrable to name them after what they do, not why the caller wants them
to do so, especially when the semantics is clear.  It will allow easier
reuse of the function by new callers that do not create a new merge commit
but wants the same head reduction.
