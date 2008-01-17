From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 17:16:45 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJNj-0000YS-78
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYAQBQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYAQBQz
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:16:55 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56216 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbYAQBQx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 20:16:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H1GkxZ003800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 17:16:47 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H1GjOs002153;
	Wed, 16 Jan 2008 17:16:45 -0800
In-Reply-To: <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70801>



On Wed, 16 Jan 2008, Kevin Ballard wrote:
> 
> I'm speaking as a user, and as such, I shouldn't even have to know that it's
> possible to write the same character in multiple different ways.

The thing is, you seem to argue that what OS X does helps you as the user.

But you are arguing based on incorrect assumptions.

First off, we've had years and years and years of usage of non-corrupting 
filesystems (pretty much every UNIX OS around since day 1, and many other 
OS's too), and it's simply not true that it's a problem. You see the 
filename in the file dialog, and you open it, and you're done. OS X isn't 
any "easier" in this regard.

In fact, this whole thread comes from the fact that the OS X choice that 
you *think* is easier, is in fact not easier at all. It's not easier for 
the user, it's not easier for the application programmer, and the really 
sad part is that it's very much *not* easier for OS X itself either (ie 
they had to literally write extra code with nasty tables to do it, and it 
really does hurt them in performance and complexity).

And _that_ is why the OS X situation is so sad. Apple literally added 
extra code to make things slower and more complex *and* harder to use 
reliably.

Does it show up in normal behaviour? Of course not. You'd probably never 
see it in real life outside of test-suites. People simply don't even tend 
to use filenames outside of US-ASCII, and when they do use them, input 
methods really *do* tend to do the normalization for you.

But when it comes to automation (which is what computers are all about), 
the OS X choice is literally the wrong one. And there's no _upside_. It's 
all downside. Which is why it's so stupid.

I bet it only exists because OS X engineers didn't really even think about 
it, and they just assumed that "normalization is helpful". They took your 
stance - thinking it was worth it, without ever really thinking it 
through.

			Linus
