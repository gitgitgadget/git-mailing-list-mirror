From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Fri, 13 May 2005 16:05:57 -0700
Message-ID: <7vbr7e9162.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 01:09:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWjHL-00066r-1m
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVEMXGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 19:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVEMXGc
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 19:06:32 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62714 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262612AbVEMXGD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 19:06:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513230558.FOZK26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 19:05:58 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513224529.GF32232@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 00:45:29 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> that is, using a '@.' prefix for those. It seems to be unique enough and
PB> '@' is one of the four magic characters prefixing diff lines. Just using
PB> the plain string seems too volatile, and I need to grep all the
PB> interesting bits out of the diff file. This is because patch can
PB> otherwise complain "only garbage found in the patch" when processing the
PB> diff, which confuses my users greatly.

PB> What do you think?

Personally what I think is that grepping in the diff, especially
if the diff is something you are generating (I am assuming that
you are taling about cg-diff fed to cg-patch to port work tree
changes forward), is a wrong way to do things.

The way JIT does the equivalent is via git-apply-patch-script.
You run git-diff-{files,cache,tree}, setting GIT_EXTERNAL_DIFF
environment variable to git-apply-patch-script, and have the
apply-patch-script to take care of the mode changes, creation,
etc.  See the implementation of the jit-patch command if you are
interested.

