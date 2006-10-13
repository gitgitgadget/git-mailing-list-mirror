From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Fri, 13 Oct 2006 14:22:46 -0700
Message-ID: <7v64endi6x.fsf@assigned-by-dhcp.cox.net>
References: <11607177011745-git-send-email-junkio@cox.net>
	<11607177024171-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0610130912500.2435@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 23:23:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYUUj-0003gy-9o
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 23:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWJMVWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 17:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWJMVWt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 17:22:49 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64669 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932073AbWJMVWs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 17:22:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013212247.HYGO18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 17:22:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZxNq1V00M1kojtg0000000
	Fri, 13 Oct 2006 17:22:50 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28861>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 12 Oct 2006, Junio C Hamano wrote:
>
>> This new option makes the resulting pack express the delta base
>> with more compact "offset" format.
>
> Actually I thought about making it the default whenever git-pack-objects 
> supported it, and use a negative option with git-repack to disable it 
> instead.
>
> The fact is that there is little reason for not using delta base offsets 
> in most cases and specifying -b all the time would become more of an 
> annoyance.
>
> What do you think?

The only time it matters is if the packs in repository being
repacked needs to be readable by older git, which I think is
only when somebody with older git uses commit walkers to
download the pack into a remote repository to use.  Using or not
using delta-base-offset is tied to each repository, and in a
sense that is similar to "repository format version".

So how about

	[core]
        	repackUseDeltaBase = true
