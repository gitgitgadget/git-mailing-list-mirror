From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and
 Mercurial
Date: Wed, 1 Aug 2007 21:13:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708012109040.3582@woody.linux-foundation.org>
References: <200708010216.59750.jnareb@gmail.com>
 <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
 <7vodhrby6f.fsf@assigned-by-dhcp.cox.net> <20070801092428.GB28106@thunk.org>
 <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net> <20070801220350.GD28106@thunk.org>
 <20070802040201.GI23484@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Allan Wind <allan_wind@lifeintegrity.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 06:14:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGS4s-00019d-V3
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 06:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbXHBEOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 00:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXHBEOD
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 00:14:03 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56837 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbXHBEOB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 00:14:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l724DLVJ005412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Aug 2007 21:13:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l724DGlL004686;
	Wed, 1 Aug 2007 21:13:16 -0700
In-Reply-To: <20070802040201.GI23484@lifeintegrity.com>
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54510>



On Thu, 2 Aug 2007, Allan Wind wrote:
> 
> I would expect /something and file:///something to behave exactly the 
> same way (the latter just having bit extra syntax sugar).

I do agree that they should be basically the same, but from an 
implementation standpoint it actually makes a lot of sense to separate 
them. Also, there's actually a small amount of "logic" in it: the 
/something is obviously a "raw filename", while the "file:://something" 
clearly is something a lot more abstract.

I don't actually have a very strong opinion, but I do think that "file://" 
makes sense regardless (ie the patch I sent out is probably a good idea).

I also strongly dispute that "file://something" is _identical_ to just 
"something". There's a huge difference, as anybody who has ever tried to 
do

	cp file://file-A file-B

will have hopefully found out. They may mean the same thing, but they have 
totally different levels of abstraction, so it does actually make some 
sense that you end up *cloning* the same thing, but different ways.

		Linus
