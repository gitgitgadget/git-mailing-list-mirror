From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Clarify role of init command in git-submodules
 documentation
Date: Mon, 20 Aug 2007 09:54:59 +0200
Message-ID: <20070820075459.GY1070MdfPADPa@greensroom.kotnet.org>
References: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
 <11875937841178-git-send-email-madduck@madduck.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, hjemli@gmail.com
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 09:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN26o-0005ny-0f
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 09:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbXHTHzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 03:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbXHTHzF
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 03:55:05 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:60214 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbXHTHzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 03:55:01 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JN2007YGBBN02@psmtp09.wxs.nl> for git@vger.kernel.org; Mon,
 20 Aug 2007 09:55:00 +0200 (MEST)
Received: (qmail 31971 invoked by uid 500); Mon, 20 Aug 2007 07:54:59 +0000
In-reply-to: <11875937841178-git-send-email-madduck@madduck.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56187>

On Mon, Aug 20, 2007 at 09:09:44AM +0200, martin f. krafft wrote:
>  FILES
>  -----
> -When initializing submodules, a .gitmodules file in the top-level directory
> -of the containing repository is used to find the url of each submodule.
> -This file should be formatted in the same way as $GIR_DIR/config. The key
> -to each submodule url is "submodule.$name.url".
> +To work with submodules, a user has to prepare a repository clone with the

I think this is a bit ambiguous.

> +command `git-submodule init`. This command copies the url of each submodule

As you can see in the "init" section of the man pages, the url is only
copied if it's not there already.

> +listed in the .gitmodules file in the top-level directory of the containing
> +repository to $GIT_DIR/config. The key to each submodule url is
> +"submodule.$name.url".
> +
> +The .gitmodules file then specifies the location of each submodule with
> +respect to the repository (and is shared among all contributors), while the
> +url of each submodule comes from the local configuration in $GIT_DIR/config
> +and can thus be modified independently of all other users.

This is better than the previous version, but in my mind still a bit confusing.
Let me have a go:

.gitmodules::
	This file specifies the location of each submodule with respect
	to the top-level directory of the git working tree as well as
	the default url of each submodule.  This default url is ignored
	by all git submodule subcommands, except init.  The latter can
	be used to initialize the url in $GIR_DIR/config, which is the
	url used by the other subcommands.  This file is typically
	tracked as it contains information that is shared by all
	contributors.  See also: gitlink:gitmodules[5].

$GIT_DIR/config::
	This files contains the url of each submodule in "submodule.$name.url".
	These urls are required by git submodule subcommands such as update
	and can be initialized by calling "git submodule init".
	The urls are specified in the local $GIT_DIR/config as the most
	appropriate url to get updates from may by different for different users
	and should not depend on the particular revision of the superproject
	that is currently checked out.

skimo
