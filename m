Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995BDC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbiCGMos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiCGMop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1C34B8D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q14so7506809wrc.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZ3Ubdx0zSuxRjyTPyuMkoglAn+2rOMwTrCh3gMoGuY=;
        b=LLm6IoyKYkkA0HmsOLE2FlgIZAqGP4YR+zxIeRz3AJjnv49f71THbA2RFVvN3xLasp
         bzdCs3h8ltHcaLnR+La77sTiSGzUPDrm1Y6wLjIFnKkT3o+7TP2JH0H99DHRSZbr1BHJ
         VGUIiN5SlKVKZjOCJ1R7SoWiRvvtBO+5ZJ6Zfke53MTU4ioR//XBbFgQ2s/7r92epQZx
         fs++wxqMPqRKxCkNBdruOjkRdRx4zzSEaoYp6oXGi+YxMPyE9y/BleVDu4nC0FaztmFL
         yCF5znKuEjOrj1PBL4atkYCpb28ddD3IFW5wbs905GixZUcExXb9Nem5ObOkwVFJUaZo
         H+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZ3Ubdx0zSuxRjyTPyuMkoglAn+2rOMwTrCh3gMoGuY=;
        b=4/z83Q1wbxXNypFGrSfEi8wt9tSEYN/511JpgdsH61YbCQnA2kikcByFOA1SGKojZZ
         S1ct6nr4nniK3oeVolGx4gae3ftWE12O8tCtmW7T/h4qsKGKxmRW0lvuK4brtfLQcZ/V
         Dq/NODi0dHhTnIBjFcFNwJHitbkMLmNCWlBJex/fjeNR4iFAWCuP4NRsCfcJgy41zMS3
         +dIj4HupD+9xD0pUuADpE38cwYkVgZPSgusLDKZi27nk5lQ1i8NAp7uh5hI6sjnxEwE1
         nhqP7CDOVpuWcD2YV7+iNtmAUuOzgclYhbsv2YeKyNNh7/DbqU0hstFICzKxXLUon4IF
         hfkA==
X-Gm-Message-State: AOAM531f3a+y88oFQdkqwvk5w9OaS0+a/1/RFgRz/ylEwTX6d2RZVl6a
        zWBPdutwtjIJ+AcB6DgHxrcHoPxKWWyM/g==
X-Google-Smtp-Source: ABdhPJx7aLgxyqmfoPNsD60BuwQVUeDgA+CeHFF2YGstNsQeuRBdUWJ0s2a2N/kKcV4Nqq5ezGIVzA==
X-Received: by 2002:adf:f70a:0:b0:1ee:33bf:3864 with SMTP id r10-20020adff70a000000b001ee33bf3864mr7904495wrp.4.1646657029576;
        Mon, 07 Mar 2022 04:43:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] t5540: don't rely on "hook/post-update.sample"
Date:   Mon,  7 Mar 2022 13:43:33 +0100
Message-Id: <patch-v2-02.10-4bee939a894-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in a87679339c0 (test: rename http fetch and push
test files, 2014-02-06) to stop relying on the "exec git
update-server-info" in "templates/hooks--post-update.sample", let's
instead inline the expected hook in the test itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5540-http-push-webdav.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index b0dbacf0b9b..380e97c1762 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -42,7 +42,9 @@ test_expect_success 'setup remote repository' '
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
 	git --bare update-server-info &&
-	mv hooks/post-update.sample hooks/post-update &&
+	write_script hooks/post-update <<-\EOF &&
+	exec git update-server-info
+	EOF
 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
 	cd - &&
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
-- 
2.35.1.1242.gfeba0eae32b

