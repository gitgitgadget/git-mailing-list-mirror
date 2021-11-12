Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B500C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B0F60F6E
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhKLG47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhKLG4x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 01:56:53 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD62C061767
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y196so6898729wmc.3
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cfbT9ufNRXyCEL7/2xLe33IdbpOB+2TX+jIohA/9SKA=;
        b=lq3/qGSeMGgE3psQIwEPpaeGGv4hK7RDdxpUburJ/kiEXJ4pgAeckN306CaeQ52ciM
         xkne0G8GVD19V0Npl1tf9YWGvBrTvtoz6rjuMKhPOnT+b1jbbUzArwrhhkU1QUfk8tZd
         j4yl+SxTUdFHvoeenX/vSrrGRRMpVf+HrlYnyC+Wf/b6YbFiFf9BgWZPo+YoZiTEbzpL
         yh1doxdgZrafX0RX9QVeOQpaxp5S/nx/AjTr4JW5DDCQsNDmKvDK3SU1Rkg9GBFo84Sv
         eVMgXVEQEfsTnnt/nDckbG5ncOKdmFc3lnAtPJirRhvrWmuaJS1N8jhUjgNA3QJRtRVx
         quJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cfbT9ufNRXyCEL7/2xLe33IdbpOB+2TX+jIohA/9SKA=;
        b=W+5xauHKSBmgI4NTjhRNphn68+MfO8voMAV1ZMxeaQmP0knE2ie7nHxQC998djZnaE
         huvOKaAOZ/NpR63Q4JVVOHodLG1T+QsIdx5d56nX6Wy0rhqAUQ+WQpcqT06M616bDulO
         4Zjsdhm7qgs71ddxSl+BE49BEK90KbGmJeea2RnM/2jUeUlJYPT03GUJ2S7TbyM7uLsb
         djdYkuO8V5HRm2oqkVPYhOfIvt5Y2ExkyyqyAAzRpUMglVP9WMgzOKW1ZgE3/K8vSNpS
         NWRgIpGFBUE2jA1ZxsBoQDUJqq1yRiFIJdIRbQ05gNob7YIa9ghp3SmVvaGcDvvu37fo
         MzWA==
X-Gm-Message-State: AOAM531WLPgGfzV8x65ADYal5sdeLaRD//SOksHY8CDctPGfW8thYZ5c
        K8MOMFCPD25oZyRHJUFjoBFZ+KuEBXo=
X-Google-Smtp-Source: ABdhPJx9wNnSABblg7kVRrdxRTj87G2D5kJ1CjZ+gvaG2u5+PxJE99R3fmDYcYM9peAX2jf9eUrH4A==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr32626880wmn.93.1636700041813;
        Thu, 11 Nov 2021 22:54:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be3sm707344wmb.1.2021.11.11.22.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 22:54:01 -0800 (PST)
Message-Id: <71e6989375c9b8dd00151481e0bb19c991e673f3.1636700040.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 06:53:57 +0000
Subject: [PATCH v2 1/4] doc: git-format-patch: specify the option --always
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-format-patch.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 113eabc107c..a9f2bf94182 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -30,6 +30,7 @@ SYNOPSIS
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--filename-max-length=<n>]
 		   [--progress]
+		   [--always]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -388,6 +389,10 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 --progress::
 	Show progress reports on stderr as patches are generated.
 
+--always::
+	Patch commits with detailed commit messages,
+	even if they emit no changes. (see linkgit:git-diff-tree[1])
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message,
-- 
gitgitgadget

