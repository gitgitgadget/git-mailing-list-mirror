Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F7E1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeIED3O (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:14 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:35248 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED3O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:14 -0400
Received: by mail-qk1-f202.google.com with SMTP id t9-v6so3720056qkl.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xS7aAOlrwJ9ECXZIS8vz2GmOFu/aDpIajDvBV0AVV4g=;
        b=ZX+RTtXzSa+2DaEFDapym6n4TVwIyR65Qc+TO/2VG+o4Et6tCTo7+pjE06Lp/ZhKsy
         H1Xz8EU7DZ5pY7nQKTEgzoO4qcbvJA+9y8DzeyadewTj4DxldvrI7uPsYnEH4S5V9IhC
         rZKTD780ICuaa1uZGYFG7Dtazrr0kPpYyl36Ey2i5KoKqtk6RAMSIqaS8bE/6dsKLGD2
         HOOS7vQrHVxlBz7cseQ3AMavE1/3PnG3YvSGB98fodOhMxF3H2yaT4Ujc1OK1RpKYONC
         S+wH3C4E860nm5BDCFy0ap5+f8E3JLpB4241fBMKjUfh3/85icVsHKm1eSksYn20B4ML
         +7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xS7aAOlrwJ9ECXZIS8vz2GmOFu/aDpIajDvBV0AVV4g=;
        b=Hc9y+z4RgL2UGe3YX3n1bD2SOaeAv7ie990i1Kd/UR0DLZiE34rY0cZo2WZo7JwOJX
         Y3iMqWBVC+GDV5IaCQ8x5zRW5rsjiTVsYI2gExoh4pyFTuUps/2J6MSchRjzBapuarkR
         DgX49pF0L6rnbiZCob3s/dhiK0DZD4P0YFbpCPboth4YHRU0zaKqxLFp2wyeXaAfT6Cz
         Dj+6TzL+wgbmYTM+aF6Bg7XgF3G84FX9YFE0iPmOEXw74KqLTn9ScTEolVv5qdxfMWxZ
         4uwWgVoepiHK0MIH4q1ymdmNNOxgwJNXxH17VSkgjpiB85cVGnZ6u4P0o72NX1XpaB7K
         svUA==
X-Gm-Message-State: APzg51AReSwO055NXuAdWa0LFiY4c2jP9fqqN4DdtWT3N6EFHPEOFr6Z
        ARkEdlo5eN6uW/xaDiU51HeB/OmAtiIK2O23PGIM9qTEB0Rwase5lzWHI9e8IcL2x3gctpXAPjd
        GZZl2NGRdXdu5bZRsX3enE6fw2OmdZP/A8wS6hJgRCoZBchOQwRg+lsvypwVB
X-Google-Smtp-Source: ANB0VdbNggMa4kHgjLuYo2lHegofSjV/ZwLmEhnwx9X18MUQzIzUxVTSa67TmNX2M8kh40T0nH8fLXI9AdrC
X-Received: by 2002:a0c:d4ba:: with SMTP id u55-v6mr18544734qvh.5.1536102117277;
 Tue, 04 Sep 2018 16:01:57 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:38 -0700
Message-Id: <20180904230149.180332-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 00/11] fetch: make sure submodule oids are fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend of [1] and was rebased to origin/master and all review comments
have been addressed.

Thanks,
Stefan

[1] https://public-inbox.org/git/20180808221752.195419-1-sbeller@google.com/

Stefan Beller (11):
  string_list: print_string_list to use trace_printf
  string-list.h: add string_list_{pop, last} functions
  sha1-array: provide oid_array_filter
  submodule.c: convert submodule_move_head new argument to object id
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule: move global changed_submodule_names into fetch submodule
    struct
  submodule.c: do not copy around submodule list
  submodule: fetch in submodules git directory instead of in worktree
  fetch: retry fetching submodules if sha1 were not fetched
  builtin/fetch: check for submodule updates for non branch fetches

 builtin/fetch.c             |  14 +--
 entry.c                     |   6 +-
 sha1-array.c                |  18 ++++
 sha1-array.h                |   5 +
 string-list.c               |  20 +++-
 string-list.h               |  15 ++-
 submodule.c                 | 200 ++++++++++++++++++++++++++++--------
 submodule.h                 |   2 +-
 t/t5526-fetch-submodules.sh |  23 ++++-
 unpack-trees.c              |  13 +--
 10 files changed, 246 insertions(+), 70 deletions(-)

-- 
2.19.0.rc1.350.ge57e33dbd1-goog

