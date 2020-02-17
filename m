Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47486C7619D
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7362067D
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clnb0Rj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgBQIlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39501 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQIlU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so17425351wme.4
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVPYOpfGA3DoPKAt7s4uzGZlEU1bEK8dMXd6CagqkN8=;
        b=clnb0Rj86Xwc2c8Yi3m2Gsi1RF/GrTfEz7KB1BW8bAre7RQE82qBoHp2UTpGsPiG14
         NpF6BiIfx2joBG9BD7WQPlvuc3kFaNU7rY5ple+ESZE9Mw8tNH70eHU5bUvRvjaqjREP
         7HslCirZwhPpODqL1PMmQh0456JDrNo8T4HWnB7xROz+K86xUrMgaCe+vawfAQsMhpYj
         coaW2mqKih/EQf4AwZgZ91zt+0Kd/8va0FaEn3151vXF6JqWKIM7jI1YrdDQTfkcod9N
         ElmY+wGOoXVXFviz7qEXutat/+FHZN+esMhjbhiBm1YbHMjeuS40sMQn/0SpL1xxBfKz
         qhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVPYOpfGA3DoPKAt7s4uzGZlEU1bEK8dMXd6CagqkN8=;
        b=l4ODzLrIayZRyznCuaFv5JlHUtPZUOxUGqNCPG0i/OknBGbNOQnexUZTssvYCucU06
         XAiRXNZ+ispq9XHuP/RZPde4pSkQ1n3z6dLmNotiAvTNSsYgHNgeLiaJC9SkL/T2GaqU
         YyLHxzPKoN4LeG5/VVcfajeA0gQ3uReuTamsxkkAMYruk+kcSILirn72l3a33Q4g6hYZ
         YLXFvYz3opa4osbANyQeERIxDAQJyW91lcf5FphQROBw4Kkq1Lrafmz8iXoS+X+7DVsz
         92RtcXRe+I2gzyDDMuqtsiEwOVYtPv2XktrxB26bpJfU+krjag7MckMuabrjp7XEBTRT
         vs1Q==
X-Gm-Message-State: APjAAAUsvGnQkf0err/uLNsMvo3yWFPp4cmKXWuuDL7pd93ghrZJ8ZoJ
        qNQfV+L9CEr2mtT7imXYWK8RvB8v
X-Google-Smtp-Source: APXvYqwMahwO1mRsN9Zch6Zqs/iOeZWcH8tGkR+s95u8PkUgXF7JfYFEh89bH4o83UeUCPaB9eCbNw==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr21263136wmf.93.1581928878234;
        Mon, 17 Feb 2020 00:41:18 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:17 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH v4 00/12] Finish converting git bisect to C part 1
Date:   Mon, 17 Feb 2020 09:40:27 +0100
Message-Id: <20200217084039.78215-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a first part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This first part is formed of preparatory/clean-up patches and all 
`bisect.c` libification work. 

I would like to thank René Scharfe and Taylor Blau for their
suggestions.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part1-v4

--- Changes since v3 Finish converting git bisect to C part 1 patch series ---

General changes
---------------

* Removed `run-command: make exists_in_PATH() non-static` patch of this
part 1 patch series.

Miriam Rubio (3):
  bisect--helper: convert `vocab_*` char pointers to char arrays
  bisect: use the standard 'if (!var)' way to check for 0
  bisect: add enum to represent bisect returning codes

Pranit Bauva (7):
  bisect--helper: return error codes from `cmd_bisect__helper()`
  bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and
    its dependents
  bisect: libify `bisect_checkout`
  bisect: libify `check_merge_bases` and its dependents
  bisect: libify `check_good_are_ancestors_of_bad` and its dependents
  bisect: libify `handle_bad_merge_base` and its dependents
  bisect: libify `bisect_next_all`

Tanushree Tumane (2):
  bisect--helper: change `retval` to `res`
  bisect--helper: introduce new `decide_next()` function

 bisect.c                 | 135 +++++++++++++++++++++++++++------------
 bisect.h                 |  29 ++++++++-
 builtin/bisect--helper.c | 123 +++++++++++++++++++----------------
 3 files changed, 189 insertions(+), 98 deletions(-)

-- 
2.25.0

