From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/7] Switch git_mmap to use pread.
Date: Sun, 24 Dec 2006 12:14:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612241213320.3671@woody.osdl.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
 <20061224054547.GB8146@spearce.org> <Pine.LNX.4.63.0612241407250.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 21:15:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyZkV-0005yH-6z
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 21:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbWLXUPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 15:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbWLXUPE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 15:15:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54732 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbWLXUPD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 15:15:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBOKEr2J029867
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Dec 2006 12:14:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBOKEqs3012825;
	Sun, 24 Dec 2006 12:14:52 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612241407250.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-1.156 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35372>



On Sun, 24 Dec 2006, Johannes Schindelin wrote:
> 
> I don't think it matters much. The _only_ platform we really use NO_MMAP 
> (other than for testing) is Windows, and AFAICT it does not have pread(), 
> so it is emulated by lseek/read/lseek anyway.

Windows definitely has pread(). It is, of course, possible that Cygwin 
emulates it some other way (including doing a "lseek/read/lseek" 
combination), but pread() should still be better - because maybe some 
future cygwin release ends up using the native interfaces.

		Linus
