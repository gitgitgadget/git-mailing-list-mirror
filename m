From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Wed, 04 Nov 2009 10:03:49 -0800
Message-ID: <7vhbtai2uy.fsf@alter.siamese.dyndns.org>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
 <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
 <1257295737457-3942366.post@n2.nabble.com>
 <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com>
 <1257315478920-3943388.post@n2.nabble.com>
 <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com>
 <20091104072709.GC24263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:04:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kDK-0005uZ-50
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526AbZKDSD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbZKDSD4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:03:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbZKDSDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:03:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24270732B4;
	Wed,  4 Nov 2009 13:04:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=c7485r2UA/YeDGDqeM6zINKo+KY=; b=jAiQDgLHN3N4Ii8tGCiT1+y
	rxa4k1JcDh2Bo9nxxux5edPZhoSyty5B+hF43z4T7u3ly152v53uxEKC9JijxXLi
	+HWbLk4Z7SV+Tz+9mJuyDQd1Ab+JhcM06QwYsnXWTCKmbtPwusjBDuJ9lVBkQEpt
	txUS4ld7PkOaWi+1Pz+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LEBcXCuj1fW+bQuK0jHjYq59R+pXzwzO6AbDo2CHaPfJxBNpu
	LxtBDToCAClggNun9S94+RtcuQsek/2ZFKj0pTyWbzJIcYog8RHoHasmkWq4mB7m
	LYIXk4JGk9/gfq+/UEJfcMkttpP/S4z0EQ/Ew7gHcXFaFUB10Sa1E91jJI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D39EA732B3;
	Wed,  4 Nov 2009 13:03:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B84E0732B2; Wed,  4 Nov
 2009 13:03:50 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B1CD2C6-C96C-11DE-BD4D-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132103>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 04, 2009 at 07:41:28AM +0100, Sverre Rabbelier wrote:
>
>> On Wed, Nov 4, 2009 at 07:17, Tim Mazid <timmazid@hotmail.com> wrote:
>> > So instead of invoking 'git checkout REMOTE/BRANCH', do 'git checkout -b
>> > BRANCH REMOTE/BRANCH'.
>> 
>> Automagically doing 'git checkout -t remote/branch' when asked to do
>> 'git checkout remote/branch' was suggested earlier on the list and I
>> think there was even a patch that implemented it, not sure what the
>> outcome of the series was. I do remember that Peff was annoyed by it
>> at the GitTogether though so it might be a bad idea.
>
> It's in 'next' now.

Isn't it quite different?  What's in 'next' for 1.7.0 is to guess the
user's intention when:

 - he says 'git checkout BRANCH'; and

 - BRANCH does not yet exist; and

 - BRANCH does not name a commit so the request cannot be to detach HEAD
   at some commit (like REMOTE/BRANCH); and

 - there is a unique REMOTE that has BRANCH.  

The user wants to check out his own BRANCH (the request lacks REMOTE to
start with) but such a branch does not exist yet, and there is only one
sensible commit to start that new branch, hence we DWIM it and helpfully
run "git branch -t BRANCH REMOTE/BRANCH" automatically before performing
"git checkout BRANCH" that was asked.

We never claim to allow checking out the remote tracking branch itself.
The new guessing is only about a local branch that does not exist yet.

> ... I am still not convinced that we won't later regret leaving the
> stale local branch sitting around, or that users won't find it confusing
> to see:
>
>   $ git checkout foo
>   Branch foo set up to track remote branch foo from origin.
>   Switched to a new branch 'foo'
>
>   ... time passes ...
>
>   $ git checkout foo
>   Switched to branch 'foo'
>   Your branch is behind 'origin/foo' by 1 commit, and can be fast-forwarded.
>
> (i.e., you do the same thing, but get two very different results,...

I think this is primarily because the way this DWIM is totally silent in
the transcript is misleading.  If you explain it the way I outlined above,
I do not think there is any confusion.  That is, there is no way for the
user to get confused if the command sequence were like so:

   $ git branch -t foo origin/foo
   Branch foo set up to track remote branch foo from origin.
   $ git checkout foo
   Switched to a new branch 'foo'

   ... time passes ...

   $ git checkout foo
   Switched to branch 'foo'
   Your branch is behind 'origin/foo' by 1 commit, and can be fast-forwarded.

It could just be a matter of telling what we are doing a bit more
explicitly when this DWIM kicks in.  How about this?

   $ git checkout foo
   (first forking your own 'foo' from 'origin/foo')
   Branch foo set up to track remote branch foo from origin.
   Switched to a new branch 'foo'

In any case, I do not think the DWIM would kick in when you try to detach
at remote branch head.  I did not check gitk code to find out the exact
command line it uses, but I do not think it runs "checkout BRANCH".  The
command needs to be at least "checkout REMOTE/BRANCH" to work the way it
does now with any released version of git, and I would not be surprised if
paulus was cautious enough to have spelled it as "refs/REMOTE/BRANCH" to
avoid any potential ambiguity issues.
