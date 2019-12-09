Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D5EC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBA220637
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmcmzYRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLIUrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:47:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52614 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIUrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:47:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so815479wmc.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EAx3crMgQ1AToqU+KuMPHqZBnV7nxJn/qZTgDLIQvr0=;
        b=SmcmzYRtvs+o0tNlXIcjg7jWK6IFwUGzIMuT52Ym2mjoYgYCqkzzaiJFyGDwRrkQsQ
         feVbp0pb3lqtTC1sxExd816GIRyq0V9bZPtSby6jgihxkBmUM3xIlncS1VWW28YM0bP/
         NUyEjHq/NzlJo4O/dVWBfuzdJt+UEEQtt6M2O1NERKfVGYXZNfGgtgYYMadNfc3ZAde3
         ImRObXeWOAdkzKWluKa161NMBA36Wc7cEK+VI4c0GzmJ861Nw9WGw0r+eDTHIbpt/CDI
         h950W/kKvpOpEUJzWhNcE7XIiIqEh8KpAtUiZJ3bZvYmZf4LhnNxXFOnx7QlZjQpV6Vk
         aHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EAx3crMgQ1AToqU+KuMPHqZBnV7nxJn/qZTgDLIQvr0=;
        b=jOx3C1hkX2BpQDnxQejm1Gx6Bgc1duADpMCzUj6Wr62AtlThF+5xM6YzXieEO9LA1V
         Pmm0Hm7eosqHwI0ZM2+UzzPeVWchzvZCiCvC/N2vVmNJV92ZYdvF85RZcQX+vc2owhlE
         BJTA0VQcj3kD8HoEJwoJrSnCy7LJPSF/1XcWzTj1eCPyP9SNeqm5jk+8p2+uYlplyevp
         in3xWWrSa9s9aDXFc2yR4ahoA49kp6LunWUQoA2V0Hc6DgyYuI0LFlf9jIegh+lzmz54
         jvekSyi18Flg16VNBU0O2rJcnj6AbXiftddtotQ/We35uKD78VL/XJnbz0DQu9p0Vaq9
         4Gog==
X-Gm-Message-State: APjAAAVyvxZd8tSNOBTTwRC/bb9z9/dDUkJo/v6gavwGeTM29PvEayI3
        koshEa4rjNo9HM191WJCnCoeKpwk
X-Google-Smtp-Source: APXvYqx25NbAjZTaiz1pThCWC+JJkCnJ/tC7GW8e9tsPf+BJvn/5e3NizvrXiCaL895GGrBsjjG49Q==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr1034434wmg.38.1575924467038;
        Mon, 09 Dec 2019 12:47:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm588483wmf.29.2019.12.09.12.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:47:46 -0800 (PST)
Message-Id: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 20:47:37 +0000
Subject: [PATCH 0/8] Directory traversal bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes multiple fill_directory() bugs, one of them new to 2.24.0
coming from en/clean-nested-with-ignored-topic, the rest having been around
in versions of git going back up to a decade. There is also one testcase it
documents but does not fix; I tracked the code for that testcase far enough
to determine that fill_directory() and its callees were not at fault; rather
post-fill_directory() processing done by ls-files eventually calls
git_fnmatch() and it incorrectly filters out one of the returned paths. I
suspect there's a whole can of wildmatch() worms to be found following that
thread, so I just opted to document my findings next to that testcase.

See https://lore.kernel.org/git/87fti15agv.fsf@kyleam.com/ for the report
spawning this series.

Some comments about notable items in this series:

 * Patch 2: Revert a previous patch which fixed status --ignore behavior
   incorrectly and which complicates code that we will need to significantly
   restructure in order to fix all the issues we want to address (patches 6
   & 7 provide the right fix)
 * Patch 4: a fix to my en/clean-nested-with-ignored-topic, fixing the new
   bugs
 * Patches 6&7: the fixes to the old issues (Other patches were adding
   testcases, code cleanups, comment cleanups, etc.)

CC: blees@dcon.de, gitster@pobox.com, kyle@kyleam.com, sxlijin@gmail.com

Elijah Newren (8):
  t3011: demonstrate directory traversal failures
  Revert "dir.c: make 'git-status --ignored' work within leading
    directories"
  dir: remove stray quote character in comment
  dir: exit before wildcard fall-through if there is no wildcard
  dir: break part of read_directory_recursive() out for reuse
  dir: fix checks on common prefix directory
  dir: synchronize treat_leading_path() and read_directory_recursive()
  dir: consolidate similar code in treat_directory()

 dir.c                                         | 174 +++++++++++-----
 ...common-prefixes-and-directory-traversal.sh | 193 ++++++++++++++++++
 t/t7061-wtstatus-ignore.sh                    |   7 +-
 3 files changed, 323 insertions(+), 51 deletions(-)
 create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-676%2Fnewren%2Fls-files-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-676/newren/ls-files-bug-v1
Pull-Request: https://github.com/git/git/pull/676
-- 
gitgitgadget
