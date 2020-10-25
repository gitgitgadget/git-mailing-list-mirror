Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E780C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA8E20936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFk/ls7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766891AbgJYDO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766874AbgJYDOT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:19 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE3C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:03 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n15so5085482otl.8
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L02rjo4+/MtLroLh7HRKhtTUinqFIjVhSsYyby5xYBc=;
        b=dFk/ls7Q8q6g8R/cr2O463bdyH3MVUqW+RlfEhTj6D0fx/CgXpkWcEp8hcWgYB1Nt4
         bCF2RpoePVQzhD4m31pi0yO66pCmIdcHehJ3Ww/ESizvOUdiQ8tHbCcXL3K8c2AU0UWW
         Oa/mxILBuX6Hvog95HXMUlm79vUmR5Kx+OUigSxKalQNHMNF62PzH2S9fb5KUXqwU9Hy
         SeQHMvm83E+spFuIy6SopuFXPcWEqAHldKPhUOFCtkUd1G4BfJbCO5dScc82m7Qe2L4r
         JIj0o9RSMsQ2gSS3u8jpJY2j8OHiomSnEn5XPcoDRJCuO/mU4IvHCzi3o9S6EBm19Iyc
         +8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L02rjo4+/MtLroLh7HRKhtTUinqFIjVhSsYyby5xYBc=;
        b=a5qmv1dSu24YJceRyzRL/EB3xR+QUa1G4ETmKl6vUieD9wRzmZtIwIr2g6xNGlXR5c
         5K75qq5r3tan6b4r4u2BVbH9mFg3pF9F1CN1hO7l7LaVAiFtttHIF7RsdRjRg98icupY
         s7VXa0s0T9C/NuZmlQnC744XdvBFm0CrCRAwgZBtg84WJQYLy1IkWXF0AEn3tHLHdTGN
         DOJ4QXy80wzG0JKwk0usm25jNAfz6D1MWP15DNPdvWJoELcURl9mD7/u4p3s95YiEABO
         6moP2y8MzB6+9Ov0pCS8WibnTz04nnNvYCsobfd8Y8u6xSuIURxX2SOblWHWwdapYy2T
         W+4Q==
X-Gm-Message-State: AOAM5331UhrR8yZwzryvpEx8tFIx0tXoAoCdknofU7fTn/7ig0PtmXPP
        BgH2y8ppikckU/Vfr59OaLIVQlVNnE45Og==
X-Google-Smtp-Source: ABdhPJxGDetCiKQG7pIE9Ie585P+Qo+5peoRrQ79EBTB05Njtkaxn6bGxRhseYnUU5M9bHJm86VpWg==
X-Received: by 2002:a9d:6005:: with SMTP id h5mr6545188otj.87.1603595642296;
        Sat, 24 Oct 2020 20:14:02 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k22sm1872217oih.24.2020.10.24.20.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/29] completion: zsh: fix completion for --no-.. options
Date:   Sat, 24 Oct 2020 22:13:25 -0500
Message-Id: <20201025031343.346913-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was introduced in upstream's bash script, but never in zsh's:

  b221b5ab9b (completion: collapse extra --no-.. options)

It has been failing since v2.19.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 17041d0b23..c2a90beb8b 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -56,10 +56,32 @@ __gitcomp ()
 	case "$cur_" in
 	--*=)
 		;;
+	--no-*)
+		local c IFS=$' \t\n'
+		local -a array
+		for c in ${=1}; do
+			if [[ $c == "--" ]]; then
+				continue
+			fi
+			c="$c${4-}"
+			case $c in
+			--*=|*.) ;;
+			*) c="$c " ;;
+			esac
+			array+=("$c")
+		done
+		compset -P '*[=:]'
+		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
+		;;
 	*)
 		local c IFS=$' \t\n'
 		local -a array
 		for c in ${=1}; do
+			if [[ $c == "--" ]]; then
+				c="--no-...${4-}"
+				array+=("$c ")
+				break
+			fi
 			c="$c${4-}"
 			case $c in
 			--*=*|*.) ;;
-- 
2.29.0

