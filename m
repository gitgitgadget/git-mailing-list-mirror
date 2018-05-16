Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1D41F406
	for <e@80x24.org>; Wed, 16 May 2018 22:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEPW6k (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:58:40 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:46509 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeEPW6j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:58:39 -0400
Received: by mail-ua0-f202.google.com with SMTP id 69-v6so2250130uag.13
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Fn4XPmZVxLDgmIAOheqQtpMRTuqmUWqWVGg/AGAKick=;
        b=nvuQZa33zyewjCqCiLQS4E6LfwdT0nhmUBvvlntnDSJYeap4zhdYoxA/UjJRgACF9S
         mW4X4j9sCbGGXJ9HQblWOO09lWWwCXkisEqW9jzWHTbBDWYXE7NBMGfeTGj9fmPLwl7P
         Wx+xKg/Bl+NApnpc/7AbzzH+exdBOBsJuLJycViUhFGelFIGvOWaUxzb/sb+5HxJsS7n
         GqkTJyKyTrMSnM5Xm2kAukZtriSujJ1g1CjHsX88RM5emESM4tiBOJyMkXszh9PlxP/3
         8639Mp1k5bY0rVXztbMv5yMkp78VBFlcnVoe8dsB1sK6/P3mMFaYZQXLIuEZJGdcsOIF
         nrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Fn4XPmZVxLDgmIAOheqQtpMRTuqmUWqWVGg/AGAKick=;
        b=NXwSqZgteYk7JczvA6/5FaXL0eJ4hCBTdt+bvhtU3BSjed0bUF6crTXvPz9o7iMD6r
         wc60fJx0BIgYuBmL6ulc3q8e8Dj9Ghx97QvzWBLxr91o50opn+ymYGKV2nMhVPqru11a
         Akgu1pXJsUBg7DApam6ZnSRaJx2hhXpTAC3EQLWCKVg91OXTV/MptF+sFU+vtnX6ETcD
         ajuCS7LTyRAKiy7yA/hpzd+DL/e74rKre58tkrfvIxfK3owRB+Ddb9x+7CgHUYUHT2Zm
         BLBQBaW/RlrJEHOjs3BxRFWc8+3cgga8KTQMvA+t5+AmQiBfDG5wBXTi01oHKrIKr5ge
         W60w==
X-Gm-Message-State: ALKqPweQJ4eNL9KYSeCkmsFTsyt0jSOq9AlOW6ZFKATlEM1h754kHsa9
        BS/mHsYLuNfbIfFbQdvQy3zbUd20tsaqQRUCLvN3jhLyAW2Iav0jzRNbkOQkvNLTEWwLm5cysFT
        qnHSha/c42yIdnZpGw7kWkyBSVOh8bZF+AnqZR9Q6vZomiWc4QWYe8cqHew==
X-Google-Smtp-Source: AB8JxZqnHs0tZAy6mJcivShGtaq9OB222fCaHaatWLK87hhgGnlul8hctXSvI9PDfOwTNq67uGGjS5E5lRA=
MIME-Version: 1.0
X-Received: by 2002:ab0:3108:: with SMTP id e8-v6mr2316163ual.97.1526511518048;
 Wed, 16 May 2018 15:58:38 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:47 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180516225823.235426-1-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 00/36] refactoring refspecs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
 * added missing extern keyword in the first patch
 * reordered patch 2 and 3 and updated some comments to be clearer.
 * fixed some memory leaks
 * squashed in some changes recommended by Aevar 

Brandon Williams (36):
  refspec: move refspec parsing logic into its own file
  refspec: rename struct refspec to struct refspec_item
  refspec: factor out parsing a single refspec
  refspec: introduce struct refspec
  refspec: convert valid_fetch_refspec to use parse_refspec
  submodule--helper: convert push_check to use struct refspec
  pull: convert get_tracking_branch to use refspec_item_init
  transport: convert transport_push to use struct refspec
  remote: convert check_push_refs to use struct refspec
  remote: convert match_push_refs to use struct refspec
  clone: convert cmd_clone to use refspec_item_init
  fast-export: convert to use struct refspec
  remote: convert push refspecs to struct refspec
  remote: convert fetch refspecs to struct refspec
  remote: remove add_prune_tags_to_fetch_refspec
  transport-helper: convert to use struct refspec
  fetch: convert fetch_one to use struct refspec
  fetch: convert refmap to use struct refspec
  refspec: remove the deprecated functions
  fetch: convert do_fetch to take a struct refspec
  fetch: convert get_ref_map to take a struct refspec
  fetch: convert prune_refs to take a struct refspec
  remote: convert get_stale_heads to take a struct refspec
  remote: convert apply_refspecs to take a struct refspec
  remote: convert query_refspecs to take a struct refspec
  remote: convert get_ref_match to take a struct refspec
  remote: convert match_explicit_refs to take a struct refspec
  push: check for errors earlier
  push: convert to use struct refspec
  transport: convert transport_push to take a struct refspec
  send-pack: store refspecs in a struct refspec
  transport: remove transport_verify_remote_names
  http-push: store refspecs in a struct refspec
  remote: convert match_push_refs to take a struct refspec
  remote: convert check_push_refs to take a struct refspec
  submodule: convert push_unpushed_submodules to take a struct refspec

 Makefile                    |   1 +
 branch.c                    |   7 +-
 builtin/clone.c             |  13 +-
 builtin/fast-export.c       |  22 +--
 builtin/fetch.c             | 134 ++++++--------
 builtin/merge.c             |   1 +
 builtin/pull.c              |   9 +-
 builtin/push.c              |  80 ++++----
 builtin/remote.c            |  37 ++--
 builtin/send-pack.c         |  24 +--
 builtin/submodule--helper.c |  14 +-
 checkout.c                  |   5 +-
 http-push.c                 |  18 +-
 refspec.c                   | 194 ++++++++++++++++++++
 refspec.h                   |  44 +++++
 remote.c                    | 353 ++++++++----------------------------
 remote.h                    |  50 ++---
 submodule.c                 |  19 +-
 submodule.h                 |   3 +-
 transport-helper.c          |  39 ++--
 transport.c                 |  51 ++----
 transport.h                 |   4 +-
 22 files changed, 527 insertions(+), 595 deletions(-)
 create mode 100644 refspec.c
 create mode 100644 refspec.h

-- 
2.17.0.441.gb46fe60e1d-goog

