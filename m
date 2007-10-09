From: =?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
Subject: [PATCH] Fixed crash in fetching remote tags when there is not tags.
Date: Tue, 09 Oct 2007 11:51:08 +0300
Message-ID: <1191919868-4963-2-git-send-email-v@pp.inet.fi>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 11:31:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfBQU-0000TK-1m
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 11:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbXJIJaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 05:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbXJIJaY
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 05:30:24 -0400
Received: from astana.suomi.net ([82.128.152.18]:54367 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126AbXJIJaV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 05:30:21 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2007 05:30:21 EDT
Received: from tiku.suomi.net ([82.128.154.67])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JPM005KPZ9ANU40@astana.suomi.net> for
 git@vger.kernel.org; Tue, 09 Oct 2007 11:51:10 +0300 (EEST)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JPM009TUZBERGB0@mailstore.suomi.net> for git@vger.kernel.org;
 Tue, 09 Oct 2007 11:52:26 +0300 (EEST)
Received: from localhost.localdomain
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam2.suomi.net (Postfix) with ESMTP id A45CC19CB0F; Tue,
 09 Oct 2007 11:51:37 +0300 (EEST)
In-reply-to: <1191919868-4963-1-git-send-email-v@pp.inet.fi>
X-Mailer: git-send-email 1.5.3.4.1156.g5407-dirty
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.768,
 required 5, autolearn=not spam, AWL 0.10,	BAYES_00 -1.00,
 FORGED_RCVD_HELO 0.14)
X-OPOY-MailScanner-From: v@pp.inet.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60374>

Signed-off-by: V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 <v@pp.inet.fi>
---
 remote.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index e7d735b..5e92378 100644
--- a/remote.c
+++ b/remote.c
@@ -537,6 +537,8 @@ static int count_refspec_match(const char *pattern,
=20
 static void tail_link_ref(struct ref *ref, struct ref ***tail)
 {
+	if (!ref) return;
+=09
 	**tail =3D ref;
 	while (ref->next)
 		ref =3D ref->next;
--=20
1.5.3.4.1156.g5407-dirty
