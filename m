From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Truncating and cleaning a imported git repositary to make it more
	usable
Date: Fri, 28 Mar 2008 12:35:16 +0000
Message-ID: <1206707716.9819.15.camel@malory>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 13:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfDnu-00069v-87
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 13:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbYC1Mer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 08:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753581AbYC1Mer
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 08:34:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:39261 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbYC1Mer (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 08:34:47 -0400
Received: by fg-out-1718.google.com with SMTP id l27so262021fgb.17
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 05:34:43 -0700 (PDT)
Received: by 10.82.121.20 with SMTP id t20mr5433159buc.20.1206707682991;
        Fri, 28 Mar 2008 05:34:42 -0700 (PDT)
Received: from ?192.168.250.3? ( [86.15.108.50])
        by mx.google.com with ESMTPS id l12sm2030094fgb.8.2008.03.28.05.34.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Mar 2008 05:34:41 -0700 (PDT)
X-Mailer: Evolution 2.12.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78399>

Hi,

I've succeeded in porting our whole CVS repository into git (with plenty
of swap, cvsps is very memory hungry). Now we have a reference
historical repository I need to think about creating one we actually use
for day to day use (the .git is currently in the order of 650Mb which is
a little heavy for pushing around DSL links willy nilly).

What I need to achieve is fairly simple.

1. Find the common ancestor point for all the product branches I want to
keep in the repo.

Can anyone point me to the magic invocation that would allow this?
git-merge-base can find the common point for two commits, do I just have
to iteratively use that?

I'm currently working over a terminal link so it would be dead handy if
there was a visual way of showing what gitk --all does on the command
line.

2. Create a new repo, starting at the common ancestor point

  2(a). I'd need to remove the orphaned old CVS modules which are still
around but not referenced any more.

3. Create the product branches and import ANCESTOR..BRANCH_HEAD into
them

I'm not sure if I could pull directly into the new repo here. I could do
it by doing a:

  old_repo: git-format-patch ANCESTOR..BRANCH_HEAD
  new_repo: git-am ../old_repo/0*

But I'm open to newer cleaner ways of dealing with this.

Has anyone done this before? Are there cleaner ways of dealing with
this?

--
Alex, homepage: http://www.bennee.com/~alex/
When one knows women one pities men, but when one studies men, one
excuses women. -- Horne Tooke
