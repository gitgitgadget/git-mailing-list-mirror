Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D1C1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfJUNXr (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:23:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43469 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfJUNXr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:23:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so8746424wrr.10
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jzkmSFvimaTs3MzVizC6IFAQqdDqmV3mBcUrww32yd8=;
        b=PrBg/BopJCuT+XG7P7UclEXzBIjbTAjBC5iBh63oeU13TGmAVD1wSfbuLAZJtKKdRY
         UgMs8nx60nwIZjfEjHVH3TrjLY+PRB0BZGMVr/aPSd5CF/UDZ+33npK/ejkCfpqNxQ44
         bWP/DrGBWHwZf7HMY3bRFbUxu3KYGhouHK4SFTSP/MwhWwlSJqUeJUSgbyfj3Bdv7F7k
         iSYWlfFhIWX8FaP/0vXfz8fDHq9rpgy6sfTGlpEPaNTiBg1brMucmM9uYARwg5iZ9FHM
         yBoRZ+Zq4TTveU1vOY3rIGZKLiRmiLu7jtDRyEoIZmSek6yXcqHLmRkxN+U6oWmcGnv4
         eNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jzkmSFvimaTs3MzVizC6IFAQqdDqmV3mBcUrww32yd8=;
        b=PVk6Rj4gejBzfRPhhDGROIRn1TTDvpFzsjMQQYS1/mKyn3KU/pcFDDbQouOlfJ/Q0z
         0S+jmaOj4yYgT1pYrNQcMOeVf4grvuvK7ICfKey9gXiXHpMUhAOwITmVYd/YmwhlGSX9
         6UxanPPFh3M6d34W6VJPCTqD3XPz+7WV27T0bfloCSNNNHp5WqePdrgTtVKivUhIzxDx
         DJNcHKUiM0aj8plos8Czcg0Qc+Xu0njKPoqE3izg4DfWxCPtmYcaYUC66SUnCLWQbc2g
         B1Sk7DO0JUH91kfQ1mKdVzNV9pfjLVuADsckUxTBfFXwOMuCuPvS1WPzmovdnfRga8EM
         iuXg==
X-Gm-Message-State: APjAAAVFVP6vFWCJPuTCBN/KeXZBL3j4/bs6qi38q0+MVhL+E3meMSV5
        gblH/PwGiZrfucGM8NwkKw==
X-Google-Smtp-Source: APXvYqxWjnqQ8z7pKXf1yhY0c1wm11Fix5iYf1Sq3D8fuw2ObKfSSQox+v4LViUJo3o5vsG3uAwI8w==
X-Received: by 2002:adf:dc44:: with SMTP id m4mr21354642wrj.203.1571664224470;
        Mon, 21 Oct 2019 06:23:44 -0700 (PDT)
Received: from localhost (ip-109-41-129-59.web.vodafone.de. [109.41.129.59])
        by smtp.gmail.com with ESMTPSA id w22sm13269356wmc.16.2019.10.21.06.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 06:23:43 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t4014: make output-directory tests self-contained
Date:   Mon, 21 Oct 2019 15:23:42 +0200
Message-Id: <8451a4dac2e1dfaae130786444531ad85807fdf7.1571664168.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.13.g28bc381d7c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted by Gábor in [1], the new tests in edefc31873 ("format-patch:
create leading components of output directory", 2019-10-11) cannot be
run independently. Fix this.

[1] https://public-inbox.org/git/20191011144650.GM29845@szeder.dev/

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
Cc: Denton Liu <liu.denton@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t4014-format-patch.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 9facc3a79e..b8969998b5 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1615,17 +1615,20 @@ test_expect_success 'format-patch -o with no leading directories' '
 '
 
 test_expect_success 'format-patch -o with leading existing directories' '
-	git format-patch -o patches/side master..side &&
+	rm -rf existing-dir &&
+	mkdir existing-dir &&
+	git format-patch -o existing-dir/patches master..side &&
 	count=$(git rev-list --count master..side) &&
-	ls patches/side >list &&
+	ls existing-dir/patches >list &&
 	test_line_count = $count list
 '
 
 test_expect_success 'format-patch -o with leading non-existing directories' '
-	rm -fr patches &&
-	git format-patch -o patches/side master..side &&
+	rm -rf non-existing-dir &&
+	git format-patch -o non-existing-dir/patches master..side &&
 	count=$(git rev-list --count master..side) &&
-	ls patches/side >list &&
+	test_path_is_dir non-existing-dir &&
+	ls non-existing-dir/patches >list &&
 	test_line_count = $count list
 '
 
-- 
2.23.0.13.g28bc381d7c

