From: Junio C Hamano <junkio@cox.net>
Subject: Re: [0/5] Parsers for git objects, porting some programs
Date: Mon, 18 Apr 2005 18:15:40 -0700
Message-ID: <7v7jizsh1f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0504181558180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 03:12:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhHl-0007RI-Rx
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVDSBQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDSBQR
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:16:17 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:999 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261251AbVDSBQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 21:16:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050419011540.AHA18934.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 21:15:40 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504181558180.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Mon, 18 Apr 2005 16:12:00 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> On Mon, 18 Apr 2005, Linus Torvalds wrote:
>> On Sun, 17 Apr 2005, Daniel Barkalow wrote:
>> >
>> > This series introduces common parsers for objects, and ports the programs
>> > that currently use revision.h to them.
>> > 
>> >  1: the header files
>> >  2: the implementations
>> >  3: port rev-tree
>> >  4: port fsck-cache
>> >  5: port merge-base
>> 
>> Ok, having now looked at the code, I don't have any objections at all. 

I was looking at the tree part and am thinking that it would
make it much nicer if your tree object records path for each
entry.  Currently it just borrows from object.refs to represent
its children, which is good enough for the applications listed
above (none of them would care where in the tree the object
belongs to), but I was thinking about an incremental dumper I
talked about in another thread and noticed that I cannot use the
current struct tree as is to compare two trees to find related
sha1 files (then I would inflate both, run diff and record the
output as a recipe to create one sha1 object from the other).

Or am I misreading the code that parses tree objects?

