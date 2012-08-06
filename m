From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv2] merge-recursive: add hint for translators in handle_change_delete()
Date: Mon,  6 Aug 2012 20:03:44 +0200
Message-ID: <1344276224-11876-1-git-send-email-ralf.thielow@gmail.com>
References: <1344189332-27082-1-git-send-email-ralf.thielow@gmail.com>
Cc: trast@student.ethz.ch, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 06 20:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyRfA-00053D-3Q
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 20:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195Ab2HFSEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 14:04:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58656 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248Ab2HFSEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 14:04:13 -0400
Received: by bkwj10 with SMTP id j10so1141307bkw.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eeUHm8OHANgyu+B057fTec1ho4WRnsZg6ZW3C0gt9EA=;
        b=yRRV2wdDVcp4E+ip0vTe1HFyEzeaOf7L5aybcH096To8i7JDZ+o1mjGXf/4u81zTnG
         qPGoY7u09x+CDNzhwQXO3XlGwpIIxW2xf+GL+i77VrIwkOVL0itY0qGx5hk6PQQasM++
         ZZP35M79jEnLME542/g7PWtgwV6yGAxHNUunFpOhYGfXvlXuorlgpEjW5cHOPMF843Gq
         FuSG/z0jFRXyX9lGeURDxgI8C6+uNdo67KneAmM/mhvAWIoQr1SiNb86PV7ZCBvQpBTG
         XMbQRIpoenEr+dsjME8W3QRCzeFCfe7Zhbim+psQm8zqR/FSKWE/nDHcf9O1k69K04wT
         mQKQ==
Received: by 10.204.146.82 with SMTP id g18mr3199270bkv.126.1344276252012;
        Mon, 06 Aug 2012 11:04:12 -0700 (PDT)
Received: from rath.fedora (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id hs2sm7835604bkc.1.2012.08.06.11.04.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 11:04:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1
In-Reply-To: <1344189332-27082-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202975>

The outputs in handle_change_delete() contain a lot of placeholders.
This could end up in confusion to translators. Add a hint for translators
that they can easily understand it without study the code.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
The first version did only explain the first and the
fourth placeholder. Junio pointed out that the others
could still confuse translators. This second version
explains now all placeholders. It differs to Junio's
suggestion in a modified header and an optional part
for the other messages.

 merge-recursive.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8903a73..ca58dcd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1035,6 +1035,20 @@ static void handle_change_delete(struct merge_options *o,
 		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
 	} else if (!a_sha) {
 		if (!renamed) {
+			/*
+			 * TRANSLATORS: The next four messages have many
+			 * placeholders.
+			 *
+			 * CONFLICT (
+			 * %s=<translation of noun "rename" or "modify">/delete):
+			 * %s=<name of the path being merged> deleted in
+			 * %s=<name of a branch> and
+			 * %s=<translation of verb pp "renamed" or "modified"> in
+			 * %s=<name of a branch>. Version
+			 * %s=<name of a branch> of
+			 * %s=<name of the path being merged> left in tree[.][at
+			 * %s=<name of the path beeing merged was renamed to>.]
+			 */
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree."),
 			       change, path, o->branch1, change_past,
-- 
1.7.12.rc1
