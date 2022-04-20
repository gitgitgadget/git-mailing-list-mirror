Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92563C433FE
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382215AbiDTUrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382191AbiDTUqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656384578A
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so3873539wrg.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WbCyBB3b+JrlO6bcxV7sHoIjfAZBpv4bnjaEWZ+VEMc=;
        b=NiiunuM1lTI7oD3wiWQOfYDeFQqBNSs7Qm11Ren3UPSu0p2/8/1uCx0U4u4mVmRLhQ
         Dfvh3v5QGf9YyLI7Cq4J4rZ3Nd+btoOIvVqPdqmMeoXIesstuQQ6/BtFKWHam5+87rW5
         dzRjOhvfE8QklqUBV1T4Sn1n093f/h0BxjGsfbuFQo6ZkEkxI2vYJtKTrJVaNp5oRNj9
         8H8MKNc837T59z+qRQV5IxBePwwryoZIULCYnQS2LnonwMlNCFXdAW80TUJmUgFkfEYT
         ffWxAQWseaTply1O9wu2YHXY4TaKYFLAv9hpRIPYLwxq3fHpCqHepT3x4qHws2Vq8JXI
         gnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WbCyBB3b+JrlO6bcxV7sHoIjfAZBpv4bnjaEWZ+VEMc=;
        b=Ibq+GJdZTRf4qZm36ZWDqi4bd0TRoD6L5T00cD8ai7nGjIphXx1Eld3pBGcOX2bZzo
         WAxeHhaE4bipZmJzxVcejqhkfLgFrOdr7DQyoFLxiVeiBmz4TZSwAB+U/Y4dGV7TLzyE
         gJKnNQZPXeMVVKdOvyeU2dgs+lEnRql04Y5OOZiAtzWZEo4jq5i3Um6Rqt4fIwgvDeEo
         nzhg1j+muq1jWh9Pdtp8BDoFzgsmGizj7UQThk1PfWIEiQa7VauSZgjIcbitDGSnGbj/
         jqN4vftYEoUHv5RQOCpRx0r7mGWmxmBXbxVu2XWw2mZ9TrbclQNdqD2iKbV3FYPVNa/n
         M58Q==
X-Gm-Message-State: AOAM53179nfxxrug2MWCvUTDSqS+VW5mXJ5qHGMVzPM3K7ZPaRrzY8NF
        p9CRzPBtMbP/4Ee/dJZCW8fOW7BFd1E=
X-Google-Smtp-Source: ABdhPJxjszH7wfgW1aWo0ML62eeBBCXclAi1VuBcERAsI2krr+DLkQSOo+9vGaIuR+iQNzWrgPJGUA==
X-Received: by 2002:adf:e48c:0:b0:20a:7e29:e16d with SMTP id i12-20020adfe48c000000b0020a7e29e16dmr17220796wrm.595.1650487431622;
        Wed, 20 Apr 2022 13:43:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d6a87000000b00207aad420c4sm645718wru.101.2022.04.20.13.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:51 -0700 (PDT)
Message-Id: <93de3707d26e1e4485a192b57cc4d2a9526318d5.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:14 +0000
Subject: [PATCH v5 24/28] t7527: test FSMonitor on case insensitive+preserving
 file system
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Test that FS events from the OS are received using the preserved,
on-disk spelling of files/directories rather than spelling used
to make the change.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 1cf0ffa5676..a4f8008fea7 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -832,4 +832,40 @@ test_expect_success "Submodule always visited" '
 	my_match_and_clean
 '
 
+# On a case-insensitive file system, confirm that the daemon
+# notices when the .git directory is moved/renamed/deleted
+# regardless of how it is spelled in the the FS event.
+# That is, does the FS event receive the spelling of the
+# operation or does it receive the spelling preserved with
+# the file/directory.
+#
+test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
+#	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
+
+	git init test_insensitive &&
+
+	start_daemon -C test_insensitive --tf "$PWD/insensitive.trace" &&
+
+	mkdir -p test_insensitive/abc/def &&
+	echo xyz >test_insensitive/ABC/DEF/xyz &&
+
+	test_path_is_dir test_insensitive/.git &&
+	test_path_is_dir test_insensitive/.GIT &&
+
+	# Rename .git using an alternate spelling to verify that that
+	# daemon detects it and automatically shuts down.
+	mv test_insensitive/.GIT test_insensitive/.FOO &&
+	sleep 1 &&
+	mv test_insensitive/.FOO test_insensitive/.git &&
+	test_must_fail git -C test_insensitive fsmonitor--daemon status &&
+
+	# Verify that events were reported using on-disk spellings of the
+	# directories and files that we touched.  We may or may not get a
+	# trailing slash on modified directories.
+	#
+	egrep "^event: abc/?$"       ./insensitive.trace &&
+	egrep "^event: abc/def/?$"   ./insensitive.trace &&
+	egrep "^event: abc/def/xyz$" ./insensitive.trace
+'
+
 test_done
-- 
gitgitgadget

