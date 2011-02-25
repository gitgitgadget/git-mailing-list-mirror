From: Stephen Bash <bash@genarts.com>
Subject: git-cherry like operation for SVN imports
Date: Fri, 25 Feb 2011 10:43:10 -0500 (EST)
Message-ID: <5213723.55273.1298648590311.JavaMail.root@mail.hq.genarts.com>
References: <26101193.54947.1298648399611.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 16:51:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pszww-0006qo-AR
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 16:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381Ab1BYPvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 10:51:17 -0500
Received: from hq.genarts.com ([173.9.65.1]:40987 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932196Ab1BYPvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 10:51:16 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Feb 2011 10:51:16 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id D032BEA240B
	for <git@vger.kernel.org>; Fri, 25 Feb 2011 10:43:16 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ah0UcQIg7OhY for <git@vger.kernel.org>;
	Fri, 25 Feb 2011 10:43:10 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 673E3EA2415
	for <git@vger.kernel.org>; Fri, 25 Feb 2011 10:43:10 -0500 (EST)
In-Reply-To: <26101193.54947.1298648399611.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167912>

Hi all-

At my day job we've got about 17k commits in our Git repository (covering ~13 years) that were imported from Subversion.  Recently we've had a few regression issues come up that we thought were fixed in older (pre-Git) releases, and we're having a hard time pinning down if/when they got merged back to the mainline development branch.

In a pure Git world, I would use either git branch --contains or git-cherry...

Unfortunately during our SVN->Git process we didn't have SVN mergeinfo, so none of the Subversion merges were captured in Git (the diffs are correct, but the DAG is not).  So right away git {branch,tag} --contains is out the window (I think).  The next obvious choice is git-cherry, but (at least in our process) SVN merges are a single commit that roll up a series of diffs so the patch-id of the merge doesn't match the patch-id of the original commit (at least I haven't found a way to make this work).

One possible solution proposed by a coworker was do something like patch-id, but at the hunk level.  This has promise, but I'm not convinced that the hunks showing up in the merge commit would match those in the original (but I'm no expert when it comes to diff logic).

Does anyone have any experience with this type of problem?  Any suggestions on how we can make this work?

Thanks,
Stephen
