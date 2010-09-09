From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] builtin/fetch.c: comment that branch->remote_name is usable when has_merge
Date: Thu,  9 Sep 2010 13:56:36 -0500
Message-ID: <NYNWO-6R8khWRYvZHfeUgclo0qTrx32yM6iROg9eTvmBQn8zP_PDNNLiYY_Cx1TwXuGliHPxYzQ@cipher.nrlssc.navy.mil>
References: <7vtymipddv.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 09 21:00:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmMK-00063u-OC
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab0IITA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:00:27 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40137 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab0IITAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:00:25 -0400
Received: by mail.nrlssc.navy.mil id o89IunPh001217; Thu, 9 Sep 2010 13:56:49 -0500
In-Reply-To: <7vtymipddv.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 09 Sep 2010 18:56:49.0702 (UTC) FILETIME=[C243CC60:01CB5050]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155878>

From: Brandon Casey <drafnel@gmail.com>

Save future readers the trouble of tracing code to determine that the two
uses of branch->remote_name are safe when has_merge is set, by adding a
comment explaining that it is so.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin/fetch.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fccc9cb..6fc5047 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -148,6 +148,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		int has_merge = branch_has_merge_config(branch);
 		if (remote &&
 		    (remote->fetch_refspec_nr ||
+		     /* Note: has_merge implies non-NULL branch->remote_name */
 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
 			for (i = 0; i < remote->fetch_refspec_nr; i++) {
 				get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
@@ -162,6 +163,8 @@ static struct ref *get_ref_map(struct transport *transport,
 			 * if the remote we're fetching from is the same
 			 * as given in branch.<name>.remote, we add the
 			 * ref given in branch.<name>.merge, too.
+			 *
+			 * Note: has_merge implies non-NULL branch->remote_name
 			 */
 			if (has_merge &&
 			    !strcmp(branch->remote_name, remote->name))
-- 
1.7.2.1
