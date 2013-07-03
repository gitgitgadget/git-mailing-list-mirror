From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Wed, 03 Jul 2013 11:08:45 -0700
Message-ID: <7vppuzfrde.fsf@alter.siamese.dyndns.org>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
	<vpqehbgrnrx.fsf@anie.imag.fr>
	<CADL+T9Z=SrVyMMnYk3M7Dmb4c5xGiQtCTiDYaceKwB2-51TV-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Ed Hutchins <eh@demeterr.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 20:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuRU7-0004Od-HC
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 20:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab3GCSIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 14:08:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970Ab3GCSIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 14:08:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B780F2D37F;
	Wed,  3 Jul 2013 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IzQoqsWbnTm/+B1O0eUZ6YbH2og=; b=WDoVEy
	62e/cUFwIVklroiZTdIEWx/NruTTzvwxXxZU8UkJWFcx64ITjNptcXA7R7/aw0Nq
	jomqOxuWAt1R3P0ZONK8NLu86zf6Ypsd4ud+ZLh4utLEkH81td+euU/aCZftfl+6
	NRA4bg7XU0+8Yy+kU0/bDyF0yWuOMQGNERGUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0MQ0UlETcbPvM87Be7jBxFeGlhW87ZI
	2PBOk1DZ1X/kqjn0E/0bi1tLDwOzTItWXUSY4Xg1TUkwEAbpjiN70tKVjPLddffl
	+ZssAyDJEYl5DNfdggvSLBPZ8lvXquHqLS2LjuIQgXplp7zlXwBYwCFPzhWZIPjQ
	ftebc0YGuN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 016202D37D;
	Wed,  3 Jul 2013 18:08:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C073F2D37A;
	Wed,  3 Jul 2013 18:08:47 +0000 (UTC)
In-Reply-To: <CADL+T9Z=SrVyMMnYk3M7Dmb4c5xGiQtCTiDYaceKwB2-51TV-g@mail.gmail.com>
	(Ed Hutchins's message of "Wed, 3 Jul 2013 08:47:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B6E4348-E40B-11E2-9CA0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229502>

Ed Hutchins <eh@demeterr.com> writes:

> I'm not trying to change the way git does things (which works perfectly
> well), I'm asking for some extra information to be added to the commit
> so that analysis of the ancestry graph can be tied to the branch topics
> that the original author was working from. Currently if you have a
> rebase-branch/ff-merge-to-master workflow, the graph of commits looks
> like a single user produced all of the code. It would be very useful for
> both forensic and display purposes to categorize those commits by their
> original topics, but that history is lost in such a workflow.

I am not following that "a single user" part. As long as these
topics are done by different people, the authorship remains
separate, no matter what the shape of the graph is.

It all depends on what you show on the graph other than a circle and
connecting lines, but I presume at least you would show the subject
line. The graph would clearly show which groups of commits tackle
what problems in your history, even if you excessively linearlized
it by rebasing. You need subjects / commit log messages that are
better than "bugfix", of course, for it to work, though.

> Arguing that branch names are local and thus meaningless misses
> the point: branches are *names* which were meaningful to the
> author at the time the branch was being worked on.

That is not necessarily true.

Most of my commits start their life on a single branch that is named
after a very broad theme (or even on a detached HEAD) that ends up
touching different parts of the system and then later split into
separate topic branches that are named after more detailed single
issues. The name of the branch that happened to have been used to
create them have almost no meaning after I am done with multiple and
independent (but related in the larger scheme of things) topics.

It is not just misleading but is actively wrong to recording the
name of the original branch in commits and carrying them forward via
rebase. If you want a record of what a group of commits were about,
the right time to do so is when you merge.

Projects that care about the shape of the ancestry graph have an
obvious option of not excessively/unnecessarily linearlizing their
history. We even have the "--no-ff" mode of merge to create an
otherwise unnecessary merge to mark the point where a topic is
merged to the mainline, so that merge log messages can say what
topic was merged (and also you can even have "merge.log").

Cleaning up a messy history created on a topic branch before
presenting to others by lineralizing is one thing. It is a good
practice. Requiring any update to fast-forward on top of the tip of
the project is quite different. It does not make your history any
easier to read. A topic that has been working fine on top of last
week's trunk can have a subtle interaction with the work done by
others on the trunk since it forked, and rebasing it on top of
today's trunk, just before pushing it out on the trunk, risks
breaking the topic in a subtle way without the person who does such
a rebase without noticing, making later bisection harder.

Any option to encourage such an artificially linear history _is_
actively detrimental.
