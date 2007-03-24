From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 1/2] Documentation: Allow @@GIT_VERSION@@ in asciidoc.conf
Date: Sat, 24 Mar 2007 10:26:30 -0400
Message-ID: <382A0F82-0CD9-43B8-8F91-4CAD6DBFF890@silverinsanity.com>
References: <11746760451462-git-send-email-frank@lichtenheld.de> <7vejnfpqx5.fsf@assigned-by-dhcp.cox.net> <20070324120421.GL8017@planck.djpig.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat Mar 24 15:26:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV7CZ-0005b5-Qi
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 15:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbXCXO0h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 10:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbXCXO0h
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 10:26:37 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:40524 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbXCXO0g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 10:26:36 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 24A2B1FFC02B;
	Sat, 24 Mar 2007 14:26:35 +0000 (UTC)
In-Reply-To: <20070324120421.GL8017@planck.djpig.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43001>


On Mar 24, 2007, at 8:04 AM, Frank Lichtenheld wrote:

> On Fri, Mar 23, 2007 at 02:53:58PM -0700, Junio C Hamano wrote:
>
>> While this is attractive to some degree, *I* am grumpy.  Doesn't
>> this patch make html and man branches update all files _every_
>> time any small change is made to some documentation?
>
> Not with my patch; which is a bug in the patch though because
> asciidoc.conf should really depend on GIT-VERSION-FILE.
>
> Another possibility would be to replace the @@GIT_VERSION@@ in the  
> man pages
> themself and not in the asciidoc.conf. This would mean perhaps  
> slightly
> bigger changes to the build system, but running sed on all the  
> files is of
> course a lot faster than regenerating them with asciidoc.
>
> What do you think?

I think that any change that causes the documentation to be rebuilt  
without any change in the documentation is a horrible horrible idea.   
The asciidoc+xmlto/xsltproc chain is noticeably slow, and I don't  
think that having the version number is important enough to cause a  
rebuild.  Using sed is definitely better than doing a rebuild from  
the start at the cost of a fair amount of complexity (and extra  
files, but that's fairly negligible).

I'm not convinced of the need to have a version in every doc file,  
though.  The only use I can think of is to avoid version skew between  
the documentation and the programs, and that's easily solved by  
always building and installing them together.  Adding a version to  
just the main git man file might not be a bad mid-point though to  
make that skew easier to detect without having to rebuild *everything*.

~~ Brian
