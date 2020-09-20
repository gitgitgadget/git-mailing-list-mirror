Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A6C43468
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E8F216C4
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/jX6ddx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgITLW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgITLWr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADCC061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x123so6521866pfc.7
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NWmJWmix5MbfEOPcIXCAA1zWSU0Fqu0LzA2WS4PetQ=;
        b=s/jX6ddxJaTTaN1N/HjU/zfKuNj+lkjoNcYpBXDMjI+E1dWV2MpqHILlqIdJslPFXU
         bSc2TQsW56KGgg3BHcvxvGes+u8xBh9pgat1Ut7NZEUSlCIm1I+58uC+b3zI21Juq2xn
         1YUvYj4etS/4EwU1qHuoMicQpgMbt6SDkN5U7lTEsf7uWafpIy8WQ45YbOSo9c5hWWFi
         7of8MFcfWQQcvkuMc8V7N7qxTLfTW4TsuOwItbffGGbkwjuqY69ZlLU5EeL2zrNscavi
         bSLkKDTHN+o1pYs5bhtn+d3BBKyLOt36fRSaYE6NoAGjmDIc7nNR4ND9kBZDmJWRczdA
         EoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NWmJWmix5MbfEOPcIXCAA1zWSU0Fqu0LzA2WS4PetQ=;
        b=ZUNPty2eh7YhklP8FuRvRfjUp9vYe0FHI9kUS/+5vw5ZsjoS0extv7FVIjWyKNRWhf
         GQo9bx0NldCgUwu1/SytNW0Ox0oV/RM2zIA3eGfGj+kg3L6kBCc13bpuIxw4mqHTeend
         UWVMLuQhJotxyDXo4cLMBtisWAcwMEM6FTa7YW3D2D2pEipycK4MmtjanItmNRhOwMuS
         1qNW8bc/NqV3Ew6Vz0YcHS0g4lQ+QfdWGKsy1q7tV8jLoD9y7inEY3q1DOn4pIGPFQEy
         cBH3vH3lOfGpZGf8496mgN1e970QjqlfQO9xZar+fbG6gmr0e5NqDOoa6BfnrGeXF3ld
         OXQg==
X-Gm-Message-State: AOAM532rbl9y5F51fD/c8XKPOKYDtLfdcyRoBG6Q0MtZeBFy5GvRXAjM
        s7PUoCg5AjxHRVJb6x0W5hJK+qcMy00=
X-Google-Smtp-Source: ABdhPJwTvO6jT2kX90yjVUxZ11xJLHLoOAUFhDHTIDiAp9ubpio/02/zjaZAD6ZU+5cBZm4qj/oeTQ==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr32937353pgi.241.1600600966656;
        Sun, 20 Sep 2020 04:22:46 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:45 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 10/10] contrib/completion: complete `git diff --merge-base`
Date:   Sun, 20 Sep 2020 04:22:27 -0700
Message-Id: <32e3e52b5f4dbbb3050fe9fcff1a3c1f1d2df123.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f68c8e0646..679d1ec8a8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1692,7 +1692,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 "
 
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
-			--base --ours --theirs --no-index --relative
+			--base --ours --theirs --no-index --relative --merge-base
 			$__git_diff_common_options"
 
 _git_diff ()
-- 
2.28.0.760.g8d73e04208

