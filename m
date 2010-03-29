From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 3/7] fast-import: always create marks_file directories
Date: Mon, 29 Mar 2010 11:48:25 -0500
Message-ID: <1269881309-19690-4-git-send-email-srabbelier@gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Niede
X-From: git-owner@vger.kernel.org Mon Mar 29 18:49:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwI9a-0007r6-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab0C2Qsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:48:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44618 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab0C2Qst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:48:49 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so1551144gyg.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d8I/miMhKEktF/XkRN3Dk/oYRU22EZPNQYuVCKyqhEI=;
        b=NkOBzLYMZ4cQB9F6+u9rh9qxqjFje/3eHBUHFOvc1+hpvC3mUCvUNAbAx1r5/0RxKn
         mkYShgQEBC5WztpkaGEVTiG7Fyfyb7ejOnjBNuqo+jn0beEObp2Np9GiRPmxRCBV4LPh
         Aaz1oMIlcbFqh+3rp/VNy5ImBM6wydrvSxA4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VYqW16WtlVTXFygQeY1K0snxLb8WMdW2a5e50kdsjAMLEKvHp8bK3DHBXVaIf9FIrw
         RsNFGWO6+GjE7aMhEBSBouFT1LIFLY5p5DsDDtxG5Yc+Q9Qf7Y4/paWu6VdUDLlhcyDH
         w7E/Rg/kVliDuiWNc7M0KxSQnvjbqM7qq2pmM=
Received: by 10.142.2.2 with SMTP id 2mr1412868wfb.75.1269881328343;
        Mon, 29 Mar 2010 09:48:48 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 23sm4102040iwn.10.2010.03.29.09.48.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 09:48:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.317.gbb04ec
In-Reply-To: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143494>

CC: "Shawn O. Pearce" <spearce@spearce.org>
---

	Not stricly neccesary (one could argue that it is the
	responsibility of the caller to make sure the directory exists),
	but it might make sense to do this one (in fast-import) rather
	than having to do it in all helpers.

 fast-import.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 309f2c5..129a786 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2707,6 +2707,7 @@ static void option_import_marks(const char *marks, int from_stream)
 	}
 
 	import_marks_file = make_fast_import_path(marks);
+	safe_create_leading_directories_const(import_marks_file);
 	import_marks_file_from_stream = from_stream;
 }
 
@@ -2737,6 +2738,7 @@ static void option_active_branches(const char *branches)
 static void option_export_marks(const char *marks)
 {
 	export_marks_file = make_fast_import_path(marks);
+	safe_create_leading_directories_const(export_marks_file);
 }
 
 static void option_export_pack_edges(const char *edges)
-- 
1.7.0.3.317.gbb04ec
