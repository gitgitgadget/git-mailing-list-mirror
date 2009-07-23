From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 09:25:06 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907230922530.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <alpine.LFD.2.01.0907221742010.3352@localhost.localdomain> <alpine.LFD.2.01.0907221753290.3352@localhost.localdomain> <20090723020238.GA8948@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221925100.3352@localhost.localdomain> <m3prbr371l.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:25:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU16u-0003q1-GO
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 18:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbZGWQZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 12:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbZGWQZc
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 12:25:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45087 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754522AbZGWQZb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 12:25:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NGP6HH008633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jul 2009 09:25:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NGP6iQ003712;
	Thu, 23 Jul 2009 09:25:06 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <m3prbr371l.fsf@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123879>



On Thu, 23 Jul 2009, Jakub Narebski wrote:
> 
> BTW. Would SystemTap help there?  Among contributed scripts there is
> iotimes, so perhaps it would be possible to have iotrace...

The problem I've had with all iotracers is that it's easy enough to get an 
IO trace, but it's basically almost impossible to integrate it with what 
actually _caused_ the IO.

Using 'strace -T' shows very clearly what operations are taking a long 
time. It's very useful for seeing what you should not do for good 
performance - including IO - and where it comes from. It's just that page 
faults are invisible to it.

		Linus
