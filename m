From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 16:01:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706251557090.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
 <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 01:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2xZp-0006Ih-KM
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 01:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbXFYXCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 19:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXFYXCc
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 19:02:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58927 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751249AbXFYXCb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 19:02:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PN24YC018068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2007 16:02:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PN1wq0013256;
	Mon, 25 Jun 2007 16:01:59 -0700
In-Reply-To: <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
X-Spam-Status: No, hits=-4.598 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50935>



On Mon, 25 Jun 2007, Linus Torvalds wrote:
> 
> Actually, even this is really nasty, and it's a case where the current 
> "git.c" code can also fail.

Just to clarify: this is why the git.c code obviously does the fstat(), in 
case anybody wondered.

So I didn't mean to imply that the new git.c code in 'next' is wrong, I 
just meant to imply that the "ferror()"+"fflush()" sequence that it uses 
and that I copied for my example is a very unreliable sequence, and it 
basically fails exactly because you can never know what caused the 
ferror() to trigger - if it *ever* triggers, you're basically screwed.

I wonder how many applications actually ever use ferror() and friends. 

		Linus
