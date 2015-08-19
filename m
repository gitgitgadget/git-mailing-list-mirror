From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/3] t7063: use --force-untracked-cache to speed up a bit
Date: Wed, 19 Aug 2015 20:01:24 +0700
Message-ID: <1439989286-24355-2-git-send-email-pclouds@gmail.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
 <1439989286-24355-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 15:01:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS2zx-0004EU-CF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 15:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbbHSNBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2015 09:01:40 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35548 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbbHSNBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 09:01:40 -0400
Received: by pacgr6 with SMTP id gr6so2901553pac.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SAyAsI/4mgiO8dzsZBWoPVMmp3iaZ/dJOAHIp2YCdls=;
        b=r69I1J9Ywk1OKScJI/39D+4X6mdD9H4D3/2b6CSmRj2si1oanwZsXVWt63UfxgcR/w
         i/fPH9zN6MhwVWL6Jxj2ydXI9w5wa16YZdCVPe5q8vCgVzZ4vqZnHu3wH7HXrAbQK3wF
         YU4q1nl1Bf28RTqJJooBbrfNLrtxexXwaC42fHQWynUGO0/3av5oQ/k4UEQKhz9tEy9E
         9GJTX7kUsmynhJUXTfjDVDJzG8f9F2WK6xkBwY0XNLY/Nd1eUMd7jSTBq4LMfTRo4AhX
         BphqK0lLidp9131NYP3JDPJ88Rf95zAnAZMdmcdGl3gCWAhjHBz8OjNJ2rugyHzWMtxz
         QYbg==
X-Received: by 10.68.167.227 with SMTP id zr3mr9060777pbb.61.1439989299592;
        Wed, 19 Aug 2015 06:01:39 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id k5sm865006pdb.53.2015.08.19.06.01.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2015 06:01:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Aug 2015 20:01:33 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1439989286-24355-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276175>

When in the middle of t7063, we are sure untracked cache is supported,
so we can use --force-untracked-cache to skip the support detection
phase and save a few seconds. It's also good that --force-untracked-cac=
he
is exercised in the test suite.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t7063-status-untracked-cache.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untrack=
ed-cache.sh
index ff23f4e..744e922 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -402,7 +402,7 @@ test_expect_success 'set up sparse checkout' '
 	echo "done/[a-z]*" >.git/info/sparse-checkout &&
 	test_config core.sparsecheckout true &&
 	git checkout master &&
-	git update-index --untracked-cache &&
+	git update-index --force-untracked-cache &&
 	git status --porcelain >/dev/null && # prime the cache
 	test_path_is_missing done/.gitignore &&
 	test_path_is_file done/one
--=20
2.3.0.rc1.137.g477eb31
