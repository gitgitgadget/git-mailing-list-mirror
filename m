Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C73EC4167B
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 01:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiK0BS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 20:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiK0BS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 20:18:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06F13F8C
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:18:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z4so11725506wrr.3
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV+yf9bsKtmbK0vvxVAsOX7nnNsNOPrJgxMSGqFUauk=;
        b=MgXatTECCLPsRWo+RiWQD3/EIMpiZdTdi0iyARlF8WsmWxhXr9CYuFmQYgyk7x30R2
         jgoQDRfDKknx8gWdbYB0DLgC8aVRDZE5RCZSpkqwiVvosaayzHmKh3FRF3oUL8ivRQOa
         HdEu/fg11L2tGYL4rTDcSL0/xPV8erkQHQp3xuxmN0Y18T/v+8ESBwDkj68mxFWmfDG8
         MBzAEPCtWzh8KhaxDZh4SzgtXDhLIqZPKDtapitjPwMplHd7qASHFCMQlJ744trb1+UT
         L7Mw7TfjCewlX8eQe3Bpe4Kn+CVwU8rrLYHwR/iRllXTv5jqdqELcJ7Gqu2OSRmsV/VD
         t5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV+yf9bsKtmbK0vvxVAsOX7nnNsNOPrJgxMSGqFUauk=;
        b=6+s0Lts15ElVO/hqk52lVGZoEr34o8xb0miZcInEuy4oDTIFf0pqo15oMRpoWdhQG3
         EuH2vLKasIrwkFdFZWuqfNMLGf5njCK3Gc4C5p7CHOXPjMY0htub5HlYoF2wI/7ddqEB
         CpAgse1cnaYjo/LRUXVpn/vcPz1XXPbYfrfEj/t8lNuScdukSdNxoON8fuRqExHqg2M/
         ob8OLlLIQWGLGjRdYXglqbubIvPaC5bJ+8hjxks0PiGfumgqcqj+htBt2yWjbJka1e03
         nRx0Q9CC54i5P45reL+8f/ZVRLxH8dzAg3I237/5/xwjoJ9tzBZjqC10Ewqmk4iIXvpV
         Ihlw==
X-Gm-Message-State: ANoB5pnnFbnTq0yENDQHO3kdiWR1KfT6eClZJnjOTAGJr+lWpKuons/8
        k+bgKmLMX5goAPWvMP0UnLY0CKe800o=
X-Google-Smtp-Source: AA0mqf5lWzgXwAgW4wn8woyKm9PTdVPLS5SRzvtrPNRnbGgxdobwPyBVHqV/i5qbemzMXdfBmopI5A==
X-Received: by 2002:a05:6000:1c1:b0:242:1339:d3c4 with SMTP id t1-20020a05600001c100b002421339d3c4mr563293wrx.486.1669511935409;
        Sat, 26 Nov 2022 17:18:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003cf57329221sm15302166wms.14.2022.11.26.17.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:18:55 -0800 (PST)
Message-Id: <afface9b0102c888817f3bd3481dbd7278236954.1669511933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
References: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
        <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Nov 2022 01:18:51 +0000
Subject: [PATCH v8 1/3] git-jump: add an optional argument '--stdout'
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

It can be used with M-x grep on Emacs.

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 contrib/git-jump/README   | 10 +++++++++-
 contrib/git-jump/git-jump | 25 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 8bcace29d21..3211841305f 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -79,6 +79,14 @@ git jump grep -i foo_bar
 git config jump.grepCmd "ag --column"
 --------------------------------------------------
 
+You can use the optional argument '--stdout' to print the listing to
+standard output instead of feeding it to the editor. You can use the
+argument with M-x grep on Emacs:
+
+--------------------------------------------------
+# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
+M-x grep<RET>git jump --stdout diff<RET>
+--------------------------------------------------
 
 Related Programs
 ----------------
@@ -100,7 +108,7 @@ Limitations
 -----------
 
 This script was written and tested with vim. Given that the quickfix
-format is the same as what gcc produces, I expect emacs users have a
+format is the same as what gcc produces, I expect other tools have a
 similar feature for iterating through the list, but I know nothing about
 how to activate it.
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 92dbd4cde18..be0642bbe34 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -2,7 +2,7 @@
 
 usage() {
 	cat <<\EOF
-usage: git jump <mode> [<args>]
+usage: git jump [--stdout] <mode> [<args>]
 
 Jump to interesting elements in an editor.
 The <mode> parameter is one of:
@@ -15,6 +15,9 @@ grep: elements are grep hits. Arguments are given to git grep or, if
       configured, to the command in `jump.grepCmd`.
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
+
+If the optional argument `--stdout` is given, print the quickfix
+lines to standard output instead of feeding it to the editor.
 EOF
 }
 
@@ -64,11 +67,31 @@ mode_ws() {
 	git diff --check "$@"
 }
 
+use_stdout=
+while test $# -gt 0; do
+	case "$1" in
+	--stdout)
+		use_stdout=t
+		;;
+	--*)
+		usage >&2
+		exit 1
+		;;
+	*)
+		break
+		;;
+	esac
+	shift
+done
 if test $# -lt 1; then
 	usage >&2
 	exit 1
 fi
 mode=$1; shift
+if test "$use_stdout" = "t"; then
+	"mode_$mode" "$@"
+	exit 0
+fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-- 
gitgitgadget

