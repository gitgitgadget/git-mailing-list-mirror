From: Marc Weber <marco-oweber@gmx.de>
Subject: What about allowing multiple hooks?
Date: Fri, 21 Nov 2008 14:38:28 +0100
Message-ID: <20081121133828.GB5912@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 14:40:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3WEj-0004fw-RG
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 14:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbYKUNid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 08:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYKUNic
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 08:38:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:33087 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753113AbYKUNib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 08:38:31 -0500
Received: (qmail invoked by alias); 21 Nov 2008 13:38:28 -0000
Received: from pD9E09E33.dip.t-dialin.net (EHLO nixos) [217.224.158.51]
  by mail.gmx.net (mp053) with SMTP; 21 Nov 2008 14:38:28 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX19hvDIBwzphjGeNeKnSga2HxUsd7CvSGNNI4vqjOP
	XC2lXKR0qI/kS4
Received: by nixos (sSMTP sendmail emulation); Fri, 21 Nov 2008 14:38:28 +0100
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101527>

Use case:

I've been reading parts of the topGit code. And it does make for it to
add its own checks. However having to change the existing scripts
insterting a call to the tg hooks isn't the best way.
Why? one is using #/bin/sh the next is using #/bin/ruby maybe..

So what about allowing (or even enforcing) ths directory layout?

.git/hooks/pre-commit/hook1.sh
.git/hooks/pre-commit/hook2.sh
.git/hooks/pre-commit/topGitcheck.sh

instead of
.git/hooks/pre-commit # <- the one and only pre-commit hook

so that all can be run in squence?

This way you can keep the original git sample files and update them
while adding you very own checks more easily.

But maybe this isn't the best choice either and the way to go is

.git/hooks/list-of-hook-directories # eg containing ".git/hooks/samples\n.git/hooks/topgit" ?

.git/hooks/sample/<all the sample hook files>
.git/hooks/topgit/pro-commit

?

Then you can actually link in your own personal check script directories
easily *and* you can add them to the repository eg by using
comitted-repo-hooks instead of .git/hooks
?
This way you could provide different hook directories for different
platforms and all you have to do is enabling them by adding the path to
.git/list-of-hook-directories ?

I guess the second approach of defining kind of overlays is better
because it doesn't interfer with the existiing scheme?
Maybe it should be implemented as git config option instead of a file
containing the list of directories?

The hook direcotry list apporach is better because you've more control
about order of execution..

Thoughts?

Marc Weber
