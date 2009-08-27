From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] commit.c: rename variable named 'n' which masks previous declaration
Date: Thu, 27 Aug 2009 11:16:34 -0500
Message-ID: <vODpKBYr5sNtCfB7C_mUMqn8szqSz58pySpTHpAGYAe6MTvKrSPNr0gs14tbOkuPF97cDvuGi2M@cipher.nrlssc.navy.mil>
References: <vODpKBYr5sNtCfB7C_mUMqGkpPTwc8quzfdAUjySMC_tekZRVbEOpzkstotoeMXAS6wJ4OaF2NA@cipher.nrlssc.navy.mil> <vODpKBYr5sNtCfB7C_mUMmQyYO9vzbX98QMYSBId5GcwHT7q6zvrKlJpRNwoJvTTF7qKScin5PA@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 18:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mghf1-0005WD-7n
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbZH0QRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbZH0QRE
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:17:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38388 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbZH0QRD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:17:03 -0400
Received: by mail.nrlssc.navy.mil id n7RGGsTC031920; Thu, 27 Aug 2009 11:16:54 -0500
In-Reply-To: <vODpKBYr5sNtCfB7C_mUMmQyYO9vzbX98QMYSBId5GcwHT7q6zvrKlJpRNwoJvTTF7qKScin5PA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 27 Aug 2009 16:16:53.0589 (UTC) FILETIME=[CA63A850:01CA2731]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127169>

From: Brandon Casey <drafnel@gmail.com>

The variable named 'n' was initially declared to be of type int.  The name
'n' was reused inside inner blocks as a different type.  Rename the uses
within inner blocks to avoid confusion and give them a slightly more
descriptive name.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 commit.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index e2bcbe8..a6c6f70 100644
--- a/commit.c
+++ b/commit.c
@@ -564,13 +564,13 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 	while (interesting(list)) {
 		struct commit *commit;
 		struct commit_list *parents;
-		struct commit_list *n;
+		struct commit_list *next;
 		int flags;
 
 		commit = list->item;
-		n = list->next;
+		next = list->next;
 		free(list);
-		list = n;
+		list = next;
 
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags == (PARENT1 | PARENT2)) {
@@ -598,11 +598,11 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 	free_commit_list(list);
 	list = result; result = NULL;
 	while (list) {
-		struct commit_list *n = list->next;
+		struct commit_list *next = list->next;
 		if (!(list->item->object.flags & STALE))
 			insert_by_date(list->item, &result);
 		free(list);
-		list = n;
+		list = next;
 	}
 	return result;
 }
-- 
1.6.4
