From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 39/41] upload-pack.c: use error_errno()
Date: Sun,  1 May 2016 18:14:55 +0700
Message-ID: <1462101297-8610-40-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOk-0008MA-SJ
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcEALSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35435 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbcEALSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so19012813pfr.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrMpYL76dCsegoGZnSvjOxowW8myTE9oSuxMkZa2abU=;
        b=d152eXobflKPPQ72d2F1QZ78+fCC3wXcPdaO8SK5tNmTpDG1Bu93MKHhg85eGn5iru
         /iQ3EkYHZC8M3PCSR6dDiOF0o0P8/fo2yS7wS4vTQzB3fr+by4d0Ds+uz0rrnc9X615m
         FvQM3EDuiLUhb05pyXXZR+AaBxjLNph9HSyD9Z/Dtatarnc0zxL5cjgU7+FHo+9Nr5Ub
         2zlGAN4V5ocazGJeqRvW327As9oz7zjixToTn3YRmY/kTM2Ui2HTHAwxo2qlNcuKxUzP
         VxZgZ4pNmfDsGinXdQZmMPIj8nbyBYer2yqPjQOHwSjNKmdPSaqM0jwo1M2AY/AMGgXd
         mguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrMpYL76dCsegoGZnSvjOxowW8myTE9oSuxMkZa2abU=;
        b=SfMqxXOUkxDCn/i5zN4acPDm3GEcQqTltIwEKq2p9ROQW6mAwPMgOqcoftqSRVnqrQ
         YrO3lJb1Tyy12HH1BnEHa/Jj7l+4VVjSgG/5zveG+MJ3pM+q6FSOUhlh23PQthEdwv2Q
         m94pKys08jawPG1+OqYj1ieYx9Zygk3kHKhX2X5B840c/OhggelnCsOu4b2cXpxYp7xk
         aOqyydO++E2yk2/PH1vMp+qVZu/LW2YbIrHAjL1fqHlMMLfPm4ehJzsgGd9RVGxmWZ4v
         nNP2Ygpg8tsSdnq4slsavO22vK0lAOC6oAe7xlLEPUxaLBuBL3/TvFbrIo6TiclpmqjL
         q/LQ==
X-Gm-Message-State: AOPr4FVSohmXNHI8kGjA5INS27hVjECMX/I9QkEBqYTx+9HRXviQO1pTRy8nJhZpjTAkFg==
X-Received: by 10.98.71.80 with SMTP id u77mr43389828pfa.119.1462101525495;
        Sun, 01 May 2016 04:18:45 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 82sm37056370pfb.64.2016.05.01.04.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:41 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293189>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc802a0..f19444d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -174,8 +174,7 @@ static void create_pack_file(void)
=20
 		if (ret < 0) {
 			if (errno !=3D EINTR) {
-				error("poll failed, resuming: %s",
-				      strerror(errno));
+				error_errno("poll failed, resuming");
 				sleep(1);
 			}
 			continue;
--=20
2.8.0.rc0.210.gd302cd2
