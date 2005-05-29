From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Problem with cg-merge
Date: Sun, 29 May 2005 20:07:42 +0200
Message-ID: <20050529180742.GA31388@diku.dk>
References: <1117379092.7072.90.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 20:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSAF-00052b-5S
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVE2SHv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVE2SHv
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:07:51 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:14293 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261376AbVE2SHn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 14:07:43 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 657516E1C82; Sun, 29 May 2005 20:07:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2729C6E1BCE; Sun, 29 May 2005 20:07:11 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7D0DA61FE0; Sun, 29 May 2005 20:07:42 +0200 (CEST)
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1117379092.7072.90.camel@pegasus>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marcel Holtmann <marcel@holtmann.org> wrote Sun, May 29, 2005:
> Hi Petr,
> 
> I saw that earlier, but I don't have any idea what's wrong here. If I do
> a simple cg-update, I see something like this:
> 
> Tree change: cf1f29d97210d0594dcf5b2a734bdb714de6bf24:89a14a5bd2c880095d5c618a102319bb3dc03da9
> :100755 100755 ceda2c50fc2c2941daa34a57722df251bf892c38 fea239b99d351502d1acb098abd725557f0af202 M      cg-diff
> :100755 100755 cc0c17beef75db41da3ad4ef8983bd7e222ac739 5f0bff77eb2110d52892793e5bef104acde7be32 M      cg-help
> 
> Applying changes...
> Fast-forwarding cf1f29d97210d0594dcf5b2a734bdb714de6bf24 -> 89a14a5bd2c880095d5c618a102319bb3dc03da9
>         on top of cf1f29d97210d0594dcf5b2a734bdb714de6bf24...
> patching file cg-diff
> patching file cg-help
> cg-diff: needs update
> cg-help: needs update
> 
> This is a little bit odd, because if I call "git-diff-cache HEAD" after
> it, I will see that cg-diff and cg-help are modified. After calling
> cg-cancel everything looks fine again.

The following change fixes cg-update for me. This is in tree_timewarp().

--- 0ca4ae56fa7bbd8d10e2c2791e389bc19977e460/cg-Xlib  (mode:100755)
+++ uncommitted/cg-Xlib  (mode:100755)
@@ -66,7 +66,7 @@
 		# XXX: This may be suboptimal, but it is also non-trivial to keep
 		# the adds/removes properly.  So this is just a quick hack to get it
 		# working without much fuss.
-		cg-diff -r $branch >$patchfile
+		cg-diff >$patchfile
 	fi
 
 	git-read-tree -m "$branch" || die "$branch: bad commit"

-- 
Jonas Fonseca
