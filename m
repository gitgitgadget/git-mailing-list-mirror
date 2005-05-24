From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 12:24:35 -0700
Message-ID: <7vu0kstojw.fsf@assigned-by-dhcp.cox.net>
References: <1116626652.12975.118.camel@dhcp-188>
	<Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
	<428E745C.30304@zytor.com>
	<Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
	<4292A08A.5050108@cobite.com>
	<Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
	<20050524161745.GA9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<20050524182951.GB9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241146500.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 21:24:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaezX-0000k6-Fg
	for gcvg-git@gmane.org; Tue, 24 May 2005 21:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVEXTYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVEXTYl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 15:24:41 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35457 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261959AbVEXTYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 15:24:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524192434.IDVI19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 15:24:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241146500.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 11:52:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Perhaps more interestingly, it should also mean that you can _continue_ to 
LT> use CVS, then re-convert it at a later date, and I think you should be 
LT> able to merge with somebody who has been using git in the meantime.

LT> In contrast, if you have fancy name translation, the converted tree will 
LT> obviously depend on your translation rules.

LT> I dunno. Maybe the advantages of having nice names outweigh the 
LT> disadvantage of possibly generating incompatible trees.

LT> 			Linus

Porcelain layers should be capable of mapping author/committer
names taken out of the commit object, just like they already
convert the human unreadable unixtime value into something human
readable.  I'd vote for keeping the original value taken from
CVS for this particular "conversion" application.

What _all_ Porcelain layer implementation would benefit from is
if we had a common output format routine that is similar to the
spirit of show_date() function.  Have format_commit_fancy()
function that takes a commit object and have it do the mapping.
Then everybody can use it for their own Porcelain.

The diff-tree header generation can use it when (and only when)
it is operating under a new flag (--map-author-names), to
prettyprint the author names.  I'd also suggest to have a flag
to reduce the prettyprinting it does in the current output (like
omitting committer information) to make its output be usable for
reproducing the commit history exactly.  diff-tree with recent
enhancement you did (I am talking about single commit output and
--stdin, not my diffcore stuff) has become quite useful tool for
this kind of thing.


