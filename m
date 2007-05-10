From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Merging commits together into a super-commit
Date: Thu, 10 May 2007 13:40:12 +0200
Organization: eudaptics software gmbh
Message-ID: <4643049C.3D5F30D8@eudaptics.com>
References: <1178794261.5806.98.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 13:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm7Fb-0007VG-8o
	for gcvg-git@gmane.org; Thu, 10 May 2007 13:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438AbXEJLz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 07:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758676AbXEJLz6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 07:55:58 -0400
Received: from main.gmane.org ([80.91.229.2]:34875 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758440AbXEJLz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 07:55:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hm793-0006Yf-FJ
	for git@vger.kernel.org; Thu, 10 May 2007 13:49:17 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2007 13:49:17 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2007 13:49:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46861>

Alex Bennee wrote:
> I really love the fact I can micro-commit changes when I'm developing.
> However at some point the combination of changes I have made can be
> considered a single body of work. This is especially true when you start
> doing things like re-basing on code that has moved around a lot. You
> don't want to be correcting a whole bunch of merge failures for every
> commit in your current tree.
> 
> So far the only was I can see to do this is a:
> 
> git-diff master..HEAD > my.patch
> 
> And then re-applying your patch in stages, manually doing the commits.
> 
> Am I missing something?
> 
> I'm thinking something like git-cherrypick taking multiple commits and
> create a new super commit on a new tree. i.e.:
> 
> git-cherrypick -m "Valgrind fixes" 12345.. 12678.. 565757..
> 
> Merging the existing commit comments would be nice too.

Here we go:

- cherry-pick them before commit

  $ git cherry-pick -n x
  $ git cherry-pick -n y
  $ git cherry-pick -n z
  $ git commit -m "$(for c in x y z; do git show --stat $c; done)" -e

- merge in a single commit

  $ git merge --squash foo

You didn't really think that git couldn't do that, did you? ;)

-- Hannes
