Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9351F667
	for <e@80x24.org>; Tue, 15 Aug 2017 11:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdHOLth (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 07:49:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38385 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdHOLtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 07:49:35 -0400
Received: by mail-lf0-f65.google.com with SMTP id y15so457171lfd.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LUc59hODwzgARKEp6B6vWJMCO0FwUZK0B1rVw567sIk=;
        b=oQ3eO615Z8Nw3LkMWuRamHvxqwLLVft/JdOGyc++Al0C3KyulNpsR2vvv0Haabm+eq
         jDg2WYtm7zRHSwLoFhJWXEnG1PclJo2XAFFJooZGZpQsBqQ2LhEnMBV+gm77xoLyaekU
         4qy6wT/APPCnsciwVXfmS4uewkfYbROniR5tbsRprLrqSFFYUKty1shK099S3v5Runtl
         WZ1WOIorVwQBXR69gKGfQrGjN/sjXEPQdtysGdhQQJ+V7sN1YDGmgGznQzgrCoLpjG4g
         4czTrEn2HNdppqSKZcUNxlpNPL+/rCUw0T3TKNU2GU2D9WQPu4kM2tRnDNDHwK/23pIe
         oAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=LUc59hODwzgARKEp6B6vWJMCO0FwUZK0B1rVw567sIk=;
        b=m0AtAYdzRf8FbLspKQV7Ma3z8YKOkKntUPvg6MoEPnTc8WfpUJyVih+nnvodyZLTm8
         nU6IE2dJVi8DRbqGc2Eo6hH3v7GpZQxS9sLoUwcdwshW5WAYqxmZbgetL0H9lWeIWghe
         ekwxCYtgKzBsbhfcHlnR/GL7E/68LL9y1hco7wRfEvWI+RJKgA/cC5M6HQHzgNdoikGU
         gvhm4HMcnqRVsbUQf/3NCyJrpTTqiHlfpN6azCGElQcXaEea81bcbELhFge3Gf6LFKDD
         EaceuHPlj1Az09owXDoD56zz8vicFsdDewuC94tE3NOXh+8DB5Na0mn+Tfq4P+8sDl+n
         VpSw==
X-Gm-Message-State: AHYfb5hAvqU+BM11FFEpvVH6+7XrfnKOqAd3uKQ8sEsWOtzAAhZXExT9
        iZqR/Wc1wt8aZH/jGLc=
X-Received: by 10.46.33.77 with SMTP id h74mr9031924ljh.79.1502797773374;
        Tue, 15 Aug 2017 04:49:33 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-225-26.play-internet.pl. [94.254.225.26])
        by smtp.gmail.com with ESMTPSA id z25sm1575317lja.1.2017.08.15.04.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 04:49:32 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 2/5] sha1_file: fix hardcoded size in null_sha1
Date:   Tue, 15 Aug 2017 13:49:03 +0200
Message-Id: <a21088f049390828cdee957f88503e8466e1d34e.1502796628.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This prevents compilation error if GIT_MAX_RAWSZ is different than 20.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index b60ae15..f5b5bec 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -32,7 +32,7 @@
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
-const unsigned char null_sha1[20];
+const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
 const struct object_id empty_tree_oid = {
 	EMPTY_TREE_SHA1_BIN_LITERAL
-- 
2.9.5

