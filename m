Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A07C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 07:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiKWHEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbiKWHEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 02:04:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BCF2414
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:04:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p16so12399393wmc.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T20WUS5qp99rV0Hisl6yaxm2LFHkUrNcM5zt2P+1fnA=;
        b=ElrcFDAqme3Y6/PkTfVn/QE7o2X5aUH5FhKx1iURAi3/QpvJfGEDfQS/eRHCZPl3TO
         711gkmagv8i+KgRSYUmGBjBTb/+iXHM04BOcFBv5Z+ZF11bQl+1H6SUKRFnPmfcZtUSo
         /YCGUYI+WpES2IQzbwRzMRS5c0sX65EDI7gPmRtv7Ne5kc8RlEBMp2ItrJM3OAIEFEb3
         Mz6QcVoKS+aIrmAbBsIqx1lcAz9UMywfO30WLsDqAe1NUqkQODhKqMp4ONYv0K9kPWXQ
         ZxWeiBevT083wKw+U3j3/CFQCcernCAnIFbfA3aIh5susrmWawylF4L2JufpbusAxL7Y
         5uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T20WUS5qp99rV0Hisl6yaxm2LFHkUrNcM5zt2P+1fnA=;
        b=Aq+Z8a2khJu6T4NZk9A2XRPVvyED8HQqmcViNSM4fKsnvJh2i4BbFWoEVQUQdxkhPb
         80Z1FHAs8trm4LEmB8LH7HBQQem/3Ppyx23cnqSaWLwstkjmBnisWdaiOM8aJ3cmh1M6
         X+kO540p3wW6AYiqymwTFLBqFwT70YQlWFNY4LhQS6Hs+2vwfO9nY+YHqEJPCFsWEW2E
         QEYMiRnPI+qLp5VS8ztqVpLxWsVkcEVnhqbcb7vZ/HVSemlN2KYcd5QODhNs4TwFteZ6
         Jz3RfHVsg+MKZ3Uc9Yaf46URlkg4TOYinsReehRaePC/Qz6ERfv9Bi2hH6yPxJZxnkdg
         inXw==
X-Gm-Message-State: ANoB5pl6cA93KuX7yAqsLxmtnqVuXgf+iWg2wnmyfW7BgIYxf+Zo/OLW
        dU04eima9JXhQmdoD4r96ez7YJLjRxE=
X-Google-Smtp-Source: AA0mqf6DBvK5c/iEGVuSovBkweYLDoUwe+WrvLbZ5NsmRpZ/J3+3BMPCvLGBXSJnkAso4OcAaH2TVg==
X-Received: by 2002:a7b:cc91:0:b0:3c6:c1d5:ab81 with SMTP id p17-20020a7bcc91000000b003c6c1d5ab81mr22115911wma.192.1669187057115;
        Tue, 22 Nov 2022 23:04:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b003b4a699ce8esm1202131wme.6.2022.11.22.23.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:04:16 -0800 (PST)
Message-Id: <972d51888ba015a6697475025466432218efa6dd.1669187053.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
References: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
        <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 07:04:12 +0000
Subject: [PATCH v5 2/3] git-jump: move valid-mode check earlier
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

