Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591F020248
	for <e@80x24.org>; Thu,  7 Mar 2019 15:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCGP3h (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 10:29:37 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41330 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfCGP3f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 10:29:35 -0500
Received: by mail-ed1-f52.google.com with SMTP id x7so13796775eds.8
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZP6u+RyuMXEX/RuloqYCxwo2Z0KavvceBFJL6W7xzjc=;
        b=ALytWdvpbsXerX1i73y6a0QlcOVm5D0zSltPG5oaLTn71NEb1W4kLhzqCmUQXN9A7t
         tgcuqJhAxy5Cy4iYfyomM7jLXZWACTojNCGzZOGYh6zg3UdkswH2PuaK9BZbBfBOBp2f
         Rb1yVSaJh6f2mkPdP7vV7wSQYbYXzGT2vThzIMYolRrxJunVoho1ytywijvkqOnV0QoQ
         cWTD4pRmoCwKw3vY5Sbblpbqk95OVaWYVHAd26Erwf1NHL88IXTvr/5dSEQYBqpike3v
         gu6ao7sLEY8UeqV07cj/MiIdJSt77WFI1UzmX7LJfkMGPGCB/yPpIPsVsli6wlekdpAt
         0zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZP6u+RyuMXEX/RuloqYCxwo2Z0KavvceBFJL6W7xzjc=;
        b=MJWD52Qmg82MozwNgampMkUo5jnUwhJR93PoHOAVK7FBUt0/iJ6jl0mKb7UbjRcUuE
         0bgiYw9eV3RQu11ed3z9lEBYlb0ZrjRwqL9y1+t97kq3LREHGAWIXLB/k8wz3pcc8Vgf
         z6qSIs1a5+sH3jnUQM3PWmL6ReF+bJgepYMQRN9eVoROLtqdvIqWkS3tGLrMoNHbo+G1
         UK9zeqam8qE+SMx4gv924plIwLkmsrqeVDNcp0NikFc5DtGzgemiqWUaotfBT8qkGuiu
         L7VQv9vf5HsOLNhi5noPN4HhOvEx4gFG3/0jaiOzAp0c5g7wdcgvED0U0zkxUH5emsFk
         pocQ==
X-Gm-Message-State: APjAAAUmyif8RF9zY5sHBOfhbGbVijfqW7vB3J73caAartmKxvvn6pTR
        VnFa9MBoC/t+m8cE2EJrx3koQYiJ
X-Google-Smtp-Source: APXvYqwPifPZhOtCGwJjw1qkTkb3J3teiFMbwfxY2ky98hsWxwTdF1rrHSLmoxdsl6P5ztKmawccTg==
X-Received: by 2002:aa7:d795:: with SMTP id s21mr27657026edq.116.1551972573290;
        Thu, 07 Mar 2019 07:29:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm1463252edb.36.2019.03.07.07.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:29:32 -0800 (PST)
Date:   Thu, 07 Mar 2019 07:29:32 -0800 (PST)
X-Google-Original-Date: Thu, 07 Mar 2019 15:29:30 GMT
Message-Id: <f76c7cb66c43a6c4bf712516949a867b09710103.1551972571.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.159.git.gitgitgadget@gmail.com>
References: <pull.159.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] legacy stash: fix "rudimentary backport of -q"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When this developer backported support for `--quiet` to the scripted
version of `git stash` in 80590055ea (stash: optionally use the scripted
version again, 2018-12-20), it looked like a sane choice to use `eval`
to execute the command line passed in via the parameter list of
`maybe_quiet`.

However, that is not what we should have done, as that command-line was
already in the correct shape.

This can be seen very clearly when passing arguments with special
characters, like

	git stash -- ':(glob)**/*.txt'

Since this is exactly what we want to test in the next commit (where we
fix this very incantation with the built-in stash), let's fix the legacy
scripted version of `git stash` first.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-legacy-stash.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
index 8a8c4a9270..f60e9b3e87 100755
--- a/git-legacy-stash.sh
+++ b/git-legacy-stash.sh
@@ -86,17 +86,17 @@ maybe_quiet () {
 		shift
 		if test -n "$GIT_QUIET"
 		then
-			eval "$@" 2>/dev/null
+			"$@" 2>/dev/null
 		else
-			eval "$@"
+			"$@"
 		fi
 		;;
 	*)
 		if test -n "$GIT_QUIET"
 		then
-			eval "$@" >/dev/null 2>&1
+			"$@" >/dev/null 2>&1
 		else
-			eval "$@"
+			"$@"
 		fi
 		;;
 	esac
-- 
gitgitgadget

