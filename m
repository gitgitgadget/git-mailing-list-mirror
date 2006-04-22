From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 08:51:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604220846040.2215@localhost.localdomain>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
 <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
 <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com>
 <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
 <6794F5B2-A277-4CD9-9BA8-509F86378E68@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 21:50:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXO79-0004P1-PD
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 21:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWDVTtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 15:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWDVTtw
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 15:49:52 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:20675 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751088AbWDVTtv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 15:49:51 -0400
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MCtCQm007121
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 12:55:12 GMT
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY400HEDJPQ9Z80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 22 Apr 2006 08:51:27 -0400 (EDT)
In-reply-to: <6794F5B2-A277-4CD9-9BA8-509F86378E68@adacore.com>
X-X-Sender: nico@localhost.localdomain
To: Geert Bosch <bosch@adacore.com>
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19046>

On Sat, 22 Apr 2006, Geert Bosch wrote:

> BTW, after applying the obvious fixes, I get the following
> message:
> potomac%./git-pack-objects --no-reuse-delta --stdout <lst
> Generating pack...
> Done counting 16984 objects.
> Deltifying 16984 objects.
> 100% (16984/16984) done
> fatal: delta size changed
> 
> Is this expected now I have a different algorithm?

It should not.

First, pack-objects tries to find the best object combinations producing 
the smallest delta.  Then there is a second pass where the best delta 
are actually written out.  When that message appears that means the 
delta size for the same object pair does not match between those two 
passes.


Nicolas
