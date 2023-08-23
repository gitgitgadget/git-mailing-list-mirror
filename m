Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA35C7113B
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbjHWVyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbjHWVxz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:53:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6910D2
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:53:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d749c6d767dso4635360276.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692827633; x=1693432433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=36shxdeqL+q3CmCez95MSnO6jAyJHYb8C8INSKWS2fk=;
        b=TNoEE+EI1FVeeK+1ZhBeFHy2Low46+qETv4wEeL5nPwa4ym1j+a+mUjGoOotbwN+JS
         vqvCRYv/LXRC1/WZKqN9jVQtf6ymtjyQn1C+HNowJno/+4RFWWjvm37o/iBOdY3fvRZn
         3OwHnHa11WBc5I9sjOgFgDrH07kZsy9P4Ix0EjFggYD1bO3IMuijtKi+GBqKGdJ6BlAm
         KmyrTJ2AZ73zbFryJ/vOwbp3UkxoEqJR25lZXHyc7qI1hTsW/kTEF3ka5aFgat4C/GJr
         +L0ngPX31YY11atlZWcHkAnL1QQhvuXDTeu7vW4oCePtheXubLQT9jsA3195sH3c/XZm
         NVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827633; x=1693432433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36shxdeqL+q3CmCez95MSnO6jAyJHYb8C8INSKWS2fk=;
        b=dAF7cRP1cU9M57Jw/0+NdKU/4JImA7peb1sUGEUhx8MSqQnBRP02J2ppWZsFixmYfI
         kPDKlIZ8AC85gqXQGRc1MWQRTKXB7IBfYWXfiWNHhXze92WZbL/Uq+qEYt8o5GrRguiz
         TGdOIMNMiGaAsKC2wdvogW/gEzvCsyH0tzZe+Xwy0xy/b0foWzcEtza8PH6KbDRedL5G
         0H6KMWsyv22oSR5ZYnOTt2Qp0OXxtV0NTDmDWaFwmoiEIwO+bRySW/8DoAD1vE8Ru7Br
         0UYfkc2Q51+dIAnInP4BIIH76BVyA4mWpWttIFX2xW6bw5IJm/tPCoMCHTC41d21TKbC
         YPYg==
X-Gm-Message-State: AOJu0Yz1Rf4QTpFnN9y5v+7IUvn2rjpgCH2sXe2Qy+QFE9nt533iYIye
        3+D+lfY3vYIckkq37ULUFgws5wV18H7Dl2KguzRQjqIaC3SZ2sDd/KuEOe4ptNxEucJQNQhq5Nb
        Gts09cwJyp7aO+n0c6ZNgQSJeIUVxgDQoGEAo/P9a6w2oovE8Y3H+Obp4rorBjrk=
X-Google-Smtp-Source: AGHT+IF2tbpuEPL6nNhTNlfT2pweZ5OvtOYJkg6OajHdkpdI1GARK2r8P8FISzMGQgin3oxt1xHZBPkY3eiLvQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:83ba:288:9608:d4be])
 (user=steadmon job=sendgmr) by 2002:a25:d809:0:b0:d12:d6e4:a08f with SMTP id
 p9-20020a25d809000000b00d12d6e4a08fmr187842ybg.6.1692827633341; Wed, 23 Aug
 2023 14:53:53 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:53:47 -0700
In-Reply-To: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <cover.1692827403.git.steadmon@google.com>
Subject: [PATCH v2 0/4] config-parse: create config parsing library
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll be taking over this series from Glen (thank you for the work so
far).

Here's what I see as the current open questions:
- Do we need a cleanup of return values in config.c? If so, does it need
  to be part of this series?
- Are we OK leaving the include machinery in config.c?
- If we expect non-Git-CLI projects to use config-parse as a library,
  should we provide alternative error-handling callbacks for (assumed)
  use cases, even if they won't be directly used in the Git project?
  (I lean to "No", but I want to make sure the option is considered.)
- Does this series need to include the config-parse.c:do_event()
  refactor Jonathan Tan mentioned in [1]?

[1]: https://lore.kernel.org/git/20230804213457.1174493-1-jonathantanmy@google.com/

Changes since v1.5:
- Dropped patch 1/5: config: return positive from git_config_parse_key()


Glen Choo (4):
  config: split out config_parse_options
  config: report config parse errors using cb
  config.c: accept config_parse_options in git_config_from_stdin
  config-parse: split library out of config.[c|h]

 Makefile           |   1 +
 builtin/config.c   |   4 +-
 bundle-uri.c       |   4 +-
 config-parse.c     | 561 ++++++++++++++++++++++++++++++++++++++
 config-parse.h     | 155 +++++++++++
 config.c           | 655 ++++-----------------------------------------
 config.h           | 134 +---------
 fsck.c             |   4 +-
 submodule-config.c |   9 +-
 9 files changed, 795 insertions(+), 732 deletions(-)
 create mode 100644 config-parse.c
 create mode 100644 config-parse.h

Range-diff against v1:
1:  9924481630 < -:  ---------- config: return positive from git_config_parse_key()
-:  ---------- > 1:  5c676fbac3 config: split out config_parse_options
-:  ---------- > 2:  cb92a1f2e3 config: report config parse errors using cb
-:  ---------- > 3:  e034d0780c config.c: accept config_parse_options in git_config_from_stdin
-:  ---------- > 4:  74c5dcd5a2 config-parse: split library out of config.[c|h]

base-commit: aa9166bcc0ba654fc21f198a30647ec087f733ed
-- 
2.42.0.rc1.204.g551eb34607-goog

