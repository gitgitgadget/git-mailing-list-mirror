From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/19] apply: do not check sha1 when repository has not been found
Date: Sun, 21 Mar 2010 17:30:39 +0700
Message-ID: <1269167446-7799-13-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIVa-0003b1-6L
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab0CUKfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:35:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34500 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0CUKfl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:35:41 -0400
Received: by gwaa18 with SMTP id a18so510129gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=F39mpIqzF1cKoqCH3m5hWh9So1P2bg4PhN9EQx362/0=;
        b=GaHakVVxTk0Z3128nQ7o1seYd/ZM0TR6WIh9d4vndcGxS7UinfAdhczZTa9bOx2CPg
         FVrgB3yX+pNveasokoKRHe1/hRfYZb0cZMTKUwQBYGPHp/s2T0wZVQeFkF4CUgQZww+L
         a5DsL2qZYzq6e5xzqL/Va8Wq6+0W9E0H/trgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DsMx3yJGCCJ3kHjJ+EM1W4KUm25wG2xC7but5uKrKvhH/QvtZtlI/7m3wns8rV27+i
         zlfboB7AC1HnKr0K+wQ7f+bOnemifuQlT7y6pfp1S6uEmkIjXVyiD7RWcPnM38ygOiXJ
         Dwqu8s4ELqd/lBNBllgJqp4m0eqTJ76FIakbE=
Received: by 10.150.63.1 with SMTP id l1mr3025866yba.240.1269167740578;
        Sun, 21 Mar 2010 03:35:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 22sm1864369iwn.12.2010.03.21.03.35.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:31:59 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142809>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d27aac6..ea7bf57 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2441,7 +2441,7 @@ static int apply_binary(struct image *img, struct=
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
1.7.0.2.425.gb99f1
