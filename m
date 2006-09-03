From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sun, 03 Sep 2006 14:00:17 -0700
Message-ID: <7vhczovf6m.fsf@assigned-by-dhcp.cox.net>
References: <20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<20060902045246.GB25146@spearce.org>
	<7vodty1swz.fsf@assigned-by-dhcp.cox.net>
	<20060902175408.GD27826@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 23:00:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJz4d-0006ie-MJ
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWICVAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWICVAF
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:00:05 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17334 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932133AbWICVAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 17:00:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060903210002.BGGG6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Sep 2006 17:00:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Hx031V00R1kojtg0000000
	Sun, 03 Sep 2006 17:00:03 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902175408.GD27826@spearce.org> (Shawn Pearce's message of
	"Sat, 2 Sep 2006 13:54:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26375>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> If rev-list had an extention that lets you say
>> 
>> 	rev-list --objects --all --unpacked=$active_pack |
>> 	pack-objects $new_pack
>
> Hmm.  Seems very reasonable actually.  :-)
>
> How do we pick the "active pack" in git-repack.sh?

I was hoping that will be a Porcelain policy issue I do not have
to decide ;-).

You could introduce repack.active in .git/config that points at
the latest active, make git-repack to notice and update when it
updates it.

We could also just use .git/objects/pack/pack-active.{pack,idx}
files.  This needs some surgery to get rid of packed_git.sha1[],
sha1_pack_name() and friends and have them only require .pack
and .idx are linked by their basename only as was discussed in a
separate thread to make it dumb-transport friendly.


-- 
VGER BF report: U 0.658122
