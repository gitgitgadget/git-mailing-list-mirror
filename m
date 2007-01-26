From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 10:21:58 +0100
Organization: eudaptics software gmbh
Message-ID: <45B9C836.728F31EC@eudaptics.com>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
		<7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
		<45B9B80E.E2534F97@eudaptics.com> <7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANGX-0005Fw-Sq
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965591AbXAZJUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965587AbXAZJUl
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:20:41 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:16965 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965591AbXAZJUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:20:40 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EA2DD6D9; Fri, 26 Jan 2007 10:20:38 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37821>

Junio C Hamano wrote:
> Graft is a local matter, but that does not mean it should
> introduce inconsistencies.  It is a way to _locally_ change the
> world view, and to give the consistent world view locally, not
> only the commands you listed (fsck, prune, pack-objects) but
> also log, rev-list and friends all should take grafts into
> account, which is why losing B is the right thing to do if you
> repack or prune.  In your altered world, B is not part of any
> remaining history.

Here's my stance on it. Grafts should be a local matter. And they alter
the world view, with a pronounciation on *view*. That's why I proposed
that only log familiy of commands obey them[*]. And probably rev-list so
that gitk et.al. have a way to obey them. And also the ref parser (so
that master~20 is what it looks it is). Everything else should disregard
grafts: repack, prune, fetch, <transfer>-pack, push etc. No nasty side
effects anymore. No transfer of the grafts file needed. No clash when
someone else has a different *view* of the world.

Then the location of the file in .git/info/grafts is justified. If
grafts continue to have the radical influence that they have now, then
the grafts file is better located in .git/objects/info/grafts as part of
the objects database.

[*] ok, I originally also proposed the diff family, but that's likely
not necessary.

-- Hannes
