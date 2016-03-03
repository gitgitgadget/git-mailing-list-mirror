From: Kevin Daudt <me@ikke.info>
Subject: Re: Bypassing hooks while cherry-picking
Date: Thu, 3 Mar 2016 22:17:38 +0100
Message-ID: <20160303211738.GA26609@ikke.info>
References: <56D576A1.3020202@greg0ire.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: greg0ire <postmaster@greg0ire.fr>
X-From: git-owner@vger.kernel.org Thu Mar 03 22:17:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abacz-0007GF-V6
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 22:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbcCCVRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 16:17:41 -0500
Received: from ikke.info ([178.21.113.177]:45468 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755344AbcCCVRl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 16:17:41 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id E9C2C2D8007; Thu,  3 Mar 2016 22:17:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56D576A1.3020202@greg0ire.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288211>

On Tue, Mar 01, 2016 at 12:01:53PM +0100, greg0ire wrote:
> Hello,
> 
> using git 2.1.4 here, and it seems there is no option to bypass pre-commit
> hooks while cherry-picking, while git commit provides a --no-verify option.
> I ended up doing this to disable hooks while cherry picking :
> 
>     test -f "$GIT_DIR"/CHERRY_PICK_HEAD && exit 0
> 
> Wouldn't it be best to add the --no-verify option to cherry-pick too?
> I had a conflict when cherry-picking the commit, maybe this does not happen
> otherwise?
> 
> Steps to reproduce :
> 
> 1. create a pre-commit hook
> 2. create a commit that fails the hook, and bypass the hook
> 3. checkout another branch
> 4. might be optional : create a conflicting change with the previously
> created commit
> 5. cherry-pick the commit
> 6. might be optional : solve the conflick and use git cherry-pick --continue
> 
> Regards,
> 
> --
> greg0ire

Forgot to CC you, but I've submitted a patch[0] that adds this option.
The conflict does matter because otherwise the pre-commit hook does not
run.

Because they're now the rc-cycle, it might take a while before the patch
is accepted.


[0]:http://article.gmane.org/gmane.comp.version-control.git/288124
