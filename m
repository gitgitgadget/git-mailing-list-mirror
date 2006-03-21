From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 16:57:39 -0800
Message-ID: <7v8xr4iph8.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<200603201730.19373.Josef.Weidendorfer@gmx.de>
	<7voe00iupp.fsf@assigned-by-dhcp.cox.net>
	<200603210126.59870.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 01:57:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLVBx-0000gO-Ri
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 01:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWCUA5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 19:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWCUA5m
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 19:57:42 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54478 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751403AbWCUA5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 19:57:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060321005547.ZIGE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Mar 2006 19:55:47 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200603210126.59870.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 21 Mar 2006 01:26:59 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17774>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> I think what is reasonable is something like this:
>> 
>>  - If you start from a repository cloned in the traditional
>>    way, the upstream "master" is kept track of with your
>>    "origin", so "diff origin master" would be "my changes on top
>>    of the upstream".
>
> Yes. And it would be nice if the same would work with the new layout,
> assuming that there is no local "origin" branch, but a .git/remotes/origin
> file and .git/refs/remotes/origin directory.

My primary aversion comes from that I'd rather avoid teaching
the really core stuff about .git/remotes file, and the part that
interprets refname is fairly a low-level part.

We _could_ record refs/remotes/origin/HEAD that points at
refs/remotes/origin/master (or some other branch) upon cloning,
and if Pasky wants to do something similar upon fetching, that
fetch command could do the same thing.
