From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: being nice to patch(1)
Date: Mon, 2 Jul 2007 17:28:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
 <20070702142557.eba61ccd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, quilt-dev@nongnu.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 02:30:04 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5WHL-0002dM-Of
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 02:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbXGCA2y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 20:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758368AbXGCA2x
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 20:28:53 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44202 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756721AbXGCA2w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 20:28:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l630Sll5015421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jul 2007 17:28:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l630SfiU020811;
	Mon, 2 Jul 2007 17:28:42 -0700
In-Reply-To: <20070702145601.a0dcef0f.akpm@linux-foundation.org>
X-Spam-Status: No, hits=-2.641 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51434>



On Mon, 2 Jul 2007, Andrew Morton wrote:
> 
> I'm afraid indenting the changelog with leading spaces doesn't help -
> patch(1) still tries to apply the diff.

Oh wow. I didn't believe you, so I decided to test.

I shouldn't have doubted you.

That also explains why it reacted to that 53c700 even though it wasn't at 
the beginning of a line.

That really is a piece of crap.

People who think that basic programs like "patch" should DWIM stuff like 
that are incompetent. Yes, I can see how it can be "convenient", but 
dammit, whoever added that convenince feature really is a total moron.

At the very least it should be off by default, and controlled by some flag 
(ie "patch --dwim"). As it is, it's on by default, and I don't see any way 
at all to disable it (not in the man-page, and not googling the source 
with google code-search).

That's just incredibly broken.

I guess I shouldn't be surprised. The whole "things should be convenient, 
not safe" approach is shown by the default high fuzz-factor too. But at 
least that one you can disable.

It's positively microsoftian to make programs blindly be "convenient", 
with no thinking about what that means for security and safety of the end 
result.

So I would suggest that in quilt and other systems, you either:

 - strip all headers manually

 - forget about "patch", and use "git-apply" instead that does things 
   right and doesn't screw up like this (and can do rename diffs etc too).

I guess the second choice generally isn't an option, but dammit, 
"git-apply" really is the better program here.

		Linus
