From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] RFC: proxy-command support for git://
Date: Thu, 3 Nov 2005 11:22:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511031117290.27915@g5.osdl.org>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
 <7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Collins <paul@briny.ondioline.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 20:25:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXkg9-00052r-Ni
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 20:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVKCTXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 14:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKCTXP
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 14:23:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932111AbVKCTXO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 14:23:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA3JMbnO009064
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 3 Nov 2005 11:22:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA3JMZZC024678;
	Thu, 3 Nov 2005 11:22:37 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11086>



On Thu, 3 Nov 2005, Junio C Hamano wrote:

> Paul Collins <paul@briny.ondioline.org> writes:
> 
> > I spend some of my time using a network that only allows outgoing TCP
> > connections to certain ports, and the git-daemon port is not one of them.
> > This patch below implements an analogue to ssh's ProxyCommand feature
> > for git, as a less messy alternative to ssh port forwarding.
> 
> Wonderful.
> 
> > Questions:
> >
> > * Can git already do this and I just failed to notice?
> 
> Maybe I just failed to notice this too, but I do not think so.

Actually, you could. TWO ways, in fact, afaik.

Just use the "ssh://host/pathname" format (or just "host:pathname") and 
the GIT_SSH environment variable.

You could also override the local command-name with

	git-send-pack --exec=my-local-send-program /machine/repo/path

where the "my-local-send-program" will parse /machine/repo/path thing. At 
least that works with git-send-pack, but it's possible it doesn't work 
with some other logic (ie "git push" might decide that it's unhappy that 
/machine/repo/path doesn't exist locally because it thinks it's a local 
path).

		Linus
