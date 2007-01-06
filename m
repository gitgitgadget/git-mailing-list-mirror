From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 17:22:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051721340.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701051503m3a431e07qc12662eecc08884f@mail.gmail.com>
 <7v64bldqas.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701051515000.3661@woody.osdl.org>
 <7vac0xc9g8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701051610290.3661@woody.osdl.org>
 <Pine.LNX.4.64.0701051611550.3661@woody.osdl.org> <7v3b6pc89y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Lee <chris133@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 02:22:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H30GP-0001zx-VM
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 02:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbXAFBWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 20:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbXAFBWW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 20:22:22 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49158 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbXAFBWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 20:22:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l061MHWi016848
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Jan 2007 17:22:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l061MGO2015722;
	Fri, 5 Jan 2007 17:22:17 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b6pc89y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.67 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36064>



On Fri, 5 Jan 2007, Junio C Hamano wrote:
>
> While I have your attention, there is a patch for the sliding
> mmap() thing that raises the mmap window to 1GB (which means a
> pack smaller than that is mmap'ed in its entirety, whle 2.3GB
> pack will be mapped perhaps as three separate chunks) and the
> total mmap window to 8GB (and any overflows we LRU out) on
> places where sizeof(void*) == 8 (i.e. git compiled for 64-bit).
> 
> Currently these limits are 32MB and 256MB respectively on
> platforms with real mmap().
> 
> Do you have any comments on it?

I think it's fine. Most "normal" mmap users hopefully will only use a 
small portion of the mapped space, adn if they use it all, it means that 
they needed it all, so..

		Linus
