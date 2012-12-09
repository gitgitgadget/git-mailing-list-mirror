From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request - Hide ignored files before checkout
Date: Sun, 09 Dec 2012 01:04:05 -0800
Message-ID: <7vhanvegvu.fsf@alter.siamese.dyndns.org>
References: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com>
 <CAEUsAPaHJ+N0EnxGuVkRqcmY0fUy+4myMiWtd1_vu1vRL763JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew Ciancio <matthew.ciancio16@gmail.com>, git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 10:04:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Thcoa-0000SS-Hf
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 10:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622Ab2LIJEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 04:04:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756617Ab2LIJEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 04:04:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F63D98E4;
	Sun,  9 Dec 2012 04:04:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H3wRqtHxXjgZDcHEerDaWo8O9hs=; b=uUeLQb
	b4rtaH15st7m3FRUtQZVkaxRcgbNpFn03MaXxeaRjSUSrzpc6+eD342v4ic3d/h9
	hQCJJyzX9Ke/w1rM7jMdZpqZaoH+JZ7gmR5NJwdRIaQWnGqsa/RlRrFQrZNHIMNJ
	F0Tk4kv06mQBAdjJaIMUYl6hEbrrAGlFSRLNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wobZKQf+XhgoP2mrJZUa6MVepnkg03lu
	nYYZVJfr+mmz75fo5N29/b4Z/KUWYXpvWUHZmu4bNhrC3o9y8Kyoc4lCJ5vkq2P2
	Mk2rw+SgnDTAl/WyZO7myKlxbZw027OoRaf2Hs2DqPhMXasAGBWYw8d5bm0ovP1S
	x0Q4lTUCH/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1424298E3;
	Sun,  9 Dec 2012 04:04:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 512E198E1; Sun,  9 Dec 2012
 04:04:07 -0500 (EST)
In-Reply-To: <CAEUsAPaHJ+N0EnxGuVkRqcmY0fUy+4myMiWtd1_vu1vRL763JQ@mail.gmail.com> (Chris
 Rorvick's message of "Sat, 8 Dec 2012 13:21:07 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 634363D2-41DF-11E2-BBFC-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211228>

Chris Rorvick <chris@rorvick.com> writes:

> It's not in branchA, it's just no longer ignored because your changes
> to .gitignore were effectively reverted by jumping back to the commit
> that branchA points to.
> ...
> "hide/reappear" is the equivalent to saying "deleted/created" in the
> case of a tracked file in your working tree.  But how would Git cause
> an untracked file to reappear?  By definition, it doesn't know
> anything about the file.

Nicely explained. To make something simply disappear, you could
remove it, but that is obviously not enough to make it reappear.  It
has to be stashed away somewhere before it gets removed, and in the
context of (any) SCM, that is done by committing.

You may have Mac and Windows branches, each of which needs to link
with vendor supplied object file blackbox.o with the rest of the
source.  It is understandable if a project does not want to mix such
platform specific black box binaries in the history of the source.

But that does not necessarily mean the project can totally ignore
what specific black box binary was meant to be used with the rest of
the source.

After you released the v1.0 of your product for both Macintosh and
Windows, the vendor may supply updated versions of the blackbox.o
binary for these platforms, and you would start working toward v1.1
of your product using these updated copies of objects.  Then you
find problems in the released v1.0 software.  Without keeping track
of which version of the object was used to build the released v1.0,
you cannot diagnose, build and test a maintenance update v1.0.1.

The project may add new Macintosh (or Windows) developers.  You can
tell new Macintosh developers to clone and checkout mac branch, and
in the same e-mail, give them the untracked blackbox.o file for that
platform, but you have to rely on human not making mistakes (you may
mistakenly send Windows version of blackbox.o to him, you may send
stale Macintosh version, the developer may misplace the new one and
keep using the stale one, etc. etc.).

Some people commit blackbox.o on each platform-specific branch, or
all branches share blackbox-win.o and blackbox-mac.o, only one of
which is used at any given branch, for this exact reason.

The project, for licensing reasons, may not have rights to
distribute such a blackbox object file along with its sources, but
the vendor of the blackbox object may allow individual developer to
download and link it from vendor's site.  In such a case, the
project would not want to (and is not allowed to) commit such object
file.  One approach I have seen used in such a case is to arrange
the build procedure so that these individual developers can drop
such an external object next to the project directory, and refer to
it as ../blackbox.o when linking.

So "these files are moved away from the working tree upon checking
another branch out, and moved back into the working tree upon
checking out this branch" is pretty much outside the scope of any
SCM.  It is not very interesting, as it is not necessary to solve
any real world problem.

Of course, the users can do whatever moving/copying/renaming of
untracked files in their post-checkout hook to be run when a new
branch is checked out.
