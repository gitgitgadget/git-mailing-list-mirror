From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 09:09:32 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 18:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNVO8-000824-AG
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 18:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbYG1QO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 12:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbYG1QO4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 12:14:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38156 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752791AbYG1QOz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 12:14:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6SGCWre017226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 09:12:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6SGCVZc014164;
	Mon, 28 Jul 2008 09:12:31 -0700
In-Reply-To: <20080728160446.GA16351@old.davidb.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.404 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90469>



On Mon, 28 Jul 2008, David Brown wrote:

> On Mon, Jul 28, 2008 at 08:31:28AM +0200, Alex Riesen wrote:
> 
> > because there are situations where it produces too much false
> > positives. Like when file system crawlers keep changing it when
> > scanning and using the ctime for marking scanned files.
> 
> That's interesting, since most backup software uses the ctime to determine
> file changes.

It really is just Beagle that is (was? I can dream) a piece of 
unbelievable crap.

Anybody who uses extended attributes as part of a indexing scheme is just 
insane. Modifying the file you are indexing is not just fundamentally 
wrong to begin with, but it will then also be incredibly inefficient to 
read those entries one at a time.

And no other sane model would ever touch 'ctime'.

Oh, well. Making ctime configurable is not wrong per se. But if it's 
Beagle that triggers this, the fix is sadly in the wrong place.

		Linus
