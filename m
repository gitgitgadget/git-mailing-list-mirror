From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Importing merges when converting repos from SVN to Git (fusing
 grafts in the Git history)
Date: Tue, 08 Jan 2008 16:13:21 +0100
Message-ID: <47839311.2010606@viscovery.net>
References: <744EF0AD-4773-4A35-B772-94621E9ADA10@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Jan 08 16:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCG9I-0001Ig-Gl
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 16:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbYAHPNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 10:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYAHPNZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 10:13:25 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44269 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbYAHPNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 10:13:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCG8p-0000G3-4u; Tue, 08 Jan 2008 16:13:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 04D426EF; Tue,  8 Jan 2008 16:13:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <744EF0AD-4773-4A35-B772-94621E9ADA10@lrde.epita.fr>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69883>

Benoit Sigoure schrieb:
> I'm going to import the repositories with `git-svn' and then I'd like to
> rewrite the entire history to take these merges in account in the Git
> repo, if possible.  This will probably help us merging the (former) SVN
> branches in our new Git repo.  I know I can simulate a merge with a
> graft and I think it will be fairly easy to write a small script that
> parses the log and generates the corresponding graft file.  Now the
> question is: how to make these grafts part of the *real* history so that
> we don't have to depend on the graft file anymore?
> 
> I know this issue has already been raised on the ML (the "how to include
> grafts are real merges in the history" thing) but I couldn't find the
> corresponding posts and can't remember the conclusion...

	git-filter-branch --tag-name-filter=cat --all

should do it. It rewrites nothing but the parenthood, so you will find
that the rewritten history shares everything with the original history up
to the first merge(s).

You better run this on a "cp -al" copy of the original converted
repository because it *overwrites* the tags.

-- Hannes
