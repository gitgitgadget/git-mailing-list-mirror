From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/32] read-tree: note about dropping split-index mode or index version
Date: Mon, 28 Apr 2014 17:55:50 +0700
Message-ID: <1398682553-11634-30-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejFQ-0003tZ-QD
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbaD1K5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:57:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45717 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbaD1K5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:57:07 -0400
Received: by mail-pb0-f46.google.com with SMTP id ma3so1867688pbc.33
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qMs6bjD38GdvvSeJQKmcXBJaVAYerCjFg7hileiuaOI=;
        b=iFjYnd6PJXGTPPLtll0JzSiuYEr9vNWCsb6g7h6RPE8c+IG/cAhhGFU5iDB4RWd5Ui
         F1Obd2WmRb8XCJ8GXhS8Z2E9A71R+KI7tAXf61pUTmgywRGuHFEVJxWj5yoTH0d9ET5X
         U2ievmDsoPZ9SRPaFLFcxroYZlNK/I8I5DWrhsPl+Xm3cZnztq4IUwNMD288iD0pO6nY
         SZhfHgY2u8N2tIKP8pRjMubU6nxZ7D10G1WCBEXkVF78MxkSNMcyUtFaa7qVyuD6rqF3
         oLBSzeZr/bXCwSXSK90ueRAbCpa9RjzPNKl0a/v97THnJJNWevlB/qkZpGH7OW3qS5L/
         gDRQ==
X-Received: by 10.68.136.2 with SMTP id pw2mr1627098pbb.167.1398682627196;
        Mon, 28 Apr 2014 03:57:07 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id bu1sm34195569pbb.54.2014.04.28.03.57.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:57:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:35 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247291>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/read-tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 3204c62..e7e1c33 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -155,6 +155,15 @@ int cmd_read_tree(int argc, const char **argv, con=
st char *unused_prefix)
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
=20
+	/*
+	 * NEEDSWORK
+	 *
+	 * The old index should be read anyway even if we're going to
+	 * destroy all index entries because we still need to preserve
+	 * certain information such as index version or split-index
+	 * mode.
+	 */
+
 	if (opts.reset || opts.merge || opts.prefix) {
 		if (read_cache_unmerged() && (opts.prefix || opts.merge))
 			die("You need to resolve your current index first");
--=20
1.9.1.346.ga2b5940
