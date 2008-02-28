From: Charles Bailey <charles@hashpling.org>
Subject: Re: cookbook question
Date: Thu, 28 Feb 2008 22:58:38 +0000
Message-ID: <20080228225838.GA31479@hashpling.org>
References: <47C704BB.2010707@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Kyle Rose <krose@krose.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 23:59:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUrj6-0002uH-1Y
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 23:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758449AbYB1W6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 17:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758567AbYB1W6w
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 17:58:52 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:34515 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758437AbYB1W6v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 17:58:51 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1JUri9-0006Zb-AZ; Thu, 28 Feb 2008 22:58:49 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1SMwd4O000787;
	Thu, 28 Feb 2008 22:58:39 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1SMwc7O000786;
	Thu, 28 Feb 2008 22:58:39 GMT
Content-Disposition: inline
In-Reply-To: <47C704BB.2010707@krose.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: 45517ce58e95db2f88d46d7995a5b122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75473>

On Thu, Feb 28, 2008 at 02:00:11PM -0500, Kyle Rose wrote:
> In maintaining a postfix config that differs maybe 10% between two 
> different machines, I have a "common" branch that has ???? in the fields 
> that differ.  I realized after speaking with one of the git developers a 
> few weeks ago that I really should be using git-rebase to fix up the 
> machine-specific branches when I make a change to the common branch.  
> Unfortunately, the merge history was screwed up enough such that doing
>
> git rebase -s ours origin/common
>
> replaced one machine-specific config with the other, which is not what I 
> wanted.
>
> In order to reset things to a state in which git-rebase would be useful, I 
> did the following:
>
> git diff origin/common >/tmp/diff
> git reset --hard origin/common
> patch -p1 </tmp/diff
> git commit -a -m 'reintroduce changes'
>
> which works fine, but is obviously not the right way to do this.  What *is* 
> the right way to accomplish this?  Essentially, I'm trying to reset the 
> rebase point such that git won't rewind earlier when trying to do 
> subsequent rebases.
>
> Kyle
>

I'm not sure I understand your problem fully. Why do you think you
need to rebase?

As far as I can tell your 4 line script is equivalent to:
git reset --soft origin/common
git commit -m 'reintroduce changes'

but I don't understand why you'd want to do this.

I presume that origin/common contains changes to the common part of
the config files that you want to apply to both machines. If the two
machines' configs were originally branched from origin/common and then
had there custom changes made and committed, you should just be able
to merge subsequent changes from origin/common and not get conflicts
unless there are genuinely changes to the parts of the configs that
have been modified for the individual machines. I don't see a case for
rebase in your example.
