From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make "git rev-list" be a builtin
Date: Thu, 18 May 2006 15:00:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605181454540.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605181415090.10823@g5.osdl.org>
 <7vejyrngto.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 00:00:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgqXg-0006hr-6p
	for gcvg-git@gmane.org; Fri, 19 May 2006 00:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWERWAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 18:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWERWAV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 18:00:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932160AbWERWAV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 18:00:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IM0GtH002219
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 15:00:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IM0GYx003358;
	Thu, 18 May 2006 15:00:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejyrngto.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20307>



On Thu, 18 May 2006, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> >
> > We should have done this long ago.
> 
> Should we have?
> 
> Certainly it is almost trivial, and it means we need to worry
> about one less file, but is that the point?

Take a look at the size of the binaries before and after.

This is the _stripped_ binaries (on ppc) before:

  -rwxr-xr-x 9 torvalds torvalds 213392 May 18 14:56 git
  -rwxr-xr-x 1 torvalds torvalds 167540 May 18 14:56 git-rev-list

and after:

  -rwxr-xr-x 10 torvalds torvalds 216740 May 18 14:56 git
  -rwxr-xr-x 10 torvalds torvalds 216740 May 18 14:56 git-rev-list

ie the "git" binary grew by about 3kB, and the "git-rev-list" binary 
shrank by about 164kB (because it now takes zero disk-space: it's the same 
as the git binary).

So on ppc, you win about 160kB of disk space from this (and much more if 
you don't strip the binaries - "git-rev-list" is over half a megabyte 
with the debugging info for me).

Now, x86 probably has less of that, because it's a denser instruction set, 
but I'd expect that to be in the 100kB range too.

			Linus
