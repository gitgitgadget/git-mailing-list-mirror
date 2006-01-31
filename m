From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Use struct tree in diff-tree
Date: Tue, 31 Jan 2006 14:07:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311337500.7301@g5.osdl.org>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
 <Pine.LNX.4.64.0601291405250.25300@iabervon.org> <Pine.LNX.4.64.0601310846380.7301@g5.osdl.org>
 <7virs0uma8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 23:08:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43fQ-0004hK-Ao
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 23:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWAaWHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 17:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWAaWHi
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 17:07:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751589AbWAaWHh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 17:07:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VM7VDZ009509
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 14:07:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VM7U1Q002281;
	Tue, 31 Jan 2006 14:07:30 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virs0uma8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15355>



On Tue, 31 Jan 2006, Junio C Hamano wrote:
> 
> The one to git-tar-tree I've already applied, mostly because I
> was not careful enough and especially I did not care enough
> about performance of that program.  On my slow machine the tip
> of kernel before you came back takes 9.2 seconds wallclock as
> opposed to 8.7 seconds to tar up, so the patch degrades the
> performance by about 5%.  Maybe we would want to revert that one
> as well.

Hmm. Rather than revert it outright, it might be better to make it use the 
nicer parsing functions and "struct tree_desc".

It shouldn't look _that_ different from the "struct tree" version: instead 
of doing

	item = item->next;

it would do

	update_tree_entry(tree);

instead.

Give me a minute, I'll send you patches.

		Linus
