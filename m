From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Sat, 18 May 2013 23:22:23 -0700
Message-ID: <7vbo871obk.fsf@alter.siamese.dyndns.org>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
	<51968311.1020107@bracey.fi> <7va9ntxu3w.fsf@alter.siamese.dyndns.org>
	<51979065.4060609@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun May 19 08:22:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udx10-0007oW-S5
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 08:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab3ESGW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 02:22:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab3ESGW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 02:22:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68B631C7E9;
	Sun, 19 May 2013 06:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uf7GH9j3OYDnflFdv5dsq52ty40=; b=rXqGgX
	1WczCmH2qo4lzhh+Cin4vY9xsgzZOFNvqsw3ZkxxIZJf6m2KSc4o8qK/W4m6/J2W
	OgDwS0ty85Isuep7GnALAFQn21fxbSXfRTcO5OZpWW1QXtK+2Goa8rZqmGvI69F9
	9znPtZ2xwaZ89etfjl2g03tsEzrlcJt1dTi3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A57DBVbgIwMIqi8TBkV2QeSIiwjXNnuw
	vTWz6wV6CQk8SRE3Z54WZEZalveZFU7PoUYU9ajtdGjXhdPJPMlhx/VIHsw9qNyi
	hqJjfsjMtnqNAXAORXAGPWXS0gVFEzhpB7XZVRhrSkF+2Ryba7h905bRFETMNHsT
	Zm7cSR23EPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F73B1C7E8;
	Sun, 19 May 2013 06:22:25 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 902F81C7E5;
	Sun, 19 May 2013 06:22:24 +0000 (UTC)
In-Reply-To: <51979065.4060609@bracey.fi> (Kevin Bracey's message of "Sat, 18
	May 2013 17:29:57 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 787C70E0-C04C-11E2-8290-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224820>

Kevin Bracey <kevin@bracey.fi> writes:

>>> I found myself thinking the same thing. It's really convenient being
>>> able to set your topic branch's upstream to another local branch, so
>
>> What is that "another local branch"? ...  And if that is your workflow, setting
>> push.default to "current" (and setting remote.pushdefault to your
>> publishing repository) should be a sufficient interim solution, and
>> you do not need to set branch.$name.push to each and every branch
>> you intend to push out, I think.
>
> I agree that using "push.default current" covers some cases - I hadn't
> really considered it - tended to just stick with "upstream". "current"
> nearly does the job, but I will sometimes be wanting different names.


> What I'll often be doing is creating a topic branch based on master or
> origin/master. (I would hardly ever be updating master or pushing to
> origin/master myself, so I probably should be just doing
> origin/master, but I tend to create a local master just to save typing
> on all those "git rebase origin/master").

Do you mean, by "save typing", "instead of origin/master, I can type
master"?

If you are using the "checkout -t -b topic origin/master", "git rebase"
without any other argument should know that you meant to rebase
against 'origin/master', so you do not even have to type 'master'.
> During work, to give others visibility, and the possibility to tinker
> with the topic branch during development (as we don't have full
> inter-site sharing of work areas), I would push the topic branch up to
> the central "origin" server, often with a "kbracey/" prefix, partially
> for namespacing, and partially to indicate it's currently "private"
> work and subject to rebasing.  I guess I could create the topic branch
> as "kbracey/topic" locally, but I'd rather not have to.

Yup, that is sensible, and I think with Felipe's proposed change,
you can spell it like this:

    [branch "topic"]
	remote = origin
	merge = refs/heads/master
        push = refs/heads/kbracey/topic

Note that the above assumes you did "checkout -t -b topic origin/master"
as a typesaver for "git rebase".

> So I'd like "git rebase (-i)" to move my topic branch up
> (origin/)master. And I'd like "git push (-f)" to send it to
> "origin/kbracey/topic". 

Understood.  And I think the [branch "topic"] configuration above
would cover that use case.

> And by extension, I suppose "git pull --rebase" to update origin/master
> and rebase. (Although I'm not much of a puller -  I tend to fetch
> then rebase manually).

"git pull --rebase" would be "git fetch" followed by "git rebase",
and again the [branch "topic"] configuration above would cover that
use case, I think.

> And it would be ideal if the initial base and push tracking
> information could be set up automatically on the first "git checkout
> -b"/"git branch" and "git push".

I think checkout and branch is already covered with -t.  There may
even be a configuration option to implicitly add -t to them (I
didn't check).

> (For one, I've always found it odd
> that there's an asymmetry - if you check out a topic branch from the
> server to work on or use it, you get a local copy with upstream set by
> default. But if you create a topic branch yourself then push it, the
> upstream isn't set by default - you need the -u flag. This seems odd
> to me, and I've seen others confused by this).

Yeah, I would imagine that it would be trivial to add an option to
cause "git push" to do that, and it would be useful if you push to
and pull from the same place (I haven't thought about ramifications
such an option would have on the triangular workflows, though).

Thanks.
