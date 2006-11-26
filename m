X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 25 Nov 2006 19:39:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
 <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org> <45689747.3020403@midwinter.com>
 <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 26 Nov 2006 03:40:16 +0000 (UTC)
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32321>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoAsD-000146-81 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967264AbWKZDkE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967263AbWKZDkE
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:40:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:19897 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S967264AbWKZDj7 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:39:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAQ3dZix018655
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 25
 Nov 2006 19:39:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAQ3dZsR020450; Sat, 25 Nov
 2006 19:39:35 -0800
To: Yann Dirson <ydirson@altern.org>
Sender: git-owner@vger.kernel.org



On Sun, 26 Nov 2006, Yann Dirson wrote:
> 
> Also, I'd rather expect "git-commit -a" outside of any submodule to
> commit everything in the supermodule, triggering submodule commits as an
> intermediate step when needed - just like "git-commit -a" does not
> require to manually specify subdirectories to inclue in the commit.  I'd
> rather expect a special flag to exclude submodules from a commit.

So, how do you do commit messages? It generally doesn't make sense to 
share the same commit message for submodules - the sub-commits generally 
do different things.

I'd actually suggest that "git commit -a" with non-clean submodules error 
out for that reason, with something like

	submodule 'src/xyzzy' is not up-to-date, please commit changes to 
	that first.

exactly because you really generally should consider the submodule commits 
to be a separate phase.

