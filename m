Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB02AC433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 05:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB5A60FE3
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 05:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhKLFBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 00:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKLFBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 00:01:16 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8713DC061767
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 20:58:18 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso5894210wme.3
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 20:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cfbT9ufNRXyCEL7/2xLe33IdbpOB+2TX+jIohA/9SKA=;
        b=n1SJ3n/qpdXBH/P+LcWTuvw2Z/gdK6ghhC/Xe263o1ep1nScOmldZfasXEl/CsMwTF
         sy1KqAltBsKXPQm3hPSKC8UY15cHG3pjqKuT/NepJGtIpRsM+a0QDylYrTvvLUX1Rz18
         RmWKCfagokrHbxpUZ7Ng38GVG8uNV7/rrW92vmEpPmKWfLdg0Not/1XtTKlsV4yL49VV
         R8mvCwqqQ2QaIYPkOuYeuxNk1W3HvoJeGBYaTrv1VR2VNvVScDUSVGn7FQ9CHeVKwjQM
         9EgWFSlswozMZ0MB0oAfS4lobIFlddoClhP8+RDT8qE6R4CEly6065sfMMmne1M038H3
         TzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cfbT9ufNRXyCEL7/2xLe33IdbpOB+2TX+jIohA/9SKA=;
        b=2yO8NQbS2PjRbWfhI1zJs6FAY+/PliD0F4MGNU1K/68u44poMfwZN/XStyDtT6erXi
         L9XYB8hyFo1r+uqKEbq2hgw+8Flk7kzS4ERA8fatHQ0ltb5Rt+g9v1pzo5GPYd3Nu25c
         JzT53kh+1EnKvhl9tPqGM3imIA5kjMxjbhNGppoRsnxLHhwi867PYS4iSP4Iq/x5VSM2
         xxBxB71ECHSL5XwPmezOg43UcwOkOL5s/E7jMQle+i/Wt3vWUsxwxmfdTBuHkW1YDRzg
         cdbyortP+oGjBJdt2Qkasw/FqYUAvEBLUoLUbHIoZhNKZ73ZrsIQIap0DD2umgttVocr
         LdnA==
X-Gm-Message-State: AOAM531uGPEgVeQgoOpXlaSnw3hSMd9HfG9ln6KbtAut45q8hH6gOORx
        l+71UeUbSQC+Rvwgq0sBwMgqXcFPgtA=
X-Google-Smtp-Source: ABdhPJyCquLlQzVqfWhFF8P2V3WvQgz5WtaylVjuoRkdPiJO7RlOIlTD8eupViTUBJpOPJbw7Doz/w==
X-Received: by 2002:a05:600c:500d:: with SMTP id n13mr748155wmr.174.1636693097045;
        Thu, 11 Nov 2021 20:58:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm5257805wmq.11.2021.11.11.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 20:58:16 -0800 (PST)
Message-Id: <71e6989375c9b8dd00151481e0bb19c991e673f3.1636693095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 04:58:14 +0000
Subject: [PATCH 1/2] doc: git-format-patch: specify the option --always
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
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

