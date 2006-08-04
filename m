From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating objects manually and repack
Date: Fri, 04 Aug 2006 11:24:57 -0700
Message-ID: <7v64h8l5om.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	<Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	<9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	<Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	<Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	<9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	<9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	<Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
	<9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
	<Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
	<9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
	<Pine.LNX.4.64.0608041027530.5167@g5.osdl.org>
	<Pine.LNX.4.64.0608041052030.5167@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 20:25:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G94M3-0006t5-Ux
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 20:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWHDSZA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 14:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWHDSY7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 14:24:59 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15842 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932619AbWHDSY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 14:24:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804182458.ZQPI1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 14:24:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608041052030.5167@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 4 Aug 2006 11:06:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24815>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 4 Aug 2006, Linus Torvalds wrote:
>> 
>> You may definitely want to pack the pack-files together every once in a 
>> while. Doing so is not that hard: just list all the objects in all the 
>> pack-files you want to merge, which in turn is trivial from reading the 
>> index of the pack-files (and then you do want to do the filename, 
>> although you can just use the pack-file name if you want to). 

That would only work *once*, because the resulting pack would
now have blobs from two or more different files and you cannot
tell them apart.  So in order to collapse 110k packs into one,
you would pack packs into one every 330 packs, create trees and
commits for connectivity, and run the final repack -a -d over
the result, or something like that, I suppose...

> Btw, that index format is actually documented (and it really is _very_ 
> simple) in Documentation/technical/pack-format.txt.
>
> To get a list of all object names in a pack-file, you'd basically do just
> something like the appended.

git-show-index?
