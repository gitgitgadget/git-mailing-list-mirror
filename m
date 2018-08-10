Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E051F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeHKBGk (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:40 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:47936 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:40 -0400
Received: by mail-qt0-f202.google.com with SMTP id b7-v6so8563845qtp.14
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4sFPQRkuXWTQRhdr/8R8CbJQpLxLrw/y8NEQr2Oq0No=;
        b=tQGqdU0MhepfYWmW1MdumIXpq9HM4Yb98+fJOL7hsS7XaLFLknROvOE5QcoDHfftVY
         5N34OEcUorTK37cJCDcp7TLmW55VT6eiyJ4gJO8G9x81UXhe5CDIU7l/JbUYsG4PhNSL
         Vyc5tj6SMh4QB/OPtOEkrjQIolz/auRAoFTTrZQ1BLVAhC+XmMgxO2HZISFWlcxe1M5C
         uXce5iACKyw3E3syWsH7Za+yFL5rhhBSCfo8J2P7NpLrypviHUPlAHSNNVuPglZ/Hi1X
         WWhYRB7QhrOtYo/gDt0Anc4rRdcM6TQ8fEKKEbqyjmkuYzPgghiEPLv2Egg6zzXsn0df
         eHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4sFPQRkuXWTQRhdr/8R8CbJQpLxLrw/y8NEQr2Oq0No=;
        b=HqdK32BP9L7PcRQTIGK3QraXVU1RxPYGvnJh6D0drLq8k/OUV2v/duUIiqjs+5D7EO
         7nPOGWUklOoVcXCAh3VF7BHg+iPryyKEn29lpHUdLps6bD9PV4MGlSUArOIRdvSuhZGB
         A5t+ttVDRLtDjqt08QiCJvegX+EjWKsrnbroHpUjYZ38AtOxzthAQxwIdYhBf1X+4uev
         Tk4hXFVLUbbSSZii8TonBJ49XEWhFxYx652Nw1wEKVrlvQuFxfz1Kl0n/y5Q2T1qdBTE
         sqq7z6Kr+wof1NAsFPiVoniX9bFFaJftfB6h62vtsC1CqIcVWOgvzRId0/y2QXMfcAKP
         4iTQ==
X-Gm-Message-State: AOUpUlHqZ87tYbnG+kJek3Ydu1z2tBwnrQ/ShFsh+pPvq4eM+6FmKBNn
        iUE74HNqLGPLyDCFJBHOue+54IWXjnzl
X-Google-Smtp-Source: AA+uWPwpIpjrpO0VvIqeMnCFHNYnFv/TfP4u2jU9TCkPCtj4W+SIQdeaIlaFLdVQL3MiYBGIJRDbB0nQTOEz
X-Received: by 2002:a37:c858:: with SMTP id c85-v6mr4920006qkj.48.1533940490368;
 Fri, 10 Aug 2018 15:34:50 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:35 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180810223441.30428-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 2/8] t3206: add color test for range-diff --dual-color
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'expect'ed outcome has been taken by running the 'range-diff | decode'.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3206-range-diff.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af9..7dc7c80a1de 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,43 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'dual-coloring' '
+	sed -e "s|^:||" >expect <<-\EOF &&
+	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
+	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
+	:    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
+	:     <RESET>
+	:         s/4/A/<RESET>
+	:     <RESET>
+	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
+	:    <REVERSE><GREEN>+<RESET>
+	:     diff --git a/file b/file<RESET>
+	:    <RED> --- a/file<RESET>
+	:    <GREEN> +++ b/file<RESET>
+	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
+	:    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
+	:      9<RESET>
+	:      10<RESET>
+	:    <RED> -11<RESET>
+	:    <REVERSE><RED>-<RESET><FAINT;GREEN>+BB<RESET>
+	:    <REVERSE><GREEN>+<RESET><BOLD;GREEN>+B<RESET>
+	:      12<RESET>
+	:      13<RESET>
+	:      14<RESET>
+	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
+	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
+	:    <CYAN> @@<RESET>
+	:      9<RESET>
+	:      10<RESET>
+	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
+	:    <REVERSE><GREEN>+<RESET><BOLD> B<RESET>
+	:    <RED> -12<RESET>
+	:    <GREEN> +B<RESET>
+	:      13<RESET>
+	EOF
+	git range-diff changed...changed-message --color --dual-color >actual.raw &&
+	test_decode_color >actual <actual.raw &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.865.gffc8e1a3cd6-goog

