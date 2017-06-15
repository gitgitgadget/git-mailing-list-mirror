Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A29E20D1D
	for <e@80x24.org>; Thu, 15 Jun 2017 23:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbdFOXQQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:16:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35849 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbdFOXQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:16:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id d17so2100644wme.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ez3KxsQwvoadBDy0QPyhr37r++5hdUGWu7TGsyOSsAs=;
        b=MA03+V0SFRh0hXaREH8y5FnEYDpj1Aho2RR34Kh9hxyrR8uIvb2u7D1CYadLo7IdaX
         N3twd5K/5rNR9Q8/L9HyEm15CT1akvdjVOaK5J1hBMD+yxfTP3hM1MdaaIViz4SiEgWz
         mv+O5pDt0U3qpCthvw/I0Tdod8Ifuw9WON/iPEOSDNzkGqaI466dTLAFIzXeQdS1K4HS
         MUZgRm1ZNlyHX7oDlMFYeVRl65H34TRS5Uu7idMQ6wFgLKt4zVBMuMZcB4pRZtYZZNUF
         P3cZeykwfcXnZ8xE6JpxP6BwbA3jOg1FSriKr5lwmnlZ9a/BleLQAIbteEwSRQF5LRCY
         E3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ez3KxsQwvoadBDy0QPyhr37r++5hdUGWu7TGsyOSsAs=;
        b=qMShelwCkud0ZmEXjQ4/6YL1vS1eWkMo2pUOYNmJpyBVhjs42Px3syEWBBLYsrnEla
         6qhNg80l2C/gVyvdWaDqlO0T/n2SfVw6duqnWUikJ3YGZRF29Vu1hrHj6TXXIyqt6mrN
         +oAJ+Hh5aiMCxHPj3AkOi1TgnDf6O0HEyIxglbAhpKyvdMBEXYG2+w/XPv5RQ7hTAgGL
         lwsCTH5m0JfHcbU2kt3+fwRb7pCKTDf4cwHO5d0C5gN4xQsW4QgXEn/ZPl6YbLMns+Jn
         g+7FDZBhfszTMvtChwG16Tcy94yjAS2ber6LeIvhs74XsQrsroQV+JZd3vUDvRGWkzO+
         1b2g==
X-Gm-Message-State: AKS2vOwG7cv07JHhfSCF0hIz/eKMGoZa1G6x46UPNvmM1TCFXJpZs2vW
        W9+hZjc6Y9tzZsDHI8I=
X-Received: by 10.80.167.163 with SMTP id i32mr5397716edc.101.1497568572056;
        Thu, 15 Jun 2017 16:16:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o15sm305130edo.68.2017.06.15.16.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 16:16:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/6] coccinelle: make use of the "expression" FREE_AND_NULL() rule
Date:   Thu, 15 Jun 2017 23:15:48 +0000
Message-Id: <20170615231549.20085-6-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170615231549.20085-1-avarab@gmail.com>
References: <20170615231549.20085-1-avarab@gmail.com>
In-Reply-To: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
References: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up to the existing "expression" rule added in an earlier
change. This manually excludes a few occurrences, mostly things that
resulted in many FREE_AND_NULL() on one line, that'll be manually
fixed in a subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blame.c    | 3 +--
 ll-merge.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/blame.c b/blame.c
index 843c845cba..1183943960 100644
--- a/blame.c
+++ b/blame.c
@@ -314,8 +314,7 @@ static void fill_origin_blob(struct diff_options *opt,
 static void drop_origin_blob(struct blame_origin *o)
 {
 	if (o->file.ptr) {
-		free(o->file.ptr);
-		o->file.ptr = NULL;
+		FREE_AND_NULL(o->file.ptr);
 	}
 }
 
diff --git a/ll-merge.c b/ll-merge.c
index ac0d4a5d78..91ff519cef 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -209,8 +209,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	result->size = st.st_size;
 	result->ptr = xmallocz(result->size);
 	if (read_in_full(fd, result->ptr, result->size) != result->size) {
-		free(result->ptr);
-		result->ptr = NULL;
+		FREE_AND_NULL(result->ptr);
 		result->size = 0;
 	}
  close_bad:
-- 
2.13.1.508.gb3defc5cc

