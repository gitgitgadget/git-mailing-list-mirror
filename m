Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA3A1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 05:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfA2FWH (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 00:22:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45980 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfA2FWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 00:22:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so20508112wrr.12
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 21:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGQlbBQMYE/uXM26iGk3Qy/YVOifa/0pyh+zbYClMBA=;
        b=dCG3VCisoFHYLlh3FtzDPpSUmWYT1AxPCiEHi2FtK5vn2mhLMuG45+1T3ctSKnuVYx
         NCgV5zGtt+X/izQ5Ef5jUmn0q3M7Q8B1+jRqy/JL6OKItE2AhyRPX4A5kYMsGlU07gzO
         Ro0CL1NfJeyJ+iArw4bFv7GoNQjaGfKTP/rkvo2xn7GUgulGQcCCPcAkOm5PjmTtgNmv
         iIAKbTAQPYrmarvJ/Ef1rCWotBrrb07xcUGZEL4HnRfDO/d+/H4nMqhwOUUmdTR/t7f7
         GpiWKpiERXo68+5ZA19ioYHmzXT6FaHxi0F8rJaYJ5vOJde/0+iGZVdsAU0A5zHHstAa
         dpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGQlbBQMYE/uXM26iGk3Qy/YVOifa/0pyh+zbYClMBA=;
        b=k6WORwyttJ15cbV8GdxgZYvipn9cxAp4qpuJCzClHIkOzvv2IJvTpI8aY+lPLhLxt9
         4x2b0LCQ/7qdiMbthEmj4J8z0KFuewuH6gQg7gmYlg9flk0c2vbVzd4tHrrhelvG84NI
         NBv7teVT8OV7DEiaux+8FxZhPy6yQGLM+ySwjYDKerJz4GddJTwvMRzyqc0rRC1cIl8R
         maW7hfysWeso2cavmj+o2JTn0neRqf0t7DYLfe85LmAkpEz4OYIul+ldj5XmfAhj5RBJ
         7M0eseAB0krgEkQPmd7prXd7DB1gaPLQaW4mxr9+00cG/e7aV103m8jnyvXOGa0ybmBS
         2WMw==
X-Gm-Message-State: AHQUAua/qTaCzGg6DORv/MDQiX0Srl6Tt9JW9oGegCOBt5xlN/jxi3Si
        OxfWJE+xfJ3yZk/cqwfv7OJBEl+ge7k=
X-Google-Smtp-Source: AHgI3IbHhAbGkBCmhwJW/mRtQqm3EK2yx+DiFpfwB4syPvKfs4W+js18PrBA6Khsm7Yr/SpHzxmcqw==
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr4579501wrj.107.1548739324750;
        Mon, 28 Jan 2019 21:22:04 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id g67sm2906294wmd.38.2019.01.28.21.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 21:22:04 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v3 3/3] Add test for describe with a bare repository
Date:   Tue, 29 Jan 2019 06:18:59 +0100
Message-Id: <20190129051859.12830-3-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129051859.12830-1-koraktor@gmail.com>
References: <20190129051859.12830-1-koraktor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ensures that nothing breaks the basic functionality of describe for
bare repositories. Please note that --broken and --dirty need a working
tree.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 t/t6120-describe.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index c863c4f600..f7539a2650 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -418,4 +418,9 @@ test_expect_success 'describe complains about missing object' '
 	test_must_fail git describe $ZERO_OID
 '
 
+test_expect_success 'describe works from outside repo using --git-dir' "
+  git clone --bare '$TRASH_DIRECTORY' '$TRASH_DIRECTORY/bare' &&
+  git --git-dir '$TRASH_DIRECTORY/bare' describe
+"
+
 test_done
-- 
2.20.1

