From: Kevin Ballard <kevin@sb.org>
Subject: Re: git-svn, merging et al.
Date: Fri, 16 May 2008 13:40:28 -0400
Message-ID: <05A51125-339A-45A2-B2CF-8035F2FAE741@sb.org>
References: <320075ff0805160850r473582d9qc33f71ba7f56dd51@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 19:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx3vl-0007Ns-6n
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 19:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977AbYEPRkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 13:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757979AbYEPRkc
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 13:40:32 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:48557 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757977AbYEPRkb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 13:40:31 -0400
Received: from [192.168.0.203] (c-24-91-11-245.hsd1.nh.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 1348C109EB6;
	Fri, 16 May 2008 10:40:29 -0700 (PDT)
In-Reply-To: <320075ff0805160850r473582d9qc33f71ba7f56dd51@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82309>

On May 16, 2008, at 11:50 AM, Nigel Magnay wrote:

> Ok - it's Friday and I've got to interact with svn again..
>
> I'm using git-svn, and I've not followed the guidance. Development has
> gone on in git branches and merges - but now I need to commit the
> changes back into svn, and dcommit is, understandably, not very happy.
>
> I'm intending to instead do something like a
>  git format-patch svn-branch..git-branch
>  git checkout svn-branch
> ... apply all the patches ...
>  git commit
>  git svn dcommit
>  # back to the git work
>  git checkout git-branch
>  # this shouldn't have to do merging - but it will have the parents
> to make it clear where the last merge happened from ?
>  git merge svn-branch
>
>
> I'm happy that I'm bludgeoning changes in one big blob into SVN, as I
> can reasonably say 'if you want the real details, go look at gitweb)
>
> I've tried doing this with
> git checkout svn-branch
> git merge --squash git-branch
>
> But I don't get the result I'm expecting - what have I missed?

That merge command will produce a single commit, which isn't what you  
want. format-patch + am should work to linearize history, but you  
could also use rebase.

I recommend trying something like

   git checkout -b test svn-branch && git format-patch svn-branch..git- 
branch | git am

Then you can examine your test branch to make sure it's linear, make  
sure it compiles and looks good, then if it's good merge that into svn- 
branch (which will be a fast-forward).

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
