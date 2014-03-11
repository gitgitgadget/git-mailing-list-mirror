From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: [PATCH] status merge: guarentee space between msg and path
Date: Tue, 11 Mar 2014 12:30:47 -0400
Message-ID: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com,
	Sandy Carter <sandy.carter@savoirfairelinux.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 17:29:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNPYI-0004hT-UX
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 17:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbaCKQ3I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 12:29:08 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:62538 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbaCKQ3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 12:29:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9805110D704F;
	Tue, 11 Mar 2014 12:29:06 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AMQP-OaPeJ9a; Tue, 11 Mar 2014 12:29:06 -0400 (EDT)
Received: from scarter-X220.mtl.sfl (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5B4BA10D704E;
	Tue, 11 Mar 2014 12:29:06 -0400 (EDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243870>

Add space between how and one when printing status of unmerged data.
This fixes an appending of the how message when it is longer than 20.
This is the case in some translations such as the french one where
the colon gets appended to the file:

    supprim=C3=A9 par nous :wt-status.c
    modifi=C3=A9 des deux c=C3=B4t=C3=A9s :wt-status.h

Additionally, having a space makes the file in question easier to selec=
t
in console to quickly address the problem. Without the space, the colon
(and, sometimes the last word) of the message is selected along with th=
e
file.

The previous french example should now print as the following, which is
more proper:

    supprim=C3=A9 par nous : wt-status.c
    modifi=C3=A9 des deux c=C3=B4t=C3=A9s : wt-status.h

Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
---
 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index a452407..69e0dfc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -264,7 +264,7 @@ static void wt_status_print_unmerged_data(struct wt=
_status *s,
 	case 6: how =3D _("both added:"); break;
 	case 7: how =3D _("both modified:"); break;
 	}
-	status_printf_more(s, c, "%-20s%s\n", how, one);
+	status_printf_more(s, c, "%-19s %s\n", how, one);
 	strbuf_release(&onebuf);
 }
=20
--=20
1.9.0
