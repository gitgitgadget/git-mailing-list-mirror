From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 20:35:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701302029460.3611@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> 
 <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net> <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 05:35:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC7Bi-00068y-R3
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 05:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbXAaEfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 23:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbXAaEfI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 23:35:08 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36718 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932783AbXAaEfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 23:35:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0V4Z39V007790
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 20:35:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0V4Z226007375;
	Tue, 30 Jan 2007 20:35:02 -0800
In-Reply-To: <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38226>



On Tue, 30 Jan 2007, Mike Coleman wrote:
> 
> As for performance, my thinking was that since hg is implemented
> apparently almost entirely in Python, and has (again apparently)
> generally acceptable performance, this suggested that much of the
> problem might be I/O-bound enough that language efficiency might not
> matter so much.

Note that git actually implements a lot more than hg does.

hg depends on external programs (almost uniformly written in C) to do the 
actual diff generation, 3-way merging etc. 

Git actually ends up doing all of those internally, and minimizes external 
dependencies that way. More importantly, perhaps, it allows us to do a 
better job, faster. The early example of this is patch application, where 
git supports a much nicer patch format that can express renames etc in the 
patch.

But I'll admit - my main reason going with C is (a) it's what I know and 
(b) I absolutely _hate_ being constrained by the language. The great thing 
about C (still) is that you can do *anything* in it. You're literally 
limited by hardware, and by your own abilities. Nothing else.

			Linus
