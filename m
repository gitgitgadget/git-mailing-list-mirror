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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0521F462
	for <e@80x24.org>; Sat, 15 Jun 2019 10:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFOKHe (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 06:07:34 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41441 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfFOKHd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 06:07:33 -0400
Received: by mail-wr1-f46.google.com with SMTP id c2so4958718wrm.8
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyVFC55PUGYeCqaeYnd9U0cJnl2EDBbPcu8akeBYGPM=;
        b=bnreQY/qAwhW+h/KnZSu4Chuqhyb5M2jv7EIk4KcisoqWxzma0KxOKSm/qWKshhCKY
         o3kEOlpoE0meOy3gPpYepYoDAh3OIY93fROmFGEmEdCg+PgbG1eZGtbMBAQ/eEWP7eRB
         o84H0PRxBb5E6ByfOvE89lNMkwteb4qjyzq6uV2+3YEJJo48or1B9qi/NLJU8XdRAstP
         FUdrGDCFCpY0DVYthActDhGWQ9lmxa8qwdopFbQsdQhPeZpqyncca0TQvlU1EVBMglXe
         +/C4s6bcgHTnvYLSzKJCUyJ0lTLUVK3Qds7CIO76r/DvHmwp3vbSYtDYq74D7YI4DU0k
         883A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyVFC55PUGYeCqaeYnd9U0cJnl2EDBbPcu8akeBYGPM=;
        b=kOCgct880IYD+jRj9Topre5df6u1rdl9FbqinkywI/Z0zZqyrUw+0XkjBtvnGSD22W
         lgaSXonF6n3QaSmwQe/SMmlKwfiu6uAZuc8YeRWsCN/YfJYPK/SrNEiXIOPoGNI6GLGz
         7SGAOB9VY6/h35FdWGEqxcNBiIehXkCfwj+HS3BYhPyXCLaBFk4ZkWFHiQ+W92BLfivd
         scnDvfwWssvVuKHqh5xvlvZ2mVtPXrphkLZcYvMeqNRytw1gXMK5TCR6Ai4Bbm1FC29G
         daqSKg9GXwaCbsniujqNMGbiFndwzFZguf5dk6fAfgjyeM8s5AOMhs2J3i8wz4qVVvfd
         uAlQ==
X-Gm-Message-State: APjAAAWKEh7KqQIVcXMduzWY1A2fOPH46I+A64oK7SR45jeaE0AB571z
        sgfbHUJOgZ64Ehu7oXfGkVqL+X5pWD0=
X-Google-Smtp-Source: APXvYqyTExfIAazBXZ8ZKqk+dYKuKW8O8glU9fgcVDRqElx8N92XhphR7OUGvAcfhDL2yGSFzNqe4Q==
X-Received: by 2002:adf:fa4c:: with SMTP id y12mr53450141wrr.282.1560593251093;
        Sat, 15 Jun 2019 03:07:31 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1017:d205:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id x11sm8091576wmg.23.2019.06.15.03.07.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:07:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 2/4] t: add t0016-oidmap.sh
Date:   Sat, 15 Jun 2019 12:07:00 +0200
Message-Id: <20190615100702.20762-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.3.g82edbe9b01.dirty
In-Reply-To: <20190615100702.20762-1-chriscool@tuxfamily.org>
References: <20190615100702.20762-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Add actual tests for operations using `struct oidmap` from oidmap.{c,h}.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0016-oidmap.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 t/t0016-oidmap.sh

diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
new file mode 100755
index 0000000000..af17264ce3
--- /dev/null
+++ b/t/t0016-oidmap.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='test oidmap'
+. ./test-lib.sh
+
+# This purposefully is very similar to t0011-hashmap.sh
+
+test_oidmap () {
+	echo "$1" | test-tool oidmap $3 >actual &&
+	echo "$2" >expect &&
+	test_cmp expect actual
+}
+
+
+test_expect_success 'setup' '
+
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four
+
+'
+
+test_expect_success 'put' '
+
+test_oidmap "put one 1
+put two 2
+put invalidOid 4
+put three 3" "NULL
+NULL
+Unknown oid: invalidOid
+NULL"
+
+'
+
+test_expect_success 'replace' '
+
+test_oidmap "put one 1
+put two 2
+put three 3
+put invalidOid 4
+put two deux
+put one un" "NULL
+NULL
+NULL
+Unknown oid: invalidOid
+2
+1"
+
+'
+
+test_expect_success 'get' '
+
+test_oidmap "put one 1
+put two 2
+put three 3
+get two
+get four
+get invalidOid
+get one" "NULL
+NULL
+NULL
+2
+NULL
+Unknown oid: invalidOid
+1"
+
+'
+
+test_expect_success 'iterate' '
+
+test_oidmap "put one 1
+put two 2
+put three 3
+iterate" "NULL
+NULL
+NULL
+$(git rev-parse two) 2
+$(git rev-parse one) 1
+$(git rev-parse three) 3"
+
+'
+
+test_done
-- 
2.22.0.3.g82edbe9b01.dirty

