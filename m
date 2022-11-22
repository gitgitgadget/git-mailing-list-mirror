Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77FAC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiKVOSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiKVOSb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:18:31 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC7767F50
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:18:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z4so10339549wrr.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BEb1b/8rgtSq2UdWqp5nXJuCIUFAQ0vxrjPJdpdIG0=;
        b=e0o/1v2ZPc08gWyaY6SGPgpZ1wqBJRdTwLYypbblvlBiLKD1lNpxvTvF2lUwG5Lrnr
         HQ3QQ0/synZ6lMoTc96mBAAG+WbvQC5GtsHK8IHH1u7byYLlYxsKuVXT0nKYyMs+d8z9
         2z74b3Qocx+O0QPQOR0ADn5K6KKVDBlmkO7JU8gals6fDV0yeYKsEgnRyL9zGkUlwSDu
         an8Oa532W/QnO7bYc2PuFuSYbzaZwVRqD49dPgeMW0tKkB0LJDNhX6QdvN+FYfvJhbaZ
         MoC2zT4yBKYbS/EqWAk9/Siw26v7nJzSKlLoJS5nK+EhAyAzR/zvOjmY8ctH7Iv0/M7C
         I6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BEb1b/8rgtSq2UdWqp5nXJuCIUFAQ0vxrjPJdpdIG0=;
        b=1n5nD9VCvVq+vhRCPi3gffvk6CmJGRrnV0x13YAYnLk9WmQg3ljOGn+GfK1HVJ/kyH
         UNDAr2NM+ET7Q1a5wqHxVJCEv4gW3zwaPTrZmv1VkH/EnduNkiGoNyM5wwEf0DuHT0z7
         nQvOQkla7VLsAfb2F8XiyuWxDaLbHvV4dTGmAsTDbf9VHHozq1sDBTZZvWMgenO4QQpH
         lOGHxePDqyRhTGgxrH4J7m8/sRvMlxhqZjKnMPoYocKjWRaegHOeK1lgGI5YaejHtCw4
         M+bdXxJAyw0p8+OMPVO5Vz896t4dZjpMX+m/gTRaMlFovpGq4HQ/9dhGnCr6yyHKz9Dv
         32ig==
X-Gm-Message-State: ANoB5pmmBSTbyj1WpWdexGWKcw83qpThZ7R9UcIUWlRxV3ohqEspAdxh
        HPFz93ByY3ZcXXYBWi1p38NVykY7Z7Y=
X-Google-Smtp-Source: AA0mqf5VUUevOKLHwIH6spqiCAj/lSe+AsmE2bfAOIzbgHecB8hYmAWrZ5cYZ64UEtnB/mR3qsF75g==
X-Received: by 2002:a5d:4d04:0:b0:236:6db4:a5fc with SMTP id z4-20020a5d4d04000000b002366db4a5fcmr14923427wrt.73.1669126708517;
        Tue, 22 Nov 2022 06:18:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c311100b003a2f2bb72d5sm27508170wmo.45.2022.11.22.06.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:18:27 -0800 (PST)
Message-Id: <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
        <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Nov 2022 14:18:23 +0000
Subject: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
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

It works with GIT_EDITOR="emacs", "emacsclient" or "emacsclient -t"

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 contrib/git-jump/git-jump | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index babb3b5c68d..bfd759aa4b2 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -26,6 +26,17 @@ open_editor() {
 	eval "$editor -q \$1"
 }
 
+open_emacs() {
+	# Supported editor values are:
+	# - emacs
+	# - emacsclient
+	# - emacsclient -t
+	editor=`git var GIT_EDITOR`
+	# Wait for completion of the asynchronously executed process
+	# to avoid race conditions in case of "emacsclient".
+	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"cat $@\\\" 'grep-mode)) (delete-other-windows) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""
+}
+
 mode_diff() {
 	git diff --no-prefix --relative "$@" |
 	perl -ne '
@@ -98,4 +109,8 @@ tmp=`mktemp -t git-jump.XXXXXX` || exit 1
 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
 "mode_$mode" "$@" >"$tmp"
 test -s "$tmp" || exit 0
+if git var GIT_EDITOR | grep emacs >/dev/null; then
+	open_emacs "$tmp"
+	exit 0
+fi
 open_editor "$tmp"
-- 
gitgitgadget
