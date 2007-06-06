From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git does the wrong thing with ambiguous names
Date: Thu, 7 Jun 2007 00:58:26 +0200
Message-ID: <20070606225826.GC3969@steel.home>
References: <4667319C.9070302@nrlssc.navy.mil>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:58:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw4Sb-0003gG-CN
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965647AbXFFW6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965637AbXFFW6b
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:58:31 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:21388 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965269AbXFFW63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:58:29 -0400
Received: from tigra.home (Fa87f.f.strato-dslnet.de [195.4.168.127])
	by post.webmailer.de (klopstock mo51) (RZmta 7.2)
	with ESMTP id C04585j56JY39Y ; Thu, 7 Jun 2007 00:58:26 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5D4D1277BD;
	Thu,  7 Jun 2007 00:58:26 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3B83EBEA7; Thu,  7 Jun 2007 00:58:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4667319C.9070302@nrlssc.navy.mil>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49333>

Brandon Casey, Thu, Jun 07, 2007 00:13:48 +0200:
> 
> When a branch and tag have the same name, a git-checkout using that name 
> succeeds (exits zero without complaining), switches to the _branch_, but 
> updates the working directory contents to that specified by the _tag_. 
> git-status show modified files.

Bad. To reproduce:

mkdir a && cd a && git init && :> a && git add . && git commit -m1 &&
:>b && git add . && git commit -m2 && git tag master HEAD^ &&
find .git/refs/ && gco -b new && gco master && git status


> Looks like the ambiguity issue was brought up last year, and git is now 
> *supposed* to warn when it encounters an ambiguous name. I agree with 
> Petr, it should fail violently, preferably as Josef Weidendorfer 
> suggests also printing out the ambiguous matches so the user can cut and 
> paste.
> 

That'd be failing friendly :) Very good idea
