Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1481F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 14:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfJVOjL (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 10:39:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42443 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfJVOjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 10:39:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so8571390wrs.9
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=atHQ051mcIm/vv+hDsdLreCCo4p7XQ8XJIbuYY/kZLQ=;
        b=gCmC4M7WeiGjZ5teW224EvyzrvsPBieEd4rmgKTrN90Ed6x2rGGQIROx2bM3vRRFoK
         8RHXKo7HYnmrHV+m74sD7E8SI9NvEi+3XGDCd/fQ3CbOyYtADT2JatrYPGK5Slh0ZW1g
         GGeQraQHZyaXPo6RicGCZdVUOcjG0vbdaf3cgc620QK0EOUdZCv+sFpWAvsGC4j8pB3i
         k9IFCmWC7USjKyDRnYQyIkiA4fxz+Apcvy6Xtp8Ab20/X6zaG0cnmaLxQPv61Ntmkt29
         E2thpjuo+biXH5Vv27numBAvtzh+pNg98al4ZFlLoQy7ejAwTQD6d/5h9gdyPPAq4OT/
         CJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=atHQ051mcIm/vv+hDsdLreCCo4p7XQ8XJIbuYY/kZLQ=;
        b=QkPhMmazjvosFxQmNhwegJ5n9QRJsmVXZrglG1eTNkLF0S/QPA8fEdgiaC8i0+aE8o
         NTvj9YjFcvjmVHI95TqV8saxXMPZgvtAk+V0mPGDE8nW1J4bhgQ9AjIhQwChB5877P4j
         Md+dx81C8sOe4FE9uoKyAfdY2wQk31zbwwjTwn0TQZ7kkaulX6JA2UYhU3NMIZHSw3QE
         2w0rMpqqpwl84DbHcGYFNc9aC9L5kr9agIdskC21mgFM1bzp5PIhrgorBoALqqCukPSW
         361rD2QZW6u7V4BdNIeYkdWUxg8dhHhA23O5TzHcYpXoIGajcybkhj7dD6g4g0jRhMrb
         iI1w==
X-Gm-Message-State: APjAAAXyV4Z3KyzEW15lD8AtQyg7N5h8zwwvkDzvyasy8CkANGUTUt71
        3ttjr96Yq/kDYCK7ybrcyzO0Puma
X-Google-Smtp-Source: APXvYqwHu9MySl1pHuVMM9Z2KGw73ZELtSwgBl6+3mpwqg3s+GTHS1GKVyQdcWSpkQWK5Yp6pkBtpA==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr3698549wrq.208.1571755148416;
        Tue, 22 Oct 2019 07:39:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm21439408wra.79.2019.10.22.07.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:39:07 -0700 (PDT)
Message-Id: <pull.407.git.1571755147.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 14:39:06 +0000
Subject: [PATCH 0/1] vreportf: Fix interleaving issues, remove 4096 limitation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes t5516 on Windows. For detailed explanation please refer to code
comments in this commit.

There was a lot of back-and-forth already in vreportf(): d048a96e
(2007-11-09) - 'char msg[256]' is introduced to avoid interleaving 389d1767
(2009-03-25) - Buffer size increased to 1024 to avoid truncation 625a860c
(2009-11-22) - Buffer size increased to 4096 to avoid truncation f4c3edc0
(2015-08-11) - Buffer removed to avoid truncation b5a9e435 (2017-01-11) -
Reverts f4c3edc0 to be able to replace control chars before sending to
stderr

This fix attempts to solve all issues:

1) avoid multiple fprintf() interleaving 2) avoid truncation 3) avoid char
interleaving in fprintf() on some platforms 4) avoid buffer block
interleaving when output is large 5) avoid Out-of-order messages 6) replace
control characters in output

Other commits worthy of notice: 9ac13ec9 (2006-10-11) - Another attempt to
solve interleaving. This is seemingly related to d048a96e. 137a0d0e
(2007-11-19) - Addresses out-of-order for display() 34df8aba (2009-03-10) -
Switches xwrite() to fprintf() in recv_sideband() to support UTF-8 emulation
eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emulation,
so it's safe to use xwrite() again 5e5be9e2 (2016-06-28) - recv_sideband()
uses xwrite() again

Signed-off-by: Alexandr Miloslavskiy alexandr.miloslavskiy@syntevo.com
[alexandr.miloslavskiy@syntevo.com]

Alexandr Miloslavskiy (1):
  vreportf: Fix interleaving issues, remove 4096 limitation

 usage.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 6 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-407%2FSyntevoAlex%2F%230194_t5516_fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-407/SyntevoAlex/#0194_t5516_fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/407
-- 
gitgitgadget
