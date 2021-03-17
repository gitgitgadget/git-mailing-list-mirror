Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85448C4332E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521C264F3B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhCQU5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbhCQU4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61DAC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso4177980wmq.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EI1qeieT0Oya7mCR0qUYhK4k11tziJf8vZArZeayGrE=;
        b=koqRQBOf5BR5c/AffwRt49/7dq3FlOTtV9PdKyarOmLW5H2YXPfGOvPxwLpM0Bv5YT
         rhoECqHIWuxDG0IlUWach727U69HeilLhKP0hiPGDxV3VWNe3rJS7wn0bYhIJj++fX+t
         FZWMDMpMo3I8e6MDKenQthrI/VJ8Y6Rkumua5pQdMr52tt205Wa9gkVj6BnhsBQ8mgkp
         FDyWvwETfbZD5OFSWpk3CKTjf4/mngkS6WxtEa1J1lQ7Yb9XZ3dhQFvDmJmtY82cbiXQ
         IcHk1CX1p7gRqg1d6ZVt/6Fre57o/5CG0bcLF0oVayLrFWE6BXGwyTWXF0cTgeKfncOi
         9Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EI1qeieT0Oya7mCR0qUYhK4k11tziJf8vZArZeayGrE=;
        b=SkvaGxEyK/W1l/qurr9hrfeNBlLc/nPlpSyFgUGZlsq4zRy+udpaR0/BYURdmAH5AH
         TyLU3KhIp+1aP0lc5amOJFVHfE9C/sDjO2CYYfItrxc1xQpfZL1tUVfqzqnpIJ0+8FQ1
         wIh9EF6eBrdn7TCu68GBdUlsGqY9iWj+w6VZni+jKUb536N+KgdxR/xAvSKMLCIjaHb9
         1R1VUwxdkPTJqzuDPLxxNtdocA2W3J/yv+vBRer4eYiOgLphb1exz8W5IGS4HIEtth+0
         9FBeOBJ3LZDIR0HHTojQfgxcco/Gn9VNkiYHhXwJn/y55HQWmneDzY1peqNGS9V3fRig
         xkZQ==
X-Gm-Message-State: AOAM532cx9nGe2V+k96zE+pqgvzKhMP50jtsX3NuMQoGfC8pn3puuVqG
        fBARQYGQOhCsQ6OomtD1MB4OogXFOao=
X-Google-Smtp-Source: ABdhPJxJpoIki0UQgaPGvN2y6+izOT0gh/ouwhZklRZKN3oNuF1NOU+nFIvMmRclBbRR1sOylsxHMg==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr553025wmq.149.1616014598672;
        Wed, 17 Mar 2021 13:56:38 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:38 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 03/15] t6060: add tests for removed files
Date:   Wed, 17 Mar 2021 21:49:27 +0100
Message-Id: <20210317204939.17890-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Until now, t6060 did not not check git-mere-one-file's behaviour when a
file is deleted in a branch.  To avoid regressions on this during the
conversion, this adds a new file, `file3', in the commit tagged as`base', and
deletes it in the commit tagged as `two'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6060-merge-index.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 9e15ceb957..0cbd8a1f7f 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -8,12 +8,14 @@ test_expect_success 'setup diverging branches' '
 		echo $i
 	done >file &&
 	cp file file2 &&
-	git add file file2 &&
+	cp file file3 &&
+	git add file file2 file3 &&
 	git commit -m base &&
 	git tag base &&
 	sed s/2/two/ <file >tmp &&
 	mv tmp file &&
 	cp file file2 &&
+	git rm file3 &&
 	git commit -a -m two &&
 	git tag two &&
 	git checkout -b other HEAD^ &&
@@ -41,6 +43,7 @@ test_expect_success 'read-tree does not resolve content merge' '
 	cat >expect <<-\EOF &&
 	file
 	file2
+	file3
 	EOF
 	git read-tree -i -m base ten two &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
-- 
2.31.0

