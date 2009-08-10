From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] Correctly mark cover letters' encodings if they are not
 pure ASCII
Date: Mon, 10 Aug 2009 18:22:22 +0200 (CEST)
Message-ID: <c3c2969ae2c3b358542a466f52ea147f0275eccd.1249921206u.git.johannes.schindelin@gmx.de>
References: <cover.1249921206u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-422255834-1249921342=:8324"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 10 18:22:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXds-0005S5-Nj
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbZHJQWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755629AbZHJQWX
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:22:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:37998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755625AbZHJQWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:22:23 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:22:22 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp046) with SMTP; 10 Aug 2009 18:22:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HFE8utXjHTBNj7io20dnvewGrlPt1f6lpGMR3N9
	UsnlM/PprWdYA/
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1249921206u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125479>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-422255834-1249921342=:8324
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

If your name is, say, Üwë, you want your cover letters to appear
correctly.  Convince format-patch to mark it as 8-bit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-log.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 3600215..d4a6a7d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -678,6 +678,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	log_write_email_headers(rev, head, &subject_start, &extra_headers,
 				&need_8bit_cte);
 
+	for (i = 0; !need_8bit_cte && i < nr; i++)
+		if (has_non_ascii(list[i]->buffer))
+			need_8bit_cte = 1;
+
 	msg = body;
 	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
 		     encoding);
-- 
1.6.3.2.734.g770e
--8323329-422255834-1249921342=:8324--
