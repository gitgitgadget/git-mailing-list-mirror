From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/6] worktree: share .git/common in v1
Date: Tue, 26 Jan 2016 18:44:42 +0700
Message-ID: <1453808685-21235-4-git-send-email-pclouds@gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, max@max630.net,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 12:45:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO245-0005R5-6K
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 12:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934279AbcAZLpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 06:45:33 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35984 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934260AbcAZLpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 06:45:31 -0500
Received: by mail-pf0-f193.google.com with SMTP id n128so8121923pfn.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 03:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4GqU0Kp856wQvC1HpJz8EoSuUzNAymzxHER7Mo/DBDg=;
        b=mFZaTcvLX2LxiO5mcxwNvI/qwvGDxtYt/W7JvySV3Yxu7jcU0T25q0ddssw+N5AavS
         EsKbC3XlzaK8K5iEdsFlakUT5xds9ean0oPa0Y4Q1q7fBP4cyfAbsfRw4V2BMYqzj6tw
         ucpfawGliX5le1zkEh1/yP5X1ngn1/6HouORrixyq0jYJgfMIFoyNO/WHQWu1WSp3+mV
         ipPfQTTiXpFf7r9FeIZHTuk5J1cwF7TA90z6aOkaAY0hqefH7EnchVeFTtvMc3Px5drT
         7feqpAAn4Hd5ovBqwW4xEDa6IdSNocBDkOHiVIEy9668ZFj25fQMDYlI999VqHJfKnCG
         X1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=4GqU0Kp856wQvC1HpJz8EoSuUzNAymzxHER7Mo/DBDg=;
        b=BVHicaxYeZeDli66CHbrmvzl2Mu9dwxW9Ihf99sfXqIEmctIefKzhR2+Gq4i5lSd1L
         TWmMpIjAVmlaT051maq//ccvXMXkvoljEJt0HE1SOlNWr/Btloo2g2mbb/X3VgudxeKw
         9XtuSs1cs95VJk/vyBVJhTCxSeVn76N3N2qj+biH2u9hOBKEH7sm9Y4hwQKYjqXTtqmf
         hSqK2dVjVg2UETAlnS6BnpZ6juReHdRuqju1w0nViYr9OvY3+YK/XVrk7RT7c+9pFu0F
         GMBj9Jw0LxQWANArmgJ6qVOtD2bX6e+yobsPKVlBJIIC3zBiF+dGuz8kCtE3ybPkLXGu
         qq/w==
X-Gm-Message-State: AG10YOSAkbCahFTYwIs1ZV4/mPCkadrqsgj2hhwV4giMRs4nAQN7Nx1E2UBqc+saLnnDLw==
X-Received: by 10.66.236.129 with SMTP id uu1mr33293221pac.158.1453808730904;
        Tue, 26 Jan 2016 03:45:30 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id kw10sm1522851pab.0.2016.01.26.03.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 03:45:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Jan 2016 18:45:33 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284805>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitrepository-layout.txt | 4 ++++
 path.c                                 | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 577ee84..771e362 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -250,6 +250,10 @@ commondir::
 modules::
 	Contains the git-repositories of the submodules.
=20
+common::
+	This directory is seen from all working directories. It is
+	meant to share files that all working directories can see.
+
 worktrees::
 	Contains administrative data for linked
 	working trees. Each subdirectory contains the working tree-related
diff --git a/path.c b/path.c
index 14adf5d..3b85968 100644
--- a/path.c
+++ b/path.c
@@ -124,6 +124,7 @@ static struct common_dir common_list_v0[] =3D {
 };
=20
 static struct common_dir common_list_v1[] =3D {
+	{ 0, 1, 0, "common" },
 	{ 0, 1, 0, "branches" },
 	{ 0, 1, 0, "hooks" },
 	{ 0, 1, 0, "info" },
--=20
2.7.0.288.g1d8ad15
