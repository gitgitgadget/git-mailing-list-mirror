Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B11F1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbdLLTyD (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:54:03 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35263 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdLLTyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:54:02 -0500
Received: by mail-pg0-f67.google.com with SMTP id q20so30150pgv.2
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 11:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JDYXTndxjVeOmHilMLmwdvvT71vH1m4S1xQ7bf5kQHw=;
        b=Lv4sn8mBZeE3VfuYBlZbeeF2XyLzojlfeUQi345ZkUo47aW//943R3ImAkxdnFCxp/
         CLD1btv+cp5Lk/P4g9U/yFR8pmDMCY8ZxE+DGYkrcE5gxhTxJ+PndLnMOLPWa+YSC+lN
         DThKqmFHo1QbdhMcW4p4iwJTB/kUYlBkPJU1UcRKILSEWjGRvv/Rs1biHQHTZg+XiSqq
         p3vEMuXX5r7K2kq2cUm2WmsnTpHWxsWZ7OLZKEYFeExdpM8iXICf+5PK9a3J1GTfIlu3
         GrqqIPwz2K+3wGJ8ybxbjryPuHl55EwPNnn0+Jgetr+s7c3TnTWsXEJdk0uRJV0NiPQt
         3a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JDYXTndxjVeOmHilMLmwdvvT71vH1m4S1xQ7bf5kQHw=;
        b=HXxhxUq7x9bLUsXQ0jWG37vRoBI89e5/3pGbV+hRLbnWdNzTVOtjYqvzC2zXQ2fBU4
         TAQ766wZK98Rgj0tqOzSBD90c0LOQEfi8ha6lgjoPc7EptI17FVzQuU3egYLMHsCAfEM
         6rOXfY9u9/fZCq03ZrwHSiY+xjwABQaQqmgT3ysK9zgT50xib+MM5O6x8x4cXmkgms/6
         zEGlsbCpm6LtPoiQ9s0/XrD4IKANA6NSs5/qZCiK/NS3q/NWOFsA7mhIV457m+oN/x5t
         b1KFQQ6QqLS7q6ED1LhixiU5/p8V/mLWs33LPnc8XyzZAmZ49t7wlzLTu5JnIaeiHGcj
         D95g==
X-Gm-Message-State: AKGB3mJ2jN3azKBCwn/E376Thqz8E6QDMaSL3DObBL+kdessnBoNNKs9
        +n/ioafAg2DbXZAVSO0wgfyyscM6yJk=
X-Google-Smtp-Source: ACJfBov+8NLt3yqy905K70kxax6jVRuF5VUQVzKNIVOREC5czyniz2r64pJzRIsfP7XYtazkeTkexA==
X-Received: by 10.98.157.67 with SMTP id i64mr3410577pfd.40.1513108441273;
        Tue, 12 Dec 2017 11:54:01 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id h69sm32822565pfe.107.2017.12.12.11.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 11:54:00 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/3] convert submodule.c to not use the index compat macros
Date:   Tue, 12 Dec 2017 11:53:49 -0800
Message-Id: <20171212195352.146675-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series removes the remaining users of the index compatibility macros and
ensures that future uses of the macros will result in compiler errors.

Brandon Williams (3):
  submodule: convert stage_updated_gitmodules to take a struct
    index_state
  submodule: used correct index in is_staging_gitmodules_ok
  submodule: convert get_next_submodule to not rely on the_index

 builtin/fetch.c |  4 +++-
 builtin/mv.c    |  2 +-
 builtin/rm.c    |  2 +-
 submodule.c     | 32 ++++++++++++++++++--------------
 submodule.h     | 14 ++++++++------
 5 files changed, 31 insertions(+), 23 deletions(-)

-- 
2.15.1.504.g5279b80103-goog

