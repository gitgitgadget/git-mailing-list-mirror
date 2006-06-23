From: Junio C Hamano <junkio@cox.net>
Subject: Re: A series file for git?
Date: Fri, 23 Jun 2006 14:52:57 -0700
Message-ID: <7v64ira69y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
	<7virno79a7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
	<7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605292112530.5623@g5.osdl.org>
	<7vpshtyffk.fsf@assigned-by-dhcp.cox.net>
	<m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 23:53:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FttaM-00012x-5z
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 23:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbWFWVxA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbWFWVxA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 17:53:00 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35829 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1752090AbWFWVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 17:52:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623215258.MIUA8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 17:52:58 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Fri, 23 Jun 2006 05:37:34 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22440>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Is there any real difference between using git-format-patch | git-am
> and using git-am to apply patches.  I was using git-cherry-pick simply
> because it was easier to sha1 too.
>
> - When you reorder patches minor merge conflicts are common
>   so a big pipe won't work very often in practice.  So you
>   need a way to handle failures in the middle.

True.  The big pipe's answer to that question is that git-am
stashes what is fed to it just like when it is applying multiple
patches in .dotest/ and lets you continue from where a breakage
happened.  Also the way rebase (without the new --merge flag)
worked was to produce format-patch with full blob SHA1's on the
index lines and run git-am with --3way, so it can fall back on
three-way merge when the patch does not apply.  This often
resulted in "git-am --3way" detecting a patch that does not
apply, falling back to do a three way to notice that the patch
has already been applied.

I have to think about the rest of your message on "series" file.
