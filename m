Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF37C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 22:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4A424670
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 22:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQqtKvzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfLEWzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:55:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34617 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEWzG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 17:55:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id d202so4888254qkb.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUYM8SJCa1YddG5E8vt54k3s22PUCUl39fRDIqJ1A9o=;
        b=IQqtKvzn4S4JDf14hRke6ejnI9S+tiTLaq1nElHNpJVF+mhfZNYUS3Yt6lsxDALPwM
         8+TlbnJbEkLG7Vw8EwP/lEyqSEhuJFGOYlcUtFSF/RDnzy7nrmluqiR9AMCbMIcLPXkr
         ab5GOtBoIAZhLURir7LRt4qLftZ7/PYiKSdF1XscSJtTNUsxaTibwKGsZE5K8xnWbOE3
         b4rrMNqmz+haPzsTr8ekbz7Q6KvI++T+WDLn+yG6+JajA3kMt4RSoZQZqEfVTGVKvJDR
         fpJ1jlC1oD8H0FS5UJAcuR32+xhdoi2puGutAoaVeS6fVzWpYUfL7uQq/pkz3RPduME1
         v0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUYM8SJCa1YddG5E8vt54k3s22PUCUl39fRDIqJ1A9o=;
        b=TzRByt8vDI24LcsWDd1/kxFVTX2dBuwJU+qdKkF8dpp4CyIXzTRuWkgLNcOpADBiMD
         2bTvBbssX20wju9lXlG1yeHQn+uCNL2w7XHce27j90rq8Bd49YgQqeOp9x8Xb+z2TD9W
         KMhDAkl+3q4/H0IN8uQJhv46wi9Wd/zhwMMo94ytNFhqVL4ZCLgUXi1V6vDsWL3XNix/
         d0N3KhGao2+qQRKKAmZkb3vjMS2f5uT9oCWcKBiNiNN2Zq1UdNDByC7ghPHFhRyrg6FU
         CPl5+EqWR3CkafhdhXqHaxbP7XfakE2XIpRfOp1ibIvt68tYOjWVqQPjkGFkPIj4Ylz8
         Mjcg==
X-Gm-Message-State: APjAAAXCfjXNCRYiO0hp1aTuNYQVCd8WxpERIqtOxP3QIHWM0qCI7vJ1
        tH+1lwK2/8TOJP9oLlF1g3VKaBI/dWI=
X-Google-Smtp-Source: APXvYqyigSOSNlvQAI8X5PpogI/glqsZBBT+R7j+cFfFukutB9dOJJXWz5z3MZnxngob2FjOIEookg==
X-Received: by 2002:a37:4cc9:: with SMTP id z192mr11089286qka.436.1575586504536;
        Thu, 05 Dec 2019 14:55:04 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.249])
        by smtp.googlemail.com with ESMTPSA id f23sm5426066qke.104.2019.12.05.14.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 14:55:03 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>
Subject: [PATCH 0/3] rebase: fix bug in --fork-point
Date:   Thu,  5 Dec 2019 17:53:19 -0500
Message-Id: <20191205225322.5529-1-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rebase --fork-point with a short branch ref name (without
refs/heads/ prefix) for the upstream will not use the fork point between
the upstream and the branch.

If git rebase --forkpoint is used with a full ref on the upstream
(refs/heads/branchName), the fork point between the branch and upstream
is correctly used.

This bug was introduced in 2.20.0 with the c implementation of rebase. I
was able to reproduce it on next and master.

The code path for rebase with --fork-point and a user-provided upstream
does not use a DWIM method to look up the full ref name. This leads to
get_fork_point returning a null pointer and rebase using the upstream
itself instead of the fork point between the upstream and branch.

I looked in other places that call get_fork_point and found that
in handle_fork_point of builtin/merge_base.c, dwim_ref is used to find
the full ref name before calling get_fork_point.

I initially based this change off of maint, but then saw that there were
some tests added for rebase --fork-point on master, so I rebased onto
there to build off of those tests, but I'm not sure if that was the "right"
thing to do.

Alex Torok (3):
  rebase: add test for rebase --fork-point with short upstream
  rebase: refactor dwim_ref_or_die from merge-base.c
  rebase: fix rebase to use full ref to find fork-point

 builtin/merge-base.c         |  9 +--------
 builtin/rebase.c             |  4 +++-
 refs.c                       | 14 ++++++++++++++
 refs.h                       |  1 +
 t/t3431-rebase-fork-point.sh |  1 +
 5 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.17.1

