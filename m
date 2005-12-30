From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make GIT-VERSION-GEN tolerate missing git describe
 command
Date: Fri, 30 Dec 2005 10:49:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512301046230.3249@g5.osdl.org>
References: <dp3mtp$rfm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 19:49:28 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsPJc-0000oz-Je
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 19:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVL3StT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 13:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVL3StT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 13:49:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751278AbVL3StS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2005 13:49:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBUInEDZ001246
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Dec 2005 10:49:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBUInDgg023259;
	Fri, 30 Dec 2005 10:49:13 -0800
To: John Ellson <ellson@research.att.com>
In-Reply-To: <dp3mtp$rfm$1@sea.gmane.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14115>



On Fri, 30 Dec 2005, John Ellson wrote:
>
> I think it is probably a bug that "git non_existent_command"
> returns its error message to stdout without an error, where
> "git-non_existent_command" behaves differently and does return an
> error.
> 
> Older versions of git did not implement "git describe"  and
> GIT-VERSION-GEN produces an empty version string if run on
> a system with such a git installed.  The consequence
> is that "make rpm" fails.
> 
> This patch fixes GIT-VERSION-GEN so that it works in the
> absence of a working "git describe"

Shouldn't you make "git.c" return an error too, so that "git-describe" and 
"git describe" both fail properly?

I realize that you'd want to do your patch _too_ (in case somebody has an 
old version of "git" installed), but I just think it would be sensible to 
fix the problem that causes this in the first place..

Continuing to output to stdout rather than stderr is probably a good idea 
(so that it's easy to do "git help | less" or something), but yeah, I 
think an unrecognized command should at least return an error.

		Linus
