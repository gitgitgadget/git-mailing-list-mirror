From: Andreas Ericsson <ae@op5.se>
Subject: Re: Choosing between "renaming" and "copy"
Date: Thu, 12 Mar 2009 15:44:25 +0100
Message-ID: <49B91FC9.6090700@op5.se>
References: <2009-03-12-14-01-15+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 15:46:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhmAZ-0002ZB-Tz
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 15:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbZCLOob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 10:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbZCLOoa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 10:44:30 -0400
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:2336 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbZCLOoa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 10:44:30 -0400
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Thu, 12 Mar 2009 07:42:52 -0700
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Thu, 12 Mar 2009 07:42:52 -0700
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <2009-03-12-14-01-15+trackit+sam@rfc1149.net>
X-OriginalArrivalTime: 12 Mar 2009 14:42:52.0770 (UTC) FILETIME=[D2CCFC20:01C9A320]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113072>

Samuel Tardieu wrote:
> I renamed a file in my repository, and made a slightly modified copy
> of it. It looks like GIT gets confused on which one is the renaming
> and which one is the copy, and doesn't favour the 100% identical one
> to be chosen as the renaming.
> 
> Not a big deal, but maybe git could be more clever here.
> 
> % git commit -m "Split into flash and ram alternatives." 
> [stm32-sk 601462c] Split into flash and ram alternatives.
>  3 files changed, 3 insertions(+), 2 deletions(-)
>  copy Demo/CORTEX_STM32SK_GCC/{stm32f103r8t6.ld => stm32f103r8t6_flash.ld} (100%)
>  rename Demo/CORTEX_STM32SK_GCC/{stm32f103r8t6.ld => stm32f103r8t6_ram.ld} (98%)
> 

There isn't that much more to be clever about, really. One is a rename+edit,
the other is a copy. The other way around would have been copy+edit + rename
which isn't necessarily an improvement.

Looking at how git internally[1] does things and remembering the meanings of
"copy" and "rename" though, it makes perfect sense to leave it as-is.

[1].
In git, the content is part of the (object) name, so changing the content
makes it closer to a rename than a copy, while changing the location always
makes it a copy, although sometimes coupled with a delete.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
