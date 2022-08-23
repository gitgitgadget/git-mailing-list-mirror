Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4C3C32796
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiHWTX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiHWTXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:23:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A573134CAF
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:04:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e20so17440105wri.13
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=I3Ojpviz0Kfb3I0CUQKssWArPb+HJXPRsrZsL/QUGG0=;
        b=D/oHAg8CZE3L/jeL/SokAMnCAGkKJ1eRidzlqX1rK77SWn16AhZm2ffzwm82qcsAaC
         UONXklTT+yxuOewGROhGG6dJjqENbZPmaq0rJo4SmHdtsGkqdPZDWfHQO9g0VMwQUfQq
         sb/nID4xS1f29uazcXRekrj9hPGSBPs6FBEfkI5Oibgbwlk26Bp0hYnlnNYYy18wWOoX
         P+NTbmD5ipK+BPGSo8FeT7fe9em0FxaI8CJ+w+0f94wBgamQ8dWZCHBWBkcMssMfFDFI
         Q6pwPeuLKEalC8P1eotMFKamF28NjpDl5ht5NUPqdvRkDsURL3vrR80kdfVdXCHfNIO0
         Tn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=I3Ojpviz0Kfb3I0CUQKssWArPb+HJXPRsrZsL/QUGG0=;
        b=n803axMuGgfh2R0DUQqcNvAdtfkS4kcLHcju7RovFV5CX5ATmcZpkgiX+e+EnXzPxb
         CZ7j4AciTFd00H7EkeNQVUj3Ju15IGmh4Sh0x8osQ15l7/WmjgHNlJ08Q+4SXwsqy35+
         JbO+fSpNytF3a8B3mcWeUFF0jad7gG7KPCAyz/F77RsencD1aEtWS5EtufojpJyjN4uY
         4ylMA+McmfB2iIvps2PVROF2qiIEPk4ltavAkZ/ZdSsqJsECCymA+fChjduqdXZa1EvY
         8EhkVpYr2XDnoVoAE6AC7tMdOWSZIFsjsvbmKMSzGhDzXJ7EuNvGroUEkYcOszsFvor+
         EPGw==
X-Gm-Message-State: ACgBeo3PRsOpPsvHhffWU25uBxZis2/qXGO2P+aqGUpV9cCJJw5/aMBU
        8LKHUwCXhiE/74Vc6v/1AL5pvgQZF50=
X-Google-Smtp-Source: AA6agR5JTwoVGvKH/KYx5b422zez/Kjgu40M8k6Nz1cXqoewmfxSSoO585UGu1UyXWWJPBfTeAjkAQ==
X-Received: by 2002:a05:6000:11d1:b0:225:3354:674d with SMTP id i17-20020a05600011d100b002253354674dmr12545309wrx.234.1661277873076;
        Tue, 23 Aug 2022 11:04:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a4efb794d7sm20011142wmq.36.2022.08.23.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:04:32 -0700 (PDT)
Message-Id: <74ab50eeb1c6debd2f371e548cf6c782479f69af.1661277870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 18:04:28 +0000
Subject: [PATCH 1/3] t3701: redefine what is "bogus" output of a diff filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When parsing the colored version of a diff, the interactive `add`
command really relies on the colored version having the same number of
lines as the non-colored version. That is an invariant.

However, in the 'detect bogus diffFilter output' test case in t3701, we
essentially required a hunk header that contains parseable `@@ ... @@`
hunk headers, and called all colored diffs without such hunks bogus.

The reason for this is that we would like to show the users the adjusted
hunk headers _including_ the extra part after the `@@ ... @@`
information, which usually contains things like the function name or
soms such.

Now, there is a _very_ popular diff colorizer called `diff-so-fancy`
that does not produce such colored diffs as the built-in `add` command
expects. Nevertheless, the Perl variant of the `add` command handles
those nicely, essentially by ignoring the hunk header and saying "there
is nothing else we can show except the original hunk header, even if we
had to adjust the line range and the original hunk header might get that
wrong".

In preparation for teaching the built-in interactive `add` to be a bit
more lenient, let's change the 'detect bogus diffFilter output' test
case so that it verifies that a mismatched number of lines causes the
command to error out, but not an unparseable hunk header.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b354fb39de8..b40d1c94d99 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -761,7 +761,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	git reset --hard &&
 
 	echo content >test &&
-	test_config interactive.diffFilter "sed 1d" &&
+	test_config interactive.diffFilter "sed q" &&
 	printf y >y &&
 	force_color test_must_fail git add -p <y
 '
-- 
gitgitgadget

