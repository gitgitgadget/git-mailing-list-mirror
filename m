From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] builtin/branch.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Mon, 13 Dec 2010 23:59:55 -0200
Message-ID: <996ab205063a5e0d70c064ed43633a4f651ea9ce.1292291971.git.tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 03:00:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKBu-0007Ey-Nk
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759016Ab0LNCA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:00:29 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42688 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759010Ab0LNCA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:00:29 -0500
Received: by yxt3 with SMTP id 3so68441yxt.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 18:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=IZN7rAEd42OMSiCy+zyHuYgEYF1lZ7qi77Ta8Tmmg7g=;
        b=KHDeU2kVHppdvzRdG5GGLfKBkQkqX2CQrFQ3Hh4IRX6N74K0+D47jfUzovBY6vSWXC
         OKjUxFsNMwvYDvrv6Ntas5KK65mNRAytJmpbQtQqGt8w/N+A1cg+FhVJFSgz4zTrr84C
         0EJAPl2CG80lZLGufo51PfUff9h0evqFlGoXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=mQMLrgpjWfxaeTeCPvmH/VOneMdQ9ylAbV/6qsYyvSmv1HOE4M7dezemvX/SNNQhMZ
         sf1Q4X7Y5cZw2T3IxAnpjj8T8EhKR8I+CUkd2Zv9FTI3hTKme8VTUOf5N8qJcoAgm9WY
         x415WDBU2b09p0EofCU2M4adudVSl7jBFqBws=
Received: by 10.151.154.19 with SMTP id g19mr6894895ybo.440.1292292028247;
        Mon, 13 Dec 2010 18:00:28 -0800 (PST)
Received: from localhost ([186.205.6.151])
        by mx.google.com with ESMTPS id v8sm3932587yba.14.2010.12.13.18.00.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 18:00:27 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.343.g7d43d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163611>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/branch.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 807355a..7f34fad 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -314,11 +314,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	}
 
 	/* Resize buffer */
-	if (ref_list->index >= ref_list->alloc) {
-		ref_list->alloc = alloc_nr(ref_list->alloc);
-		ref_list->list = xrealloc(ref_list->list,
-				ref_list->alloc * sizeof(struct ref_item));
-	}
+	ALLOC_GROW(ref_list->list, ref_list->index + 1, ref_list->alloc);
 
 	/* Record the new item */
 	newitem = &(ref_list->list[ref_list->index++]);
-- 
1.7.3.2.343.g7d43d
