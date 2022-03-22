Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1CC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiCVSDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiCVSCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907C66C94
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so3814468wmj.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MEG3piFdmt+jIkWUnne4CEZ7uXu+O+UAM85s3uqrVgA=;
        b=KkW0iUPSuY/h5AnXah7VfypN/JY2LN7P3qoECb+2WexPNH/3+5g0v42wzgRmN5kPK9
         c9AZmqXwf1oDudmyfuzDYYuXlxNqkfH4nJKWmMESNmr5zLSi5qSkGV93z/KvbabO/MkD
         nf0/FTx9SWYFCRbCbJvgIKlDHNNdrhaJQHH+Vy8fzHYzYoxia8FFXLXzPYQFyJbHpx6x
         61OAjYMd4zJ6VovTHvST5uVCA3rqW7Krhrx6yk3Phibqs1DBY2l7JFDxPF6DbxSb8uop
         wXVRhRTouGgEX4wQF9AFyDzJptA4EtJHOH8WuDpeTGOLgP4anC1/jHpjmhiUty7dFmZS
         OakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MEG3piFdmt+jIkWUnne4CEZ7uXu+O+UAM85s3uqrVgA=;
        b=kN3lZeUCSOmunpzzQlMuVPAYNHcxDBcTae3j+Wptpsg6fiOLUc3kPX7pscYAMQ0FX3
         /8M/7YyCeCV9ztOI8Kc/ZkHJ7rJ/voFk0LFxYogPK4kbzgCkykhZ3e+BFUYIRaSIyzit
         S0qWBsxdg/Cc9fhxBNij6ab5hccfYGrpANA5R6KG7br7XacBiVPc06g3RQ3kw0mF3OVL
         rDE0bf7hRLVK48BT/9vQ93HhaJ1pX2KBaQyn0CJxHmZCmmjvEV7DBfVF2W1cWPdfr2QN
         4MY6xEFADD//JQ6LDO37vHwgc/iCIwm7LKK+UQUQ98Mn6Ij66nRSta/ZEdPv25sfpLgn
         3NsQ==
X-Gm-Message-State: AOAM530mcomBK19wTlA7IWci1SN0gWLsbS7hvVHvwjptkPIPkUDgBIkK
        b7wyjD7/Bypd1yXYRqU29fi3WlsRRUY=
X-Google-Smtp-Source: ABdhPJzFMI68c6YAsB5vNDXVmX7bCMLhRFynE7LZTd4TpFeUgA3yfOGehhPGF+6P2ozJMtY7NgtKNg==
X-Received: by 2002:a05:600c:190e:b0:38c:b1ea:f4ac with SMTP id j14-20020a05600c190e00b0038cb1eaf4acmr5066441wmq.70.1647972049536;
        Tue, 22 Mar 2022 11:00:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm15877172wrm.82.2022.03.22.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:48 -0700 (PDT)
Message-Id: <c925a9a7459a0642180282b41b210defe934e38f.1647972011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:00:03 +0000
Subject: [PATCH v7 22/29] t/perf: avoid copying builtin fsmonitor files into
 test repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Do not copy any of the various fsmonitor--daemon files from the .git
directory of the (GIT_PREF_REPO or GIT_PERF_LARGE_REPO) source repo
into the test's trash directory.

When perf tests start, they copy the contents of the source repo into
the test's trash directory.  If fsmonitor is running in the source repo,
there may be control files, such as the IPC socket and/or fsmonitor
cookie files.  These should not be copied into the test repo.

Unix domain sockets cannot be copied in the manner used by the test
setup, so if present, the test setup fails.

Cookie files are harmless, but we should avoid them.

The builtin fsmonitor keeps all such control files/sockets in
.git/fsmonitor--daemon*, so it is simple to exclude them.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 407252bac70..932105cd12c 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -78,7 +78,7 @@ test_perf_copy_repo_contents () {
 	for stuff in "$1"/*
 	do
 		case "$stuff" in
-		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees)
+		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees|*/fsmonitor--daemon*)
 			;;
 		*)
 			cp -R "$stuff" "$repo/.git/" || exit 1
-- 
gitgitgadget

