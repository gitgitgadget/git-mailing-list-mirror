From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 18:14:13 -0600
Message-ID: <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 01:16:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0mMe-0006fl-8l
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 01:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbYKNAPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 19:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbYKNAPX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:15:23 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58182 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbYKNAPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 19:15:22 -0500
Received: by mail.nrlssc.navy.mil id mAE0EDUY005374; Thu, 13 Nov 2008 18:14:13 -0600
In-Reply-To: <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
X-OriginalArrivalTime: 14 Nov 2008 00:14:13.0364 (UTC) FILETIME=[EC784340:01C945ED]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100935>



Second version.


Hot cache (over NFS):

Before:

0.01user 0.11system 0:00.13elapsed 95%CPU
0.01user 0.11system 0:00.13elapsed 96%CPU
0.01user 0.12system 0:00.13elapsed 97%CPU

After:

0.01user 0.09system 0:00.11elapsed 95%CPU
0.01user 0.09system 0:00.11elapsed 95%CPU
0.01user 0.09system 0:00.11elapsed 95%CPU


Cold cache* (over NFS):

Before:

0.01user 0.31system 0:04.40elapsed 7%CPU
0.01user 0.31system 0:06.47elapsed 5%CPU
0.01user 0.26system 0:04.19elapsed 6%CPU
0.01user 0.30system 0:04.99elapsed 6%CPU

After:

0.01user 0.46system 0:01.39elapsed 34%CPU
0.01user 0.41system 0:00.88elapsed 47%CPU
0.01user 0.45system 0:01.16elapsed 40%CPU
0.01user 0.45system 0:00.99elapsed 47%CPU
0.01user 0.45system 0:01.02elapsed 45%CPU


* Note: I can't do 'echo 3 > /proc/sys/vm/drop_caches', so cold
  cache means 'sleep 60' between git diff (30 wasn't long enough).

-brandon
