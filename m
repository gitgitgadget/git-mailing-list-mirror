Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC77C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJLJfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJLJfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DFD4D240
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h131-20020a1c2189000000b003c6c154d528so846004wmh.4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHBpt9SecOHHTeViI0YJnz4MzO19KKdL/aPF1VZPjoQ=;
        b=N0FQY/QR5rnLSfedt1ojf8Os9vmIQYvGA0iMoMb+uohgJ5joxd8SMkeZycfrr0O6if
         TZ5mzeu9It00B4rcqch7Dze2Cn83Qcd2OGLw5cMU9hzSGsFKOfEqWIV6w3ndbKEbyF5e
         bKEOEHBvgTcHGujAGllpRTeZ5P27i8Hx294P1b/O8zo25hDwX5wFMFiEqOCnVlB8IFjk
         Wum9F9x4LjIXctqSG4KwkH08VPFeMMBheB+KW/kfrfe1qnekhdXnkGhvW8oHRwOXCuVm
         s015i2FyQdrZa8YtQqSEcKOboC19nuVFsV0/QuXcu/V/CmUnzO0qtAgnNstM5D7qEnS4
         OdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHBpt9SecOHHTeViI0YJnz4MzO19KKdL/aPF1VZPjoQ=;
        b=0oatbgTmYhLD6xYVgQ0RTVwzUkwWnmRUFZq3g3IyPdGmTEeMJ9GktH8lguNSRntxuA
         BBpmORGQOhkS1OD1yDJU5PrcZRt2g3nyllRBuuiPedtIlQj5epAWtSStXt659JtVXIcd
         ZoqK32MMseiUxSh3AE3679cbO5mrKXjdj8LKRQCBoFUuqDgXpdwmk0vzrF/smbJxmXvo
         zdG779D9Ns3Sy8STIi+xLtR2NEJExV9lqeseE1BqTSaFYlXRYf9FRZUzA6huedXEz1Mo
         V0PMqV45buTa4qd8DpcBmxzqEenvwoDoRUZvUXeV7o+V6davOS0SXTsuhXeyKeM2MnET
         8Jdw==
X-Gm-Message-State: ACrzQf2yBpvWNpcc3DStpksVAL9cMd0MeH4flttyf2n/VP9oeOAxtl5w
        jr4v+MtVdvUUcpfGTKVc6XEoKpqyQdw=
X-Google-Smtp-Source: AMsMyM6S+cDqtB7QUtZKhMUEoZVRW7NhODSpPa1rt3RfHn/Xp729Q5ZPi3/og0Ej5NkfIEwfNQZq1w==
X-Received: by 2002:a05:600c:6885:b0:3bd:d782:623c with SMTP id fn5-20020a05600c688500b003bdd782623cmr2048639wmb.102.1665567319057;
        Wed, 12 Oct 2022 02:35:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j26-20020adfd21a000000b0022cc0a2cbecsm13165096wrh.15.2022.10.12.02.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:18 -0700 (PDT)
Message-Id: <1094681eb115edd5a40b85790179b6d44a0fc521.1665567312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:09 +0000
Subject: [PATCH v3 5/8] rebase --apply: respect GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog messages when finishing a rebase hard code "rebase" rather
than using GIT_REFLOG_ACTION.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 7 ++++---
 t/t3406-rebase-message.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9a40a5e27f8..f7b00efeb92 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -582,10 +582,11 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
-		    opts->head_name);
+	strbuf_addf(&head_reflog, "%s finished: returning to %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 8aa6a79acc1..bb2a4949abc 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 write_reflog_expect () {
 	if test $mode = --apply
 	then
-		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
+		sed 's/(finish)/finished/; s/ ([^)]*)//'
 	else
 		cat
 	fi >expect
-- 
gitgitgadget

