X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 09:35:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611180933360.3692@woody.osdl.org>
References: <20061118041137.6064.75827.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 18 Nov 2006 17:35:40 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118041137.6064.75827.stgit@machine.or.cz>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31780>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlU6G-0002nx-0W for gcvg-git@gmane.org; Sat, 18 Nov
 2006 18:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755179AbWKRRf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 12:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbWKRRf2
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 12:35:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:65455 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1755179AbWKRRf2 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 12:35:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAIHZJix002768
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 18
 Nov 2006 09:35:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAIHZIZC011477; Sat, 18 Nov
 2006 09:35:18 -0800
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org



On Sat, 18 Nov 2006, Petr Baudis wrote:
>
> Some of the ref manipulation tools (git-for-each-ref and git-show-ref in
> particular) would not handle hidden (~ /^\./) refs. This may be an
> acceptable or possibly even desirable behaviour for the ref walkers and
> repackers, but git-show-ref hiddenrefname must work.

No.

Refnames MUST NOT start with a ".". 

It's not even about the traditional unix "hidden file" thing. It's simply 
a syntactic issue. A ref cannot start with a ".", because we use things 
like ".." and "..." to separate them.

For the same reason, a ref must not contain - anywhere in its name - a "^" 
or a ".." or the other magic characters.

If you want to hide refs, you should do so some other way.

