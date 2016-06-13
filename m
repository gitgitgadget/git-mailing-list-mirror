From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 8/8] t0400: add test for external odb write support
Date: Mon, 13 Jun 2016 10:55:46 +0200
Message-ID: <20160613085546.11784-9-chriscool@tuxfamily.org>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNfz-0007VH-4U
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbcFMI4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35418 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161113AbcFMI4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id k184so13078977wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEu5e5efhdd7Yq3vzzf1c+I1KfcblTUKnaEReM29cCE=;
        b=bDFD3z6wPN7zHui1fcK94xgJCOIVZOZqqUx4IwnFw/Jpnn3sCVMrbQ8sml+iFhu8eu
         OqTQWqiNTbNrW2RRLiTGazDKiNsZ4Oj/9cbYh2R6O1EAhSyDYq08SJ0Lr6dwP7xe05Xr
         l/dSFSlwEpdnIKtPReIBwJhy6grR4Mn3bAcibirfrooIuxc5Qnn5PctfHewPF2zbvlw6
         MNajygKNPNiEx/p+D3BEwz/K/1atIIt+t3eWWBCWTDarORD25k8ReXtMNYRQMTb41EHg
         +GIzANgPKq7IH1AMNvjKHBzB3yp9xucx0JsAD2ENxaDNOyD4B/z/PtpYUDzCuytIiSW8
         B3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEu5e5efhdd7Yq3vzzf1c+I1KfcblTUKnaEReM29cCE=;
        b=C/JZPnX7jS6OqmSd6oOWeIjzmyHMYEQReiPJAFpFX3O91W/xB/NtwY4gxqopTR34v9
         3/OhpMzoimh9jMy1zU9kopjvJ7A1SJwwroiamJXwGMMvWa8oFD7kJkCi7XqF4oUfcq6A
         A2kSv451K8fKWghiEIgm15X23WSqffYOA0mQH8xj4BSaci5+nl000woo/qzKVSY0DzIi
         ne5x2m7Qx4Q8BwqeMknSbzgkq6IM+bsemcFTQ3pBRQn1BqASeR019kU7NQ3UiMYNQt28
         TDR9At3fEQxiYtv+lSTMbzOlxi4EfaOB3ep42NIZeTVNCs1wRHrlqmRwzSJPPmVbVx1Y
         MJ+g==
X-Gm-Message-State: ALyK8tJcBa0qu59t5OgFPaDnq/PZZH1fU/1CJZlxWUorkF+ZTVj/OD9a1LTqCn48p+uXHw==
X-Received: by 10.28.229.147 with SMTP id c141mr10915998wmh.5.1465808172686;
        Mon, 13 Jun 2016 01:56:12 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:12 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297171>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 6c6da5c..3c868ca 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -66,4 +66,12 @@ test_expect_success 'helper can add objects to alt repo' '
 	test "$size" -eq "$alt_size"
 '
 
+test_expect_success 'commit adds objects to alt repo' '
+	test_config odb.magic.command "$HELPER" &&
+	test_commit three &&
+	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo && git show "$hash3") &&
+	test "$content" = "three"
+'
+
 test_done
-- 
2.9.0.rc2.362.g3cd93d0
