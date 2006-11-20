X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 20 Nov 2006 15:05:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org>
 <7v7ixp20za.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 20 Nov 2006 23:06:03 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v7ixp20za.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31955>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmID7-0005MT-99 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966323AbWKTXFy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966882AbWKTXFy
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:05:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:15757 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S966323AbWKTXFy (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:05:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAKN5mix016647
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 20
 Nov 2006 15:05:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAKN5l5X005243; Mon, 20 Nov
 2006 15:05:48 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 20 Nov 2006, Junio C Hamano wrote:
> 
> That was shot down by Linus and I agree with him.  "bind" was a
> bad idea because binding of a particular subproject commit into
> a tree is a property of the tree, not one of the commits that
> happen to have that tree.

Yes. I think it would be a _fine_ idea to have a new tree-entry type that 
points to a sub-commit, but it really does need to be on a "tree level", 
not a commit level.

If it's on a tree level, getting things like "git diff" etc to work is not 
impossible, and it will also fit very well into the whole git 
infrastructure.

So right now a tree entry can be another tree or a blob - and the only 
extension would be to add a "commit" type (which would largely _act_ as a 
tree entry, at least for sorting, ie it would use the same "sorts as if it 
had a '/' at the end" logic).

Now, to get everything to work seamlessly within such a commit thing 
might be a fair amount of work, but I'm not sure you even _need_ to. It 
might be ok to just say "subproject 'xyzzy' differs" in the diff, for 
example, and have some rudimentary support for "git status" etc talking 
about subprojects that need to be committed.

