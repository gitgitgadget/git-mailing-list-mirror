From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Wed, 05 Oct 2005 19:59:34 -0600
Message-ID: <m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
	<7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
	<7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 04:05:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENL4e-0007Li-LN
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 04:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVJFCBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 22:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVJFCBG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 22:01:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27010 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750707AbVJFCBF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 22:01:05 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j961xaPx017592;
	Wed, 5 Oct 2005 19:59:36 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j961xZgn017591;
	Wed, 5 Oct 2005 19:59:35 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslvfcy0g.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 05 Oct 2005 17:03:27 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9755>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> ... Although I would actually prefer to be able to try against
>> a specific named release (not "all named tags" first).
>
> That makes sense, given that you know better than the tool can
> possibly guess, especially from the performance point of view.
>
> What's interesting is that from the correctness point of view,
> it should not make that much of a difference which base tree
> happens to be picked -- if the base tree is wildly different
> from your current HEAD, most of that wild difference will be
> carried over intact to the result of patch application for paths
> and parts of the files the patch does not touch.  Three-way
> merge notices that and your "changes" from the base tree win.

There is another workable strategy.  Modify git-diff-xxx to report
the sha1 of the tree, or the sha1's of the files the patch applies to.
And make that information available to git-apply.  I don't how often
it would help but it has the possibility of letting the tools know
exactly what the patch applied against.

A rational for why this would work is that is that a kernel repository
is large,  and unless objects/alternatives can be made to work across
servers there will be people who can use git for development but can't
host a repository that can be pulled from.   Especially for a small
patch.

Using sha1's for context before merging should be able to give you a
whole lot more machine verifiable context with just a little bit of work. 

Eric
