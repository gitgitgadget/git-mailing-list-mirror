Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F791F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeHMU6I (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:58:08 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:36986 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbeHMU6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:58:08 -0400
Received: by mail-ua1-f74.google.com with SMTP id w15-v6so7908433uao.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2j5SO5c+Y/Rd+v+qhdY4nSwJXkYgN9gwpPub47TkX8s=;
        b=kgPeEYSPVvGQXG2qq3BNB4Lra+DrmwmnidrwIiMjD9ElijWnGfVZZfAyr11dhGhN8v
         2BcKyEGlTIF4kkycTvzSKOzCIaprKhZ0AnZ5NlJLOMe47ZfcPJ//+7WiS6Ma/UWjrnui
         jOIAkGD7BjQAcoyeLmAlS5zc5C803S2xopcpMVYl5pozbmzxAlw07gEzq2TviTNOS/+B
         lcftx3HCL8rCLbYTKCAgjHwO73sQ8/sJwTPFS6Y9STGkEJPwxMCNHcZ0xldGinJMVgBy
         UxSW2WVAEfJQgexLOyJF0U4IFB96XPY2jrRmhyMHuyZyOsWiRy1HuzhV2tkQMyN4YHUW
         IC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2j5SO5c+Y/Rd+v+qhdY4nSwJXkYgN9gwpPub47TkX8s=;
        b=WkRn56ml252gEZNZ/NGYNILNAxcbsEFzjPqAot15HGG5VFGej6GJHFEXjJdzDcjltz
         mkRZBkzWnn1XZZYo3GSRfkZsFvCB78c1MQ0cOa5qvrNRGRFq/wRpzezH+ytLbewjwdH5
         ekApcF4DxU3xS1B7t+vTG94VbMR8voYPrETjxD5aJXXGRApncrK5wf2oqYwGYp5r42IE
         jl41vSGhtYijspla04hoLuRG8KI3B77niOn7CBsCeEQIbgGM9GnDtLoqrdWX4FzdMctd
         mKRH31Y4BHH6wiJkl6jR+g4hTTfANmatkHKQnOwAz/2wZLfmAK4K1O/qn3tifQ4hjbLc
         e8Jw==
X-Gm-Message-State: AOUpUlHqEDhnfb4qZNuYogdQ6emO8WgG0lsPnZHQqwKCrNVBxqVpbqxt
        9WGoPb6YZ243i3vWp4rkT7FZH6IkRoBoESNmtULH0qj4DjjJhnZONbB1KHNvLIBJSt1kaObTWvm
        JOKM4DGEQBpN0II+Dgd69Pj4v9S8DDUsFtyKL+JKu/5gXf5gDOI8yEBIPppc=
X-Google-Smtp-Source: AA+uWPyL0yybu9PvK/fnnVJPfoET9hvP4N7ATArIQ9VIYhk3EAJNx+OsEOePGB2H4r+iEjzWD/oprCABRZ8s
X-Received: by 2002:a1f:1e55:: with SMTP id e82-v6mr10353172vke.84.1534184088906;
 Mon, 13 Aug 2018 11:14:48 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:14:27 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1534183648.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v3 0/5] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Applied the following changes suggested by git@jeffhostetler.com:
 - Change the filter name from tree:none to tree:0 to make room for
   future improvements which allow filtering based on depth.
 - Made a separate filter logic function and filter data struct for
   tree:0 rather than share it with blob:none. I would usually prefer
   making the code less redundant whenever possible, but since there
   are plans to extend this in the future, it makes more sense to have
   this separate.

Matthew DeVore (5):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: implement filter tree:0

 Documentation/rev-list-options.txt     |   3 +
 builtin/rev-list.c                     |  10 +-
 list-objects-filter-options.c          |   4 +
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  50 ++++++
 list-objects.c                         | 236 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  10 +-
 t/t5317-pack-objects-filter-objects.sh |  40 +++++
 t/t5616-partial-clone.sh               |  27 +++
 t/t6112-rev-list-filters-objects.sh    |  13 ++
 11 files changed, 274 insertions(+), 121 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

