From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 1/7] i18n: index-pack: use plural string instead of normal one
Date: Tue, 19 Apr 2016 13:19:18 +0000
Message-ID: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:21:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVaW-0003mh-SF
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbcDSNVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 09:21:03 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:54977 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754422AbcDSNUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:20:06 -0400
Received: (qmail 14431 invoked from network); 19 Apr 2016 13:19:58 -0000
Received: (qmail 6677 invoked from network); 19 Apr 2016 13:19:58 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[147.203.126.136])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <git@vger.kernel.org>; 19 Apr 2016 13:19:53 -0000
X-PTMail-RemoteIP: 147.203.126.136
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291860>

Git could output "completed with 1 local objects", but in this case
using "object" instead of "objects" is the correct form.
Use Q_() instead of _().

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/index-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2d1eb8b..e8c71fc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1250,7 +1250,9 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		       nr_unresolved * sizeof(*objects));
 		f = sha1fd(output_fd, curr_pack);
 		fix_unresolved_deltas(f);
-		strbuf_addf(&msg, _("completed with %d local objects"),
+		strbuf_addf(&msg, Q_("completed with %d local object",
+				     "completed with %d local objects",
+				     nr_objects - nr_objects_initial),
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
-- 
2.1.4
