From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 15:11:10 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802101507100.2896@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <m3myq8fwdx.fsf@localhost.localdomain> <alpine.LFD.1.00.0802101241590.2896@woody.linux-foundation.org> <200802102353.40230.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLM1-0005WA-Ti
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbYBJXMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 18:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbYBJXMX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 18:12:23 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57631 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752699AbYBJXMX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 18:12:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1ANBBtm017399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Feb 2008 15:11:12 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1ANBAgB018479;
	Sun, 10 Feb 2008 15:11:10 -0800
In-Reply-To: <200802102353.40230.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73433>



On Sun, 10 Feb 2008, Jakub Narebski wrote:
> 
> Well, we could always add it as a local (per repository) "cache".
> With only generation numbers we could use pack-index-like format
> to store a mapping "commit sha-1 => generation number", just like
> now pack index stores mapping "object sha-1 => offset in pack".

Yes, and even embedding this in the pack-file (or perhaps, the index, as a 
new index extension) is probably a good idea.

> If we want to store also roots, we could either map 
> "commit sha-1 => generation number, roots set offset / id" (constant
> length value)[*1*], or have gen-*.gen file with generation numbers
> and roots, and gen-*.idx as index to that file.

The thing is, the roots are almost never actually interesting. Very seldom 
do you have any issue with different commits having different roots. So I 
really don't think it's worth it, considering that it's also much more 
complicated than just adding a sequence number to each commit.

		Linus
