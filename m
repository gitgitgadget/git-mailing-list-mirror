From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: fetch <repo> <branch>:<branch> fetches tags?
Date: Mon, 28 Jan 2008 20:33:07 -0600
Message-ID: <479E9063.5000403@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:33:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgIA-0006Mz-Mk
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYA2CdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbYA2CdK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:33:10 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36170 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbYA2CdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:33:10 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0T2X7e3018569
	for <git@vger.kernel.org>; Mon, 28 Jan 2008 20:33:08 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 28 Jan 2008 20:33:07 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 29 Jan 2008 02:33:07.0916 (UTC) FILETIME=[487478C0:01C8621F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--2.279200-0-4-1
X-TM-AS-Category-Info: : 4:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjU4LTE1MDY1Ny03MDA3?=
	=?us-ascii?B?ODItNzA2ODkxLTcwMDk5OS03MDA2MzAtNzA4MzI4LTcwNDg4NS03?=
	=?us-ascii?B?MDE0MzMtNzA4MjU3LTcwMTM4NC03MDE0MzctMTg3MDY3LTEwNTcw?=
	=?us-ascii?B?MC03MDk1ODQtNzA5MTM3LTcwMDg0Ni03MDAzMDAtNzAyMDQ0LTcw?=
	=?us-ascii?B?MjYwOS03MDM3ODgtNzAwNjkzLTcwMjkwMS03MDgzMjUtMTQ4MDM5?=
	=?us-ascii?B?LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71918>


Is this the intended behavior?

I'm pretty sure this was discussed recently on the list.
My understanding was that tags would only be fetched
automatically if a remote tracking branch was configured.

$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true


I expect these to fetch tags automatically (and they do):

   git fetch
   git pull
   git fetch <repo>
   git pull <repo>

I expect these to _not_ fetch tags (and they don't):

   git fetch <repo> <branch>
   git pull <repo> <branch>

But, I did not expect these to fetch tags:

   git fetch <repo> <branch>:<branch>
   git pull <repo> <branch>:<branch>


The association I am making here is between manually specifying
the repo and branch implying "don't automatically fetch tags",
and fetch/pull automatically determining the branch (and repo)
implying "automatically fetch tags".

There is nothing automatic about that last form of fetch.

I know there is --no-tags, and I know I can do

   git fetch <repo> <branch>
   git branch <branch> FETCH_HEAD

But neither are what I expected to have to do. So I guess the
colon notation implies remote tracking? I'm not sure I want
the tags by default when I call fetch this way. In this
instance I definitely did not want them.

-brandon
