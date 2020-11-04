Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A5C388F9
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CF42067B
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4f81O0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgKDRrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbgKDRra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:30 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B829C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:30 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s21so23071143oij.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7CI/ZykoKzaO59Xhwn/2SBndJ4CIFMdgttXarqFQHk=;
        b=U4f81O0x62WLfE1ZWbJXdd7X/rL8LWz7MGTqKoJs/jieB7SmGd80+MC/iQzMXQPzkz
         oQZuRcRtaLj8NxVzk/ytgzjkDQP4+5d9Vx9+UzWRlOwOUYKSgAKeXqUWy1VKl71OqAVY
         ykzFjNrhxxTDFstrXtfNoqaorgh4XGUiZOmIQbLlqyPQpem7/QF0mP54xlgvxDyCu6r7
         PwtffOxOX2ktY9AC1798G7K1loh9yov69LpLuwkMWykDDY98xZTBCxw+U9Nb3ktlZm3f
         cW1a0zaHdSnyxyyDeCwtoJ83uQvB4EpAwSBEf9/SyAF3iszHxCREHG8thvqPpi+Ckiti
         6eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7CI/ZykoKzaO59Xhwn/2SBndJ4CIFMdgttXarqFQHk=;
        b=YwyfBcGYlipEeGP6Zrmzqg89ROebxyjkkjfzdiUXY7TG3AAVIsY9txidsyPmHeVvFc
         4zs4T6ODRMNN5DxqW/gtIk7yZJSffkNp8TEzXNQS5YKGKFQrK/vFMXxVPrY/kZ7xXoR8
         pIOG3ATNdkAuU1JgTjEKlO5m39kRLy+++uLBTAfwgmUWRy1ixtskjAfjDB669BuyHwLu
         B/TLV5a4lC3UWiOIiCrIJH6SydmOR2e8nmQFDcFU0w+UhY1dxA9IouC5ndX3Dy66RROf
         3mbg1zDDVtv81x6HlPbCY3N6Ff6Vqp+XXHjNDMJQAFKOPAnZjLlR8CHQJGUlsTM8Gi2w
         sHMw==
X-Gm-Message-State: AOAM532lIbwBa7AJ14Mu08Pvf3YpNklxz+LcuM8wo8JKs/eq3oyRhDju
        KWfrSjfHyuKoO7mTuqDKA0ghdBQId+uRzg==
X-Google-Smtp-Source: ABdhPJwofygNpbz6+iUGEglcAwy4CR9dZHWd0o9efREiT7wAYlYP3s4lhVqDdEMq2VQCY6CXdCPZbg==
X-Received: by 2002:aca:88b:: with SMTP id 133mr3109018oii.143.1604512049169;
        Wed, 04 Nov 2020 09:47:29 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k13sm677557ooi.41.2020.11.04.09.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:28 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/10] completion: bash: simplify _get_comp_words_by_ref()
Date:   Wed,  4 Nov 2020 11:47:12 -0600
Message-Id: <20201104174716.783348-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need the whole functionality of _get_comp_words_by_ref(), we
know exactly what we need from that function, so only do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 30 ++++++--------------------
 t/t9902-completion.sh                  | 21 ++++--------------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 90202e11a4..1bd81dcc9c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -260,30 +260,12 @@ __git_reassemble_comp_words_by_ref()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local exclude cur_ words_ cword_
-	if [ "$1" = "-n" ]; then
-		exclude=$2
-		shift 2
-	fi
-	__git_reassemble_comp_words_by_ref "$exclude"
-	cur_=${words_[cword_]}
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=$cur_
-			;;
-		prev)
-			prev=${words_[$cword_-1]}
-			;;
-		words)
-			words=("${words_[@]}")
-			;;
-		cword)
-			cword=$cword_
-			;;
-		esac
-		shift
-	done
+	local words_ cword_
+	__git_reassemble_comp_words_by_ref "=:"
+	cword=$cword_
+	cur=${words_[cword]}
+	prev=${words_[cword-1]}
+	words=("${words_[@]}")
 }
 fi
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index ab5134cdcc..bc18bd4b68 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -40,23 +40,10 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 # So let's override it with a minimal version for testing purposes.
 _get_comp_words_by_ref ()
 {
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=${_words[_cword]}
-			;;
-		prev)
-			prev=${_words[_cword-1]}
-			;;
-		words)
-			words=("${_words[@]}")
-			;;
-		cword)
-			cword=$_cword
-			;;
-		esac
-		shift
-	done
+	cword=$_cword
+	cur=${_words[cword]}
+	prev=${_words[cword-1]}
+	words=("${_words[@]}")
 }
 
 print_comp ()
-- 
2.29.2

