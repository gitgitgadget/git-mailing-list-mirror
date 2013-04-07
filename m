From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sat, 06 Apr 2013 20:31:32 -0700
Message-ID: <7v61zz9fu3.fsf@alter.siamese.dyndns.org>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 05:31:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOgKT-0005Xp-3l
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 05:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161464Ab3DGDbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 23:31:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161353Ab3DGDbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 23:31:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31BC4F034;
	Sun,  7 Apr 2013 03:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mgAlwubpXC9NNHjPakvvXaAtOVY=; b=p/6bk1
	y+bm3bykaYd3/GMGh7c+E2/1HkzNfD1bGxb3bNf1OvZGITxVZuFzlOsKQAWgF88W
	EnVPcdQdqSqCMblMQadxvtmkwutLo9gorEidtwy9OkQf8mt44KFKAZNgRjYKlEfk
	Rw7XaybDgbTZc8S4dgriP7F+JB3C39hhE5oKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K6FJjI3efJnVQ8QpzTfQLXXNXLNEkIKo
	DCnzdM5ewsv4O0MSqXgevX31wk10VWiudof09d4fG7VDtA34kOlEOWd1JrBXqXSp
	lLC+pF0U2o1c+ZvYfGUOvExRMC2yScClR9lSw8338Bb923qtN4DaofR4VbBxqBkU
	wgFlBtkKb2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26C12F033;
	Sun,  7 Apr 2013 03:31:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7931CF032; Sun,  7 Apr 2013
 03:31:34 +0000 (UTC)
In-Reply-To: <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 7 Apr 2013 01:40:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A59B2812-9F33-11E2-BBD5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220275>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> So we've thought about it for some time, and I really need you to
> start reviewing the code now.
>
> I'll just summarize what we've discussed so far:
> ...

I do not think we have heard anything concrete and usable about what
you are trying to achieve yet.

You may be proposing to discard baby with bathwater.  We haven't
seen an evidence that the change is really worth having.  We do not
even know what you are trying to change, other than "I want to add a
new object type to largely replicate what is recorded in .gitmodules
file".  What are you trying to solve?

	I want to have a project for an appliance, that binds two
	projects, the kernel and the appliance's userspace.  The
	usual suspects to use to implement such a project would be
	Git submodule, repo, or Gitslave.

	I want to be able to do X and Y and Z in managing such a
	project.

        If I try to use submodule, I cannot see how I could make it
	do X for _this thing_, and it is not a bug in the
	implementation but is fundamental because of _this and
	that_.  If I try to use repo, ...... the same, and the same
	for Gitslave. ......

	I propose to add a new "gitlink" object recorded in the tree
	and in the index, and the said cases X, Y and Z can be
	solved in _such and such way_.  We cannot solve it without
	having a new "gitlink" object recorded in the tree object
	because of _this and that reason_.

I think it is too premature to discuss _your_ code.  The patches do
not even tell us anything about how much more work is needed to
merely make Git with your patches work properly again.  For one
thing, I suspect that you won't even be able to repack a repository
that has OBJ_LINK only with the patches you posted.

At this point the only thing that we can gain from reading your
patch is that you can write C to do _something_, but that something
is so fuzzily explained that we do not know what to make of that
knowledge that you write good (or bad, we don't know) C.

It would be much more productive to learn what these specific issues
X, Y and Z are, and if the problems you are having with existing
solutions are really fundamental that need changes to object layer
to solve.
