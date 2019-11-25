Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDAC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 04:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B423A20815
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 04:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGjpiiSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKYEPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 23:15:47 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40701 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKYEPr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 23:15:47 -0500
Received: by mail-wr1-f52.google.com with SMTP id 4so12849284wro.7
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 20:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YOEO4oTQFYQpWybZs6kHey8Bp4WfzRjrIigtLlUfRFA=;
        b=CGjpiiSinmA/9D1mk0JpGmofOwVCF4HDuIU98n1iqxWshvCPFSjn85G+I5q8t2Pu78
         esHQFxOVJ//KWJchhDSdWAzGJ9pEtBGaWd3sYkMyCTXIM6f8ROuyZoUrEJw5K8eGoYPY
         /rC9hNqRXWRQASHCVXIv8T+fg5fkX9MvW2NqEkDVbDc0phLwTNpDU2EwK8kRtWiWM883
         qdCSZ+7kKxmLoXwi0JU+xUbe2xqnqUZH1bWypr/l+JJCSESQdOyy1DqhDAKbYm3muvqP
         lrbfd65ibNWN9dFAahmHXadQ+zriE4xu+QkvfuH9vyAO2UrS1WuP9qr5+a7RB+lYNcS+
         YA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YOEO4oTQFYQpWybZs6kHey8Bp4WfzRjrIigtLlUfRFA=;
        b=KEoOlkjva7J1048r9JFYKSiEQD8QOPpR5aLtSGgk/Kkz/70r/W7qDx2wwo0sAErQCM
         UJEEHPAJkTUH4D4TYIcq/PHwXOfXxv3GB/ErbQ7xLFf7FovekPzobidqsFk4GYU1pZAD
         PDi8mjXq7OheUS9jbdwhp/9EXrCCOT2s3IR1IKvUORTmvIQ4wd7luifJhlN4yvfpCFiX
         5Jn4zKUJGERpqGyOR7+jGCX0ep9NBALusI0Me3nt4ocLuLltNF+7OVLk2nvhP6QHlFFr
         koD5dSJt375FghBZEHpOWLw1zA9Fh2ucgi3kD6bxWXQTroQPC/HHqcJ8hRA0pjiUzXR6
         4WXw==
X-Gm-Message-State: APjAAAVgoucSPTPt84wR2KpCimRa3gCryIXHPTCjSlM39N8peS2yzS8J
        WM95SJyLSOJr3idzoBrdbYfoIwTr
X-Google-Smtp-Source: APXvYqwmNPYMj3uxeE2+47lcaB+3dbBYlypwNTYPccYIMW9JiBbj/rl6DbMkRr0/eT8pWXBL58jOGA==
X-Received: by 2002:a5d:570a:: with SMTP id a10mr28610527wrv.107.1574655345151;
        Sun, 24 Nov 2019 20:15:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm6845566wmi.9.2019.11.24.20.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 20:15:44 -0800 (PST)
Message-Id: <pull.472.v3.git.1574655344.gitgitgadget@gmail.com>
In-Reply-To: <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
References: <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 04:15:43 +0000
Subject: [PATCH v3 0/1] submodule: Fix 'submodule status' when called from a subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Manish Goregaokar <manishsmail@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated with an improved test.

Manish Goregaokar (1):
  submodule: fix 'submodule status' when called from a subdirectory

 builtin/submodule--helper.c |  3 ++-
 t/t7400-submodule-basic.sh  | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-472%2FManishearth%2Fsubdir-status-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-472/Manishearth/subdir-status-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/472

Range-diff vs v2:

 1:  e4c932bd09 ! 1:  8dcea6b399 submodule: fix 'submodule status' when called from a subdirectory
     @@ -41,18 +41,21 @@
      +	test_when_finished "rmdir addtest/subdir" &&
      +	(
      +		cd addtest &&
     -+		git status > /tmp/foo &&
     -+		git submodule status | awk "{print \$1}" >expected &&
      +		mkdir subdir &&
     ++		git submodule status >output &&
     ++		awk "{print \$1}" <output >expect &&
      +		cd subdir &&
     -+		git submodule status | awk "{print \$1}" >../actual &&
     -+		test_cmp ../expected ../actual &&
     -+		git -C ../submod checkout @^ &&
     -+		git submodule status | awk "{print \$1}" >../actual2 &&
     ++		git submodule status >../output &&
     ++		awk "{print \$1}" <../output >../actual &&
     ++		test_cmp ../expect ../actual &&
     ++		git -C ../submod checkout HEAD^ &&
     ++		git submodule status >../output &&
     ++		awk "{print \$1}" <../output >../actual2 &&
      +		cd .. &&
     -+		git submodule status | awk "{print \$1}" >expected2 &&
     -+		test_cmp actual2 expected2 &&
     -+		test_must_fail test_cmp actual actual2
     ++		git submodule status >output &&
     ++		awk "{print \$1}" <output >expect2 &&
     ++		test_cmp actual2 expect2 &&
     ++		! test_cmp actual actual2
      +	)
      +'
      +

-- 
gitgitgadget
