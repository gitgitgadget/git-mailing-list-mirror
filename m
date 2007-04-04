From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] display shortlog after git-commit
Date: Wed, 4 Apr 2007 10:01:35 +0300
Message-ID: <20070404070135.GF31984@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 09:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYzV0-0000EH-Sw
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 09:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992700AbXDDHBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 03:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992705AbXDDHBi
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 03:01:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:41367 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992700AbXDDHBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 03:01:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so559500uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 00:01:35 -0700 (PDT)
Received: by 10.67.76.16 with SMTP id d16mr1218940ugl.1175670095159;
        Wed, 04 Apr 2007 00:01:35 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id s1sm1628313uge.2007.04.04.00.01.33;
        Wed, 04 Apr 2007 00:01:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43720>

This might be useful to make people review their log messages
as recorded by git, to make sure they match project guidelines:
among the things most commonly misconfigured are author mail,
and the commit title line.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

> I actually find it awkward that author/summary information is never
> shown during git commit - sometimes one does git commit
> on a machine where GIT_AUTHOR_EMAIL has not been setup
> correctly, and the result often is mst@mst-desktop.(none).
> Or people sometimes forget that the first line will show up
> in the pretty=short summary and the result is that what
> ends up being there is just 2 first lines of the long description.
>
> One has to remember to always do git log --pretty=short
> after commit to verify that one did get these details right.
>
> Ideas:
> - Maybe have git-commit display shortlog summary for commit just created?

Hopefully this will make people fix the git config up and amend their commits themselves.
Does this sound like a good idea?
BTW, it's a pity that --no-commit-id breaks --pretty=short.
Maybe use something like --pretty='format:Author: %an <%ae>%n%s' instead?

diff --git a/git-commit.sh b/git-commit.sh
index 292cf96..88e487f 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -650,7 +650,7 @@ then
 	if test -z "$quiet"
 	then
 		echo "Created${initial_commit:+ initial} commit $commit"
-		git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
+		git-diff-tree --shortstat --pretty=short --summary --root HEAD --
 	fi
 fi
 
-- 
MST
