From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -z HEAD | git-diff-helper -z fails for me
Date: Mon, 23 May 2005 11:21:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
 <7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 20:21:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaHVz-0005Go-3n
	for gcvg-git@gmane.org; Mon, 23 May 2005 20:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVEWSUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 14:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVEWSUL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 14:20:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:23180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261922AbVEWSUF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 14:20:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4NIJtjA005928
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 11:19:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4NIJs3K011478;
	Mon, 23 May 2005 11:19:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Junio C Hamano wrote:
> 
> Tg> 	(faui00u) [~/work/git/yagf] git-diff-tree -z HEAD | git-diff-helper -z
> Tg> 	03c70739ae572ea9832b97dfcf9ca2594702efe8 (from 30e756ea8569bb429b7073b304acd8a960f77e4b)
> Tg> 	:100755 100755 f2e04c3b45b2a5ab5cf53228025158902c9de5be b93fd0310e51eea4d48d42c6ad83399cff8ab56egitgit(faui00u) [~/work/git/yagf]
> 
> Tg> What I am doing wrong here?
> 
> Nothing.  I'm an idiot.
> 
> Linus, do you mind if I say with "-z" git-diff-tree should not
> do _any_ header thing?

How about instead making sure that any "extra" text be NUL-terminated and
never start with ':' after a NUL (which will automatically be true, since
it's either "diff-tree " + ascii for the verbose case, or just the tree
name).

That way git-diff-helper automatically does the right thing when it just 
passes lines (where "lines" is defined as being NUL-terminated) that it 
doesn't understand through unmodified.

		Linus
