From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 4/4] t1700-split-index: add test for rev-parse --shared-index-path
Date: Fri, 22 Apr 2016 17:53:12 -0400
Message-ID: <1461361992-91918-5-git-send-email-rappazzo@gmail.com>
References: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 23:53:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atj0l-0001lV-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbcDVVxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:53:08 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34168 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbcDVVxF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:53:05 -0400
Received: by mail-yw0-f195.google.com with SMTP id i22so16074905ywc.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bBonegNYbnoOgO9FBJ6QePicgdFKkm5uecAcgaFMPFA=;
        b=OHk0HUQL4L5/E41Sk3KSwS8vCURvS5rFKDO0CSULzmz6OREy2I6fKZd5hZ44TOzAtT
         i5EsrArmt2VclRZoxR1xmg+hP3Npdmd+fR6D8vTk5E+3W2kU/l2xbyRyN3XYQTi/SOfk
         jE73lKzFbmqwSJ0SJ631f/Pcf3LZbh4DrTz1h96ELUrFdb3/6cT+WCfz780V5i/otles
         CsvOtFVMQgaBQvjDBTCyACOCjfhtm+ZGJuzV6fDJla1XDnMp+rWY5Ennq/lqCiX/KNgz
         TTx+gRZ4ZnryDse2UF/WiDbYn87FGj0eCkYQXay15wknij07pDuHz3DkJDdo6t/Ur9/L
         D1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bBonegNYbnoOgO9FBJ6QePicgdFKkm5uecAcgaFMPFA=;
        b=iYMghZtTL59Hn7dZltTxScNQRaMc0JXggHIcHnbJLWUcvEkBSys67Jlq3mOdo7gB5N
         sP35C/PJEI2VZ3mNwTo+IkeC0Gn4tgKsJekGsV4r0e8W74TvKiyLaORgrXlaTLwS2Eqj
         NWxiNmMn8Fi5bMbQRKHu7tM3C36gV4IjZS+RUwIbZk6eYtGMU4WiOdTnDxhzX0E6Hdbf
         U6u4wcTNsYNDJa4C0gjDXg5rtCQ5p592ceCLBduUn+pPoOOPMmABnOQWdz1/XNHf/D9L
         RcJLiioD/60CUAlOLAsWVM2v69t7kYlNS2QJeJ1DBGt5WtvB8I6zWJlMZ/ECsOMsrost
         M1vA==
X-Gm-Message-State: AOPr4FVURaiNoXHCo7HE8BwVaa0iow+KSzktgkW2hc2sJxxPJA3rVGt5EjStPcgQIheXXQ==
X-Received: by 10.37.2.146 with SMTP id 140mr14632969ybc.60.1461361984759;
        Fri, 22 Apr 2016 14:53:04 -0700 (PDT)
Received: from MRappazzo-8.local.com (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id m141sm5542104ywd.2.2016.04.22.14.53.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 14:53:04 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292271>

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/t1700-split-index.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 8aef49f..d2d9e02 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,4 +200,21 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-parse --shared-index-path' '
+	rm -rf .git &&
+	test_create_repo . &&
+	git update-index --split-index &&
+	ls -t .git/sharedindex* | tail -n 1 >expect &&
+	git rev-parse --shared-index-path >actual &&
+	test_cmp expect actual &&
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	(
+		cd work &&
+		ls -t ../.git/sharedindex* | tail -n 1 >expect &&
+		git rev-parse --shared-index-path >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.8.0
