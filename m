From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REPLACEMENT PATCH 2/2] Add "--early-output" log flag for
 interactive GUI use
Date: Sun, 4 Nov 2007 10:11:54 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 19:12:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IojxL-0005VK-99
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 19:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbXKDSMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 13:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbXKDSMD
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 13:12:03 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40338 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752949AbXKDSMC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 13:12:02 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA4IBsB7016062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Nov 2007 10:11:56 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA4IBs9N010531;
	Sun, 4 Nov 2007 10:11:54 -0800
In-Reply-To: <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63423>



On Sat, 3 Nov 2007, Linus Torvalds wrote:
> > 
> > How hard would it be to put the total number of commits on that "Final
> > output" line?  That would be useful for me.
> 
> Not hard. I think we basically have it anyway.

Actually, I take that back.

It's hard. Not because we don't have the commits, but because while we do 
the top-level shape pruning in the eearly stages, we do *not* do the final 
path-limiting until we actually output the commits.

Which actually makes "--early-output" right now do some rather odd things 
when you use a path limiter: we don't do the "rewrite_parents()" thing 
until later, so the early output will have done the first level of history 
simplification, but it won't have made history *dense* yet.

I'm looking at it now, I'll have to think about this a bit more. It might 
be trivial to fix, but this thing has real potential for being subtle.

			Linus
