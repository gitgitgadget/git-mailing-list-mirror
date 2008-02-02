From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sat, 02 Feb 2008 13:31:47 -0800
Message-ID: <7vk5ln11vg.fsf@gitster.siamese.dyndns.org>
References: <3asc6spe.fsf@blue.sea.net>
	<7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
	<20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net>
	<20080202161813.GA19797@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 22:32:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLPyI-0006gP-VH
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 22:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765203AbYBBVbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 16:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764537AbYBBVbx
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 16:31:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764432AbYBBVbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 16:31:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A21A5470;
	Sat,  2 Feb 2008 16:31:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E5B9546F;
	Sat,  2 Feb 2008 16:31:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72305>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>> It does not matter what advanced users use. The documentation should
>> primarily focus the newcomers.
>
> That could have been an argument for disallowing the HEAD^ syntax
> entirely, but it's too late for that.

It's not "it's too late" unless you are proposing to revamp git
and to remove support for nonlinear history.  With ^ and digits
you can name anything.  With ~ and digits you cannot.

> Even if we eradicated all mention of ^ from the in-tree documentation,
> it would still show up in lots of out-of-tree documentation and
> examples.  So we have to introduce it to newbies.  Fortunately, it isn't
> that hard.

Jari might be thinking that absolute newbies do not do any
merges themselves, but even then, people need to know $commit^2
as soon as they start to interact with a history that have any
merge.  And people won't stay newbies forever.

> One way we can help them is by continuing to mix the two in examples, so
> let's continue with the current mixture.

Yeah, I am pretty much for it.

HEAD~2 and upwards are very good usability enhancement compared
to "HEAD^^^(many uparrows...)".  The reason we accept HEAD~1 is
not because that is easier to type, nor easier to understand,
nor makes you more productive.  It is solely for consistency for
the consistency's sake.

In an introductory document, we could present things in this
order:

 1. "HEAD^" means the parent.  It's parent is "HEAD^^".

        Side note: You read the ^ operator from right to left.
        When you see "HEAD^^", you read the rightmost ^ as "the
        parent of", and tuck the remainder to form "the parent
        of HEAD^".

 2. You can have merges, so the above "_the_ parent" is a white
    lie.  The other branch that was merged is HEAD^2 (the second
    parent).

        Side note: this means "HEAD^" we introduced in 1. is
        "the first parent"; a natural consequence of this is
        that you could also say HEAD^1 if you really wanted to
        be explicit.

 3. As major parts of your history consists of a sequence of
    commits that have only single parent, you would often need
    to refer to ancestor that is Nth generation back following
    the first parent.  You can of course say "HEAD^^^^" to mean
    the first parent of the first parent of the first parent of
    the first parent of the HEAD, but that quickly becomes
    combersome.  Instead you can say HEAD~4.

        Side note: "HEAD^" we introduced in 1. is "the first
        generation ancestor in the first parent chain"; a
        natural consequence of this is that you could also say
        HEAD~1 if you really wanted to be explicit.

But that's for introductory document.  Once people get past to
the stage and understand what these two notation mean, we should
freely use the more convenient form in the reference part of the
documentation.
