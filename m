From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Tue, 14 Mar 2006 15:07:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
References: <20060314211022.GA12498@localhost.localdomain>
 <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 15 00:08:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJIcR-00008t-Ah
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 00:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbWCNXH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 18:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWCNXH5
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 18:07:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750739AbWCNXH4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Mar 2006 18:07:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2EN7kDZ009112
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Mar 2006 15:07:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2EN7edK015815;
	Tue, 14 Mar 2006 15:07:43 -0800
To: Qingning Huo <qhuo@mayhq.co.uk>
In-Reply-To: <20060314224027.GB14733@localhost.localdomain>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17602>



On Tue, 14 Mar 2006, Qingning Huo wrote:
> 
> Thanks for your detailed explanation.  Yes, "git push" and "git pull"
> both work fine out of the box.  That is the good thing.  But,
> 
> $ grep git git-pull.sh
> 
> . git-sh-setup
> orig_head=$(git-rev-parse --verify HEAD) || die "Pulling into a black hole?"
> git-fetch --update-head-ok "$@" || exit 1
> curr_head=$(git-rev-parse --verify HEAD)
>         git-read-tree -u -m "$orig_head" "$curr_head" ||
>         var=`git repo-config --get pull.octopus`
>         var=`git repo-config --get pull.twohead`
> merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
> git-merge $no_summary $no_commit $strategy_args "$merge_name" HEAD $merge_head
> 
> We have "git-read-tree" and "git repo-config" at the same time.  Are
> there any rules saying which form should be preferred?  How about pick
> one form and stick to it?

I agree that it is inconsistent as-is. So a patch to make it use the 
"git-repo-config" form (the argument being that internally, we use the 
full names) might be good if just for consistency.

		Linus
