Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479421F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfDXPO6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33574 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfDXPO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so11065384qkc.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hl2kohpjMFRdWldR0OVJ1OtbUQ6v2TVaz0BAtesidEQ=;
        b=jyUvPxkhZZoRtA7zyfDQIplrQEs4X38HtsjmFfJL8RJVfjRswwkFc9XEvkHvrgFozv
         XhdBKLyD78221FuXRsZXuBbNTssUMr3iFJ/9jPQNjdX6HQH7CIZpJLbkKpPVhdc69CSf
         CGRLuBKxvgvZEp7PLnXrbRIcWX28di4u+s4laJIOFBh3htQInVJ6a3yQztutpSObR286
         m41gBHRedTV1Hy/HNGK/A6cZ7HZNssQD4JHUsFtU/GY0fV5LTH96sIVC6GRle3r77l4L
         zHfDgNLxnao+subxEaYkZLxNlxWAP2YqDgg2mUS15BSQHztsjspHJflslU38tPfVJ9t9
         Q2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hl2kohpjMFRdWldR0OVJ1OtbUQ6v2TVaz0BAtesidEQ=;
        b=MjSdNncPnimEsth5pZei0lW87dJraw1UQu0FFcf01L0wpDTIOSAhhFEAPfG3u+bZ4T
         W8P7anfTvaIjmM3KdE8Gq2s2rZv9gGdTLSpjhIT7QEqMVsMFqB1bGr1TRPgJYcTLksyi
         T8bnCP8T4xTvHfkblNDH2v3XF/tVISzUp4qBA5V0yFWEmxpXvz7pANFLdzF5vPEz1tns
         rw+KDChEsdDATZkrlJFQnU3EUe14P4Nm9RLRdsPO59tetNQpD/y+uaaH+81HYG1yM410
         TWj1lHvHRxM3xzmW0XbNg4FPG7lFOOoeZmpqf5DJZQ7e38FW7Lx2Sp+8a9RJjFCXMq/9
         DkKA==
X-Gm-Message-State: APjAAAUZoOtrQ0W5c/3ViwfenD4dHaN3ViLK3VKPTtvP2U8NA5VA74jh
        K3RTlbpdOyy9NgnLbDNmbjhDc5Zk
X-Google-Smtp-Source: APXvYqx//AMUXIhgZ+/TzJujsp5/2Q84dvpm4a1DSptIHmjhPlIM3KjaI8HbPJTIQ8kQ8G2p0lZzhw==
X-Received: by 2002:ae9:e916:: with SMTP id x22mr25705303qkf.66.1556118895455;
        Wed, 24 Apr 2019 08:14:55 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:54 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 11/11] t5319-multi-pack-index.sh: test batch size zero
Date:   Wed, 24 Apr 2019 11:14:28 -0400
Message-Id: <20190424151428.170316-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'git multi-pack-index repack' command can take a batch size of
zero, which creates a new pack-file containing all objects in the
multi-pack-index. The first 'repack' command will create one new
pack-file, and an 'expire' command after that will delete the old
pack-files, as they no longer contain any referenced objects in the
multi-pack-index.

We must remove the .keep file that was added in the previous test
in order to expire that pack-file.

Also test that a 'repack' will do nothing if there is only one
pack-file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index bcfa520401..0f116b4b92 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -512,5 +512,24 @@ test_expect_success 'expire respects .keep files' '
 	)
 '
 
+test_expect_success 'repack --batch-size=0 repacks everything' '
+	(
+		cd dup &&
+		rm .git/objects/pack/*.keep &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 2 idx-list &&
+		git multi-pack-index repack --batch-size=0 &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 3 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 3 midx-list &&
+		git multi-pack-index expire &&
+		ls -al .git/objects/pack/*idx >idx-list &&
+		test_line_count = 1 idx-list &&
+		git multi-pack-index repack --batch-size=0 &&
+		ls -al .git/objects/pack/*idx >new-idx-list &&
+		test_cmp idx-list new-idx-list
+	)
+'
 
 test_done
-- 
2.21.0.1096.g1c91fdc207

