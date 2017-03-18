Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80A920323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdCRKI6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:08:58 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35132 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdCRKI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:08:56 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so42280607pfx.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNjXBBnDhdD86tbHTEc/QqogZ2zZVB8Au2ghGjGuQW4=;
        b=rlLj/K2nfe/kZQlHaNqT4SN5oPSMYCu+5u39HGYf/uvaDIIUgssr+eikvSv+9LjwMn
         OVrHCi19LQX6hw2uc5UZ+FW6xlpNFAH+nrWRG9D806/Wy362AgppfjG1nmGkH7LNqCDS
         gWnJs3XLBMTNCL+rmp7JFJnG6jQkgHxa19oucPCw40wAwaBV8+7b4qUxtK63shNA8ZWr
         7CdMkJPH8BbWtIZHM4yYEKwFk4A4WdhibhZ1qASNJmH9ONhm7S2D6w/eL6KJoXMtYGQE
         849YgrfCT6ELK+EejvQEzrpRn+RL9unZ/Qm5lgfLEXL1Xk5VEzQmBlhBybTtjV8BEVz4
         gD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNjXBBnDhdD86tbHTEc/QqogZ2zZVB8Au2ghGjGuQW4=;
        b=AC5P9zPr75EDldn9rd+6rTgmFONfatodzZm/EWiWMbpDXHajA9bT/jpqVIWPsplC/V
         6oX8Cr2LqHXCkghVxJGLhBEnzIHdmHqSXIOeq9FHLzeD0FBg1RpOttoRhTQc23GnDZKO
         eubyNaNrqrGaxn5TQ8CzLEnyb5QKQ+LukIxSfdTGpyFqV8WIeFwJ/fL1TJ+cCus9R+Wp
         m5HJUPG83fOorDMxSoPV53VDnVDo1Yt11W86bxVILZYzCH8Fnt+RjrKMkZFbwExFNcg0
         z46khBzJYoklivQqwIKGmXrLLmFbjsj9gqJgm3iiz0RGxLQw+IFcR5c6Tid/A2TG5xRW
         3ZgQ==
X-Gm-Message-State: AFeK/H1ZLayQjE3AWq25XxRP4NPODISYwC+S0V4haCjJtvZfNuGS6kaOKRx59veuY3NmKQ==
X-Received: by 10.98.158.219 with SMTP id f88mr22019372pfk.50.1489831338236;
        Sat, 18 Mar 2017 03:02:18 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id y5sm21736037pfd.33.2017.03.18.03.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:02:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:02:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 0/4] Kill manual ref parsing code in worktree.c
Date:   Sat, 18 Mar 2017 17:02:02 +0700
Message-Id: <20170318100206.5980-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216120302.5302-1-pclouds@gmail.com>
References: <20170216120302.5302-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 is a rebased version on latest nd/files-backend-git-dir [1]. Since
that series added a bunch of new refs_* functions, v2's 02/05 and
04/05 are removed. The new 01/04 could be an indepedent fix, but at
test-ref-store.c requires it, so I put it here. More tests are added
now that we have test-ref-store.c (yay!)

[1] http://public-inbox.org/git/%3C20170318020337.22767-1-pclouds@gmail.com%3E/

Nguyễn Thái Ngọc Duy (4):
  environment.c: fix potential segfault by get_git_common_dir()
  refs: introduce get_worktree_ref_store()
  worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
  refs: kill set_worktree_head_symref()

 branch.c                               |  15 ++---
 environment.c                          |   2 +
 refs.c                                 |  32 +++++++++++
 refs.h                                 |  12 +---
 refs/files-backend.c                   |  44 --------------
 t/helper/test-ref-store.c              |  19 ++++++
 t/t1407-worktree-ref-store.sh (new +x) |  52 +++++++++++++++++
 worktree.c                             | 102 +++++++++------------------------
 worktree.h                             |   2 +-
 9 files changed, 143 insertions(+), 137 deletions(-)
 create mode 100755 t/t1407-worktree-ref-store.sh

-- 
2.11.0.157.gd943d85

