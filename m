Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF01C43217
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 03:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKYDhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 22:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKYDhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 22:37:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15EA2B240
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:37:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t1so2515972wmi.4
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T20WUS5qp99rV0Hisl6yaxm2LFHkUrNcM5zt2P+1fnA=;
        b=CS8Hk/nVj6kQILHgXbz9WH3R+PDkMij8j0NTE9uqGvqVcQvRusLWG+2SKt5OSTdta3
         EGoig4p9lQ0lZOO1ctwCLNjiJFSzHY7QBnn24ZOVLN0JB4+pB01n9RjcA7yZ7TVTUQpU
         CLvfJxmOozkGggfgHUV253ES6UeSofT11ZvqditMIV4eixhvyKd43GOU8JGnuexyjYET
         eotKhmCwRK9fBOUkhIqVJw7uSMEhyUlJ9z7W3SKQaGT9DApCuf3r1Ky1vW03kpJSEG4L
         QqwXqOqmfgfbqBFd0wjcUervGjIPwisZtC8Ru8V30NsqLQrCC1uVPZqr/+q9/chl3WDH
         SmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T20WUS5qp99rV0Hisl6yaxm2LFHkUrNcM5zt2P+1fnA=;
        b=l57EYbyhNNtpFJIAFceJP4FjubCivAmUgldkXHsZm3Vb4Ap830wBCpKNMupV624My4
         wPvQ2/denNFAJGzo8DmPLfsPhTFlkc1dxF27jMkJWOYD0MBgXDniIbRYgUY+LtJPQJHJ
         gHzXo8wn/vCYkFdhnqsQ9f2wtFD8yeM4N7p8HbfD4E6t8SRcT1fnWG/WhOtvIi/0zLxq
         +Tjj2I1ZWCfWlBGiioP4O7cmTE3EUWNr7jsQETyuX5An6WfX8HJo0VNDHj4YzkWeDr3d
         qucjzwJhCTK0LTjunizTOBfH2xgHZwHNNcpbTrA7RdEuibVV8z4b0IwKBEgznIhUsATo
         YDwQ==
X-Gm-Message-State: ANoB5pkRcDv5MqKGdOGrfTwFi5j+S2ia8KiceUrwS5slL4bA0Iqd+wqo
        ohB00q4fApovS+zisEN/eHVuuhQjrnk=
X-Google-Smtp-Source: AA0mqf7asXCtQ0rlubVyrLj+qjPgpUc0X2G+Mke6tvi1otGuoBInZWg2K4SIbniz0bSZr5JeqbMExQ==
X-Received: by 2002:a1c:770a:0:b0:3cf:ab80:b558 with SMTP id t10-20020a1c770a000000b003cfab80b558mr29008042wmi.155.1669347426156;
        Thu, 24 Nov 2022 19:37:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003b4fe03c881sm7241239wmq.48.2022.11.24.19.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 19:37:05 -0800 (PST)
Message-Id: <972d51888ba015a6697475025466432218efa6dd.1669347422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
        <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 03:37:00 +0000
Subject: [PATCH v7 2/3] git-jump: move valid-mode check earlier
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

