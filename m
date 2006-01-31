From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Possible git-rev-list bug
Date: Tue, 31 Jan 2006 07:55:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601310745270.7301@g5.osdl.org>
References: <43DC8DDF.6080904@yahoo.it> <7vmzhekcz3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 16:57:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3xrQ-0003YI-OR
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 16:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWAaPz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 10:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWAaPz7
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 10:55:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbWAaPz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 10:55:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VFtsDZ020909
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 07:55:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VFtrfI016203;
	Tue, 31 Jan 2006 07:55:54 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzhekcz3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15320>



On Sun, 29 Jan 2006, Junio C Hamano wrote:

> Marco Costalba <mcostalba@yahoo.it> writes:
> 
> > $ git-rev-list --max-count=1 --parents addafaf92eeb86033da91323d0d3ad7a496dae83 -- rev-list.c
> > addaf.. d8f6b.. 93b74.. d8f6b.. d8f6b.. 3815f..
> >
> > We have the same parent (d8f6b..) multiple times.
> 
> I think it probably is a bug.

Well, it's not strictly a bug, and multiple of the same parents _can_ 
happen in real life due to buggy commits, so a tool that depends on some 
kind of parent uniqueness are a bit fragile. There is nothing fundamental 
in the git data structures that says that you couldn't have the same 
parent twice.

In this case, it didn't start out with the same parent - we had five 
unique parents, but by the time the tree had been simplified, some of them 
had become common.

So I don't know if it's a "bug", and the bad reaction by gitk and qgit are 
arguably the _real_ bugs. 

But Junio's patch is simple, and perhaps the right thing to do. 

			Linus
