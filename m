From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Wed, 14 Oct 2009 12:31:06 -0700
Message-ID: <7veip5db7p.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <200910131051.47117.trast@student.ethz.ch>
 <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
 <20091013220640.GB12603@coredump.intra.peff.net>
 <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de>
 <76718490910131805o42e8321ama85b90b7e901dc7d@mail.gmail.com>
 <7vfx9modqf.fsf@alter.siamese.dyndns.org>
 <76718490910140549l4a6b4f60je64d1b71a1a33d1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 21:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My9iP-000530-PH
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 21:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbZJNTcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759249AbZJNTcL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 15:32:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759085AbZJNTcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 15:32:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8136A5886C;
	Wed, 14 Oct 2009 15:31:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=GOrpvOuBeSnuCmM/hkaTcMFojag=; b=NI0nSBG/wGn6nQzVj0/CuJu
	qymanVtTyAEbB406w0Z2txyXw/wq4+eNQ3BfNLS98+69seqvLsfr4KbpyEiWr5KW
	TZOiAYOLFHWCoIBpXdgOmJ+lsWD8pLOOWcCFbrFbwEnmFgMgzCDoHPsoL7ylVKFO
	mCU9VPIxTCWJkG231HO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YthJOT9hyWxmmWJZ/QK9z6o01oSXiCzaOz0wPk9/y3pLVY0EQ
	0hz8/t+PgywY2vZnENML53KuiLysc8Hq8MLHaTSvIaBvTUKpb4FgPkvgTbtCJqBM
	g18gHXwoAXbgfnTN3VPtu9TLFgjDaLzF6Py8PND0Hwkh3WUkQJICQFT4aY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A1A458863;
	Wed, 14 Oct 2009 15:31:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B45E558861; Wed, 14 Oct
 2009 15:31:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 259C2492-B8F8-11DE-9A45-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130327>

Jay Soffian <jaysoffian@gmail.com> writes:

> What if instead we do something like this:
>
> $ git checkout v1.5.5
> Note: moving to 'v1.5.5' which isn't a local branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
>   git checkout -b <new_branch_name>
> HEAD is now at 1d2375d... GIT 1.5.5
> $ [edit foo.c]
> $ git add foo.c
> $ git commit -m "edited some file"
> Cannot commit to v1.5.5. Please use git commit -b <branch> to specify
> the name of a new branch to commit to, or use git commit --detach to
> force a detached commit.
>
> So we modify git to, by default, no longer allow creating a commit
> while detached or on a branch that cannot be committed to.

I'd probably object to such a change if there is no easy way to turn it
off per session (that means "expert mode" configuration variable, or a
command line option per "git commit" invocation, are not a viable escape
hatch), as I do it all the time, while reworking on an existing series.
E.g.

    $ git checkout $(git merge-base master topic)
    $ work on redoing topic
      - cherry-picking parts from topic~$n
      - editing
      - committing
    $ git show-branch HEAD topic
    $ git branch -f topic

is a very common sequence of how I personally work, at day-job and also
while maintaining git itself.

I probably would not mind such a change if I can say "I am detaching now
in order to build on a non-branch.  Do not bother me with unwarranted and
misguided helpfulness until I am done" once upfront when I perform the
first checkout.
