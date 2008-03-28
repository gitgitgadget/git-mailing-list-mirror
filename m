From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: Truncating and cleaning a imported git repositary to make it more usable
Date: Fri, 28 Mar 2008 13:08:05 +0000
Message-ID: <b2cdc9f30803280608y501147c0tc02f43196bda4bf7@mail.gmail.com>
References: <1206707716.9819.15.camel@malory>
	 <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 14:08:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfEKF-0000wk-Oi
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 14:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbYC1NIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 09:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbYC1NIJ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 09:08:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:21587 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbYC1NIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 09:08:07 -0400
Received: by wr-out-0506.google.com with SMTP id c48so162871wra.1
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 06:08:06 -0700 (PDT)
Received: by 10.140.170.12 with SMTP id s12mr1353102rve.83.1206709685940;
        Fri, 28 Mar 2008 06:08:05 -0700 (PDT)
Received: by 10.140.161.13 with HTTP; Fri, 28 Mar 2008 06:08:05 -0700 (PDT)
In-Reply-To: <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 48323fd971bacf6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78404>

On Fri, Mar 28, 2008 at 12:50 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 3/28/08, Alex Bennee <kernel-hacker@bennee.com> wrote:
>  >  I've succeeded in porting our whole CVS repository into git (with plenty
>  >  of swap, cvsps is very memory hungry). Now we have a reference
>  >  historical repository I need to think about creating one we actually use
>  >  for day to day use (the .git is currently in the order of 650Mb which is
>  >  a little heavy for pushing around DSL links willy nilly).
>
>  You used git-repack and git-gc, right?  If not, the repo will be
>  bigger than it should be.

Oh yes. Unfortunately for 7 years of development of an embedded
platform there is a lot of cruft in the CVS repo :-(.

However as it needs to be a drop in replacement for the current repo
we can't just drop all the history and start from a fresh repo.

>  >  1. Find the common ancestor point for all the product branches I want to
>  >  keep in the repo.

>  "git show-branch -a" probably does what you want.

Cool. Or in fact git-show-branch --merge-base seems to be the baby.

I'm sure it's been mentioned before but the plethora of git commands
can make it hard to find the commands you want even
if your sure there is some way of doing it :-)

>  >  2. Create a new repo, starting at the common ancestor point
>  >
>  >   2(a). I'd need to remove the orphaned old CVS modules which are still
>  >  around but not referenced any more.
>  >
>  >  3. Create the product branches and import ANCESTOR..BRANCH_HEAD into
>  >  them
>
>  You probably want to look at git-filter-branch, particularly the
>  --parent-filter option.
>
>  Note that 2(a) would be easiest if you just did it before importing
>  from CVS at all, since it's easy to remove old modules from CVS just
>  by moving the files out of the way.

Trouble is looking at the current repo I'm not sure which modules are
orphans (at the common anscestor point) and which have been added
since.

Of course now I can easily go back in time (easier than in CVS) I can
build up this list.

>  Have fun,

For certain values of fun ;-)

-- 
Alex, homepage: http://www.bennee.com/~alex/
