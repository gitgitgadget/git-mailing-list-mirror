From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 14:32:38 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:35:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFGqO-00059y-Fe
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757869AbYAPWd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758254AbYAPWd0
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:33:26 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55150 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758286AbYAPWdY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 17:33:24 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GMWceh028304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 14:32:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GMWcGP027825;
	Wed, 16 Jan 2008 14:32:38 -0800
In-Reply-To: <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70755>



On Wed, 16 Jan 2008, Kevin Ballard wrote:
> 
> It's not using different encodings, it's all Unicode. However, it accepts
> different normalization variants of Unicode, since it can read them all and it
> would be folly to require everybody to conform to its own special internal
> variant. But it does have to normalize them, otherwise how would it detect the
> same filename using different normalizations?

That's a singularly *stupid* argument.

Here, let me rephrase that same idiotic argument:

  "But it does have to uppercase them, otherwise how would it detect the 
   same filename using different cases?"

..and if you don't see how that's *exactly* the same argument, you really 
are stupid.

The fact is, normalization is wrong.

It's wrong when you normalize upper/lower case (no, the word "Polish" is 
not the same as "polish"), and it's equally wrong when you normalize for 
"looks similar".

> In other words, you're used to filenames as bytes, HFS+ treats filenames 
> as strings.

No. HFS+ treats users as idiots and thinks that it should "fix" the 
filename for them. And it causes problems.

It causes problems for exactly the same reasons case-independence causes 
problems, because it's EXACTLY THE SAME ISSUE. People may think that "but 
they are the same", but they aren't. Case matters. And so does "single 
character" vs "two character overlay". 

Does it always matter? Hell no. But the problem with a filesystem that 
thinks it knows better is that when it *sometimes* matters, the filesystem 
simply DOES THE WRONG THING.

Can't you understand that?

			Linus
