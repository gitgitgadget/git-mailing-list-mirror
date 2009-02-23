From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT] [PATCH 2/2] Make sure to set up the default (pull)
	remote branch for master
Date: Mon, 23 Feb 2009 08:09:57 -0800
Message-ID: <20090223160957.GK22848@spearce.org>
References: <cover.1235228532.git.ferry.huberts@pelagic.nl> <e26eb3c2a7a0ce2b96252f00c17a62913d741579.1235228532.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ferry.huberts@pelagic.nl
X-From: git-owner@vger.kernel.org Mon Feb 23 17:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbdOx-0003Fv-Q1
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbZBWQKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbZBWQJ7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:09:59 -0500
Received: from george.spearce.org ([209.20.77.23]:59491 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZBWQJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 11:09:59 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8879E38210; Mon, 23 Feb 2009 16:09:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <e26eb3c2a7a0ce2b96252f00c17a62913d741579.1235228532.git.ferry.huberts@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111149>

ferry.huberts@pelagic.nl wrote:
> This is to make sure that the git plugin sets up a clone
> in the same fashion as the CLI git clone command.
...
> @@ -158,6 +159,11 @@ private void doInit(final IProgressMonitor monitor)
>  		local.getConfig().setBoolean("core", null, "bare", false);
>  		
>  		remoteConfig.update(local.getConfig());
> +
> +		/* setup the default (pull) remote branch for master */
> +		local.getConfig().setString(RepositoryConfig.BRANCH_SECTION, Constants.MASTER, "remote", remoteName);
> +		local.getConfig().setString(RepositoryConfig.BRANCH_SECTION, Constants.MASTER, "merge", Constants.R_HEADS + Constants.MASTER);

Shouldn't this be "branch" and not "Constants.MASTER" ?

IIRC the dialog lets you start off a branch that isn't "master",
especially if the remote repository has no branch named "master"
but has something else that HEAD points at.  "git clone" would
setup this branch.${branch}.merge to point at what the upstream
branch calls itself.

-- 
Shawn.
