From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 04:13:53 -0700
Message-ID: <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
	<Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
	<A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 22:28:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOi4-0001zd-1T
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWDVU2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWDVU2A
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:28:00 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:50637 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751150AbWDVU17 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:27:59 -0400
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MBENQc010789
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 11:14:23 GMT
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422111354.SECW8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 07:13:54 -0400
To: Geert Bosch <bosch@adacore.com>
In-Reply-To: <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com> (Geert Bosch's
	message of "Sat, 22 Apr 2006 07:04:38 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19052>

Geert Bosch <bosch@adacore.com> writes:

> BTW. It's a shame that we don't reuse the index when comparing one
> source
>      against multiple targets. Creating the index takes about 70% of
> the time.

(Please line-wrap sensibly).

I think we tried that with Nico/Davide's delta already, and IIRC
we had mixed results.

It really depends on how big an index for a source is.  Keep in
mind that we keep --window (default=10) of the source text
in-core, and you are suggesting to keep index in-core as well,
so we need to take memory pressure into account.

Having said that, the initial number you posted suggests the
algorithm is very fast, in which case reusing index may not
matter.  We will see ;-).
