From: Junio C Hamano <junkio@cox.net>
Subject: Re: recur status on linux-2.6
Date: Thu, 17 Aug 2006 21:09:18 -0700
Message-ID: <7vwt96d6s1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64gwmv2j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608132006510.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vveowl8sm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608132221030.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 06:09:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDvfk-0002KC-8w
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 06:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWHREJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 00:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWHREJV
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 00:09:21 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43235 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030402AbWHREJT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 00:09:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818040918.GHKZ6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 00:09:18 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25623>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 13 Aug 2006, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > I fail to see how this is worse than -recursive...
>> 
>> These are what I got.  ls-files -u output followed by git diff.
>
> I am a little confused here: I thought it would be enough to compare the 
> outputs of "git-ls-files --stage". But that seems wrong.
>
> What are the stages for, again?

I do not offhand remember what git-merge-recursive and
git-merge-recur store in stage #1 when they recurse to create a
virtual common ancestor.  I expected it would contain the blob
used as the base for the final file-level three-way merge
(i.e. the blob in the virtual common ancestor), and if that is
the case, i.e. if the blob matches the second argument for
"merge" (from RCS), it should be enough to check that the stages
match to verify two implementations do the same thing.

But in practice, stage #1 is not very interesting nor useful
after a conflicted merge (git diff --ours and git diff --theirs
are more useful, so is git log -p --merge), so it is possible
that merge-recursive is leaving the blob from one of the true
common ancestors there while using the blob from the virtual
common ancestor to produce the final result in the working tree
and nobody has noticed.  I dunno.
