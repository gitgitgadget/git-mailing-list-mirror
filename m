From: =?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
Subject: [PATCH] http-push: disable http-push without USE_CURL_MULTI
Date: Sun, 13 Jan 2008 20:02:59 +0100
Message-ID: <1200250979-19604-3-git-send-email-gb@gbarbier.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
 <1200250979-19604-2-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 20:03:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE87L-00078E-D0
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 20:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbYAMTDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2008 14:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYAMTDF
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 14:03:05 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37535 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbYAMTDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 14:03:04 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A2D471AB2FA;
	Sun, 13 Jan 2008 20:03:00 +0100 (CET)
Received: from localhost.localdomain (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2CE6A1AB38E;
	Sun, 13 Jan 2008 20:03:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1200250979-19604-2-git-send-email-gb@gbarbier.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70405>

Make http-push always fail when not compiled with USE_CURL_MULTI, since
otherwise it corrupts the remote repository (and then fails anyway).

Signed-off-by: Gr=C3=A9goire Barbier <gb@gbarbier.org>
---
 http-push.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index cbbf432..96c8e75 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2212,6 +2212,10 @@ int main(int argc, char **argv)
 		break;
 	}
=20
+#ifndef USE_CURL_MULTI
+	die("git-push is not available for http/https repository when not com=
piled with USE_CURL_MULTI");
+#endif
+
 	if (!remote->url)
 		usage(http_push_usage);
=20
--=20
1.5.3.6
