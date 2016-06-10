From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/27] t5500, t5539: tests for shallow depth excluding a ref
Date: Fri, 10 Jun 2016 19:27:11 +0700
Message-ID: <20160610122714.3341-25-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:31:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLa4-0002Jp-KI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbcFJM3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:52 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33169 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932960AbcFJM3u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:29:50 -0400
Received: by mail-pa0-f68.google.com with SMTP id di3so5028605pab.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVd8lfxaxtGc1+QoRmweWx+5hE78ArCqGOQ5KF4btn8=;
        b=OLCpYCIpOWQ8zDDM4hofHlIDjnEIBGf6uS48xmQvcpGktN9aVktnpDYwlEfXkN+qcr
         7nrlpMVkrRvbaW0DMBWBI11gyRXpdsYZQOYvUKzsnzBMF/9vK28AegAO2GxIWwmWXSQf
         2Pwk5GnsPund7c8+0L0wOtLFXK/pFWbYNurua06Qrcc8NXC6oNox69hqvYL8KEfWIjEt
         4NEdq/4IlpujEfBnUV1GOkRdrNTEJaaZma7K7GRnQMxjaNguCJCqR8kHAEiEA+D0ATwx
         mRT68gsyIh4/tNHz0PwY2Td67+wSvC8xlKOesi6AjitnfdsqZi9FarU3Y92TT9RGDDLg
         etCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVd8lfxaxtGc1+QoRmweWx+5hE78ArCqGOQ5KF4btn8=;
        b=C64hcylFk2mWdsw090NPkXiLRQ0/dwsiy+xGhkriBhX3h8YOWoL2IQ9YnJNbe/AXP+
         duvcCCYojSu0dcA2lXyM+600g6ajNWeswRF9DoFPDGWBYb9PflMV82V6oZVHf1b4MquC
         dHuGKCjQjHApJo2U2+Oq6uDPJY+jVT47sUidkA85dQNbpiRKjP97zR+jGvIlw7KQ88G6
         6lJlX8trdBNtVN9zrQKsxechgvZK7Zy6s86CyD97SanRwHBb73iO3jLgbzF9V48O4G1Y
         lgkLNNJLm5W1HfY9HrPsGpeDcM8ikdr65hqo5O9nBmFhop22bRkkA3ukyYVxEtHvHyOJ
         0Fbw==
X-Gm-Message-State: ALyK8tIQV7oWQYqPGtgB5PtHThmza+hnDwhpRc0LTGNJtnBUhrNaR3+8exF+i2L6sL17TQ==
X-Received: by 10.66.253.38 with SMTP id zx6mr2062378pac.19.1465561789991;
        Fri, 10 Jun 2016 05:29:49 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id y70sm17552317pff.25.2016.06.10.05.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:45 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296991>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh         | 21 +++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 22 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 26f050d..145b370 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -661,4 +661,25 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'shallow clone exclude tag two' '
+	test_create_repo shallow-exclude &&
+	(
+	cd shallow-exclude &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git clone --shallow-exclude two "file://$(pwd)/." ../shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --shallow-exclude one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	test_write_lines three two >expected &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index 704753c..8e38c1b 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -98,5 +98,27 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'shallow clone exclude tag two' '
+	test_create_repo shallow-exclude &&
+	(
+	cd shallow-exclude &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-exclude.git" &&
+	git clone --shallow-exclude two $HTTPD_URL/smart/shallow-exclude.git =
=2E./shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --shallow-exclude one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	test_write_lines three two >expected &&
+	test_cmp expected actual
+'
+
 stop_httpd
 test_done
--=20
2.8.2.524.g6ff3d78
