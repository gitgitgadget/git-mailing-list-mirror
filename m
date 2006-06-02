From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Clean up sha1 file writing
Date: Fri, 2 Jun 2006 14:17:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606021416040.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org> <E1Fixs4-0005pD-10@moooo.ath.cx>
 <Pine.LNX.4.64.0605241145490.5623@g5.osdl.org> <44808710.1080000@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 02 23:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmH16-0004oX-8M
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 23:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWFBVRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 17:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWFBVRI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 17:17:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030284AbWFBVRH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 17:17:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k52LH42g014275
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Jun 2006 14:17:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k52LH3VB023358;
	Fri, 2 Jun 2006 14:17:03 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <44808710.1080000@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21175>



On Fri, 2 Jun 2006, H. Peter Anvin wrote:
> Linus Torvalds wrote:
> > 
> > Any POSIX-conformant OS/filesystem should always do a full write for a
> > regular file, unless a serious error happens.
> > 
> 
> Actually, at least Linux won't, if the object is larger than 2 GB on a 64-bit
> system :)

Yeah, true.

In the end, you should always have the loop. That way, you never have to 
worry about what kind of file descriptor it is, what kind of filesystem 
you're running on, and what the limits of ssize_t might be.

		Linus
