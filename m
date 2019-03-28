Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1EC620248
	for <e@80x24.org>; Thu, 28 Mar 2019 20:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfC1UFH (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 16:05:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52278 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfC1UFH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 16:05:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so141896wma.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 13:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZoZ8YJXqbi0UX894W+FSeXf3vHD5w2VbOWvPwij7ZK8=;
        b=kh5av2gaZGhjC/spI09Thq0cQL/0fYtaJbNX0XSmr0h6eaBAjdNPWtC7t/tePocXba
         EMzeBl+DNrazFuUAoEeZ+ksMED00Y2F063xx/C5Ak9vS077uZW93CIaECLh0n9bZbym4
         M4KRRReI3KdMI8+EVg0O26ES/OhOFZUyhj35sBOIcnuOBNV9LLQX2jajiD7mSk0VyaLW
         gtbtrTzB9b+iTilpeUOxPNhac5tfGdIpSuN1e32XUuUg0ZSvmfeYp31aSiCB0OOOe67M
         0o1jJnhkMAglN9Pa3aDmIdfdmmkHYKdW5DP8wO0Bq8ATfmPHv3mla+lypqxgvtca5vrN
         QnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZoZ8YJXqbi0UX894W+FSeXf3vHD5w2VbOWvPwij7ZK8=;
        b=h6Uyqwfgkp8gSsA2+M6H5hMVPg0OH70LJzJs2JLPeDX3pFheZzv4JB1DqG3m0X39nG
         Axt6p6bgFclJN7PlxyvZGdssrkRcbSsEs1eIlqeMEVpqrkZ2qKibShG7Jqok/rVT1IeE
         OkDoROm3D/aMJtLQUpdmsjilioSdwCElc7PyKj87kLb2vJgcIQS80S/0Xc8tnJ2APOZI
         1KPM476sXjEogowPjrC0THtoWxesoFnU+u458cBqiMNgCmOcAUhh5l4nh/YPbrbWot1x
         WYidm+jRh6pk0l1gZGVDUj0ZWHf6bgegiNp5MesWdOO1xbmRqm6SguaKlkDm+nYvoJUF
         G2Jg==
X-Gm-Message-State: APjAAAV27X4eYn/T7nQ4ASMZQhpxE/+KLIvHqtTGssDTYZxAaL8cQ334
        PBnAdBMb9+PVVic/45hh7WaPZvX/bEw=
X-Google-Smtp-Source: APXvYqyXDIAo0VSKOURM2zV/hMmNQ3jOOVdsii6vYjQ7rQsXTMYeNlg2dd0UnF3HCFOzqhbJBJIDMQ==
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr1147337wme.46.1553803505166;
        Thu, 28 Mar 2019 13:05:05 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g84sm68842wmf.25.2019.03.28.13.05.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 13:05:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
Date:   Thu, 28 Mar 2019 21:04:56 +0100
Message-Id: <20190328200456.29240-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20181204132716.19208-2-avarab@gmail.com>
References: <20181204132716.19208-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the error() case in alt_odb_usable() where an alternate
directory doesn't exist. This behavior has been the same since
26125f6b9b ("detect broken alternates.", 2006-02-22), but if that
error() was turned into die() the entire test suite would still pass.

Perhaps we should die() in that case, but let's start by adding a test
here to assert the long-standing existing behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Unchanged from a 3-part series I submitted in December:
https://public-inbox.org/git/20181204132716.19208-1-avarab@gmail.com/

Part of trying to re-submit the uncontentious parts of whatever I've
submitted in the past that I have stalled for whatever reason...

 t/t5613-info-alternate.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 895f46bb91..d2964c57b7 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -136,4 +136,11 @@ test_expect_success CASE_INSENSITIVE_FS 'dup finding can be case-insensitive' '
 	test_cmp expect actual.alternates
 '
 
+test_expect_success 'print "error" on non-existing alternate' '
+	git init --bare I &&
+	echo DOES_NOT_EXIST >I/objects/info/alternates &&
+	git -C I fsck 2>stderr &&
+	test_i18ngrep "does not exist; check" stderr
+'
+
 test_done
-- 
2.21.0.392.gf8f6787159e

