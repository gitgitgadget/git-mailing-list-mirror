From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 1/7] i18n: index-pack: use plural string instead of normal one
Date: Sat,  9 Apr 2016 20:38:38 +0000
Message-ID: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 22:39:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozes-0000jw-1w
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbcDIUi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:38:56 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:56781 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754517AbcDIUi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 16:38:56 -0400
Received: (qmail 8042 invoked from network); 9 Apr 2016 20:38:53 -0000
Received: (qmail 15132 invoked from network); 9 Apr 2016 20:38:53 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 9 Apr 2016 20:38:48 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291126>

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
