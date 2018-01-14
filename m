Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415F71FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 16:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbeANQtP (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 11:49:15 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46378 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeANQtO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 11:49:14 -0500
Received: by mail-pf0-f196.google.com with SMTP id y5so7016085pff.13
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 08:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KGmIX1ld7BsW/4RJUCJEiWtRUmuv0F5gRJtOd+th98g=;
        b=GsGswlk4VFGrDkuUCBRMY/UeVTHsnlucm4bFnWsb4TgWi99Cg39DxJnyohgrK0nJUy
         86qvLCq07UnQ3tpIeUU7YMkK9BHcvCynU7wyC1gCpXNQ7wV/YXBGJrC2VJ1SjC3SGZcP
         lwHz/Gn6bM/wMEgnoh7gG6ves1Jksul2CAGnEhFJPGueGWjuYC4Tw+I/KSR2iKh0A57i
         9MGB7xkpn5ISyPPDKzVo2EvSfUm/xXTgu95SSz8I9CGhVriLMQbumcy/Y0C41wLBTszp
         nOzZ4kPTdOIl+0RM8aF/IxFEWcISJYZeZEeS/vB3dPZddJv+A5ZD4fMHqq4aFqvK0RDn
         5wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KGmIX1ld7BsW/4RJUCJEiWtRUmuv0F5gRJtOd+th98g=;
        b=YESXQ4CyBzz4ec87P9sunczWi4EDJuDBofMKbNO9vW3rt1M6YhZ9blmiLfBLjyMLHq
         RLIjPJvCXMHYP1EbTH8j52BBhP5WLpyXYXsDXOCXZgtYJdOADsv0pDdT4V1IHa72UlCw
         MhRRmcRnIekU+y5JwT/przsZ4Q0mNMIz7eS9HIgFEvJeJkGC1bR0mt+7qRKP0Z6u6xGI
         52T5tyo7NX08Rk8BPvCC8Nq0p+moNZk4gvbFlnaMThdRzIbIvVt3u8/pL3qnKf5kg1h0
         OBny/HvtkEKBqmBdpQylCmuMyD3Nv4KOriogIwPJJRwVMxzbBVz0K3n5bYUL9uT9t1pM
         rtqw==
X-Gm-Message-State: AKGB3mK2nZI3bX3s4tM7ugluDt9/EMeCnu5F9BtYlzSEn082zZjRtC4t
        Svc3duikh/HEiZf1Zkks0az0JXhX
X-Google-Smtp-Source: ACJfBosKTKF2i4OJp/eiEGPEW2RISluJq1hdTUX/X4qKcMr/+T9Jj3rP5EFT5PXG2VMkl3H298/nrw==
X-Received: by 10.99.154.10 with SMTP id o10mr25040652pge.156.1515948553504;
        Sun, 14 Jan 2018 08:49:13 -0800 (PST)
Received: from localhost.localdomain ([27.63.154.55])
        by smtp.gmail.com with ESMTPSA id d6sm4799787pfc.35.2018.01.14.08.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jan 2018 08:49:12 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [PATCH v3 0/2] Incremental rewrite of git-submodules
Date:   Mon, 15 Jan 2018 02:45:27 +0530
Message-Id: <20180114211529.6391-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180111201721.25930-1-pc44800@gmail.com>
References: <20180111201721.25930-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:

* For the variables: super_config_url and sub_origin_url, xstrdup() was used
  while assigning "" to them, before freeing.

* In case of the function deinit_submodule, since the orignal code doesn't die
  upon failure of the function mkdir(), printf was used instead of die_errno.

As before you can find this series at:
https://github.com/pratham-pc/git/commits/patch-series-2

And its build report is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series-2
Build #197

Prathamesh Chavan (2):
  submodule: port submodule subcommand 'sync' from shell to C
  submodule: port submodule subcommand 'deinit' from shell to C

 builtin/submodule--helper.c | 340 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 112 +--------------
 2 files changed, 342 insertions(+), 110 deletions(-)

-- 
2.15.1

