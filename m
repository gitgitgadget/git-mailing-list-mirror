Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E06C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 00:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbiCOAxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 20:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiCOAxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 20:53:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C0242A27
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 17:52:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso661154wms.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 17:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hl9V6NOozKHu5s6HXE6nP9mQzECbMmfT0nmth1LsAjo=;
        b=RVHo8wl/SOyTRW4F2iwmICU7mk8fh2tw6VFCN/X72x7rbB1X7ZJVV8CMkkPNrqn91X
         O6VFMuykIfI49ZSyVP7Fn/6sOuOcDASkLDLmruAcdIhcI6x8Zt9tw6VxVHWtCqMBidoI
         bnCYXvepuYmXj6+pfEjnRZi2dQcKD77RrNycKVNkGqPoZR48HAFeuCC66GzGhsOddmZ7
         9XiE0sQC1EP5XW/1kJVBpRSc0zhYrJBf1JOlU7fT/Mo6Bo9/WjMdwjgdKprrxIN8KW0B
         WuBb7t3hdoz6eSq/FVTj5xlLU1cFCR9ZRQOJAl1M2rGpSkr5zbKytEQml38PYdCkvjsb
         lAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hl9V6NOozKHu5s6HXE6nP9mQzECbMmfT0nmth1LsAjo=;
        b=K3DKOKm/vlhP7GQYPU6JEAx+SmHPoSWl3zhFkzBjGNZnIJHR6+re3ysEm29ZQiqOan
         niQwVEsXS+9YkG/gACYP4iek930eG6KXHsHoLI6PlWpw+o7uc7CL39KndjDagMZzgMw/
         mkRcnK4I7FtJDV0aaPWSeZRiWMj2/u67VQIlqYULu/jWmv42Sk9kdpyb11Dxtbp0ib/o
         l3HXUIAo1g+1JhiYeHvXR/gGc2IDpwdL2BhXes9w9o3xAM/lTkJQwLKp/qeObTXZwcDO
         +h6vWIfq30ejHb6giq6b9c0mgHyRUMc3OvwXxC3zGk208UNixeNhVUfGP/wzbZmSek5X
         4Myw==
X-Gm-Message-State: AOAM5300u/hN0bk5j3twU66iWU+sd2gijmL1MaCuXHM5Y6Twv1a7Gh9D
        wvKfij6ruxbSoYD5x9JuPmNmTsV4UwA=
X-Google-Smtp-Source: ABdhPJygSAxD+EF84oNnA/AmsOjZO0dOwY6YPEGinRqn58F9hsBTzFswcZV0M7n2vAJrLzOr0jV40w==
X-Received: by 2002:a7b:ce83:0:b0:37b:f1f1:3a0c with SMTP id q3-20020a7bce83000000b0037bf1f13a0cmr1267634wmj.10.1647305549161;
        Mon, 14 Mar 2022 17:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000186f00b0020384249361sm13625785wri.104.2022.03.14.17.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:52:28 -0700 (PDT)
Message-Id: <2bb8f1cb1c4072bed544baa34451ed0093e2f007.1647305547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
        <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
From:   "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 00:52:26 +0000
Subject: [PATCH v2 1/2] tab completion of filenames for 'git restore'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Cantrell <david@cantrell.org.uk>,
        David Cantrell <david@cantrell.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Cantrell <david@cantrell.org.uk>

If no --args are present after 'git restore' it assumes that you want
to tab-complete one of the files with uncommitted changes

Signed-off-by: David Cantrell <david@cantrell.org.uk>
---
 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 49a328aa8a4..7ccad8ff4b1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2883,14 +2883,21 @@ _git_restore ()
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
+		return
 		;;
 	--source=*)
 		__git_complete_refs --cur="${cur##--source=}"
+		return
 		;;
 	--*)
 		__gitcomp_builtin restore
+		return
 		;;
 	esac
+
+	if __git rev-parse --verify --quiet HEAD >/dev/null; then
+		__git_complete_index_file "--committable"
+	fi
 }
 
 __git_revert_inprogress_options=$__git_sequencer_inprogress_options
-- 
gitgitgadget

