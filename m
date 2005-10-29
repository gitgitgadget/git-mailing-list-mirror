From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Fri, 28 Oct 2005 20:07:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510282003360.3348@g5.osdl.org>
References: <1130434230.19641.21.camel@dv> <7vslum3l2w.fsf@assigned-by-dhcp.cox.net>
 <1130463389.2186.14.camel@dv> <7v4q72xavz.fsf@assigned-by-dhcp.cox.net>
 <1130539503.10531.43.camel@dv> <7vslul2g29.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 05:09:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVh4h-000135-4p
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 05:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVJ2DHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 23:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVJ2DHg
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 23:07:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751110AbVJ2DHg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 23:07:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9T37RFC016918
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Oct 2005 20:07:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9T37QFS001549;
	Fri, 28 Oct 2005 20:07:26 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslul2g29.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10782>



On Fri, 28 Oct 2005, Junio C Hamano wrote:
> 
> Sorry you lost me.  I am not sure what you mean by "without
> actually doing anything" part.  The input to patch-id command in
> the above pipe is (commit-object-name patch)*.  The command
> reads such a stream, and transforms it to a (patch-id
> commit-object-name)* stream.  In other words, the input
> identifies each patch with a commit-object-name, and the command
> condenses each patch to a patch-id, and spits them out, labelled
> with commit-object-name.

Note that git-patch-id will happily take a patch without the commit ID at 
the head, it just won't have a commit ID to match it up with. For such 
patches it will just spit it out with an all-zero commit-object-name.

And that's very much by design. The point is that you can match up your 
(perhaps non-git) patches with what has been accepted. Which is why 
git-patch-id should always take non-git patches too, and then you can 
match them up by sorting by patch ID and doing "join -1" to match up 
duplicates.

So git-patch-id will work with or without the commit ID, but the commit ID 
is then later needed to figure out _which_ commit you matched up.

		Linus
