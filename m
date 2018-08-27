Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29C21F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeH0Xbl (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:31:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39740 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Xbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so103917wmq.4
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cotXSi6bBdcR9vB2cmxFwz5VtRzlnXMtv3LQqZjlRTY=;
        b=Lt4swb0m+YhCeTjZpkuyEa5tPQkGnFTNU/7USZ67bqzR9T6/8uHrmNaj3XB4nvc+m9
         tZlcUFqHSQ8ZXyG/SQxRF5bXSS8VHU5cfEgAMnIyi8oKknxhxd7A37M4JQtvL3IwM4qx
         FouJGR2yppE3/uJgwj8W7P/m3hwULqZq9tXvxRYtJ9oH8CPHI7YXNaAVBLHWBatVEkeC
         dIozG26pynGjn56yAC4CjSBBcfSfVqqd2iVg3F0e1eTX6+39kyzT9LZlkempnjgfT004
         HJjHrrkqiKyiXGsBRU0D8SV7YvFk+A+PxBO9jYNgoHRfGqFdvoTVKXrq1G0Ixr2/xmrm
         1FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cotXSi6bBdcR9vB2cmxFwz5VtRzlnXMtv3LQqZjlRTY=;
        b=OPWChCHzKKxF38HODyP3Jn4OPz4V+qZQqEXhL5Lzov1sHSF93630E2ia3Fs1YLhYOu
         rs3Fy5CtuhV8pJBO0pH555SqZI1dvjSFs4U8Zry9KxKohwBX04y8WcqMgioDRssvb9nc
         sHG1dmX0DEgFRiYQobt0xuBMxDUPt639CQ9KUE/YRTthiss3KLnJAG/bHhievSdV1anW
         GiaLUVOrsCfEaomrfZTchGo8vh5M4e2Ru5qQcxw9eXEY9yrS/8/a2GYtm9nAQc/FA0rd
         DqzRLSouogMOFTKE5MTtOlmnlILn7YI8/0Rpk0KWbAD6ZZDhGNEXzH3FNmBof36ZcVrY
         eAQg==
X-Gm-Message-State: APzg51AHAd8DjXPesD/HkXWIZE4uh3pyNFtYpcOk9pQYDF93HHXPQAux
        K5sUpY6yqpRIXnmCyZXTUZLc20y9IDs=
X-Google-Smtp-Source: ANB0VdYL7YqPUr7P3kQRCgxXc1OMylVoBXGM2YPjJgSAf3LQnuB19JOjwSuV/v4eD/SvytIcsOtngw==
X-Received: by 2002:a1c:1314:: with SMTP id 20-v6mr6320896wmt.55.1535399019249;
        Mon, 27 Aug 2018 12:43:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm121958wmd.4.2018.08.27.12.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:43:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/7] fsck: document and test sorted skipList input
Date:   Mon, 27 Aug 2018 19:43:19 +0000
Message-Id: <20180827194323.17055-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180827194323.17055-1-avarab@gmail.com>
References: <20180827194323.17055-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the skipList support was first added in cd94c6f91 ("fsck:
git receive-pack: support excluding objects from fsck'ing",
2015-06-22) the documentation for the format has that the file is a
sorted list of object names.

Thus, anyone using the feature would have thought the list needed to
be sorted. E.g. I recently in conjunction with my fetch.fsck.*
implementation in 1362df0d41 ("fetch: implement fetch.fsck.*",
2018-07-27) wrote some code to ship a skipList, and went out of my way
to sort it.

Doing so seems intuitive, since it contains fixed-width records, and
has no support for comments, so one might expect it to be binary
searched in-place on-disk.

However, as documented here this was never a requirement, so let's
change the documentation. Since this is a file format change let's
also document what was said about this in the past, so e.g. someone
like myself reading the new docs can see this never needed to be
sorted ("why do I have all this code to sort this thing...").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 10 +++++++++-
 t/t5504-fetch-receive-strict.sh | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1c42364988..9359fb534e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1708,7 +1708,7 @@ doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
 will only cause git to warn.
 
 fsck.skipList::
-	The path to a sorted list of object names (i.e. one SHA-1 per
+	The path to a list of object names (i.e. one SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
 	be ignored. This feature is useful when an established project
 	should be accepted despite early commits containing errors that
@@ -1723,6 +1723,14 @@ Unlike variables like `color.ui` and `core.editor` the
 fall back on the `fsck.skipList` configuration if they aren't set. To
 uniformly configure the same fsck settings in different circumstances
 all three of them they must all set to the same values.
++
+Older versions of Git (before 2.20) documented that the object names
+list should be sorted. This was never a requirement, the object names
+can appear in any order, but when reading the list we track whether
+the list is sorted for the purposes of an internal binary search
+implementation, which can save itself some work with an already sorted
+list.  Unless you have a humongous list there's no reason to go out of
+your way to pre-sort the list.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index cbae31f330..fa56052f0f 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -142,6 +142,25 @@ test_expect_success 'fsck with no skipList input' '
 	test_i18ngrep "missingEmail" err
 '
 
+test_expect_success 'setup sorted and unsorted skipLists' '
+	cat >SKIP.unsorted <<-EOF &&
+	0000000000000000000000000000000000000004
+	0000000000000000000000000000000000000002
+	$commit
+	0000000000000000000000000000000000000001
+	0000000000000000000000000000000000000003
+	EOF
+	sort SKIP.unsorted >SKIP.sorted
+'
+
+test_expect_success 'fsck with sorted skipList' '
+	git -c fsck.skipList=SKIP.sorted fsck
+'
+
+test_expect_success 'fsck with unsorted skipList' '
+	git -c fsck.skipList=SKIP.unsorted fsck
+'
+
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
-- 
2.19.0.rc0.228.g281dcd1b4d0

