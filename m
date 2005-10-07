From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Fri, 07 Oct 2005 10:01:33 -0700
Message-ID: <7v8xx55kia.fsf@assigned-by-dhcp.cox.net>
References: <20051005214447.GF15593@reactrix.com>
	<Pine.LNX.4.63.0510061550510.23242@iabervon.org>
	<20051007000041.GH15593@reactrix.com>
	<Pine.LNX.4.63.0510071149550.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 19:03:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENvbV-0006rO-EA
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 19:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbVJGRBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 13:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbVJGRBg
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 13:01:36 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36288 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030509AbVJGRBf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 13:01:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007170122.PWH29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 13:01:22 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510071149550.23242@iabervon.org> (Daniel
	Barkalow's message of "Fri, 7 Oct 2005 12:23:01 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9807>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> > It should be fine to download objects and a pack that contains them at the 
>> > same time, although there's currently a check in fetch.c which should be 
>> > removed, so that it will call fetch() for an object if the object appears 
>> > between the prefetch() and the fetch().
>> 
>> Can you provide a patch, or point me toward the right place to make that
>> change?
>
> It's line 168 of fetch.c; the "!has_sha1_file(obj->sha1)" part should go 
> away.

The check was added in 029f6de377c7e0484f5c4cf070934599580f1784
because back then calling fetch() on an object that we already
had had a funny interaction with what http-fetch.c did.  I
suspect that Nick's curl-multi changes made it unnecessary, but
you should double check for other transports.
