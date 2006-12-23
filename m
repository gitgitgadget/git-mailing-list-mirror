From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 12/17] Load core configuration in git-verify-pack.
Date: Sat, 23 Dec 2006 02:34:33 -0500
Message-ID: <20061223073433.GM9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Oz-0001uJ-Pw
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbWLWHeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWLWHeh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38805 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbWLWHeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1OV-0003Ci-BW; Sat, 23 Dec 2006 02:34:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0997220FB65; Sat, 23 Dec 2006 02:34:34 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35292>

Now that our pack access code's behavior may be altered by the
setting of core.packedGitWindowSize or core.packedGitLimit we need
to make sure these values are set as configured in the repository's
configuration file rather than to their defaults.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-verify-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 7d39d9b..4e31c27 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -55,6 +55,7 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 	int no_more_options = 0;
 	int nothing_done = 1;
 
+	git_config(git_default_config);
 	while (1 < argc) {
 		if (!no_more_options && argv[1][0] == '-') {
 			if (!strcmp("-v", argv[1]))
-- 
1.4.4.3.g87d8
