From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Sat, 20 Dec 2008 08:08:01 +0100
Message-ID: <200812200808.02011.robin.rosenberg.lists@dewire.com>
References: <200812182039.15169.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 08:11:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDvzI-00061R-Qc
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 08:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbYLTHIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 02:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbYLTHIU
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 02:08:20 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:36299 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243AbYLTHIT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 02:08:19 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A979500540EA87; Sat, 20 Dec 2008 08:08:10 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <200812182039.15169.bss@iguanasuicide.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103628>

fredag 19 december 2008 03:39:15 skrev Boyd Stephen Smith Jr.:
> Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
> ---
> On Thursday 2008 December 18 18:21:25 Linus Torvalds wrote:
> > I suspect we should warn about reverting merges.
> 

Or mention the reverted parent in the commit message since it is not obvious.

-- robin

>From e982c8cefcdeefd6e8aabc8c354bed69161f40ee Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sat, 20 Dec 2008 07:22:39 +0100
Subject: [PATCH] Mention reverted parent in commit message for reverted merge.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 builtin-revert.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 4038b41..fc59229 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -352,6 +352,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		add_to_msg(oneline_body + 1);
 		add_to_msg("\"\n\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
+		if (commit->parents->next) {
+			add_to_msg(" removing\ncontributions from ");
+			add_to_msg(sha1_to_hex(parent->object.sha1));
+		}
 		add_to_msg(".\n");
 	} else {
 		base = parent;
-- 
1.6.1.rc3.36.g43d5.dirty
