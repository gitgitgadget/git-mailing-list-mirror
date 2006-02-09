From: Ryan Anderson <ryan@michonline.com>
Subject: Re: What's in git.git
Date: Thu, 9 Feb 2006 18:30:59 -0500
Message-ID: <20060209233059.GH20880@mythryan2.michonline.com>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net> <12c511ca0602091514p35c3904bha8d5d406e5472969@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 00:32:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7LGq-0005z3-GN
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 00:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWBIXcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 18:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWBIXcN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 18:32:13 -0500
Received: from mail.autoweb.net ([198.172.237.26]:61384 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750827AbWBIXcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 18:32:12 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F7LGi-0002cn-F6; Thu, 09 Feb 2006 18:32:09 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F7LGh-0007JX-2c; Thu, 09 Feb 2006 18:32:08 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F7LG8-0008VX-UV; Thu, 09 Feb 2006 18:31:32 -0500
To: Tony Luck <tony.luck@intel.com>
Content-Disposition: inline
In-Reply-To: <12c511ca0602091514p35c3904bha8d5d406e5472969@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15838>

On Thu, Feb 09, 2006 at 03:14:59PM -0800, Tony Luck wrote:
> On 2/8/06, Junio C Hamano <junkio@cox.net> wrote:
> >  * If there are patches sent to improve a topic branch in it,
> >    they will be applied to the topic branch, and then the topic
> >    branch is merged into "next", without any funny rewinding or
> >    rebasing of "next".  This will make the "next" branch
> >    cluttered with repeated merges from the same topic branch,
> >    but that is OK.  "next" will not be merged into "master",
> >    ever.
> >
> >  * Once a topic is fully cooked, the topic branch will be merged
> >    into "master".
> 
> This is pretty much the workflow in my test/release branches (mostly
> documented in Documentation/howto/using-topic-branches.txt).
> 
> I've sometimes wondered about re-creating the topic branches in
> the case where there have been a series of follow-on commits
> before pulling them into the release branch.  The goal would be
> to present history not as it was, but as it should have been if we
> didn't have all the dumb mistakes and typos.
> 
> So is there an easy way in git to take the series of commits
> from a topic branch, make a new branch with all those commits
> as just one commit ... with an open editor on the concatenated
> commit comments (If there were just typo fixes the comment
> from the first commit would apply, but sometimes the follow-on
> commits would have substantive changes).

git checkout topic
git format-patch --stdout origin > topic-diff
$VISUAL topic-diff
# Fix comments
git checkout master
git checkout -b new-topic master
git-am topic-diff

.. done?

(I typically do something akin to this before sending patches to Junio,
by looking at the output of format-patch in a directory, editing,
combining a few changes if necessary, then re-committing, re-running
format-patch, and sending the output upstream.)

-- 

Ryan Anderson
  sometimes Pug Majere
