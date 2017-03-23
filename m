Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D289A20958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbdCWWeN (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:34:13 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38155 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932145AbdCWWeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:34:12 -0400
Received: by mail-it0-f52.google.com with SMTP id y18so286168itc.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lr7aCvP9+dgYqlB2gGRDm5wTM+bMglmTKmvwl5kmK+Y=;
        b=Yu8EpsBjsUWwl7JhGu6wLvc1uaqZ2ZBREFHW0STpX3rOzbg1wd8hCgZ/wUEj5CG+8N
         8CpMW+Ed0PfhON9oIg+juVzNF1cf+iOPXdEIjPm3EvokNWRBdCkcAmzMQBP1HiejEli6
         Iz4T+27lNDNwI8jEaTP6M/ISR3m8c98BAyhX88b/MAMNK0A1NFTF5Khhe4yt4gugpzJu
         RMM/8WWZKxdPAjNc1w+WHMDTbzFlJBmHUMhK2WDXc0VvYK8SAaD1HdVxwZGrBmmo2BYZ
         vIUexkFY19DMq3thcyL5j7h/ky53gAsfT+UrVwZEe/ghSR6vyw8jcaXWUNxhU8GxVRK3
         6qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lr7aCvP9+dgYqlB2gGRDm5wTM+bMglmTKmvwl5kmK+Y=;
        b=FLHwBWlXV5TxQaCA7+XY3wdtQpXFByoCGUa2fWqR9L67lRi4geSX2hIoEFrjtURZtC
         4HiK+XR0G6jkis+06WA6rLr//RwjsejNhnFGQZ2O0HNEwfetJWTHdV1YTkIAnFgcHhdo
         sg9s297NyNync+giOP0k4rzhpIb4NnoCkcgHerYWnGN9GxvFOjddTF8EqlL6BnePCQXZ
         XyebSnyorHNAUfdSXSh+l4q9hUOEJyRsrsSbitMFHZaFq+lhs76hh9eiaw0QXShif9fA
         XDy07ByDM6KnNsAlbfLwnn96WSy28KovLB2lbQZXJoQsLqOYNZMuJ6e97rFU5TW4TXEG
         peyQ==
X-Gm-Message-State: AFeK/H2jNgR8VypKY6lcsU1/BrZXdmsXbHFHBPuc/37sW9Enl8eAqxaMEQ/huI3JWx7fWlfY
X-Received: by 10.36.211.67 with SMTP id n64mr99492itg.13.1490308450591;
        Thu, 23 Mar 2017 15:34:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id i96sm268419iod.46.2017.03.23.15.34.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:34:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v5 0/7] short status: improve reporting for submodule changes
Date:   Thu, 23 Mar 2017 15:33:31 -0700
Message-Id: <20170323223338.32274-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5:
* fixed rebase error in the first 2 patches
* the last 3 patches introduce behavior change outside the scope of is_modified_submodule
  whereas the first 4 ought to just be local changes.
  
Thanks,
Stefan

v4:
* broken down in a lot of tiny patches.

Jonathan wrote:
> Patch 1/3 is the one that gives me pause, since I hadn't been able to
> chase down all callers.  Would it be feasible to split that into two:
> one patch to switch to --porcelain=2 but not change behavior, and a
> separate patch to improve what is stored in the dirty_submodule flags?

This part is in the latest patch now.

Thanks,
Stefan


v3:
This comes as a series; first I'd like to refactor is_submodule_modified
to take advantage of the new porcelain=2 plumbing switch to check for changes
in the submodule.

On top of the refactoring comes the actual change, which moved the
rewriting of the submodule change indicator letter to the collection part.

Thanks,
Stefan

Stefan Beller (8):
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c: use argv_array in is_submodule_modified
  submodule.c: convert is_submodule_modified to use
    strbuf_getwholeline_fd
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c: factor out early loop termination in
    is_submodule_modified
  submodule.c: stricter checking for submodules in is_submodule_modified
  short status: improve reporting for submodule changes
  submodule.c: correctly handle nested submodules in
    is_submodule_modified

 Documentation/git-status.txt |  9 +++++++
 submodule.c                  | 56 ++++++++++++++++++++-----------------------
 t/t3600-rm.sh                | 18 ++++++++++----
 t/t7506-status-submodule.sh  | 57 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 13 ++++++++--
 5 files changed, 116 insertions(+), 37 deletions(-)

-- 
2.12.1.438.gb674c4c09c

