From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 3 Jan 2010 11:32:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com> <7v637nzky0.fsf@alter.siamese.dyndns.org> <7vzl4zy5z3.fsf@alter.siamese.dyndns.org> <20100102115041.GA32381@do> <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com> <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com> <877hrzga16.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jan 03 20:32:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRWBw-00065z-4d
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 20:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab0ACTcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 14:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072Ab0ACTcd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 14:32:33 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58889 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940Ab0ACTcc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jan 2010 14:32:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o03JWOV9023834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Jan 2010 11:32:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o03JWONF020144;
	Sun, 3 Jan 2010 11:32:24 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <877hrzga16.fsf@catnip.gol.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.67 required=5 tests=AWL,BAYES_00,FH_DATE_PAST_20XX,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136082>



On Sun, 3 Jan 2010, Miles Bader wrote:
> 
> Since it's a general attribute of solaris that the default (/usr/bin)
> tools are horrible sysv things and the actual useful tools are in
> e.g. /usr/xpg4/bin, maybe it would be better to just try and add that
> directory to the path...?

There is no generic way to make solaris sane, I'm afraid.

Everybody agrees that the "normal" Solaris tools are so horrible that they 
all set up some alternative. However, qutie often the preferred 
alternative is the GNU versions, mostly installed in /usr/local, and then 
they put that first in the path.

Which means that if you put /usr/xpg4/bin before other paths in your PATH, 
you'll totally break such systems, because now you get the (inferior) 
tools in xpg4 before the preferred tools in /usr/local. Or - this also 
happens - people end up installing their own versions in $HOME/bin, 
because the system admin is uncaring or incompetent.

In other words, there is no single normal or default Solaris installation 
that we can work around. The normal/default installation is so horrible 
that it's virtually never used in any environment where people actually 
have shell access and do development.

Don't ask me why. EVERYBODY knows that the default /usr/bin is total crap. 
Even Sun people know. But there's apparently some very deep-seated reason 
(probably not technical, but mental/historical) why they can't be fixed or 
replaced, probably relating to "make world" and the whole build system.

			Linus
