Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4342C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 01:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKTB1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 20:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKTB1a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 20:27:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D663B8
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 17:27:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b12so1120232wrn.2
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 17:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c99+BAgzJtOvTukoHupNR5U+51P1HwVnPNnuTBq86g4=;
        b=asXkFvNr3Hapm2Qo0k3XuXGPARwKmTOR8DzcZCfy0u1W/eAU7BB38duDvFXeKStFn2
         R2xjU9fw6KuXhc7gbaP/bx/ZRm3jPy2r7qFqt9dtaolvEhI+SAYFRGqzxvkQROyRLAgf
         299c17Fa2uJAi45JQk6AgxBcFEDEJm1VKSHBgr95knm4W2CrGxczSwwV1iBu/c8mbaQd
         tTetWpWn/J4kfOXNcSJd+AaWYgxP4hSjJ7b1o+3tyN3XoCgNRZUHv7d7ANWyRkqlqciH
         jQWaARFz/BDSQ4HOK+88dfYlGXkDtcC7qlKWW5Ps6px5UEqsXUoOU/oUl2qEqrLo/SvD
         K8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c99+BAgzJtOvTukoHupNR5U+51P1HwVnPNnuTBq86g4=;
        b=MYyHtcr8t+KIfIkV7s4NskdLzaCZ1dGJ5fwNhjCP6wfVEDxwS23NpQuI6PkKyOC+Wd
         oFHSUDDFijiGzQsxiwwiRdfIHIrjjmRx8Tv2QxwDti5yQvkWh75s6jBHw594Ar61b0+l
         5WBTHbA0zCWtOvwfQf4EDXd/NKftBgiexOHs2+pKE6vm1G+FTZpDGjrf0RSFwFyvi5WF
         +7Pyc7nJP3o/p4AA79OeKFK/lDXEkZdeWuSOVQSS1b4/P8rkOifxdMAurkfLljgpjFkD
         u1GKmJlzm+PRS13/44YAOPIZWpPQI9wS8MezMhM0pghxYEOR/apbz77pCyi2t76vsDeh
         QvOw==
X-Gm-Message-State: ANoB5plc8y+eldsRMpgMs7CvO0cN4lfeReDaX2zoXOLvfGmLgghiaLM2
        6DMl+/Rndee41AW45YxG7TxDRQ55HpU=
X-Google-Smtp-Source: AA0mqf6CgKUTwAB2dbWkmXYe1/VDMNbzLpNbMPNxJL7MTBkfhklMfebSDMS8OETPafRkTVD1VVmkXQ==
X-Received: by 2002:a5d:4845:0:b0:241:c1bd:9c75 with SMTP id n5-20020a5d4845000000b00241c1bd9c75mr4854106wrs.422.1668907647675;
        Sat, 19 Nov 2022 17:27:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb43000000b00225307f43fbsm7388180wrs.44.2022.11.19.17.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 17:27:27 -0800 (PST)
Message-Id: <72c4fd5532b89e21b55913b780311ec7e9fda9df.1668907644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
        <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Nov 2022 01:27:24 +0000
Subject: [PATCH v2 2/2] git-jump: invoke emacsclient
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yoichi Nakayama <yoichi.nakayama@gmail.com>

It works with GIT_EDITOR="emacsclient" or GIT_EDITOR="emacsclient -t"

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 contrib/git-jump/git-jump | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index a907f69304d..f267eac2233 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -26,6 +26,11 @@ open_editor() {
 	eval "$editor -q \$1"
 }
 
+open_emacsclient() {
+	editor=`git var GIT_EDITOR`
+	eval "$editor -e \"(prog1 (switch-to-buffer-other-frame (grep \\\"git jump stdout $@\\\")) (delete-other-windows) (select-frame-set-input-focus (selected-frame)))\""
+}
+
 mode_diff() {
 	git diff --no-prefix --relative "$@" |
 	perl -ne '
@@ -79,6 +84,12 @@ if test "$mode" = "stdout"; then
 	exit 0
 fi
 
+if git var GIT_EDITOR | grep emacsclient >/dev/null; then
+	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+	open_emacsclient "$mode" "$@"
+	exit 0
+fi
+
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
-- 
gitgitgadget
