Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E121F462
	for <e@80x24.org>; Wed, 12 Jun 2019 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfFLSKL (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 14:10:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32843 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfFLSKL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 14:10:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9so27084510edr.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5Jy7++giPFvWS8od9LJD6lxbphI9SA23GHipkbex79Y=;
        b=X7bh1ScDVoL+ocHeaIGioafYmGCnn3YYaVXxZMfnD+qxlpAHOn4FjrJQhP9Rfim3fz
         yjA7UXzOEzNbMhGbMXZ6tDvoD6h2XwKElU+IsFYUUIx6vJX+169RVS0GunJuxqOAvakg
         eU1vW1HuCSpjan9S86WsvWt9rKysteuHQNfsvptVApvxrPkHHWhQm639okl2rZE0ZSG7
         mVTf6/uPuZXQtSTXyRAkRocrxgN3NWzsaHTbOmFeqNtGOsSW3yiPGQjm3670wNnHmJ18
         20b/hjZ5UkTvKtwU1JpFyaqt5ReccrVfOaId1BWBVtWLYk67G5gM0l4SqfXaSE7HmZnG
         oHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Jy7++giPFvWS8od9LJD6lxbphI9SA23GHipkbex79Y=;
        b=tkra3z1VsB7HDIx6SoK11EJCJ3+xlazTqvho/hVew4ccG/sIHyU/J6p3EXnVbXLMG0
         Kj/gFZyx4g2M9PV4Frh4NrIcG8FtAj5AsnsXeBE16YJc28bM8Mx55ObWsHBl9kG8FvK+
         9Gn/mRV5MyTC3lauTcDy+9AKHuHWiIsL8S11RzrhD1Ikyujzb9cLzwSb/pF9sRWckLrq
         rSQrSzvdm2G+zXJY307yTPk9Xc7kdJoVpaFI12hkc+1CyEaHnFuxd/ACmtFcgmNb51rT
         6bid0a+wPphMYzzl6GGBSecUJ5HdGWlgp5FKDJbytiP9e51CtTywozzcuywR1ffuW7D3
         t9SA==
X-Gm-Message-State: APjAAAWrL0kg/cQCGVo0wAQyrR8ZIAewo/CsOp+vlfMyEcxWph0l/USq
        bY2ShCIQr8CBQczy1CwWkaqKMgXA
X-Google-Smtp-Source: APXvYqypTLuBvbIGLNxW+KxiLUtoQSAuERmQ1RiTtEptTidJKoXFiaq+AXUL+622Sfc/zzPaK2lQ+A==
X-Received: by 2002:a17:906:4f8f:: with SMTP id o15mr71950058eju.129.1560363009292;
        Wed, 12 Jun 2019 11:10:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm92305ejo.78.2019.06.12.11.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 11:10:08 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:10:08 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 18:10:07 GMT
Message-Id: <pull.263.git.gitgitgadget@gmail.com>
From:   "Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] submodule foreach: fix recursion of options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the usage of git in Buildkite we noted that git fails upon calling 
git submodule foreach --recursive git reset --hardafter updating git version
to 2.22.0.

This is due to a problem with the recursive calling of git submodule--helper 
itself, which is fixed in the patch below.

Morian Sonnet (1):
  submodule foreach: fix recursion of options

 builtin/submodule--helper.c  | 1 +
 t/t7407-submodule-foreach.sh | 5 +++++
 2 files changed, 6 insertions(+)


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-263%2Fmomoson%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-263/momoson/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/263
-- 
gitgitgadget
