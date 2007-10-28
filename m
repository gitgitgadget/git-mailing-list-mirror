From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 05/10] rename ref_matches_abbrev() to ref_abbrev_matches_full_with_fetch_rules()
Date: Sun, 28 Oct 2007 18:46:16 +0100
Message-ID: <11935935822846-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de>
 <1193593581486-git-send-email-prohaska@zib.de>
 <11935935812185-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCH1-0000QQ-I2
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXJ1Rty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbXJ1Rtx
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:49:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:63829 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMc4016197
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsZ019730;
	Sun, 28 Oct 2007 18:46:22 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935935812185-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62575>

The new naming makes the order of the arguments and the rules used
for matching more explicit. This will avoid confusion with
ref_abbrev_matches_full_with_rev_parse_rules(), which will be
introduced in a follow-up commit.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 remote.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 687eb8e..59e6485 100644
--- a/remote.c
+++ b/remote.c
@@ -421,7 +421,7 @@ int remote_has_url(struct remote *remote, const char *url)
  * Returns true if, under the matching rules for fetching, name is the
  * same as the given full name.
  */
-static int ref_matches_abbrev(const char *name, const char *full)
+static int ref_abbrev_matches_full_with_fetch_rules(const char *name, const char *full)
 {
 	if (!prefixcmp(name, "refs/") || !strcmp(name, "HEAD"))
 		return !strcmp(name, full);
@@ -820,7 +820,7 @@ int branch_merge_matches(struct branch *branch,
 {
 	if (!branch || i < 0 || i >= branch->merge_nr)
 		return 0;
-	return ref_matches_abbrev(branch->merge[i]->src, refname);
+	return ref_abbrev_matches_full_with_fetch_rules(branch->merge[i]->src, refname);
 }
 
 static struct ref *get_expanded_map(struct ref *remote_refs,
@@ -859,7 +859,7 @@ static struct ref *find_ref_by_name_abbrev(struct ref *refs, const char *name)
 {
 	struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
-		if (ref_matches_abbrev(name, ref->name))
+		if (ref_abbrev_matches_full_with_fetch_rules(name, ref->name))
 			return ref;
 	}
 	return NULL;
-- 
1.5.3.4.439.ge8b49
