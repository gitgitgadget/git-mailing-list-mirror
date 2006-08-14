From: Junio C Hamano <junkio@cox.net>
Subject: Re: Validation of a commit object?
Date: Mon, 14 Aug 2006 14:32:06 -0700
Message-ID: <7vr6zjdmw9.fsf@assigned-by-dhcp.cox.net>
References: <20060814062830.GF18667@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 23:32:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCk2h-0003a8-RH
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 23:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWHNVcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 17:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWHNVcJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 17:32:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3753 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964975AbWHNVcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 17:32:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814213207.BPCH12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 17:32:07 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25413>

Shawn Pearce <spearce@spearce.org> writes:

> I'm thinking that can't be right.  Shouldn't fsck-objects be doing
> better checking on commits?
>
> The reason I ask is I'm working on my (bastard) fast-import program
> for Jon's Mozilla CVS -> GIT conversion effort and I'm taking the
> author and committer lines blind from the Python code.  If the
> Python code gives me a bad line its going to go into the pack that
> way, with that possibly resulting in a totally corrupt repository.
> I hoped to apply the same verification that fsck-objects applies
> but apparently it doesn't do anything.  :-)
>
> I'm willing to write some better validation in fsck-objects.c
> and submit the patch if folks think we should do stronger checks
> in there.

Historical repositories (e.g. very early days of git, linux-2.6
just after 2.6.12-rc2, and sparse) used to have commit objects
that recorded committer dates in RFC2822 format not the current
unixtime format.  I think all of them have been converted later,
but not warning or checking these fields may be related to it.

In general stricter check is always preferred.  I just wanted to
mention the older repositories as something we might want to
keep in mind.
