From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] pack-check.c: minor formatting fix to match coding style
Date: Fri, 30 Jan 2009 03:05:13 -0800
Message-ID: <1233313517-24208-2-git-send-email-gitster@pobox.com>
References: <1233313517-24208-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 12:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrD1-0005hA-EJ
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZA3LFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZA3LFY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:05:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbZA3LFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:05:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AF20F2A11C
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 207852A111 for
 <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:21 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.312.g5be3c
In-Reply-To: <1233313517-24208-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E3AE30FC-EEBD-11DD-8327-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107792>

Adjust misaligned columns and multi-line comments that violate our coding
style before touching this file.

Also fix an obvious typo.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pack-check.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 90c33b1..2c5f521 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -4,7 +4,7 @@
 
 struct idx_entry
 {
-	off_t                offset;
+	off_t offset;
 	const unsigned char *sha1;
 	unsigned int nr;
 };
@@ -43,7 +43,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 }
 
 static int verify_packfile(struct packed_git *p,
-		struct pack_window **w_curs)
+			   struct pack_window **w_curs)
 {
 	off_t index_size = p->index_size;
 	const unsigned char *index_base = p->index_data;
@@ -54,7 +54,8 @@ static int verify_packfile(struct packed_git *p,
 	int err = 0;
 	struct idx_entry *entries;
 
-	/* Note that the pack header checks are actually performed by
+	/*
+	 * Note that the pack header checks are actually performed by
 	 * use_pack when it first opens the pack file.  If anything
 	 * goes wrong during those checks then the call will die out
 	 * immediately.
@@ -72,21 +73,23 @@ static int verify_packfile(struct packed_git *p,
 	git_SHA1_Final(sha1, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (hashcmp(sha1, pack_sig))
-		err = error("%s SHA1 checksum mismatch",
-			    p->pack_name);
+		err = error("%s SHA1 checksum mismatch", p->pack_name);
 	if (hashcmp(index_base + index_size - 40, pack_sig))
-		err = error("%s SHA1 does not match its inddex",
-			    p->pack_name);
+		err = error("%s SHA1 does not match its index", p->pack_name);
 	unuse_pack(w_curs);
 
-	/* Make sure everything reachable from idx is valid.  Since we
+	/*
+	 * Make sure everything reachable from idx is valid.  Since we
 	 * have verified that nr_objects matches between idx and pack,
 	 * we do not do scan-streaming check on the pack file.
 	 */
 	nr_objects = p->num_objects;
 	entries = xmalloc((nr_objects + 1) * sizeof(*entries));
 	entries[nr_objects].offset = pack_sig_ofs;
-	/* first sort entries by pack offset, since unpacking them is more efficient that way */
+	/*
+	 * First sort entries by pack offset, since unpacking them is more
+	 * efficient that way.
+	 */
 	for (i = 0; i < nr_objects; i++) {
 		entries[i].sha1 = nth_packed_object_sha1(p, i);
 		if (!entries[i].sha1)
-- 
1.6.1.2.312.g5be3c
