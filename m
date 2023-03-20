Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B39FC6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCTUzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCTUzT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:55:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6087625951
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:54:57 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s1so1220611ild.6
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679345696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOBUGBEe2wlgSsNRDQ0cuYVXzc/Y2FxJIw8rXUzI1VA=;
        b=MFcWD5tdnXgJ1Fj0AL3HIWSIE3unD7yn/Q1EnrARpUHaIuyih/dtw+7dRkqMDMy+yg
         yfyz2dbwoALkc8U7bnGIc1jArVMm9VvoTkh6N8iwqGQgGwS8jddHdPFm/eG3Iekc/Lhv
         chfmQIoNkPN+6t+f5BR1ScqN6aSBrNm8lEMLz/05n4g0vGKuGRQDgcLHtkl02FPnKc72
         5h0nE2gvOEpJbofzRW156IUmgoEzcnO8ZR/vHFPVWkW7KfYwxayyT4G+aXmIWjYHMVd6
         WatZYQMb2mKeDJmhaUAitMzJLd0/kBRIQRHhRXIi17s6uxN9mpCsAmjTuEXmSk6GeGTH
         u6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOBUGBEe2wlgSsNRDQ0cuYVXzc/Y2FxJIw8rXUzI1VA=;
        b=PPDXm7Sp5v6USGo4wktQfx7FRc4MvUQR8ZvIePJqkd/HzUey68xLnMQWLZ23FcZ2Jc
         dtvgel0s0H9BbQNfizNPIgtp0W+hVYA8EghPBQo8Y0HsQ6OhtHpiIHyOQKu1chGLTh5U
         dBr1zsUWAhEK8N/F+Euq25ffyUnJiPWYvu+9jrsaKAxChcKXrOfUZtudF9BG38vyzyZV
         p5UMBx8MEdZxgG5HTkm4POgvfjNhxtB2WycWMP7yDehPdG6Hxj4bWvFz3LEwfwSveQoN
         P4gjAQq4UDnMS6eLctWCM9fMyi2gAZXQ4VWWxqBb3cWXe3/Vx0fRv7GKcciRkAjZeAvN
         mekQ==
X-Gm-Message-State: AO0yUKW8XoOAF/qtDcoM6I3c5IRAJ7YpFcxnGLFyuTH3NjNBLFGNmMIs
        HLoXh4E1rA5Wb4lXfn0LqcDHp6/cUQg=
X-Google-Smtp-Source: AK7set8Rp8DkV8JQu+jeP3PjaB1PQa5BSqdhskWqf+W4aE8HmeC5akcYp82VOVZjtvFYbM5EYS0a+A==
X-Received: by 2002:a92:c0c5:0:b0:318:cda9:c60c with SMTP id t5-20020a92c0c5000000b00318cda9c60cmr32009ilf.2.1679345696313;
        Mon, 20 Mar 2023 13:54:56 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a16-20020a056e020e1000b00323058c173csm3045610ilk.59.2023.03.20.13.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:54:55 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [RFC PATCH v6 0/2] diff-files: integrate with sparse index
Date:   Mon, 20 Mar 2023 16:52:39 -0400
Message-Id: <20230320205241.105476-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230310050021.123769-1-cheskaqiqi@gmail.com>
References: <20230310050021.123769-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Did not fix the logic of spare-checkout yet. Leave the spare diff-files 
with pathspec outside sparse definition as 'test_expect_failure' now.
but will fix soon.

Changes since v5:

1. Add space after "definition."

2. Add test case for a pathspec with wildcards or other "magic"

3. Before messing with modified files on disk, add a "baseline" 
of correct behavior when a pathspec points to out-of-cone files.

4. Write the contents of an
existing file inside that sparse directory to disk manually

5. Use 'test_all_match' rather than 'test_sparse_match'. 
wouldn't need the additional 'test_must_be_empty' checks.


Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  8 +++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 73 ++++++++++++++++++++++++
 3 files changed, 83 insertions(+)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
2.39.0

