From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 30 Apr 2005 18:09:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 03:59:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS3j1-0001qL-5S
	for gcvg-git@gmane.org; Sun, 01 May 2005 03:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVEABIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 21:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVEABIF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 21:08:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:2226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbVEABIC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 21:08:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4117rs4028677
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Apr 2005 18:07:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4117qhN026511;
	Sat, 30 Apr 2005 18:07:53 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Apr 2005, Junio C Hamano wrote:
>
> Diff-tree-helper take two patch inadvertently dropped the
> support of -R option

Talking about the diffs, I'm beginning to hate those "mode" things.

Not only do they screw up diffstat (big deal), but they are pointless, 
since 99.9% of the time the mode stays the same.

So it would be much nicer (I think) if mode changes are handled 
separately, with a simple separate line before the diff saying

	"Mode change: %o->%o %s", oldmode, newmode, path

and not mess up the diff header. That way, you only see it when it
actually makes any difference, and it's more readable both for humans
_and_ machines as a result.

Normal "patch" will just ignore the extra lines before the diff anyway, so 
it won't matter there.

Comments?

		Linus
