Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5BE20D0C
	for <e@80x24.org>; Thu, 15 Jun 2017 23:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbdFOXQD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:16:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33632 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbdFOXQC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:16:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id f90so2095469wmh.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjLu3baRV3B+xze9MKKtBxCMefx42CEOV5zPXk7X7UY=;
        b=svXbKmmRrOjdsH6wxecn7hr1CSZJ8OgZpi+WZv3y8tuwr0C7HAI0HdavZB83sQ8/oS
         5cbKDYl+og7UcBfqEMBHT7JBgHwDivFKwpkR2nIJkMUTsbIOSMAxCuBqWBLpb++T8UCr
         D13Ewxy4mKn/lILJX/Ix/Kd0vIzODcnprJQhBlVbpCy+SyVfCkbwlREW5m26xcMxFD5r
         Eib1ptAt7b2YuJq5WdfntUAIKrSoJBfN2ICnTgh/c8hMzgLJXHN4+LdfTw80fZOd0WJM
         QkVq1poTfZ4X4Mgq7G1XytOF10g9fJ6zMomYHPJGUeRoJDUO8hj0xf6/8Q4pb2nrfqNK
         h6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjLu3baRV3B+xze9MKKtBxCMefx42CEOV5zPXk7X7UY=;
        b=UkFYOf7wcmQDQLeoLJydPekxMvrX0snWiivKjZehgChiWHt6fxIbMarn82bQ8j679/
         7kc263PmYryHjUD8kktT59BmLQa//0v0JmQHzvAZJHUvHiHiyeBcOHRbq6orTvVRl0Yp
         rN9j5HImKWgBDUfwzIWpMXMlsxXG2n30g1OIQ4z8s8v/2G3IBBVelEiTG2vW1i9tlbQu
         +QDNC4pKoCwcsMTSAFMGr23jw2cN70l8UONNP4GM4y42VNI92bJ/s6UD5uLWwPV4BJav
         S71U2RtKv005oOVG50FFbPOkrrBkTkA+G5RwA5uJJVkfG5g34b+VQe94SfE4wUvklggB
         wrDA==
X-Gm-Message-State: AKS2vOy4LlTuwspKL1xuTLkjrwKheE3mspU/gGHN65JuxbRN8lAzvZRE
        JG7fSJf6xJzeux6Aks4=
X-Received: by 10.80.209.215 with SMTP id i23mr5076504edg.165.1497568560609;
        Thu, 15 Jun 2017 16:16:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o15sm305130edo.68.2017.06.15.16.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 16:15:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/6] Add a FREE_AND_NULL() wrapper macro
Date:   Thu, 15 Jun 2017 23:15:43 +0000
Message-Id: <20170615231549.20085-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
References: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I didn't know about the coccinelle semantic patch facility. This adds
coccinelle rules to do the code changes, and adds subsequent follow-up
commits which apply that change, with the series ending with a patch
that I manually authored.

This fixes a bug in earlier versions of the series. I was mistakenly
freeing the wrong thing in the tree-walk.c change, that change is now
gone, and all the changes not made by coccinelle are in one commit,
making it easier to review.

Ævar Arnfjörð Bjarmason (6):
  git-compat-util: add a FREE_AND_NULL() wrapper around free(ptr); ptr =
    NULL
  coccinelle: add a rule to make "type" code use FREE_AND_NULL()
  coccinelle: make use of the "type" FREE_AND_NULL() rule
  coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
  coccinelle: make use of the "expression" FREE_AND_NULL() rule
  *.[ch] refactoring: make use of the FREE_AND_NULL() macro

 alias.c                       |  6 ++----
 apply.c                       |  3 +--
 attr.c                        |  6 ++----
 blame.c                       |  3 +--
 branch.c                      |  3 +--
 builtin/am.c                  | 18 +++++-------------
 builtin/clean.c               |  6 ++----
 builtin/config.c              |  6 ++----
 builtin/index-pack.c          |  6 ++----
 builtin/pack-objects.c        | 12 ++++--------
 builtin/unpack-objects.c      |  3 +--
 builtin/worktree.c            |  6 ++----
 commit-slab.h                 |  3 +--
 commit.c                      |  3 +--
 config.c                      |  3 +--
 contrib/coccinelle/free.cocci | 15 +++++++++++++++
 credential.c                  |  9 +++------
 diff-lib.c                    |  3 +--
 diff.c                        |  6 ++----
 diffcore-rename.c             |  6 ++----
 dir.c                         |  9 +++------
 fast-import.c                 |  6 ++----
 git-compat-util.h             |  6 ++++++
 gpg-interface.c               | 15 +++++----------
 grep.c                        | 12 ++++--------
 help.c                        |  3 +--
 http-push.c                   | 24 ++++++++----------------
 http.c                        | 15 +++++----------
 imap-send.c                   |  3 +--
 line-log.c                    |  6 ++----
 ll-merge.c                    |  3 +--
 mailinfo.c                    |  3 +--
 object.c                      |  3 +--
 pathspec.c                    |  3 +--
 prio-queue.c                  |  3 +--
 read-cache.c                  |  6 ++----
 ref-filter.c                  |  3 +--
 refs/files-backend.c          |  3 +--
 refs/ref-cache.c              |  3 +--
 remote-testsvn.c              |  3 +--
 rerere.c                      |  3 +--
 sequencer.c                   |  3 +--
 sha1-array.c                  |  3 +--
 sha1_file.c                   |  3 +--
 split-index.c                 |  3 +--
 transport-helper.c            | 27 +++++++++------------------
 transport.c                   |  3 +--
 tree-diff.c                   |  6 ++----
 tree.c                        |  3 +--
 49 files changed, 117 insertions(+), 195 deletions(-)

-- 
2.13.1.508.gb3defc5cc

