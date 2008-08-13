From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [TopGit PATCH] tg-info: fix sed typo
Date: Wed, 13 Aug 2008 00:16:33 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808130013480.8904@harper.uchicago.edu>
References: <Pine.GSO.4.62.0808121309000.18832@harper.uchicago.edu>
 <20080812204433.GM10151@machine.or.cz> <Pine.GSO.4.62.0808121557290.24244@harper.uchicago.edu>
 <Pine.GSO.4.62.0808121911340.1112@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 13 07:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT8ju-0003lO-AO
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 07:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYHMFQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 01:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbYHMFQj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 01:16:39 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:53003 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYHMFQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 01:16:38 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7D5GYLn024359;
	Wed, 13 Aug 2008 00:16:34 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7D5GYdK009049;
	Wed, 13 Aug 2008 00:16:34 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808121911340.1112@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92179>

There was a semicolon missing before a closing brace.  The result
is an error message on some operating systems (e.g., Mac OS 10.3).

	$ tg info
	Topic Branch: t/some-topic (       2/       2 commits)
	Subject: [PATCH] t/some-topic
	Base: 082a7c9
	sed: 1: "1{s/^/Depends: /;n}; s/ ...": extra characters a
	t the end of n command

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>

---
	Hi again,

	Here is the other change I needed to run topgit.  I
	hope it is of some use.

 tg-info.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg-info.sh b/tg-info.sh
index 43589f9..7899ada 100644
--- a/tg-info.sh
+++ b/tg-info.sh
@@ -39,7 +39,7 @@ branch_contains "$name" "$base_rev" ||
 	echo "Base is newer than head! Please run \`tg update\`."
 
 git cat-file blob "$name:.topdeps" |
-	sed '1{s/^/Depends: /;n}; s/^/         /;'
+	sed '1{ s/^/Depends: /; n; }; s/^/         /'
 
 depcheck="$(mktemp)"
 missing_deps=
-- 
tg: (f27e693..) t/sed-fix (depends on: )
