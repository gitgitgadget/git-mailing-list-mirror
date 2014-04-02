From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Q: ".git/HEAD" and ".git/refs/heads"
Date: Wed, 02 Apr 2014 16:52:31 +0200
Message-ID: <533C404F020000A1000151CE@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:51:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeQa-0000xS-Nu
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbaDBPAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 11:00:23 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:53194 "EHLO
	rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758600AbaDBPAW convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-git@vger.kernel.org:1:1>);
	Wed, 2 Apr 2014 11:00:22 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Apr 2014 11:00:22 EDT
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 5BF073777D
	for <git@vger.kernel.org>; Wed,  2 Apr 2014 16:52:34 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gwsmtp.uni-regensburg.de", Issuer "Uni Regensburg CA - G01" (not verified))
	by rrzmta1.uni-regensburg.de (Postfix) with ESMTPS id 418B837772
	for <git@vger.kernel.org>; Wed,  2 Apr 2014 16:52:34 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Wed, 02 Apr 2014 16:47:54 +0200
X-Mailer: Novell GroupWise Internet Agent 12.0.2 
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245697>

Hi!

I have a small question: After a "git gc" with last commit being "[shared 2679648]" I found this:
> cat .git/HEAD
ref: refs/heads/shared
> cat .git/refs/heads/shared
cat: .git/refs/heads/shared: No such file or directory

Is this intentional? How does Git find the numeric commit for HEAD?
Using find, I found my commit in these files:
.git/logs/HEAD
.git/logs/refs/heads/shared
.git/info/refs
.git/packed-refs

Before "git gc" I found the commit ID in HEAD.

Why I'm worrying?: I tried to make a simple script that finds out the current HEAD-commit like this:
            if [ -d .git ]; then
                GIT_HEAD="$(<.git/HEAD)"
                GIT_BRANCH="${GIT_HEAD##*/}"
                GIT_HEAD="Git:$GIT_BRANCH-$(cut -c1-7 .git/${GIT_HEAD##*: })"
            fi

Then $GIT_HEAD was something like "Git:shared-863962c".

Should I use code like this:?
awk '$2 == "refs/heads/shared" { print $1 }' .git/info/refs

Of course I'd be most pleased if there was some git builtin to get that (I read the manual without success).

Using an older version of Git (git-1.7.12)...

Regards,
Ulrich Windl
