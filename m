Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948A31F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeJKFOR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:14:17 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:49742 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:14:16 -0400
Received: by mail-io1-f73.google.com with SMTP id k9-v6so5936099iob.16
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SSWU8JIO5zVEtT0irrT6kLsYafvZPj1GZu9a1fHhw1A=;
        b=mK1jC4gCP3tYBpA9lNhDsPpDXwoaC2ZwkFujZkzF2tnXIP5DajgljzqpdBzZrFCDAy
         FiOB7zSYvA8Ve3/U2Fyq+eAN/Az+ZzHoSF38W2L6WPWW+cZ+Bx36ZyaJvXeuLiXTSfyz
         iu2QFlB/DaftVKPYZlpwS1IzOASl5bRDXX1m5cTeX645KmbVdEZbkytjKEkyjZBzHIH+
         TM7cxSh5gvdQeSDTcATeDBNeuyz2mS3G+UDL/56x4YwLJ2c0K+hvl1cOv9B+sMF0oZpJ
         z5rbhVvxsK3o5fM13KEq2aobjKT2tdVFmn1GOqrHJeiYTarZmzMfA8vzTk3Dml/UxTjz
         beEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SSWU8JIO5zVEtT0irrT6kLsYafvZPj1GZu9a1fHhw1A=;
        b=HimgqtGJ9AvmZYSb6Kb9t/hKD3DDc4qWDk8R/don2n4b7sVyBJvBcd0oWsYTqMblTc
         6tvkqhreAK9GL1e06kk8eUnD71PnL59MoV+rzjCVDWX9RKpfobCrNSA1lUHT/vgmt/uv
         H5cU2ijYdmvDU8JvcXkojsWQBzNg4VsEZd1JQNHlS3/x5uEZrblZTh7ubleFmjIY4i+v
         WPkjfaiQ9HDUNSGXb2hSthzYp/3af+QJl3lgpIdwLK6KWRkcAYAQtW9fJkgmOOdZE1rr
         iHg49Hs/PUdlWm/wNI7jYA4JVqAH18Bwg7/zC11s7ALs3i1cxQdllZsbyIFH3/9f0RFz
         AFJA==
X-Gm-Message-State: ABuFfogb4JvroS4jzvD4B4NiqnPmOYB/mHHzUPXAyf5XstYFYNcVqqh/
        uV7Xfsx+niovmzJBcnr8HEhrTPB3Hx/PQq1zShJ5JkQHGRVhN+HUlv0H47sukDXG1g9CmwNZxbA
        SlueAULNHNlzbGearaClr5gxhUfUX10WEc4+XzrhXXXTis9Rn2He8rQ578uEM
X-Google-Smtp-Source: ACcGV63rj8t9WPCjMxmdHyu8MQIXKqW4k6T48mEA30VVz89+QGvt+wLZyOjFojxyXjYN3EwJ91vfwbU1yHGw
X-Received: by 2002:a24:dd45:: with SMTP id t66-v6mr2277248itf.5.1539208211265;
 Wed, 10 Oct 2018 14:50:11 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:49:59 -0700
Message-Id: <20181010215008.233529-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 0/9] fetch: make sure submodule oids are fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is nearly the same as sent in [1], with one commit message fixed.
[1] https://public-inbox.org/git/20180925194755.105578-1-sbeller@google.com/
and replaces sb/submodule-recursive-fetch-gets-the-tip.

Thanks,
Stefan

Stefan Beller (9):
  sha1-array: provide oid_array_filter
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule.c: move global changed_submodule_names into fetch submodule
    struct
  submodule.c: do not copy around submodule list
  repository: repo_submodule_init to take a submodule struct
  submodule: fetch in submodules git directory instead of in worktree
  fetch: retry fetching submodules if needed objects were not fetched
  builtin/fetch: check for submodule updates for non branch fetches

 Documentation/technical/api-oid-array.txt |   5 +
 builtin/fetch.c                           |  14 +-
 builtin/grep.c                            |  17 +-
 builtin/ls-files.c                        |  12 +-
 builtin/submodule--helper.c               |   2 +-
 repository.c                              |  27 +--
 repository.h                              |  11 +-
 sha1-array.c                              |  17 ++
 sha1-array.h                              |   3 +
 submodule.c                               | 275 +++++++++++++++++-----
 t/t5526-fetch-submodules.sh               |  23 +-
 11 files changed, 311 insertions(+), 95 deletions(-)

-- 
2.19.0

