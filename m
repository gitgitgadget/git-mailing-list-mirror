Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B541F404
	for <e@80x24.org>; Wed, 12 Sep 2018 14:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeILT1j (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 15:27:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41916 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILT1j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 15:27:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id b12-v6so1053516plr.8
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=J7ZPUxA0QWoGllzK3gQtGWNn4FP4fqVY9jLCzydS9Yo=;
        b=SC2HPCZfLWj28jbzybiLfypfl7Hsgg5rVQ8OWriYhm2sOe1OddDzKbael84/6fXIzW
         kqJNLCNbPNYYwoThZiaX/Tyksfw0r017Vjdk1tna94LyBtvfNwvX1hb7QJgohomr/sIh
         /egGtRL6z/0iaxKJDWX6Qux7Z59C+fXiWgdrz+opfGZ25J5A0u58NhAnDRNscSOkgtlr
         aBPxC0ksoeoTIJ5lCIaVVF7wdOID5UeIhlEJguhzRncWjVwM0CDB1nP5qMf7MkKpMBIJ
         w3WCAOodPhysPYAxK7uYLCFtkgs1nPLhkZx0zTNjLcsPYVqnRFbQBFiuqQhe3nK7n8ql
         Q2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J7ZPUxA0QWoGllzK3gQtGWNn4FP4fqVY9jLCzydS9Yo=;
        b=EqwyeD3I3fz3+WYL2JAOyw4G0+jnc8YGgR04o3c78D18yM8dY79ZCKJEUTSs2VdUDN
         jHfdkf7GHzE1XN2G2dicsqp/ng4cmsZkeamI9hQOXK6Bha73XQGJp1Vpp1rzosPVKnTE
         hETlhDY8iB5Q5WwVMF6N0KWYAZiGqjpBM2EE+kpfbpa/mqnmIOWhoVNHsHtxjLMSgI4F
         0JivMV9+N66kSCC1sXtwTIzO9JdDAwaauZnYYQ+Gng4SOXUI7girijNbnX3C3CK/smot
         3wHaeRTfmP6A5pP6GpoifZJGMOKcbOiMfjcaWKsXcJFsx8D97rKLmeYNmpKSi079uWSa
         yALA==
X-Gm-Message-State: APzg51AFIRexblzMMbO0Ot3AJbPsJY656TU92ZkrhwpOs1IPCTPFGExJ
        SFJdSmZjSHD9DlM+2RBOL1D118Mf
X-Google-Smtp-Source: ANB0VdZpH4fM/uxh3JnfqtUrrEmXFANTJKi3lYUKaRCmVN24jPP3dmnfkhInkJOJMKVA0roYWmD2ZQ==
X-Received: by 2002:a17:902:7488:: with SMTP id h8-v6mr2595695pll.16.1536762175693;
        Wed, 12 Sep 2018 07:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y69-v6sm2265553pfd.36.2018.09.12.07.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:22:54 -0700 (PDT)
Date:   Wed, 12 Sep 2018 07:22:54 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Sep 2018 14:22:51 GMT
Message-Id: <pull.39.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Properly peel tags in can_all_from_reach_with_flags()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Peff reported [1], the refactored can_all_from_reach_with_flags() method
does not properly peel tags. Since the helper method can_all_from_reach()
and code in t/helper/test-reach.c all peel tags before getting to this
method, it is not super-simple to create a test that demonstrates this.

I modified t/helper/test-reach.c to allow calling
can_all_from_reach_with_flags() directly, and added a test in
t6600-test-reach.sh that demonstrates the segfault without the fix. The fix
in commit-reach.c is Peff's fix verbatim.

[1] 
https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u

Derrick Stolee (1):
  commit-reach: properly peel tags

 commit-reach.c        | 25 ++++++++++++++++++-------
 t/helper/test-reach.c | 22 +++++++++++++++++-----
 t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 14 deletions(-)


base-commit: 6621c838743812aaba96e55cfec8524ea1144c2d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-39%2Fderrickstolee%2Ftag-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-39/derrickstolee/tag-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/39
-- 
gitgitgadget
