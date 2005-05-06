From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Version of dirdiff to display diffs between git trees
Date: Fri, 6 May 2005 09:19:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505060916320.2233@ppc970.osdl.org>
References: <17019.28326.351036.268948@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:11:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5PC-0001Xu-9A
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVEFQRG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEFQRG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:17:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:58011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261208AbVEFQRC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:17:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46GGxU3000330
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 09:17:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46GGxGj016347;
	Fri, 6 May 2005 09:16:59 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17019.28326.351036.268948@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, Paul Mackerras wrote:
> The main window summarizes which files have changed.  Double-clicking
> on a file name pops up a diff viewer window which displays the
> differences between the different versions of the file in a
> color-coded unidiff format.  I find it useful to copy .git/HEAD to
> .git/OLD_HEAD before doing an update on my linux-2.6 repository, and
> then after the update do

If you use git-pull-script, it does this for you (except it calls it
ORIG_HEAD), and you can just do

	git-diff-tree -p ORIG_HEAD HEAD

to see the changes. In fact git-pull-script will do that for you, and 
output the diffstat of it.

Having the original head is also nice for when you decide that the other 
side has had a few too many drugs, in which case you just do

	cat .git/ORIG_HEAD > .git/HEAD
	git-read-tree -m HEAD
	git-checkout-cache -f -a
	git-update-cache --refresh

and you're back to your original head (the above is basically "unpull").

		Linus
