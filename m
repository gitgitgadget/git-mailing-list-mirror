From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Sun, 2 Oct 2005 18:03:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510021752390.31407@g5.osdl.org>
References: <200510010158.j911wiB3005296@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 03:07:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMEnA-0006Fr-Od
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 03:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVJCBGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 21:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVJCBGx
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 21:06:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932102AbVJCBGx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 21:06:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9313F4s009361
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Oct 2005 18:03:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9313CvA006619;
	Sun, 2 Oct 2005 18:03:13 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200510010158.j911wiB3005296@inti.inf.utfsm.cl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9627>


[ Sorry about the spam, most of you probably have never cared ]

On Fri, 30 Sep 2005, Horst von Brand wrote:
> 
> I'd been trying my hand at the original version. Need to merge my changes
> with yours...

Heh, now that I got into cleaning things up, I've also been actually 
fixing things that have long irritated me, but the code was just too messy 
for me, and my level of care wasn't high enough to overcome.

I fixed the "outputs binary data in the 128-159 range to the terminal" 
yesterday (which would quite possibly corrupt terminal state if trying to 
edit binary files), and today I added a "utf-8" mode.

The utf-8 mode is purely about the _terminal_ being in UTF-8. The actual 
editor is still very much byte-char based, but now it understands 8-bit 
input that comes in UTF8-encoded, and can output things in UTF-8 format. 

(Since UTF-8 is basically always used with Unicode, and the 8-bit subset 
of Unicode is iso-8859-1 aka Latin1, this is probably _less_ international 
than the non-UTF8, but hey, what can I say? If you want more, you'd need 
to teach uemacs about actual UTF8 contents).

The new "emacs.rc" will enable utf-8 mode automatically if $LANG contains 
the substring "UTF-8", since that _usually_ means that the terminal is in 
utf-8 mode. If it's wrong, you can add or delete the mode by hand (just 
like any global mode: Meta-X to add, Meta-Ctrl-X to delete).

Basically, it means that you don't have to switch the whole terminal into 
latin1 just to use uemacs.

			Linus
