Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C6DEB8FAD
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 07:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjIFHPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 03:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjIFHPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 03:15:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD35CFA
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 00:15:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso50135031fa.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693984509; x=1694589309; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XElkU3Pic70SzNC5a1oiJ1YoBfnCUCgInV5TxHh+PV8=;
        b=I7bvXaxGWezhflCQ21IM06L0Gsrz/7fpgwZgUOfT7hHp8e1HhRg+O8MoPc9tKxeQs+
         26ulNqfv/bfND/oCPU144+KZ4PsmYBc+LV+fRcK9ORCiMsbgE87al1Sp3JXddowpwmkO
         Y1IentAMR5gTCd6iHsxYEyaylE9fNMfXj79FgxBk2SRfM6ntOPt73Jgu7czPe8cIZxfz
         OqtCowBf54WUFRc4ZkvsT+t8T7yRaQwb20A2VELMXXM6fqiFy8fvzF28Osw4kqUoKAUd
         nnhpWSsSOfNscvOcwlyqH6Jrr0a1ODK4VcsbVo/OcdF7R2rOgWh2BltG4LYa0CkZmy87
         Xu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693984509; x=1694589309;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XElkU3Pic70SzNC5a1oiJ1YoBfnCUCgInV5TxHh+PV8=;
        b=j1D6zBP9hMC88smpNcHMO7p9J9zxbF62Qd7XTZh7RAJJD/f+B7VObddHs4FPjQFhPf
         0N5mEX64Fu2PWFg314werQ7sNoJvRMAYZ1KE/g/qmV0IjXPPXh8W1Dc6SUy6NGRauZnd
         Sh3vp2eRKS4zRq2T2033cp12VcI+EA3vAHISN0Isq5GdgYyMPjM/ysp4qlRsOQIL6EmA
         ENkTojwlKbn86Mv4QuT2P+i0pCY7zWq3TB90lvtzYmlYiuU+dtNpJXWfEqP/0lSPdpl8
         hiZap8LI9QAqmeY1H5/Y3lpduzBtNXvRYjHbvnT0oqk9S9s+RrYYV6NRBhVN+qVxEgpk
         5dlw==
X-Gm-Message-State: AOJu0YxYmijVqQOyW+/IA5UyO3R9cI2DPykWZrt1fu8jQDn/IpCoxOes
        kOhluphyUD03rIYUBgFE9jw=
X-Google-Smtp-Source: AGHT+IGt0lxBnM0gNMRf4Lxz71hUhJLvZ0cX7iXm4oLoluRA7yTcmUS3ucGK8Sh5yimb+1E69sG3rA==
X-Received: by 2002:ac2:464d:0:b0:4ff:a04c:8a5b with SMTP id s13-20020ac2464d000000b004ffa04c8a5bmr1633231lfo.47.1693984509140;
        Wed, 06 Sep 2023 00:15:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm2649317lfq.52.2023.09.06.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 00:15:08 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 1/1] doc/diff-options: fix link to generating patch section
References: <87zg20qzhg.fsf@osv.gnss.ru> <xmqq34zsqlr3.fsf@gitster.g>
Date:   Wed, 06 Sep 2023 10:15:07 +0300
In-Reply-To: <xmqq34zsqlr3.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        05 Sep 2023 15:49:04 -0700")
Message-ID: <87msxzpybo.fsf_-_@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When formatted as man-page, the section title is rendered
"GENERATING PATCH TEXT WITH -P" whereas reference still reads
"Generating patch text with -p", that is inconsistent and makes
searching harder than it needs to be.

Fix this by getting rid of custom reference text.

Also, documentation for every command that describes `-p` option by
including the "diff-options.txt" file does include the
"diff-generate-patch.txt" file as well (as it should), so the internal
link is in fact useful for any of them.

Fix this by getting rid of conditionals around the reference.

Fixes: ebdc46c242 (docs: link generating patch sections)
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9f33f887711d..c07488b123c6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -22,13 +22,7 @@ ifndef::git-format-patch[]
 -p::
 -u::
 --patch::
-	Generate patch (see section titled
-ifdef::git-log[]
-<<generate_patch_text_with_p, "Generating patch text with -p">>).
-endif::git-log[]
-ifndef::git-log[]
-"Generating patch text with -p").
-endif::git-log[]
+	Generate patch (see <<generate_patch_text_with_p>>).
 ifdef::git-diff[]
 	This is the default.
 endif::git-diff[]
-- 
2.25.1

