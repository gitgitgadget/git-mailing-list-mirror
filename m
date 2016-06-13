From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 5/8] t0400: add test for 'put' command
Date: Mon, 13 Jun 2016 10:55:43 +0200
Message-ID: <20160613085546.11784-6-chriscool@tuxfamily.org>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNg1-0007VH-G5
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422850AbcFMI4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35376 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161166AbcFMI4K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so13078557wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LxeDQOz9Rltp33IXZXNOaeTrOUuRqisZk3CTH4GJX88=;
        b=K0BO4s2YjweDt1GjTfHVu9iNvM6z2EXRCeEWFr8TY7go0aQrVQOlJYrJV/iyGEZZkz
         Ai3VvbwMr+J10FJRAllM+oO1DTFRdylbn9Z4qU+BmaKZorJG08AdWec5X6ves9zACr4J
         6tS6yHOOQ1QqR49/as7RmHuArBQikm/cHrJT14xokbVnHQgsohRcbdOcWjnYBCRQetb6
         VLsq+daTQrlc7JeRAgHgPKCOFtLexnDJKDpI0UI1R5yf4/d8URlifQ8oPj/8mb17p5Wc
         uIPndSlT6o5oJNfLG1VqsVUvyXMjoWkD/DpoOrOu2lph8RLZxwGq35gWsHLXTGNeuo3j
         h7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LxeDQOz9Rltp33IXZXNOaeTrOUuRqisZk3CTH4GJX88=;
        b=iHaWFa12eD9VVwdQk5V4OwByo7IbjvIKql0SQ3n0zh/js8ZQvCSTi8tTwnys5E73eg
         xutzrqK8RkL7peWSCLc3FC/PC892AUsBSP1i45zVNbByy7wl+TT4zhg+7BGHA1sDW2iA
         bOTpUxZaBzcAPGoteW9Ae0BGtWR7KS4rRPj+Clt2g0bIwc9ZADqupl7aLofFBl88EoKu
         eFIjXQ4VGUT03pbPa3UeMSU/ZAKvvpf90ZqDciHNBcXRTRfCpewmulcOdNIIqHpRFANQ
         3vX8j4YQrSIbJfDKUKutnFzlCkl53hWGpXJyM9N5g01p66hp2TYJwfWNor1QPy5/WjX4
         AtcQ==
X-Gm-Message-State: ALyK8tIHU0hbQTVbhGnTtXHbOJ6EmApUFzl/HVon11rj5ITZfKjvOiaBg9e6/qIWCZMIoQ==
X-Received: by 10.28.90.65 with SMTP id o62mr9983571wmb.16.1465808169396;
        Mon, 13 Jun 2016 01:56:09 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:08 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297172>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 0f1bb97..6c6da5c 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -57,4 +57,13 @@ test_expect_success 'helper can retrieve alt objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'helper can add objects to alt repo' '
+	hash=$(echo "Hello odb!" | git hash-object -w -t blob --stdin) &&
+	test -f .git/objects/$(echo $hash | sed "s#..#&/#") &&
+	size=$(git cat-file -s "$hash") &&
+	git cat-file blob "$hash" | ./odb-helper put "$hash" "$size" blob &&
+	alt_size=$(cd alt-repo && git cat-file -s "$hash") &&
+	test "$size" -eq "$alt_size"
+'
+
 test_done
-- 
2.9.0.rc2.362.g3cd93d0
