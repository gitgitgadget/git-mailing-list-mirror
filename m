Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7191C7EE22
	for <git@archiver.kernel.org>; Mon, 15 May 2023 12:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbjEOMNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 08:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbjEOMNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 08:13:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB061FC3
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso8998873f8f.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684152796; x=1686744796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EX9LtBIJU7ApbRd/VXHaVpi3R2zVjemKHKAo2nnI0E=;
        b=DL8ujPPBpd1G8xmjzg4lPhM+uzvd6OUO3zcp/dNNPAzvlKocZS+6TpUEI29dque6eO
         h/Ty2KiWstVmfktPFIrYK3I3hf+/w0dj//RUZX0VUUuiKOiEYTw3bl4dgU6ypqhF4U5s
         PZcyVfCkraxKkpWSEkjpBYztivKXvJYEdfj/gsWvMmvRdd9aWCcpFykZPlHiQmNuUwFp
         ZDxYOdmPU4W5tHSyhv8jDVZBfyUjF8uodWfqdyIQKdDn5uliLWsANdL3zOnRIy9JfrtL
         CnpRUDd8pWRAdQhgWLQTiKJs6FMwS9KBSfPi5KVBTeDFX8Uu9/WQzXJe4z9DspOkGzxn
         Q9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152796; x=1686744796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EX9LtBIJU7ApbRd/VXHaVpi3R2zVjemKHKAo2nnI0E=;
        b=V+/426V+GSzxJVXpVzw464U8o89ni7/RvCS1uRIRsJnPfYqCRESBJLNzxGiKYArXaU
         0uT4fiW2bAKcpGnRQSvyUXu1Ezpm7MMMAgY6D3k7KdaYhkKrzPsEGFJdxeAKvCWdH4D3
         lpv2SJY2ptsZbkR8VdorVDLZFeJuUL51qRDz1uo/lEz+Jl3GnhEC4LQ+KylzRTGa3b5D
         QLIZEdXGRodnhhecDCspN+hDemU7fR8GdoBfSFnGDX9NAPL6410ITMBIWEKbZt3ttS+9
         3byhx0kf7LyeuNQYWy6LxwnEFFKgNKoHCHsljHWA4Zq6cC1s1207DjDcS93g1sz1lH9W
         /IxA==
X-Gm-Message-State: AC+VfDzjQA9nkinZtWUqqCY6R/d2n2CJdZq8Cfha2YoMEJAQBkzYRNUJ
        rt991DoEiT4+QAvQG/8jB81g+f/Yv90=
X-Google-Smtp-Source: ACHHUZ5qRTZ6XqiyGmaofL3cTqHdPjKJKJn0eRS+QKEigXvijhMSe8JnlQFllLta0752LKahsw99fA==
X-Received: by 2002:a5d:6606:0:b0:2ef:b123:46d9 with SMTP id n6-20020a5d6606000000b002efb12346d9mr24629929wru.3.1684152795962;
        Mon, 15 May 2023 05:13:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d400a000000b00307a3045d65sm20478492wrp.46.2023.05.15.05.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:13:15 -0700 (PDT)
Message-Id: <cd51a70f3ff714c27aaa1c77cf430af6d49aaf9d.1684152793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:13:09 +0000
Subject: [PATCH v3 2/6] show-branch doc: say <ref>, not <reference>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The glossary defines 'ref' as the official name of the thing,
and the output from "git grep -e '<ref' Documentation/" shows
that most everybody uses <ref>, not <reference>.  In addition,
the page already says <ref> in its SYNOPSIS section for the
command when it is used in the mode to follow the reflogs.

Strictly speaking, many references of these should be updated to
<commit> after adding an explanation on how these <commit>s are
discovered (i.e. we take <rev>, <glob>, or <ref> and starting from
these commits, follow their ancestry or reflog entries to list
commits), but that would be a lot bigger change I would rather not
to do in this patch, whose primary purpose is to make the existing
documentation more consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-show-branch.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 71f608b1ff1..58cf6210cde 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -74,8 +74,7 @@ OPTIONS
 	that is the common ancestor of all the branches.  This
 	flag tells the command to go <n> more common commits
 	beyond that.  When <n> is negative, display only the
-	<reference>s given, without showing the commit ancestry
-	tree.
+	<ref>s given, without showing the commit ancestry tree.
 
 --list::
 	Synonym to `--more=-1`
@@ -88,8 +87,8 @@ OPTIONS
 	the case of three or more commits.
 
 --independent::
-	Among the <reference>s given, display only the ones that
-	cannot be reached from any other <reference>.
+	Among the <ref>s given, display only the ones that cannot be
+	reached from any other <ref>.
 
 --no-name::
 	Do not show naming strings for each commit.
@@ -132,10 +131,11 @@ are mutually exclusive.
 
 OUTPUT
 ------
-Given N <references>, the first N lines are the one-line
-description from their commit message.  The branch head that is
-pointed at by $GIT_DIR/HEAD is prefixed with an asterisk `*`
-character while other heads are prefixed with a `!` character.
+
+Given N <ref>s, the first N lines are the one-line description from
+their commit message. The branch head that is pointed at by
+$GIT_DIR/HEAD is prefixed with an asterisk `*` character while other
+heads are prefixed with a `!` character.
 
 Following these N lines, one-line log for each commit is
 displayed, indented N places.  If a commit is on the I-th
-- 
gitgitgadget

