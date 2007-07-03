From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook
 script)
Date: Tue, 03 Jul 2007 10:45:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707031020300.26459@xanadu.home>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782608-git-send-email-sam.vilain@catalyst.net.nz>
 <alpine.LFD.0.999.0707022331080.26459@xanadu.home> <4689D77D.20601@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:45:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5jd0-0003GL-Gy
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbXGCOpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbXGCOpN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:45:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64351 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbXGCOpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 10:45:11 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKL007LNYB3ZVE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Jul 2007 10:45:03 -0400 (EDT)
In-reply-to: <4689D77D.20601@vilain.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51501>

On Tue, 3 Jul 2007, Sam Vilain wrote:

> Nicolas Pitre wrote:
> >> Add an option to git-repack that makes the repack run suitable for
> >> running very often.  The idea is that packs get given a "generation",
> >> and that the number of packs in each generation (except the last one)
> >> is bounded.
> > 
> > Please explain again why this should be useful and is worth the 
> > complexity it brings along.  Last time this was discussed I wasn't 
> > convinced at all, and I'm still not convinced this time either.
> 
> First I think we should establish some common ground.
> 
> 1. Do you agree that some users would want their git repositories to be
> "maintenance free"?

I'm not so sure.  I think it is best to let GIT users know (or the 
admins on their behalf) how to properly maintain their repository than 
pretending that it needs no maintenance.  GIT is a tool for "developers" 
after all, not for Aunt Tillie.

And even if your developers are completely inept to the point of not 
wanting to run 'git gc' once a week for example, or once a day if 
they're otherwise really really productive, I'm sure you can automate 
some of that maintenance asynchronously from a simple post commit hook 
or something, based on the output of 'git count-objects -v'.

> 2. Do you agree that having thousands of packs would add measurable
> overhead?

Sure it would, but far less as it used to when we last discussed this 
since performances in those cases has been improved significantly.

And if you end up with thousands of packs in the first place I think you 
have a more fundamental problem to fix, something that generational 
repacking would just paper over.


Nicolas
