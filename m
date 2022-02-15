Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A140C433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbiBOP74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:59:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbiBOP7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E7BD8B4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i14so32845024wrc.10
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AYYV/9S1Pxi+/nQo2/9PJccjytswo1D3DmUghvHX2iw=;
        b=E+0/MQZwUuCdeg4tMFIYo8vO7zKJu1DU2Daa7m72eNH6N6GskbsNn2f4OJS7BXeUZk
         nbzX3qdD0Fqkq7NQ55rd9EsWQhNPrucAMTCnn8N7SjRS07OYREgWUM06U9pKX7lnolZZ
         HipLgR3ssO5u4LLGbEouq0LNH7lwu0sSkCL/hI16PuND7Pc9R3XE4o6D4TncI7S2k/5w
         JULwvs1Dp4dRRlUDu9T6rQwGq/IC+ZDCM0EsMDaqovYa+w6xKNdP24nSkpgs7sARhv92
         CV9+8zqsaye7xIqpL8ulS6RZDh1uXS7kwuNNaMiKVvt/GK4YQHqDV+THTuRJ3XeMEUgw
         gyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AYYV/9S1Pxi+/nQo2/9PJccjytswo1D3DmUghvHX2iw=;
        b=TTr4Zu62zh8GapXjQaF4bRpxiPK7u17Qm9149Lqoj9/3Z3idjpR9Tc3ju1UDU5pUnx
         buKqeqKfB0OO2dlNcjdZIHr5BLtiHJotXLuqkbomShUmLtPXICudXjwTQC38OCWlrmm1
         kePsZv4o8AkcoHnnz/YwO5o/pjM1ANjHFb/m2ntbmlBv0JC0tiB5HCQQDLGpwVZl/d02
         agypOdK9uXDX5GIV2ojM5eVP9W6yyssVnxtBCD8A2nrNUaxajHciP2QEnfYhGY2s58Mf
         wvC0/9Boegi+rQsFNOt+3Fz3TgAicVbRNStronuktnWBuopXO9hHRfdpdzgHAS0KNEdA
         d8jg==
X-Gm-Message-State: AOAM533oiOkszHUjMi8DjU/Wzi7kr3UNz5tp5E1P5lKSZp6jJZTJqJVl
        hdCAWRpqD6kNqWtflulDPpWTCuUt/wc=
X-Google-Smtp-Source: ABdhPJxf8O0cBF+vrPAcF7J3CemMicLoUyUv/D0eGx6LslEk32t0cDcfIq8Pd2FJ2cHXh8+HyC+63w==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr3790529wrh.245.1644940778990;
        Tue, 15 Feb 2022 07:59:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm15798134wmf.11.2022.02.15.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:38 -0800 (PST)
Message-Id: <9af952e4d170d71d66db721368af42ae5ce0fca8.1644940773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:13 +0000
Subject: [PATCH 03/23] t7527: test builtin FSMonitor watching repos with
 unicode paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create some test repos with UTF8 pathnames and verify that
the builtin FSMonitor can watch them.  This test is mainly
for Windows where we need to avoid `*A()` routines.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 1fdabfc4f1e..c0145544ccb 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -696,4 +696,27 @@ do
 	done
 done
 
+# Test Unicode UTF-8 characters in the pathname of the working
+# directory.  Use of "*A()" routines rather than "*W()" routines
+# on Windows can sometimes lead to odd failures.
+#
+u1=$(printf "u_c3_a6__\xC3\xA6")
+u2=$(printf "u_e2_99_ab__\xE2\x99\xAB")
+u_values="$u1 $u2"
+for u in $u_values
+do
+	test_expect_success "Unicode path: $u" '
+		test_when_finished "stop_daemon_delete_repo $u" &&
+
+		git init "$u" &&
+		echo 1 >"$u"/file1 &&
+		git -C "$u" add file1 &&
+		git -C "$u" config core.fsmonitor true &&
+
+		start_daemon "$u" &&
+		git -C "$u" status >actual &&
+		grep "new file:   file1" actual
+	'
+done
+
 test_done
-- 
gitgitgadget

