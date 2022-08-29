Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E77ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 15:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiH2PML (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiH2PMG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 11:12:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2617FE63
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b16so2961448wru.7
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=MQ1YxpBjGbCs7mGlupYs9gX/EOGPy8W/4fdNR9zno1Y=;
        b=OXpT4aYZWagH5PCuiGjAFgpV2zWwAZqUZON2KJaC36iwufe2rd7vOUrvC1KTvP9mb5
         jLOjNbIeEwP2PDkjnz8KG0j9L4+XKXuKqrFbnrkFHXrLrMZWyZ+pDqyh+gJTKpqSzFtg
         KPxoWQZQJfKPTH+2xuBjOUn+ql14tfAXQNNcpWz8Yia+Cbf7jJzbxmtyOVpnUSqiuQLn
         id+inzUtrOoNecUV2OYJBZhRcHTLfKPAJxDOkBXiA0ijxAyX7oRJcD70WNQQFJk3rUk1
         OeIUVNWTzM2Z8x5+Ou+w+B3JtvjmfTamDaB2O6ILQ03O+X3spzpSs9HqKgtfeL0ES940
         IVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=MQ1YxpBjGbCs7mGlupYs9gX/EOGPy8W/4fdNR9zno1Y=;
        b=4MAGP1/eiYy8INaouK/Wcm2mNv+1D0tkRdN+gAhXW5NI3xlWDOiGVQW/zsjAt67kL3
         6P/dNsx92JkIL2esC/UfgybCjvdvD7eZJXNiSlNwlX6XOw0cHKpxBFVSv1JUlWgIk1Jr
         pMttThiJ03o6rDBD/qFvzQpIqswfRC9TmbYQTWyDJ5yMHdKbU2UzleJnG0oXqOgU4IzZ
         B8SJYazAPCuZaqiumP/VRReEgRt70MuEDZwv6qhRhNd75v0rG1kGqBHmSgUNyHUrZKMq
         GA6p49aaYFOoGOCkQAtrNei1f5E5a25MNhydaYSzXsZnoVm4H1K+85IUfRy2uLdQliHw
         FcEw==
X-Gm-Message-State: ACgBeo39sSfGBOTes0z5sCprmwg4VUPnGnADULhZkiJOB9Fcbplq89XI
        gzimbbDzPNGGQhPxC/uIMXf9QasfbyM=
X-Google-Smtp-Source: AA6agR4tgE4b+O72YI34Gv8Y+MGVkG0QDBZDP9mXSFTPm07eZYFy5r7K1GZuphzb++nVbeO41ZcxGg==
X-Received: by 2002:a05:6000:795:b0:226:d45a:ffe5 with SMTP id bu21-20020a056000079500b00226d45affe5mr5378794wrb.33.1661785923902;
        Mon, 29 Aug 2022 08:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c440100b003a31ca9dfb6sm9700415wmn.32.2022.08.29.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:12:03 -0700 (PDT)
Message-Id: <e3e3a178f98183032b3df8ad9c81a096fe4af556.1661785916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 15:11:55 +0000
Subject: [PATCH v3 4/5] add -p: handle `diff-so-fancy`'s hunk headers better
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

The `diff-so-fancy` diff colorizer produces hunk headers that look
nothing like what the built-in `add -p` expects: there is no `@@ ... @@`
line range, and therefore the parser cannot determine where any extra
information starts (such as the function name that is often added to
those hunk header lines).

However, we can do better than simply swallowing the unparseable hunk
header. There is probably information the user wants to see, after all.
In the `diff-so-fancy` case, it shows something like `@ file:1 @`.

If the line range could not be found in the colored hunk header, let's
just show the complete hunk header.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 13 +++++++++++--
 t/t3701-add-interactive.sh |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 9d575d30ed0..0217cdd7c4a 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -363,8 +363,17 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
 		header->colored_extra_start = p + 3 - s->colored.buf;
 	else
-		/* could not parse colored hunk header, showing nothing */
-		header->colored_extra_start = hunk->colored_start;
+		/*
+		 * We tried to parse the line range out of the colored hunk
+		 * header, so that we could show just the extra information
+		 * after the line range.
+		 *
+		 * At this point, we did not find that line range, but the hunk
+		 * header likely has information that the user might find
+		 * interesting. Let's just show the entire hunk header instead
+		 * in that case.
+		 */
+		header->colored_extra_start = line - s->colored.buf;
 	header->colored_extra_end = hunk->colored_start;
 
 	return 0;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 49200b7df68..39e68b6d066 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -775,10 +775,14 @@ test_expect_success 'handle iffy colored hunk headers' '
 		add -p <n &&
 	force_color git -c interactive.diffFilter="sed \"s/\(.*@@\).*/\1FN/\"" \
 		add -p >output 2>&1 <n &&
+	force_color git -c interactive.diffFilter="sed \"s/\(.*@@\).*/file/\"" \
+		add -p >output-so-fancy 2>&1 <n &&
 	if test_have_prereq ADD_I_USE_BUILTIN
 	then
+		grep "@ file\$" output-so-fancy &&
 		grep "@ FN\$" output
 	else
+		grep "^file\$" output-so-fancy &&
 		grep "@FN\$" output
 	fi
 '
-- 
gitgitgadget

