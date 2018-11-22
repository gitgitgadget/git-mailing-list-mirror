Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93971F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 21:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438929AbeKWHyM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 02:54:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55298 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438808AbeKWHyM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 02:54:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so10092601wmc.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 13:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XE/NOuroZ5a3RmuiOaUeK7iX8UUTyJ0nzuco8TdfAuk=;
        b=P82sPaCamzaIxM0UBXipIKJMrSItZTkIJkhq5nchTvfB0E8yyDHIYacpU5S9szg5XN
         J05bzaV8Caz74Jp0XrYA6NUNuSgUbfulwjzn4crue6CXyxxE1BVOZvdOTCZjVheZe970
         EE1DOTKQDupYUwme3D8kpXcE4DYZp34OxX4xF7/oM65hCDG2r+HRx3pEmktNOphS/tch
         E5gipf1I/W1Ol1u4Vjg+4Nh5EWJmyMiOdet/lpW4eHcecq0EkNGk23ztKmOowi3OvUPE
         9no4ckLQVQ5/Ruzm/Ga/Zx3q8uoogJy0tMI6eoZFXdoMmneQnoTXbBMSXi5LVmsesoWX
         dkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XE/NOuroZ5a3RmuiOaUeK7iX8UUTyJ0nzuco8TdfAuk=;
        b=kNow9jJ+FVawup1YL9YQ3wemFlikVsmi6vovbqPD9nz/QckqUNOqcRknohciu8fRhL
         DJ2to12rv/d0bFlzexINZdlHIFRXYysJhTCA7L9XVaaCg4TC1zj1+wvkP/zj+PhnHeQ6
         cl/m7WXNodhVWNTmhwIxIOXC5Zpii3p7hQwedhGUt2MbBtC2+Sevpnrd1uJKzh0seQ1S
         LRr8k3fRnNwkJJVOmFu8pjnZoshkk2kFL3o0zHXEKSSplwJnnw3lOik9b9VMNC9xzLKj
         dH4GoARrv3tO6kaigAuB8dFbecfvnpDnnpodpQc8JIbBmDXQYtwc5Wd84sZkYHBWqONw
         cpqw==
X-Gm-Message-State: AA+aEWaCQh0kEreyIxPrF8svnVk0fgz6PmQvVAx0gdv7uxtPxbMnmG/6
        DRLrDWyoZrYSMfdxKZo0IK9+sgr7nYI=
X-Google-Smtp-Source: AFSGD/UfZH8tb5Ut9MDut1JXe+0ZtIQEqgRj2MX223mdf4uCB9cB9tCXzcSSPWwUWMZ7ZbOC27XeVA==
X-Received: by 2002:a1c:9d10:: with SMTP id g16mr10743236wme.43.1542921181026;
        Thu, 22 Nov 2018 13:13:01 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 5sm8775229wmw.8.2018.11.22.13.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:13:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] format-patch: add a more exhaustive --range-diff test
Date:   Thu, 22 Nov 2018 21:12:47 +0000
Message-Id: <20181122211248.24546-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
References: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the narrow test added in 31e2617a5f ("format-patch: add
--range-diff option to embed diff in cover letter", 2018-07-22) to
test the full output. This test would have spotted a regression in the
output if it wasn't beating around the bush and tested the full
output, let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3206-range-diff.sh | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e497c1358f..0235c038be 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -249,11 +249,28 @@ for prev in topic master..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
 		git format-patch --stdout --cover-letter --range-diff=$prev \
-			master..unmodified >actual &&
-		grep "= 1: .* s/5/A" actual &&
-		grep "= 2: .* s/4/A" actual &&
-		grep "= 3: .* s/11/B" actual &&
-		grep "= 4: .* s/12/B" actual
+			master..unmodified >actual.raw &&
+		sed -e "s|^:||" -e "s|:$||" >expect <<-\EOF &&
+		:1:  4de457d = 1:  35b9b25 s/5/A/
+		:     a => b | 0
+		:     1 file changed, 0 insertions(+), 0 deletions(-)
+		:    :
+		:2:  fccce22 = 2:  de345ab s/4/A/
+		:     a => b | 0
+		:     1 file changed, 0 insertions(+), 0 deletions(-)
+		:    :
+		:3:  147e64e = 3:  9af6654 s/11/B/
+		:     a => b | 0
+		:     1 file changed, 0 insertions(+), 0 deletions(-)
+		:    :
+		:4:  a63e992 = 4:  2901f77 s/12/B/
+		:     a => b | 0
+		:     1 file changed, 0 insertions(+), 0 deletions(-)
+		:    :
+		:-- :
+		EOF
+		sed -ne "/^1:/,/^--/p" <actual.raw >actual &&
+		test_cmp expect actual
 	'
 done
 
-- 
2.20.0.rc0.387.gc7a69e6b6c

