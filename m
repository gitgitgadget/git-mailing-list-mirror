From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 09:45:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
 <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 11 18:46:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7yp2-00043o-E0
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 18:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWBKRqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 12:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWBKRqF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 12:46:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbWBKRqE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 12:46:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1BHjvDZ011787
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 09:45:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1BHju6V007427;
	Sat, 11 Feb 2006 09:45:56 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15953>



On Fri, 10 Feb 2006, Junio C Hamano wrote:
> 
> It probably should default to quiet if (!isatty(1)).

Sounds fine. isatty(2), though, since we use stderr for these messages 
(stdout is usually the data-stream).

> The real improvement, independent of this client-side patch,
> would be to reuse recently generated packs, but that needs
> writable cache directory on the server side.

More importantly, it really wouldn't have helped that much in this 
situation. At least for me, the network is 90% of the problem, the 
pack-file generation is at most 10%. So cached packfiles really only 
matter for server-side problems (high CPU load, or lack of memory, or 
heavy disk activity).

So the problems really are very independent.

			Linus
