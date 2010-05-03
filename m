From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Migrating from subversion via git svn contains log entry, but
 not the file change in the branch.
Date: Mon, 03 May 2010 14:38:06 +0200
Message-ID: <4BDEC3AE.90409@drmicha.warpmail.net>
References: <1272889536578-4997493.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: magnuspalmer <magnus.palmer@jayway.com>
X-From: git-owner@vger.kernel.org Mon May 03 14:38:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8uue-0007j5-T2
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 14:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667Ab0ECMiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 08:38:10 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60582 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758300Ab0ECMiI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 08:38:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E62F1F201E;
	Mon,  3 May 2010 08:38:07 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 03 May 2010 08:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=P7pcs5NLVij29c9M+JSfH4YFAFw=; b=HBEQ5PXotlu5KqVJ78p7jj9XcdCQUjy+/yBfOLfXQCGDjTRvaun/LxsnHL6LLN25o/uRdt7CKMSjRtxY0sa4oBcoDrtLn3OjBIARyn/S/er0djidOTIlom7DPQciQ0ssXpw548s6oEE/LrBuX1hG2n3rVvzRpM1Bhjle7lNt+es=
X-Sasl-enc: WmQShAz6qoSRVunh9XTXOfZY+Pk2B2tkTiwrIV2XHdcv 1272890287
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 56AFF4B434;
	Mon,  3 May 2010 08:38:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1272889536578-4997493.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146229>

magnuspalmer venit, vidit, dixit 03.05.2010 14:25:
> 
> I've been working almost fulltime for two weeks migrating a subversion
> repository to git.
> Most repos go fine, but some doesn't and I'm running out of options.
> 
> Been trying to find posts regarding this and tried what I've found.
> 
> The subversion repo contains subrepos.
> Layout is this:
> tags
> branches
> <trunk is in root dir, contains only a maven pom.xml>
> subrepo-a(with standard layout: trunk, tags, branches)
> subrepo-n
> 
> Team is doing ongoing development in currently four branches (develop,
> release-product-a-1.1, release-product-b-1.0, trunk). I'll deal with that
> later.
> 
> What happends is that I get the svn log message, but the file is not the
> correct one, or the file is completely missing suddenly.
> git checkout develop
> HEAD is now at 5269d17... increased version to 1.2.0-SNAPSHOT.
> 
> The change in the file is not there, the old version number in the pom.xml.
> I compare this with the one checkout out via svn.
> 
> git svn init --trunk='' --tags=tags/*/* --branches=branches --prefix=svn/

What is the reason for the tags/*/*? I would expect a simple --tags=tags
here.

> --ignore-paths="branches|tags|subrepo-a|subrepo-b|"
> https://example.com/svn/theproject/client
> 
> Then I've tried:
> git fetch
> git fetch --no-follow-parent

git svn that, I assume.

> turn on/off brokensymlink workaround
> git config svn.brokenSymlinkWorkaround false
> git config svn.brokenSymlinkWorkaround true

Do you use symlinks?

> Also started at different revisions
> -r XYZ:HEAD
> 
> For one of the cases (with svn.brokenSymlinkWorkaround=false) I get:
> Found possible branch point:
> https://example.com/svn/theproject/client/branches/develop/pom.xml =>
> https://example.com/svn/theproject/client/branches/release-1.1.0, 10623
> Initializing parent: release-1.1.0@10623
> W: Ignoring error from SVN, path probably does not exist: (160013):
> Filesystem has no item: File not found: revision 6973, path
> '/theproject/client/branches/develop/pom.xml'
> 
> And I end up with a:
> remotes/release-1.1.0
> remotes/release-1.1.0@10623
> 
> Any ideas of how to proceed?
> I am getting short out of ideas.

I assume you can't make that repo accessible, can you?

Michael
