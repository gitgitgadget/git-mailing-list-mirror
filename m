From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-cherry like operation for SVN imports
Date: Sun, 27 Feb 2011 15:36:04 +0100
Message-ID: <4D6A6154.5010204@drmicha.warpmail.net>
References: <26101193.54947.1298648399611.JavaMail.root@mail.hq.genarts.com> <5213723.55273.1298648590311.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 15:35:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pthi6-0000Im-DB
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 15:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab1B0Oey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 09:34:54 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50762 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984Ab1B0Oex (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 09:34:53 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B98BE20A7D;
	Sun, 27 Feb 2011 09:34:52 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sun, 27 Feb 2011 09:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=V7NjbevG7sw1L65mUMdMrFsj1Nw=; b=MsfdQ8/mh7Ze2gaDCj0JdOvE/rHWss0JVZaZF2QFjcBMdyfMEoc5Nrn465yYaEIB99/b0febnNQV2W2VUB1OszSdOegYB5xA/+YlNxt2+BmnPYO4hGXbot+WTExq2H7JNSzhAbrclPG37DpIjVyE8Z0mxuePf8jrmJfAmfiENcQ=
X-Sasl-enc: 96iCUvo3l4AMJaH0O9UT23mo8FI7VjSlD8zQCLXTBy/m 1298817292
Received: from localhost.localdomain (p5485925B.dip0.t-ipconnect.de [84.133.146.91])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 20ECE407CBD;
	Sun, 27 Feb 2011 09:34:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <5213723.55273.1298648590311.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168033>

Stephen Bash venit, vidit, dixit 25.02.2011 16:43:
> Hi all-
> 
> At my day job we've got about 17k commits in our Git repository (covering ~13 years) that were imported from Subversion.  Recently we've had a few regression issues come up that we thought were fixed in older (pre-Git) releases, and we're having a hard time pinning down if/when they got merged back to the mainline development branch.
> 
> In a pure Git world, I would use either git branch --contains or git-cherry...
> 
> Unfortunately during our SVN->Git process we didn't have SVN mergeinfo, so none of the Subversion merges were captured in Git (the diffs are correct, but the DAG is not).  So right away git {branch,tag} --contains is out the window (I think).  The next obvious choice is git-cherry, but (at least in our process) SVN merges are a single commit that roll up a series of diffs so the patch-id of the merge doesn't match the patch-id of the original commit (at least I haven't found a way to make this work).
> 
> One possible solution proposed by a coworker was do something like patch-id, but at the hunk level.  This has promise, but I'm not convinced that the hunks showing up in the merge commit would match those in the original (but I'm no expert when it comes to diff logic).
> 
> Does anyone have any experience with this type of problem?  Any suggestions on how we can make this work?

If your merges coalesce several commits you're out of luck with cherry.

I guess I would try to find a "signature hunk" (characteristic for fix
you're after) and try "log -S" with that. I mean, if anything else
fails, it's time for the pickaxe ;)

Michael
