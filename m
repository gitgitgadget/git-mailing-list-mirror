From: Guanqun Lu <guanqun.lu@gmail.com>
Subject: [PATCH 1/2] code cleanup in sha1_file.c: xmalloc -> xcalloc
Date: Wed, 11 Feb 2009 14:43:31 +0800
Message-ID: <1234334612-24907-1-git-send-email-guanqun.lu@gmail.com>
Cc: Guanqun Lu <guanqun.lu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 15:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWtnU-0005qj-Jx
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 15:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbZBJOjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 09:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbZBJOjp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 09:39:45 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:30441 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbZBJOjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 09:39:45 -0500
Received: by ti-out-0910.google.com with SMTP id d10so2315103tib.23
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 06:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iJ2kj6exU7eapAXsdIH6jkVoYGcPPWtd20pAIUdMwAg=;
        b=Tn0w7yAxoagUh1MjkFM6SnRH79mjFLyFlumCqE4yF+HWtcQBisC2eBQzScBrwWZbVO
         G9xF0pxAyGbQAuSqdgpNmXvueqUKRH6cJSvwxF2Yy/SzmzUET5vOeMnho0NiY2iFbXkl
         WMrZjVgbwl+OR1qpOdou9rY/6qokMUBcjMfKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BmfLId1NnkysLGPa8oT8WK0CLZ0YuEwzI8ouR91FEX3zI67GwWnv0d6O3l4emv7Jvu
         T06SLC6OLDKfiyat9gesF7zbNHAy1OdbqzvKtxGaHn5WREZ4OV8O2UUaxzIjT0qRJLRQ
         hA6Kyv5Y54nhFffGzmAlqGkfeA3OCTkDS4aY0=
Received: by 10.110.63.6 with SMTP id l6mr4305031tia.50.1234276782751;
        Tue, 10 Feb 2009 06:39:42 -0800 (PST)
Received: from localhost ([202.120.224.18])
        by mx.google.com with ESMTPS id b4sm1393184tic.16.2009.02.10.06.39.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 06:39:41 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.392.gb04d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109248>

'xmalloc' followed immediately by 'memset' is replaced
with 'xcalloc', and a simple grep in this project seems
to show that it's the only place.

Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
---
 sha1_file.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8868b80..93e5fc0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -858,8 +858,7 @@ unsigned char* use_pack(struct packed_git *p,
 
 static struct packed_git *alloc_packed_git(int extra)
 {
-	struct packed_git *p = xmalloc(sizeof(*p) + extra);
-	memset(p, 0, sizeof(*p));
+	struct packed_git *p = xcalloc(1, sizeof(*p) + extra);
 	p->pack_fd = -1;
 	return p;
 }
-- 
1.6.1.2.392.gb04d1
