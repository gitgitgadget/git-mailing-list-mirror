From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 16:02:43 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org>
References: <C3AC3E6F.10D42%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 01:03:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD7Mn-0001lc-VA
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 01:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbYAKACy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 19:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbYAKACy
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 19:02:54 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41858 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754219AbYAKACy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2008 19:02:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0B02iP1001939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jan 2008 16:02:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0B02ht5016170;
	Thu, 10 Jan 2008 16:02:44 -0800
In-Reply-To: <C3AC3E6F.10D42%jefferis@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.423 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_84
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70111>



On Thu, 10 Jan 2008, Gregory Jefferis wrote:
> 
> So this is what has to be accommodated.  But instead of having autocrlf
> always set on Windows and always converting to LF in the repository, why not
> do nothing by default [ .. ]

Why? You can screw yourself more, and much more easily (and much more 
subtly), by leaving CRLF alone on Windows.

The thing is, 99.9% of all people will be *much* better off with 
autocrlf=true on Windows than with it defaulting to off (or even fail).

Isn't *that* the whole point of having a default? Pick the thing that is 
the right thing for almost everybody?

And no, "but think of the children.." is not a valid argument. Sure, you 
*can* corrupt binary imags with CRLF conversion. But it's really quite 
hard, since the git heuristics for guessing are rather good. You really 
have to work at it, and if you do, you're pretty damn likely to know about 
the issue, so that 0.1% that really needs to not convert (and it's usually 
one specific file type!) would probably not even turn off CRLF, but rather 
add a .gitattributes entry for that one filetype!

(Side note: if there are known filetype extensions that have problems with 
the git guessing, we sure as heck could take the filename into account 
when guessing! There's absolutely nothing that says that we only have to 
look at the contents when guessing about the text/binary thing!)

			Linus
