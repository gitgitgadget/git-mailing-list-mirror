Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9572AC43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 03:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKXDrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiKXDra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 22:47:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0934EB02
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:47:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so395116wms.0
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T20WUS5qp99rV0Hisl6yaxm2LFHkUrNcM5zt2P+1fnA=;
        b=pHjSpIN1VLdmXzwatAap0YsmbGKZxpT3KZHuuy3E4MeGarEdKC/qYiGgDlSUIVwB1S
         ScfbgqtGfOR4aPN6ROMLhRk5dJvcnhJyFk+6/wCvgEJ6qNA0O3RILOjmt8Hl8wZ+5bKl
         hlhZzDfnwTaBFdm15UHWkkeSGPP+5zSq0MdfUsgPI/jyDSvAxbLqMF8HU8LMO+HaNRnA
         jZ9AoJLefeBD6Um/+FLzVlaLhXiJ3QDcxqhbjyxQGYQsHrWS43aRrhL8H33YqgKUdBRG
         lHnDnI1O8MUM18OLMA/fMWYG3/033lER+o9E8jWP/4rzes3THPwc6NEgc3d4ELW55vp8
         yC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T20WUS5qp99rV0Hisl6yaxm2LFHkUrNcM5zt2P+1fnA=;
        b=P9kMJ6mkEOV2pALptWX+T8/8zskjOyZ5vXAbHXvz8zFqoqKZmNNGTSkaW0mn9QI060
         4UyEGr3jMeN6fKFTagVJDe61W1pk4Mku4iogyragD2tGeYCpjCF6TEQMJHUurK/Ko6fp
         rxAwARWBSpSDTOpeHJX7Z6dr6HCu8tOObVGdO8jropDO/3BkjGckSQB9BwhMI+odMoEe
         yNUmW2sjV0Ub85+8dFCn7oezEfc6kiJbd+6/GuoD+hdnhcvsJcDk6b37bumSxbV5aFSk
         NMneO1DmXrvqvPgrhfbkoD7gMLMBenLr9B6lAY0T5Qz40JCHdEj+8idUkSyp0iAO2ZeC
         QcSw==
X-Gm-Message-State: ANoB5pmsLMsNOeAK/WNMo3KRYk6rqdP7g8eDVhfofFnJOpBz5dwRjAxo
        oHnMUdzdu4QqLPMrIqEE2PefOu7OSMk=
X-Google-Smtp-Source: AA0mqf7GVWyiQSuwP1npdEEXCP3Ougwg6ZTke+LFtNXRDLpp++1zaS0tcJzovVUnchfVI35q3ZnpCw==
X-Received: by 2002:a05:600c:210c:b0:3cf:6af4:c4fa with SMTP id u12-20020a05600c210c00b003cf6af4c4famr22543327wml.117.1669261646386;
        Wed, 23 Nov 2022 19:47:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm4130423wmb.12.2022.11.23.19.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:47:25 -0800 (PST)
Message-Id: <972d51888ba015a6697475025466432218efa6dd.1669261642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
References: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
        <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 03:47:21 +0000
Subject: [PATCH v6 2/3] git-jump: move valid-mode check earlier
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Jeff King <peff@peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We check if the "mode" argument supplied by the user is valid by seeing
if we have a mode_$mode function defined. But we don't do that until
after creating the tempfile. This is wasteful (we create a tempfile but
never use it), and makes it harder to add new options (the recent stdout
option exits before creating the tempfile, so it misses the check and
"git jump --stdout foo" will produce "git-jump: 92: mode_foo: not found"
rather than the regular usage message).

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/git-jump | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index babb3b5c68d..cc97b0dcf02 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -88,6 +88,8 @@ if test $# -lt 1; then
 	exit 1
 fi
 mode=$1; shift
+type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+
 if test "$use_stdout" = "t"; then
 	"mode_$mode" "$@"
 	exit 0
@@ -95,7 +97,6 @@ fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
 "mode_$mode" "$@" >"$tmp"
 test -s "$tmp" || exit 0
 open_editor "$tmp"
-- 
gitgitgadget

