From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.5.1.2
Date: Sun, 22 Apr 2007 10:58:48 -0700
Message-ID: <7vvefonvdz.fsf@assigned-by-dhcp.cox.net>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
	<7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 19:58:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfgKs-0007cZ-A1
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 19:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbXDVR6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 13:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753973AbXDVR6u
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 13:58:50 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62206 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbXDVR6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 13:58:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422175849.QUHA1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 13:58:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qHyo1W00S1kojtg0000000; Sun, 22 Apr 2007 13:58:49 -0400
In-Reply-To: <alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 22 Apr 2007 10:22:47 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45256>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 21 Apr 2007, Junio C Hamano wrote:
>>
>> The latest maintenance release GIT 1.5.1.2 is available at the
>> usual places:
>
> Well, by "available" you probably mean "not available", because it doesn't 
> actually work.
>
> I get EPERM on pack-e00affefe0f779d0f9b0507aef25a1733f4a9117.idx/pack, 
> because they are
>
> 	-r-------- 1 junio junio  1120880
> 	-r-------- 1 junio junio 15709370
>
> respectively.

I've run fsck and then flipped the bits manually on these files
to unblock people, but I have no idea how this happened.  These
two were the only files that had the funny bits in the
repository.

        -r-------- 1 junio junio  1120880 Apr 22 06:46
        -r-------- 1 junio junio 15709370 Apr 22 06:46

I can tell from the output of "last" on that machine that I was
present and I am reasonably sure this was from "git repack -a -d"
I manually did.  But my umask is 0002...

Gaah.  "git repack -a -d" from 'master' leaves packs with 0400
mode (maint is fine).

> Oops.

Oops indeed.
