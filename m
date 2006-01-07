From: Junio C Hamano <junkio@cox.net>
Subject: Re: git format-patch shell quoting bug
Date: Fri, 06 Jan 2006 18:38:16 -0800
Message-ID: <7vhd8gpxt3.fsf@assigned-by-dhcp.cox.net>
References: <20060104045519.GB29515@quicksilver.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 03:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev3yI-0006Oj-TP
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 03:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965407AbWAGCiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 21:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965408AbWAGCiS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 21:38:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47060 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965407AbWAGCiS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 21:38:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107023718.FAH20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 21:37:18 -0500
To: Kyle McMartin <kyle@mcmartin.ca>
In-Reply-To: <20060104045519.GB29515@quicksilver.road.mcmartin.ca> (Kyle
	McMartin's message of "Tue, 3 Jan 2006 23:55:19 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14237>

Kyle McMartin <kyle@mcmartin.ca> writes:

> There's apparently a quoting bug in git-format-patch. When I import
> a patch with apply-mbox, for example
>
> From: Carlos O'Donell <carlos@parisc-linux.org>
>
> The author field is correctly set, including the "'" in Carlos' name.
> ...
> I believe this recently crept in, as I don't recall seeing it before.

Thanks for spotting this.

There was a similar problem with "git-commit -c".  I think I got
both of them right with commit aa66c7:

    commit aa66c7ec77d474b737da607d6cb2d07f56628def
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Thu Jan 5 19:50:37 2006 -0800

        format-patch/commit: Quote single quote in the author name properly.

        Noticed by Kyle McMartin.

        Signed-off-by: Junio C Hamano <junkio@cox.net>

The bug was present ever since format-patch started picking up
the original authorship information from the commits, done on
July 22nd last year, between v0.99.1 and v0.99.2.
