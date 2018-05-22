Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B31A1F51C
	for <e@80x24.org>; Tue, 22 May 2018 13:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeEVNbk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 09:31:40 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37890 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVNbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 09:31:39 -0400
Received: by mail-wm0-f42.google.com with SMTP id m129-v6so33527678wmb.3
        for <git@vger.kernel.org>; Tue, 22 May 2018 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lRMnsbeo2ML6e4MU00JKiSf24lt0iCpIicOzyzeurs=;
        b=M847lNnByhgT/IRzE8MfYoQEIeNGeeYWma8uHD9ZZ9069hLZThZY0C+/1fF/U3Lgx8
         n5QqWkMPelpCHqgfPR6aqGpHThuQeEbj6yGNHuo7B/llA8xMhtARWweqf3BIu2NJPHFj
         rwE3jc/TNPu6Ib61OrZPbyovwSD1pmrxW8s5z5v9/BELKL3NZ0j9s7oi4itoysPo53ns
         vGLKXCZqfjA4DCLymszqBLoAfTGGbmQe/6k28rj+QqTuTHs3J1ZcpVRxNtcYDOUhNwxr
         jzyK+/VT9EwLDJPFb7J4ED33VXv1Yy18i3UV3dLg/NON82MuwfxjfbzkatBrR+G+LJUa
         Fzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lRMnsbeo2ML6e4MU00JKiSf24lt0iCpIicOzyzeurs=;
        b=F5Cf5J3wiO+zczYY/ZaP7M8sDWqw89SqQ6NfFLa1IIALWx9Jeiw0xYeyz4xrorz39C
         UzwIAN5hhyJNr+z9ofS7+bd1sDSrNrFRhPC7U/j5mw+zP/FKffJwxZaRX3mXACjk6FdX
         cnvrWRv0WLg0rMYFqNGclqTWoaO9hwn3KVRLMeY+2j3FqeWTAfmsxkbsUqpOhoPkabXs
         Aax3siloXexb2fHYi+Uqfn+PYOMHuxt8k7qghsrhlMyQnYYeP+sYSodGCreaxn0jbfaU
         Ki/nblm38I2U3s89RJHMIS0DAKL8yw9LGpxof252sj/1bw3jNsEfRn3007/CpHDw8lgK
         rFpw==
X-Gm-Message-State: ALKqPwcBTt6nx/9g8pl7qpYqUAZ3uw9Clxfjki/u584VQQ8qH7mCncSa
        3kPAKQjPB8yY9vIGQlvQAEdt8YBbNKw=
X-Google-Smtp-Source: AB8JxZr6Nf59s1GrXbwdwHUQZdDXZNQDR4Q78ZMdm8qI0ZHjo51JEMEB1TJuhzfQ4TAKrUqz+28x5w==
X-Received: by 2002:a1c:6b11:: with SMTP id g17-v6mr1227373wmc.65.1526995897899;
        Tue, 22 May 2018 06:31:37 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-45-152.w86-221.abo.wanadoo.fr. [86.221.52.152])
        by smtp.googlemail.com with ESMTPSA id w40-v6sm29109785wrc.69.2018.05.22.06.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 06:31:36 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 0/4] rebase: split rebase -p from rebase -i
Date:   Tue, 22 May 2018 15:31:06 +0200
Message-Id: <20180522133110.32723-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the `rebase --preserve-merges` functionnality from
git-rebase--interactive.sh. This is part of the effort to depreciate
preserve-merges. The new script, git-rebase--preserve-merges.sh, should be left
to bitrot. All the dead code left by the duplication of
git-rebase--interactive.sh is also removed.

This patch series is based of js/sequencer-and-root-commits.

Alban Gruin (4):
  rebase: duplicate git-rebase--interactive.sh to
    git-rebase--preserve-merges.sh
  rebase: strip unused code in git-rebase--preserve-merges.sh
  rebase: use the new git-rebase--preserve-merges.sh
  rebase: remove -p code from git-rebase--interactive.sh

 .gitignore                     |    1 +
 Makefile                       |    2 +
 git-rebase--interactive.sh     |  708 +---------------------------
 git-rebase--preserve-merges.sh | 1004 ++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh                  |   32 +-
 5 files changed, 1040 insertions(+), 707 deletions(-)
 create mode 100644 git-rebase--preserve-merges.sh

-- 
2.16.1

