From: Christoph Mallon <christoph.mallon@gmx.de>
Subject: Re: git diff-tree against the root commit
Date: Sun, 07 Nov 2010 11:58:42 +0100
Message-ID: <4CD68662.4060709@gmx.de>
References: <4CCA6623.8090705@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 12:07:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF35c-0007sr-RI
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 12:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab0KGK6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 05:58:48 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:43150 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751482Ab0KGK6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 05:58:47 -0500
Received: (qmail invoked by alias); 07 Nov 2010 10:58:43 -0000
Received: from p5B14D520.dip.t-dialin.net (EHLO tron.homeunix.org) [91.20.213.32]
  by mail.gmx.net (mp006) with SMTP; 07 Nov 2010 11:58:43 +0100
X-Authenticated: #1673122
X-Provags-ID: V01U2FsdGVkX1+4W7V93t+4o0IV0vEMt3Wv5Vf49coTnUIkh504kh
	jrR4lWPgpXbRfV
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; de-DE; rv:1.9.2.12) Gecko/20101030 Thunderbird/3.1.6
In-Reply-To: <4CCA6623.8090705@workspacewhiz.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160874>

On 29.10.2010 08:13, Joshua Jensen wrote:
> I am mirroring a Git repository into another SCM.  I am using 'git diff-tree' to tell me what changes I need to make to the other SCM.
> 
> Today, I attempted to mirror a new submodule.  'git diff-tree' reported two SHAs... 0000000000000000000000000000000000000000 and the revision the submodule currently resides at.  I attempted to run a 'git diff-tree' within the submodule for the all zero SHA and the revision specified, but apparently, 0000000000000000000000000000000000000000 does not really represent the root commit and does not work.  I then discovered the --root option, but that doesn't seem to give me the complete file list either.
> 
> 'git diff-tree' has been working great for everything else, but I really need a root commit diff-tree listing for proper automation.
> 
> What are my options?

Diff against the empty tree. This gives you the treeish of the empty tree:
	git mktree < /dev/null
The result is 4b825dc642cb6eb9a060e54bf8d69288fbee4904. This magic number is used in git in several places. git's behaviour with parentless commits is somewhat annoying and/or broken.
