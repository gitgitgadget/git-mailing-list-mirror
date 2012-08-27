From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 2/7] Fix tests under GETTEXT_POISON on git-stash
Date: Mon, 27 Aug 2012 13:36:50 +0800
Message-ID: <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com>
References: <cover.1346045253.git.worldhello.net@gmail.com>
 <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:37:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5s0s-0002xl-W6
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab2H0FhS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 01:37:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57439 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2H0FhO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:37:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6802416pbb.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=511yJVlSXdqjN4uGjqI2F7CcPLcd5SSJgftSIpqZAso=;
        b=A49sbyBuEoowP3gfj1k+OOOfpt6kugWGfpd0SmvukfWrAQ580b8V5owZ5LwgGtHAxq
         yZBY2x2HxBf/azbkFWGEY32wqReiTQwYRwccViamZzX/QnO5BjP9cx0kWB38zNuZvQvp
         nqCU5tJjNmuXEmhoK5DiWkmu7bd4FwdnDRJ65hF7H2SQGUtqp1fGSOBvYFORdDW4oKkZ
         vCf1OfSIoOLEdiCjDzGeRsKE82P8oLoykIJdkxSgFqocJiKC1i9WtObBJ5doXVXoeX7W
         QxhNIg1+O/IRQX8ts88LRfAMP/vkpwa6c1wabzxeA+DdOK0LKJwatl1/hZL5MtMs3Q92
         7lOA==
Received: by 10.68.237.38 with SMTP id uz6mr32073803pbc.23.1346045834512;
        Sun, 26 Aug 2012 22:37:14 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id gf3sm13924207pbc.74.2012.08.26.22.37.09
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:37:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346045253.git.worldhello.net@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204321>

Use i18n-specific test functions in test scripts for git-stash.
This issue was was introduced in v1.7.4.1-119-g355ec:

    355ec i18n: git-status basic messages

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3903-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index cd0426..5dfbd 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -610,7 +610,7 @@ test_expect_success 'stash apply shows status same =
as git status (relative to cu
 		git stash apply
 	) |
 	sed -e 1,2d >actual && # drop "Saved..." and "HEAD is now..."
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 cat > expect << EOF
--=20
1.7.12.92.gaa91cb5
