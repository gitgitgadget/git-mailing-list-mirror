From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1.5.0.1.37] fix git-remote inconsistent about use of dots in remote names
Date: Wed, 21 Feb 2007 01:21:34 -0800
Message-ID: <7vabz7sw69.fsf@assigned-by-dhcp.cox.net>
References: <20070221083042.GE23952@jukie.net>
	<20070221085422.GF23952@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 10:21:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJnfP-0005tw-2a
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 10:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbXBUJVg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 04:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965338AbXBUJVg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 04:21:36 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53696 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965240AbXBUJVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 04:21:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221092134.IAG233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 04:21:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S9Ma1W0061kojtg0000000; Wed, 21 Feb 2007 04:21:34 -0500
In-Reply-To: <20070221085422.GF23952@jukie.net> (Bart Trojanowski's message of
	"Wed, 21 Feb 2007 03:54:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40291>

This is what I have currently queued -- please see earlier
discussion with Pavel on the list.

-- >8 --
From: Pavel Roskin <proski@gnu.org>
Date: Wed, 21 Feb 2007 00:03:36 -0500
Subject: [PATCH] git-remote: support remotes with a dot in the name

[jc: the original from Pavel was limiting the variable names to only
 fetch and url, but I loosened it to take valid variable names.]

Signed-off-by: Pavel Roskin <proski@gnu.org>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-remote.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 61244e9..bd70bf1 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -67,7 +67,7 @@ sub list_remote {
 		$git->command(qw(config --get-regexp), '^remote\.');
 	};
 	for (@remotes) {
-		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
+		if (/^remote\.(\S+?)\.([^.\s]+)\s+(.*)$/) {
 			add_remote_config(\%seen, $1, $2, $3);
 		}
 	}
-- 
1.5.0.1.587.g8493
