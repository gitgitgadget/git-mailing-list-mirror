Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D71C388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 07:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A91C221FB
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 07:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA2uZRgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506018AbgJVHTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505976AbgJVHTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 03:19:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730BC0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 00:19:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j18so596128pfa.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUfoAFkOAt8GseS4mjIzsm86022eylp9LVtSDhxTW1A=;
        b=JA2uZRgN0yH/XUhw+Vt67DrajwJPA/YBnpbk1NvC5Pj1137JeFhVbJkJxDDDvf8cxl
         O5ik3EpUOgrSUsMVzcjqzD4eKSujQwct+UG/Qbp1CgY5bzLuKq/KgfJRbjJ/cTvsZh4U
         fGvxO/RFBxc2peYmIafOibajNzsKk6aeljUzsOFJ40uwm3664F0KPLSG1zBlfS3I/ClL
         RrvKAENAaR3nMkxxscWtbtUHHpuQW7sc0GJR/6F9VPJD+lXCYFpm301Q28ssAvOOhy7T
         cvtRNqkWgJ8gyQ+t41IMwcHVzSt/t8/RpiA2vucP4wlWItpH5Y/EBo2+krgU4wliEGgy
         EQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUfoAFkOAt8GseS4mjIzsm86022eylp9LVtSDhxTW1A=;
        b=P+Nlr9ns8dnU/DkiI/hO199ANM8jaEximZGrjolaWN7YIyAdD7mjaxn8dI+6FFGEwQ
         TuAD5309MohRFbtIzbIt978PPnOW2pwY6HVGjZAGHeoAgVT8ZLh2p/C8JPZQniK4+3Qy
         AD5GiaVQse/hcwBaWwFXmeV2JKRQxg4OUyNm0gXEZAOf/IVWL4SNOP1KRA1OdvxXgHoH
         Z6veziWGfEY17GeU8uMVyOxQdXXOnw+dVrTeik+CrZcbHsxPfWtsy9+LO+uAc5DDtI+6
         +cj3iumYzy09VIix6h4gYW9w+HdsLaE7iH8nlMbwcAHoGtiIqUCw6Qm3LfA6si0vdTbl
         hRqQ==
X-Gm-Message-State: AOAM5309ua/qyQinP6cbGZnJ/7gWhT7tfbqd62ULz8d1tkg9ZQpMiKLQ
        8YQPlcUhVmJQemcwiB9YwGpmRPuwBZd05w==
X-Google-Smtp-Source: ABdhPJyte6YPp3W32aRmt/mINBtRFM6V8oA7ZKT584DilQ2TLuDWKKxbWBy9I4X+wAeBMAOHgBiLQQ==
X-Received: by 2002:aa7:9e9d:0:b029:152:5ebd:42a with SMTP id p29-20020aa79e9d0000b02901525ebd042amr1207921pfq.4.1603351179239;
        Thu, 22 Oct 2020 00:19:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4050:2e84:4e7a:290b:4332:f03e:69aa])
        by smtp.googlemail.com with ESMTPSA id 78sm1030004pfz.211.2020.10.22.00.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 00:19:38 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v6 0/5][Outreachy] modernize test scripts 
Date:   Thu, 22 Oct 2020 12:46:45 +0530
Message-Id: <20201022071649.24284-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201021124823.2217-1-charvi077@gmail.com>
References: <20201021124823.2217-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this patch series, I have fixed the remaining errors of 
whitespace after redirect operator in t7102 test script and
v5 3/5 is updated. Other patches remains unchanged.

This patch series :
 -modernize the three test scripts : t7101, t7201 and t7102.
 - cleans up with 5 types of changes in all the three scripts.
   1. Converting the old style test format to new one
   2. Removing blankspaces in test bodies
   3. Removing whitespaces after the redirect operator, according to
      CodingGuidelines 
   4. Using 'git -C' to avoid use of another subshell 
   5. Placing commands in separate lines



Charvi Mendiratta (5):
  t7101,t7102,t7201: modernize test formatting
  t7102,t7201: remove unnecessary blank spaces in test body
  t7102,t7201: remove whitespace after redirect operator
  t7201: use 'git -C' to avoid subshell
  t7201: put each command on a separate line

 t/t7101-reset-empty-subdirs.sh |  66 ++++++++++-----------
 t/t7102-reset.sh               |  65 ++++++++-------------
 t/t7201-co.sh                  | 102 +++++++++++++--------------------
 3 files changed, 97 insertions(+), 136 deletions(-)

-- 
2.29.0.rc1

