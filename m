Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD592C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352383AbiCaBsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352350AbiCaBsA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:48:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274E48887
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i4so12781980wrb.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=osxVDintRc7xnV+Ioo6P0DodHIT6c0NDbazCFAJOgT0=;
        b=Lx6AJ2YX7rJLvpFa6/fd6EI7SoeYL8SA3jxsg13hLC3mGBaMwTebRJNucbs0Qp8tIZ
         Xa8TZa5ZvVn18fru9LxuIr/UrcLRmJ1X5OU/tEAA0iCXFs5/845q7ETnJg0jwz4rJm5/
         EI54aeHjDcheuBwF5b4X5lbNytET/hiKsuPK1miJWhLqUuc+hsbzMszwxLY6Nhk/aeWz
         6Ibs1X4FIvgzOIME6p522PWWRryjckDdHGC2g5QkIrmWA2KGAM+T/dMX1jH3hJ6cnYgV
         NQax983Pp7I8wqcWOKuu/x6PaY15UZ4W935iz0knIjNStMv1gjQYzwj8kVsTeT9h7nWT
         KNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osxVDintRc7xnV+Ioo6P0DodHIT6c0NDbazCFAJOgT0=;
        b=mCYxELZ7GtBPF/8mD/dijyMNxETrQwGLJNZHB630riBLyBO/iT5gw57aIK1/tK2zDu
         cRwxjHmCczEQjY+GMiwORatdra3cOQnsDirbIjcu34yODQC79KH99WXGhnS9Vu2fiSCh
         q40w3LBB/qvST28Hrfant1XxLWNwplBkB7R3GL2Qki58u5pwf2/KBBgDjQKUFG3RcDLc
         fOBvH2xCz1I/vcvQUv0IwerYz7BBWkpnHG31VFkkW4L+1VhuYX2y6BwrZM9A3EbzheiZ
         UUmY6HskdTxdM4Jvmx1qCK/I+XMAjeWQ7UHUHYfuILaG64NV8l6THP8KWlalt4HPg0En
         FzjA==
X-Gm-Message-State: AOAM530Om8gY2RSIqnhti7L0NwtT3NBlFaQNnOhbNnCi1nT3lvpyYWfq
        EWynDdpFZ5ApZDSp2ZsVcojNGul/yifW3A==
X-Google-Smtp-Source: ABdhPJwOQ28QsqOny1Hq9+T14lxQ4/KXxhbA6ld9mF1jhL7UfsNGGCAkyHtev9GUDabpJKcRrg49HA==
X-Received: by 2002:adf:d1e7:0:b0:205:8909:a67f with SMTP id g7-20020adfd1e7000000b002058909a67fmr2054930wrd.66.1648691172807;
        Wed, 30 Mar 2022 18:46:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm23603272wri.77.2022.03.30.18.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:46:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/6] xdiff/xmacros.h: remove unused XDL_PTRFREE
Date:   Thu, 31 Mar 2022 03:45:52 +0200
Message-Id: <patch-v4-3.6-cf54976bbc4-20220331T014349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1561.ge8eddc63765
In-Reply-To: <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This macro was added in 3443546f6ef (Use a *real* built-in diff
generator, 2006-03-24), but none of the xdiff code uses it, it uses
xdl_free() directly.

If we need its functionality again we'll use the FREE_AND_NULL() macro
added in 481df65f4f7 (git-compat-util: add a FREE_AND_NULL() wrapper
around free(ptr); ptr = NULL, 2017-06-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xmacros.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 2809a28ca96..ae4636c2477 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -34,7 +34,6 @@
 #define XDL_ADDBITS(v,b)	((v) + ((v) >> (b)))
 #define XDL_MASKBITS(b)		((1UL << (b)) - 1)
 #define XDL_HASHLONG(v,b)	(XDL_ADDBITS((unsigned long)(v), b) & XDL_MASKBITS(b))
-#define XDL_PTRFREE(p) do { if (p) { xdl_free(p); (p) = NULL; } } while (0)
 #define XDL_LE32_PUT(p, v) \
 do { \
 	unsigned char *__p = (unsigned char *) (p); \
-- 
2.35.1.1561.ge8eddc63765

