From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 13:19:50 -0700
Message-ID: <7vk4yvt7kp.fsf@alter.siamese.dyndns.org>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MytI0-0006OJ-C5
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 22:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbZJPUUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 16:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbZJPUUX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 16:20:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZJPUUL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 16:20:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9ACB47ACC0;
	Fri, 16 Oct 2009 16:20:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pm7xJPzMc+AHcCPlmQaLkNE3TxU=; b=kklsxY
	26VAs3Ko2XcvJrTL2vr5r0agYfoTkmPpXC/hSz1gouy5f5Kj6xPSz272OV3eEIUd
	uBVljYrdtx6sSwvjfjKkDpfjgNH+LaoGZDZEod90PjVjrfVtwaOw+ySgtKMqTrMl
	bVyx2z7BLcAwDU8uKK++CIk5mW+Gckrn7Bu7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pokZJKQJBuvdFBcWwLQvc/PmqPHn4sLk
	WK4GEeqmlG0+pPvuCK7tF4Zgu4Vd6Ey+eJIw1ari7ha6IJahzA4tilfWRtvt3fYw
	mXbFRrCt21iXmXrZwFyYiRJaHShmTcWbxV+ArcHqg4oPlm9eYBmtlY4AnYxYAyRs
	4/ta22QsYDY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FC9B7ACBF;
	Fri, 16 Oct 2009 16:20:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 64ABB7ACBE; Fri, 16 Oct 2009
 16:19:51 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk>
 (Julian Phillips's message of "Fri\, 16 Oct 2009 20\:48\:20 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B256616-BA91-11DE-A601-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130525>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Fri, 16 Oct 2009, Junio C Hamano wrote:
>
>> Julian Phillips <julian@quantumfyre.co.uk> writes:
>> ...
>>> I don't care what git has to do, I'm talking about the user experience
>>
>> But Bj?rn is showing two commands the _user_ has to type, iow, the comment
>> is about the user experience.
>
> Only Currently.  My point was that _if_ we wanted to support this sort
> of thing, then we can make is simpler to do by providing a simple
> command for the user.
>
> The point I wanted to make was that the decision on what to do should
> be driven by the user's experience - not by the fact that it is easier
> to implement something else.

Sorry, but I do not see in what way what you said in the thread connects
to the above three lines.  Are you talking about this one from you a few
messages back?

    How about:

    $ git checkout origin/master
    $ git fetch
    Refusing to fetch, as it would update a checkedout branch
    "git fetch -f" will force the update, but you will need to run "git
    reset --hard HEAD" to update your checkout to match.

I am not seeing "not the implementation ease but the user experience"
drive in this suggestion.  If you are driving from the user experience
point of view, I would have instead suggested:

    How about:

    $ git checkout origin/master
    $ git fetch

    and fetch happily updates the tracked branch, without affecting the
    HEAD state (nor index nor the work tree, of course).

User experience here is:

    * Let's checkout what the upstream has on the master.  I am at least
      aware that git is distributed and does not go to the network unless
      I tell it to, and am aware that origin/master is the state of the
      upsream _when I told git to look at it the last time_.  So I'll get
      the state I talked with the upstream the last time, and that is what
      I want to look at.

    * Hmm, there may be even more updates since I talked with the upstream
      the last time.  Let's tell git to fetch.  I already know that this
      updates origin/master to a more recent state.

Isn't it much cleaner and less confusing?  And with these kind of
awareness, the user can choose to do various things from here, e.g.:

    * Oh, fetch did fetched something.  I want the updated state.  Let's
      check it out with "git checkout origin/master"; or

    * Ok, what changed since I last talked with the upstream?  I have one
      end of the state already checked out, and I updated origin/master
      with their latest, so I can say "git diff HEAD origin/master".

Notice in the latter the user can be a neophyte who hasn't learned reflogs
yet.

> My interest in this thread is solely that it might provide a mechanism
> to find out which tag was checked out.

Hmm, what is lacking in "git describe HEAD" for that?  I am not
complaining that you might be asking for something that exists, but I _do_
want to know if something that exists is not a satisfactory solution and
if so how it can be improved.
