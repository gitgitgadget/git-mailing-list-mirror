From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 21:01:26 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908052056500.3390@localhost.localdomain>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
 <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain> <alpine.LFD.2.01.0908052043082.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 06:02:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuBE-00039I-0O
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbZHFECG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbZHFECG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:02:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50848 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761AbZHFECF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 00:02:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7641Q4B020102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 21:01:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7641QGu024637;
	Wed, 5 Aug 2009 21:01:26 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908052043082.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125029>



On Wed, 5 Aug 2009, Linus Torvalds wrote:
> 
> Here's the patch that gets me sub-28s git-fsck times. In fact, it gives me 
> sub-27s times. In fact, it's really close to the OpenSSL times.

Just to back that up:

 - OpenSSL:

	real	0m26.363s
	user	0m26.174s
	sys	0m0.188s

 - This C implementation:

	real	0m26.594s
	user	0m26.310s
	sys	0m0.256s

so I'm still slower, but now you really have to look closely to see the 
difference. In fact, you have to do multiple runs to make sure, because 
the error bars are bigger thant he difference - but openssl definitely 
edges my C code out by a small amount, and the above numbers are rairly 
normal.

		Linus
