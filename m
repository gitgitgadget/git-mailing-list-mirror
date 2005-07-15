From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Is cogito really this inefficient
Date: Thu, 14 Jul 2005 17:29:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507141725280.19183@g5.osdl.org>
References: <20050713135052.C6791@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org> <20050714083700.A26322@flint.arm.linux.org.uk>
 <tnxu0ixoiuo.fsf@arm.com> <20050714105938.A31383@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0507140832490.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 02:32:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtE7H-000816-GS
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 02:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVGOAbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 20:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVGOAbN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 20:31:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262936AbVGOA3a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 20:29:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6F0TFjA009522
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Jul 2005 17:29:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6F0T9Uu015361;
	Thu, 14 Jul 2005 17:29:11 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58.0507140832490.19183@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Jul 2005, Linus Torvalds wrote:
>
> I'll look into making diff-cache be more efficient. I normally don't use
> it myself, so I didn't bother (I use git-diff-files, which is way more
> efficient, but doesn't show the difference against the _tree_, it shows
> the difference against the index. Since cogito tries to hide the index
> from you, cogito can't very well use that).

Ok, done.

I made git-diff-cache _and_ git-diff-files limit the pathnames early, so
that they don't even bother expanding the tree objects that are
irrelevant, and don't bother even validating index objects that don't
match the pathnames given.

Junio - I think this makes gitcore-pathspec pretty pointless, but I didn't
actually remove it. I guess "git-diff-helper" still uses it.

		Linus
