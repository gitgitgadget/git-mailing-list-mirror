Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0150A1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbeK1Dle (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:41:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42193 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbeK1Dle (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:41:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so23391462wrx.9
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIU6FeqFaIHIjEjULoZ0nrz1+nLmgIT4BQMf/FUq0Uo=;
        b=IaeUi6N+990JxKl+8T3//Gh/XYOsI2AOqVTQFPYPxnSro9dnydL5btZqzEyDMrrkO6
         sQ+d6BoB3UyKF8cM1QbDQIDrigPFwTy9onLm14Bzsys60X62wx7U8UUvq+DuAalIYoJt
         o1YGXf7d/9rJW8jrbr+Js3u/h65BRwW8Xr516qZIqUr0NaTluzy2wH4aCJtbEdasUYLY
         iKK3l/ZGHvXJ/f8Wonma4XiVXwHC+kAp6xCc2U+evxutSYaFE/r7vBtkvZvn9tLKfj85
         DY5SujLPXm0QC3FbFVjqMRoDOKiCWrQQatzxUmNeDn1kn/cZEgI8kpab6ypqBz9WNQhl
         tBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIU6FeqFaIHIjEjULoZ0nrz1+nLmgIT4BQMf/FUq0Uo=;
        b=Sgnu2euJp2WTytCtAgwW7V6LjUiukgcVKUykpTA8xdJfl7MDliAvy6qT+tE6L++60U
         RWjr04+NfRHLftv5BkTrOYTs7FSx13/sX27dlzO8NkMpE14t5FQmQ2ptznxJ+U0K0gUx
         65hD+PeyLRVcTg2b6V8qqL6D6HmjXaTJRFweROikWwfMPGQ0F45ryHoJmHLZQPQb+14i
         m53A6qkuuiYvwd2N1mSLL4a4YgYfhZodI/vPMpukX+/fW83ewiBzBacJI/0crpiVTzUs
         VxghuT972OTqTK30wf5wkQngKkz/3+vE1O9iAUscgJIH6adKO0kSj0tj2g5OSA8iD9tR
         ABHA==
X-Gm-Message-State: AA+aEWZIfJSYuU2rqbkx/ReRTmRsw0N2I3xn5TvcFQxOhshDrNva+04a
        +o8ZUV71hBkqZaD0LqaDR1VhPPzH
X-Google-Smtp-Source: AFSGD/W/DWiEeoynTKZXe6b3zOLDML8+aOzlF9uQEtE/4unn2wAdkE8gVbIq4mNZbpM9Gl8xaZCD0Q==
X-Received: by 2002:adf:9123:: with SMTP id j32mr17115835wrj.122.1543336984035;
        Tue, 27 Nov 2018 08:43:04 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h16sm3325426wrs.60.2018.11.27.08.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:43:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Haaris Mehmood <hsed@unimetic.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: avoid syntax triggering old dash bug
Date:   Tue, 27 Nov 2018 17:42:53 +0100
Message-Id: <20181127164253.9832-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid a bug in dash that's been fixed ever since its
ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
released with dash v0.5.7 in July 2011.

This fixes 1/2 tests failing on Debian Lenny & Squeeze. The other
failure is due to 1b42f45255 ("git-svn: apply "svn.pathnameencoding"
before URL encoding", 2016-02-09).

This particular test has been failing since 5f9674243d ("config: add
--expiry-date", 2017-11-18).

1. https://git.kernel.org/pub/scm/utils/dash/dash.git/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1300-config.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9652b241c7..7690b518b8 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -892,8 +892,9 @@ test_expect_success 'get --expiry-date' '
 	1510348087
 	0
 	EOF
+	date_valid1=$(git config --expiry-date date.valid1) &&
 	{
-		echo "$rel_out $(git config --expiry-date date.valid1)"
+		echo "$rel_out $date_valid1"
 		git config --expiry-date date.valid2 &&
 		git config --expiry-date date.valid3 &&
 		git config --expiry-date date.valid4 &&
-- 
2.20.0.rc1.379.g1dd7ef354c

