From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 05/10] zip: use GIT_SHA1_HEXSZ for trailers
Date: Fri, 13 Mar 2015 23:39:31 +0000
Message-ID: <1426289976-568060-6-git-send-email-sandals@crustytoothpaste.net>
References: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 00:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWZBo-0008Qk-F8
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 00:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbbCMXkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 19:40:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50132 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbbCMXkM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 19:40:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 77BC528096;
	Fri, 13 Mar 2015 23:40:11 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265427>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-zip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 4bde019..b669e50 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -427,12 +427,12 @@ static void write_zip_trailer(const unsigned char *sha1)
 	copy_le16(trailer.entries, zip_dir_entries);
 	copy_le32(trailer.size, zip_dir_offset);
 	copy_le32(trailer.offset, zip_offset);
-	copy_le16(trailer.comment_length, sha1 ? 40 : 0);
+	copy_le16(trailer.comment_length, sha1 ? GIT_SHA1_HEXSZ : 0);
 
 	write_or_die(1, zip_dir, zip_dir_offset);
 	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
 	if (sha1)
-		write_or_die(1, sha1_to_hex(sha1), 40);
+		write_or_die(1, sha1_to_hex(sha1), GIT_SHA1_HEXSZ);
 }
 
 static void dos_time(time_t *time, int *dos_date, int *dos_time)
-- 
2.2.1.209.g41e5f3a
