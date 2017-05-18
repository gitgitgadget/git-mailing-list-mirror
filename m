Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6742027B
	for <e@80x24.org>; Thu, 18 May 2017 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbdERIWO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 04:22:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34769 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754107AbdERIWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 04:22:08 -0400
Received: by mail-qk0-f194.google.com with SMTP id u75so5038310qka.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vjmYCtNc4p+mHkdnu696HJ/ecDTt9Oqr2403/e2ARno=;
        b=vPA33641Gsf4OJDsi6xfrspX02VbHK0feC0LVP3ZlLTfjQbgN7H3ebgE9y8dTrx+Xu
         oeKVBST9p3T4hVPHQhFFuK+sPa0mjzOCOKoWcAtOyb63iBFDbR/9JrBXBx6rGuouB9jJ
         KH22f4rewh41U+Ou5NNwka5DAFuQN/TxvB8MTtXGUltNaq7AD3Cq70KhO/DVBgRK84VA
         gdrdqNdinq7xwegsaO5WVwXI4cajxLMXSsxkGERkmheJSQws8kaKyYxu+h4aiB2hoAK2
         Si3ZGwZ35qkSmIFjqGkETRUdenX7gY/PaKPB1TEcxv1Z7h8uP82aoOAtGljOeiJ1CJ82
         lnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vjmYCtNc4p+mHkdnu696HJ/ecDTt9Oqr2403/e2ARno=;
        b=QF0h/CTSd/nNvEm/sPSEtK6KUluwsV7pcxOmeswVu+oItLvMRwaQBfEAER6ipo5V6f
         BGk6/gp0jDEfdKZm1XjXAJHHjiYLv0ibBtuJRus6pD9PRy9uaD4f/P0tHukjbS5I2Ivr
         I7Rw4DKdyjrdnHOkrT69QdJPbYcUtL6O5akP4lfgn9zPiZ8mjrFMhy7k639gZXEv5odO
         1VrG/irBkdrH71gfVHLrd+MnS/IcP94i/orG+8getOQlgWvs0UBVny1r+Az+41OnJTZa
         VnpRpfcATBG1fhDVgV6KEPYmiN1HzEabemqLZk9c++68XmHjMTsmHJ3/IgUUk+mtNM7a
         UrUw==
X-Gm-Message-State: AODbwcBLHua2NcJmtAxKHBw5DJrm7RMDFR5HmGM/ETtJoDTvYWLmh/ln
        g0bn+4OkJy7USw==
X-Received: by 10.55.157.198 with SMTP id g189mr2373908qke.111.1495095727988;
        Thu, 18 May 2017 01:22:07 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id k36sm2999604qte.65.2017.05.18.01.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 01:22:07 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 1/6] t7300: clean -d should skip dirs with ignored files
Date:   Thu, 18 May 2017 04:21:49 -0400
Message-Id: <20170518082154.28643-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If git sees a directory which contains only untracked and ignored
files, clean -d should not remove that directory. It was recently
discovered that this is *not* true of git clean -d, and it's possible
that this has never worked correctly; this test and its accompanying
patch series aims to fix that.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7300-clean.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index b89fd2a6a..3a2d709c2 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,4 +653,20 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
+test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+	echo /foo/bar >.gitignore &&
+	echo ignoreme >>.gitignore &&
+	rm -rf foo &&
+	mkdir -p foo/a/aa/aaa foo/b/bb/bbb &&
+	touch foo/bar foo/baz foo/a/aa/ignoreme foo/b/ignoreme foo/b/bb/1 foo/b/bb/2 &&
+	git clean -df &&
+	test_path_is_dir foo &&
+	test_path_is_file foo/bar &&
+	test_path_is_missing foo/baz &&
+	test_path_is_file foo/a/aa/ignoreme &&
+	test_path_is_missing foo/a/aa/aaa &&
+	test_path_is_file foo/b/ignoreme &&
+	test_path_is_missing foo/b/bb
+'
+
 test_done
-- 
2.13.0

