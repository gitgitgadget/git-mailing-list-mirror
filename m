From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/43] apply: do not check sha1 if there is no repository
Date: Mon,  5 Apr 2010 20:41:18 +0200
Message-ID: <1270492888-26589-34-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrHA-0000ps-Pt
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0DESnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:41 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab0DESnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:39 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WnuriLMh8phhBQihafr2qqKr7FhHgBNJ8jSPqFNgruc=;
        b=rGGVagZ/X0YCEpmLS39sSodCzd2odcFNp04OrKGiCRB1kTLJe03BnRr5SL45cEDuZB
         80jBeEHF0EtnQDOXrXiyXvS6i0z4VCe+MhRxk2ztmsUtIVe02U3xYF3IdfwE//WqaVpN
         wo3ujTDxCkQofzVSi9lFIl0SwxMjlQFziP538=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PqH5idkYQ/RlU8c16omxC5830omvs6lKaOHOuLxu13x7ztfQevl5PKRQPVaSf50MuR
         JvkCRXm/w/PGHEsQpwEXl2NQsTjLRDhKPuqnyJwl8laTGLsn3T22lToUljuKuec2DppW
         nruZsW/yEivwuqnvEKV6Z4VZJGQQ2EN5DMGzs=
Received: by 10.223.75.15 with SMTP id w15mr6093512faj.70.1270493018444;
        Mon, 05 Apr 2010 11:43:38 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id f31sm13676495fkf.48.2010.04.05.11.43.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:38 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:35 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144024>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index bb957d4..0f269aa 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2546,7 +2546,7 @@ static int apply_binary(struct image *img, struct=
 patch *patch)
 		return 0; /* deletion patch */
 	}
=20
-	if (has_sha1_file(sha1)) {
+	if (startup_info->have_repository && has_sha1_file(sha1)) {
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
--=20
1.7.0.rc1.541.g2da82.dirty
