Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA2C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714B62085B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYdfSsQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793169AbgJZTc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:32:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36482 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793155AbgJZTc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:32:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id x7so14083452wrl.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vMH5vwO5QL5SVQYyWMfmLGq3mbDWKi9TRC3hlzYGQik=;
        b=IYdfSsQRKwb4kud8fqaZCgnIuZc5KSBM/22hjjGtIYYkvdPVsS63o3m+hFzcRhxLA9
         Rhv93r01FXYJXjw5x515SLRaodRop8SiWRN6pjI0FmldNtc6XdgtRvhhRE+c9bF94IzN
         af9T6r/dq7wnFcfqE7TOturZKwTC1NtubvDEoXpw4DQhUm2EW9rGHm9crL5gBmCk96FR
         c2jh0XDEfhe87Bu9kywPaAXXHDvpEOXiAo/HVdLNbPfQGSzQTb28ghFXpE1294mgitQv
         FSvLVqb5gjNy3+A0gGO4zV+/NZaa4nQk44ixgRe8RxD/x/YdFeJosqVPtvSxE14F4zNi
         5iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vMH5vwO5QL5SVQYyWMfmLGq3mbDWKi9TRC3hlzYGQik=;
        b=n4C9tr4GlgHPf7NVRH8bLT2HakxLWAop52aqPI69TjXNTyJoAjvQyNgl5JEB6+Z2nD
         TXl/A+HqztLXhvtt/x2m+VAG27of2GgzDxseTE05IQH4YRVTmxmpAQdGIflto/95wMjU
         e3ZYz1BKgt/WLsyU2/Rkx4PBZb7nflqHPiFZbfCElqE4DkTJOsWD9Agx3AwA2KaN0nit
         fnzO4PVBoztVp+fMO7oT69kok7QwPFOU0A5tZ9XR9OKKwMbIdw4EPf2yOHUDBAmSYJ5+
         7505j+Qg/9XYvQWevn3TFoa7Acpmn8pAgcURXdLGgAa4dWxtVoiSz1vBdNi0MfXhWm/6
         s/MA==
X-Gm-Message-State: AOAM531h0+o1idD4w/oNmiLJLIzhpk2bMbqEk97TiAr5D6pGi3XrC5Ra
        9UUaQyc2Bkv1XopIBh696MpI+jStsSI=
X-Google-Smtp-Source: ABdhPJwBkUl2XvYCLtxygSsqn5U1QEfuJkKLAgqOPMFFmapyWBnvS+RmkKK6rnJK8+qCkdWAe+k09A==
X-Received: by 2002:adf:8b1a:: with SMTP id n26mr16876368wra.407.1603740774656;
        Mon, 26 Oct 2020 12:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm21462972wmh.9.2020.10.26.12.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:32:54 -0700 (PDT)
Message-Id: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:43 +0000
Subject: [PATCH 00/10] Update fsmonitor perf suite to support integration comparisons
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series builds upon nk/diff-files-vs-fsmonitor

This builds up to a comparison between our perl script and 
https://github.com/jgavris/rs-git-fsmonitor. Stats on the comparison are in
the final commit message. I've found that rs-git-fsmonitor saves 20-30ms off
of every git command compared to the perl script.

It may provide some motivation for supplying a faster implementation of
fsmonitor-watchman.

Nipunn Koorapati (10):
  t/perf/fsmonitor: separate one time repo initialization
  t/perf/fsmonitor: move watchman setup to one-time-repo-setup
  t/perf/fsmonitor: improve error message if typoing hook name
  t/perf/fsmonitor: factor description out for readability
  t/perf/fsmonitor: shorten DESC to basename
  t/perf/fsmonitor: silence initial git commit
  t/perf/fsmonitor: factor setup for fsmonitor into function
  t/perf/fsmonitor: initialize test with git reset
  t/perf/fsmonitor: perf comparison of multiple fsmonitor integrations
  t/perf/fsmonitor: add benchmark for dirty status

 t/perf/p7519-fsmonitor.sh | 94 ++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 31 deletions(-)


base-commit: 2bfa953e5daf3253cc5fae2de2c68fbd206dfe12
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-772%2Fnipunn1313%2Fnk%2Ffsmonitor-perf-suite-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-772/nipunn1313/nk/fsmonitor-perf-suite-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/772
-- 
gitgitgadget
