From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/33] read_raw_ref(): clear *type at start of function
Date: Fri,  6 May 2016 18:13:54 +0200
Message-ID: <4de20012b2428116751facc0897a3d3b3a2541e8.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:16:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiQ2-0000YN-7q
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665AbcEFQOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:47 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63355 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758663AbcEFQOp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:45 -0400
X-AuditID: 1207440c-c53ff70000000b85-e7-572cc2f4ab9d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 8F.64.02949.4F2CC275; Fri,  6 May 2016 12:14:44 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUt031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:42 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqPvlkE64wbHXYhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxrvfsZC/azVGy//IKxgfE6cxcjJ4eEgIlEQ/M2
	NhBbSGAro0TbVp0uRi4g+ziTxI7mC2AJNgFdiUU9zUwgtohAhETDqxbGLkYODmaBz4wSK7lB
	wsICXhIPltxmB7FZBFQlZv1dAjafVyBKYt/7j6wQu+QkLk9/ADaSU8BC4lDvcSaIveYSHWtv
	sE9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81pXQTIyS8eHYwflsnc4hR
	gINRiYf3wGntcCHWxLLiytxDjJIcTEqivN8LdMKF+JLyUyozEosz4otKc1KLDzFKcDArifBe
	2QeU401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8AYdBGoULEpNT61I
	y8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB4V/fDEwAkBSPEB75UHaeYsLEnOBohCtpxiNORb8
	uL2WiePI/ntrmYRY8vLzUqXEeQ1ASgVASjNK8+AWwRLLK0ZxoL+FeSeBVPEAkxLcvFdAq5iA
	Vr2fqwmyqiQRISXVwMi+7VJH9u6ASRGy8fH3/lyJ+3XZotNS2C/7d8F3GwF+P4MV2udt3X+f
	9r9V87Jv9aM7iWdzZ7SIPVpuPe/VkeltFoz/zk+eO4fpnVem5e1OofuMks1rXe8a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293821>

This is more convenient and less error-prone for callers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fa8bbd6..8ced104 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1430,6 +1430,7 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 	int ret = -1;
 	int save_errno;
 
+	*type = 0;
 	strbuf_reset(&sb_path);
 	strbuf_git_path(&sb_path, "%s", refname);
 	path = sb_path.buf;
-- 
2.8.1
