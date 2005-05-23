From: Junio C Hamano <junkio@cox.net>
Subject: Re: cogito - how do I ???
Date: Mon, 23 May 2005 00:40:40 -0700
Message-ID: <7v64xa75l3.fsf@assigned-by-dhcp.cox.net>
References: <20050521214700.GA18676@mars.ravnborg.org>
	<2765.10.10.10.24.1116713164.squirrel@linux1>
	<Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
	<20050523071919.GG23388@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 09:40:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da7XP-0004Hm-E5
	for gcvg-git@gmane.org; Mon, 23 May 2005 09:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVEWHks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 03:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEWHks
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 03:40:48 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:46588 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261863AbVEWHkm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 03:40:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523074040.TPBH23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 03:40:40 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050523071919.GG23388@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Mon, 23 May 2005 09:19:19 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

>> git-rev-tree MERGE_HEAD ^HEAD | git-diff-tree -v -m -s --stdin

TG> This doesn't work for me:

It should not.  "diff-tree --stdin" expects the line to begin
with an SHA1 and it either takes (1) one SHA1 followed by one
space followed by another SHA1 potentially followed by garbage
til the newline, or (2) one SHA1 potentially followed by garbage
til the newline.  rev-tree has the timestamp at the beginning
which does not match either of them.  What you are doing with
awk should work, so should this:

  git-rev-tree MH ^H | sed -e 's/^[0-9]* //' | git-diff-tree --stdin ...


