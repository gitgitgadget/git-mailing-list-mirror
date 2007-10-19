From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
 objects'
Date: Fri, 19 Oct 2007 12:00:15 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710191157560.26902@woody.linux-foundation.org>
References: <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
 <20071019030749.GA9274@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
 <20071019033228.GA10697@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
 <20071019035647.GA18717@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710182111030.26902@woody.linux-foundation.org>
 <20071019042930.GA16487@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710190753040.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iix5c-0002Ah-MD
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764211AbXJSTAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762962AbXJSTAo
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:00:44 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56746 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757301AbXJSTAn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 15:00:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JJ0GIM024299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Oct 2007 12:00:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JJ0F4M015143;
	Fri, 19 Oct 2007 12:00:16 -0700
In-Reply-To: <alpine.LFD.0.9999.0710190753040.19446@xanadu.home>
X-Spam-Status: No, hits=-4.72 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61741>



On Fri, 19 Oct 2007, Nicolas Pitre wrote:
> On Fri, 19 Oct 2007, Jeff King wrote:
> > 
> > Ah, right. I hadn't thought of that. While it would be a nice
> > convenience feature, it's probably not worth the deep internal hackery
> > that would be required.
> 
> What about a preprocessor that could match <1>@{<2>..<3>} in the 
> argument list and substitute that with <1>@{<2>}..<1>@{<3>} before it is 
> actually parsed?

Could be done, but I almost think it would be better to just make the 
sha1_name.c interfaces take some extended data structure which allows 
looking up multiple SHA1's at the same time.

Sure, we'd leave the "simple" interfaces around for users that simply want 
just one SHA1 value, but that would allow us to remove duplicate code from 
revision.c and rev-parse.c. And it would allow us to generally make the 
SHA1 parsing fancier: there may well be other expressions that are worth 
doing.

		Linus
