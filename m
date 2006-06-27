From: Junio C Hamano <junkio@cox.net>
Subject: Re: CFT: merge-recursive in C
Date: Mon, 26 Jun 2006 17:27:13 -0700
Message-ID: <7vzmfzfnoe.fsf@assigned-by-dhcp.cox.net>
References: <20060626233838.GA3121@steel.home>
	<Pine.LNX.4.64.0606261652350.3927@g5.osdl.org>
	<Pine.LNX.4.64.0606261704390.3927@g5.osdl.org>
	<20060627002439.GD3121@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 02:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv1QE-0004ko-Vw
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 02:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWF0A1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 20:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWF0A1P
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 20:27:15 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:29158 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030261AbWF0A1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 20:27:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627002714.KWCT8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 20:27:14 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060627002439.GD3121@steel.home> (Alex Riesen's message of
	"Tue, 27 Jun 2006 02:24:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22703>

fork0@t-online.de (Alex Riesen) writes:

> Linus Torvalds, Tue, Jun 27, 2006 02:07:02 +0200:
>> > 
>> > git-diff-tree is one of the simplest git operations. We've got absolutely 
>> > _tons_ of infrastructure in place to do it efficiently, since it's done 
>> > all over the map (a "git-rev-list" with path limiting will do a diff-tree 
>> > against all the commits).
>> 
>> Side note - I think merge-recursive could/should be rewritten to use 
>> "git-merge-tree" instead of "git-read-tree -u -m". I suspect that the 
>> git-merge-tree output is in fact a lot closer to what git-merge-recursive 
>> actually wants to have.
>> 
>
> Yep. And does not touch the index, too. Cool...

Actually "does not touch the index" part is a defect in
merge-tree.  It is fine at the recursive level, but at the top
level we need to make sure the local changes do not interfere
with the merge.
