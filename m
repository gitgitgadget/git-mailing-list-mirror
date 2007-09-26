From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 22:29:58 -0700
Message-ID: <7vlkau0zah.fsf@gitster.siamese.dyndns.org>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se>
	<46F96493.8000607@gmail.com>
	<20070925201717.GB19549@segfault.peff.net>
	<46F97618.9010207@gmail.com>
	<20070926004734.GA22617@segfault.peff.net>
	<46F9CA2A.7000107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 07:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaPTk-0002Tb-K6
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 07:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbXIZFaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 01:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbXIZFaI
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 01:30:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbXIZFaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 01:30:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 62C9013BC3D;
	Wed, 26 Sep 2007 01:30:22 -0400 (EDT)
In-Reply-To: <46F9CA2A.7000107@gmail.com> (Russ Brown's message of "Tue, 25
	Sep 2007 21:55:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59215>

Russ Brown <pickscrape@gmail.com> writes:

> I'm just wondering at this point why git lets you checkout remote
> tracking branches if it's something you really shouldn't do. Unless it's
> something you want to be able to do in edge cases to fix screwups maybe?

You actually never checkout "remote tracking branches".

You can be in two states, either you are on a branch (meaning,
if you create a commit, the new commit will have the current tip
commit of that branch as its first parent and will become the
new tip commit of that branch), or you aren't on _any_ branch.

The latter state is often affectionately called "detached HEAD"
state.

This is primarily useful for sightseeing.  Sometimes people
would want to check out a commit that is not a tip of any
branch.  The most typical one is "I want to have a checkout of
version 2.6.17", and people call that (loosely) as "checking out
a tag".  In the same way, you can "checkout a remote tracking
branch" (but if you want to be anal in terminology, you never
"check out a tag" nor "check out a remote branch"---you are
detaching your HEAD at the named commit (which could be the one
pointed at by the tag, or the one at the tip of your remote
tracking branch).

Detached HEAD state allows you to make further commits and
merges.  Because git allows you to create a new branch from the
current commit (i.e. whatever HEAD points at, be it on any
branch or detached) without losing local changes in the index
nor the work tree, this is often handy for doing quick fixups and
experiments --- you first start on detached HEAD and if it turns
out not to be so "quick" fixup, at that point you can create a
real branch so that you can continue working on it without
losing track.

> Thanks for this, it's very useful to read examples of workflows in
> actual use. In fact, I was thinking the other day that it would be good
> to have a site that acts as a directory of many different workflows,
> including descriptions of how they work, how you actually go about
> setting it up and using it day to day (i.e. lists of commands for each
> role/task) and the pros/cons that it provides. I reckon that would help
> newbies out quite a bit (if only for the examples). I've seen a few
> individual examples of workflow but nothing like a comprehensive set of
> them.

"Everyday" might be a good starting point for catalogs of
workflows for people playing various roles.
