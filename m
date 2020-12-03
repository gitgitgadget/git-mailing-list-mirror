Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D180FC4361B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4568F207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgLCQAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLCQAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:00:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F03C061A51
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:59:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so2379670wrv.6
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dohBzSFAS3V0UqyWnavlqodY9/BGVTVKfvhO5Ex+GPc=;
        b=PQamqpsIdOpEjYujOq0KgUXUn7c1Lw4OkkAyOdMrra5sMl0ETPCjc6Y8LgGFwnpf+p
         UFevUOPGyQz0IhqDfqEUmWV5IiyrsdjKd4Dzbn2t5oLEFoLFPd3ji/3PieNigWrVtl9a
         FaiWmWSGpNbzxj6HgasJTeGAFmRmUkdPnZjC7RHTKgCI0hODlh7GJTGOR5OQWP16zrnO
         1wbOCU9TXUwOSbdYE91xQ0a9wy6R6Hyx+U8m3GR4eIF84pTpRg9MB8Gj3d/07dbYtxwz
         HOQM/HIem5CgllD8T8YH6o0kBeCrfLTZVog0XHN7a8ZGz6hq0PY36Gi3i3vpxuJMOKC0
         ZapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dohBzSFAS3V0UqyWnavlqodY9/BGVTVKfvhO5Ex+GPc=;
        b=XX/yhelu8d3A6cDBXS/3ShMKPhxreFajkqYlOO+hA5/vtB5E5AFH23fUg0adAxptP+
         tY+Q81wEXS0xWZNs/vm55DPFKqivu907iXaFTrfnvddN/5Vc1jE9W5MD1sua4vc+duYM
         U96AbAW2wfYYE9APuAV4XLCdpQ6DALrLW6QjDPbloB7Ld8NL07qRQGUnhyRWM3kraB9c
         Xfw8fmpTvps8HrBGxLKk/ACJfr6DOG69/NmSh5btfvlj9z98WT78y6h4Nhujahm9wQkR
         86BwIxtYku3S+XHcJH/d9/WTqMDDMxHsQ5sVE/3PWG7KTLBSIg6l5A57VpQX5tICvCBP
         R9OA==
X-Gm-Message-State: AOAM531LsOLZyh6IfZZeIlz3rcQwdQDWzBY+QfyEwBWWjs4svgiXxBO8
        FwDXuBEGlsVzfj5qdpQRkeFBYTG2oTU=
X-Google-Smtp-Source: ABdhPJx8hsneLa0sPT4cy+DR3Ke+lM2K6UtCaX9BHlkCBbLLDXTrNm7COiVsjXe+VmGPZo11VVwCSw==
X-Received: by 2002:a5d:6805:: with SMTP id w5mr4641741wru.266.1607011188526;
        Thu, 03 Dec 2020 07:59:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm1979899wmi.36.2020.12.03.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:59:47 -0800 (PST)
Message-Id: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 15:59:39 +0000
Subject: [PATCH 0/7] merge-ort: some groundwork for further implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on en/merge-ort-impl. This series sets up three future
patch series (to add recursive merges, three-way content merging, and rename
detection) for the merge-ort implementation, and allows the future series to
be submitted, reviewed, and merged in any order. Since those three things
actually do have some minor dependencies between them, this preparatory
series is needed to make a few small changes to set things up to allow them
to be submitted independently. 

The first six patches are trivial. They should be easy to review, and as a
bonus you get to find how I mess up even the trivial stuff. ;-) The final
patch is more substantive and represents one of the big changes between
merge-recursive and merge-ort -- namely, how notice/warning/conflict
messages are reported to the user (I possibly should have included it in
merge-ort-impl, but that series seemed so long already...).

Elijah Newren (7):
  merge-ort: add a few includes
  merge-ort: add a clear_internal_opts helper
  merge-ort: add a path_conflict field to merge_options_internal
  merge-ort: add a paths_to_free field to merge_options_internal
  merge-ort: add function grouping comments
  merge-ort: add die-not-implemented stub handle_content_merge()
    function
  merge-ort: add modify/delete handling and delayed output processing

 merge-ort.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 191 insertions(+), 19 deletions(-)


base-commit: 00de8a7763e29fb8a034030afbd0fbfc4c818e07
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-803%2Fnewren%2Fort-common-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-803/newren/ort-common-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/803
-- 
gitgitgadget
