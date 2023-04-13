Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2335EC77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 23:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDMXbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 19:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMXbm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 19:31:42 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2DF2709
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:41 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54bfa5e698eso467063197b3.13
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681428701; x=1684020701;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryJ1csEzuTb2kEFQzlB99JgBkd801ntADmnteTwGD20=;
        b=rS8yFWOknTxFfccRqqjIY8nGxei8ZeZ54vkqm3SI3z4JI4av+kbNVHMLvVY1o4pw9G
         qp3gO6rd8Lz0NDsZdMxWtCHKyUNffbFQuDDwkQuBDVF3HKvSAh+tUGb2dKb26Ji/3UhB
         ki7mH34rkJV6PEZGMVCSpXubwnetGMCncKQf/TgwNQJAuhSYpepUJKXdY8WiRhkQsJVU
         bn7Hfsn6TTgUTc5c30mquGA3vIJODcVK2Tl7Q0BojLrUaABo9Zmt9XqwT13ELkvPImDk
         5drQCsQ8qcMe1ZM7dtCoiavXQkpjCJkbLt0koMhOX0ySUxI5t5oJCe4yq8OhsTQ+UWlY
         1nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681428701; x=1684020701;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryJ1csEzuTb2kEFQzlB99JgBkd801ntADmnteTwGD20=;
        b=HOjlvGun6zDYtweNGYiPyGw6dKumhe9sLxPm73HpwGR26xTeC9vb918OAYvbIibZUI
         0HnRNm9qtMyktZDkIn8f620hl+j7bJrdN/Qn5f4x0AxKC3qj2dBN1m/rf/OWuJHGb7yj
         5Xu4sBhP2NFDiJMUqRqQrgGwvbuWi+8O+Iq81Hk3lCeZ43JU6FPIDsGJRnVZSIT5rVFm
         QwIYEn3kxHU+hu2TYqeGPswWaooieTPcFMBS4mmNhraRh6VPpRinXYmV9HPHo1Gyqzci
         vO2RsnwOg/41nzXJ+S9LUT62vmuzSrjcz5EYNHkvD7PT9fn7uGqwdruTZeINe/ZJijoH
         OIiA==
X-Gm-Message-State: AAQBX9e77kjlyR3vbOG/AeFMHLid7PXMhHj0j0f69Jqoc6otIfUZWgkQ
        96pN0ZZcWFzN8Pc4UicLuKhu3tk9PHJpbkLb9VSoWw==
X-Google-Smtp-Source: AKy350aQLZFVHNmDBwwQl07UC/RoG4B+Sr/KW0HCftYoPmINL0FIk/t6u49N2ctiZcMJd7FCEYCV4Q==
X-Received: by 2002:a0d:e68b:0:b0:4fb:8b40:5899 with SMTP id p133-20020a0de68b000000b004fb8b405899mr3633076ywe.7.1681428700722;
        Thu, 13 Apr 2023 16:31:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dc6-20020a05690c0f0600b0054601bc6ce2sm801998ywb.118.2023.04.13.16.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:31:40 -0700 (PDT)
Date:   Thu, 13 Apr 2023 19:31:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] banned: mark `strok()`, `strtok_r()` as banned
Message-ID: <cover.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds `strtok()`, and its reentrant variant to the list of
banned functions.

The rationale is described in the final patch, but the gist is that even
though `strtok_r()` is thread-safe, it imposes a burden on the caller
and has confusing dataflow. For more details, the final patch has a full
explanation.

The series is structured as follows:

  - The first patch introduces `string_list_split_in_place_multi()`,
    which allows us to split token delimited strings in place where
    the set of accepted tokens is more than a single character.

  - The next three patches replace the only in-tree uses of strtok() we
    have, which are all in test helpers.

  - The final patch marks the two functions as banned.

Thanks in advance for your review!

Taylor Blau (5):
  string-list: introduce `string_list_split_in_place_multi()`
  t/helper/test-hashmap.c: avoid using `strtok()`
  t/helper/test-oidmap.c: avoid using `strtok()`
  t/helper/test-json-writer.c: avoid using `strtok()`
  banned.h: mark `strtok()`, `strtok_r()` as banned

 banned.h                    |  6 +++
 string-list.c               | 15 ++++++--
 string-list.h               |  6 +++
 t/helper/test-hashmap.c     | 30 +++++++++++----
 t/helper/test-json-writer.c | 76 +++++++++++++++++++++++--------------
 t/helper/test-oidmap.c      | 20 +++++++---
 6 files changed, 109 insertions(+), 44 deletions(-)

-- 
2.38.0.16.g393fd4c6db
