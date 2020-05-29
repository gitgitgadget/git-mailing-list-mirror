Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BDFC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE9B2075A
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl8JY0UR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgE2IUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2IU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:20:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7E9C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:20:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so896158pjd.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tmuxbxsyBl+aR/8Yk9i3+YtaNfXzCQa0pN64afvq3YU=;
        b=Pl8JY0UROAKOevlX9leKf9qIh9Osk6mzh+7WLXyq8UE6wzAFl+MEjh2s2tgYJUhiAF
         YVE4S/hFTCcfhF21clkTN5HZsnd8X/4RJaZM6T0hYNwmvR5539PvDiKquNcoh2WgUnw9
         BySV0z4ZAAXK+XLqTxD5bEgqdeOLPs581ytXrFOFa7e5Wbd8uBAZ03FcWxgXjSMNXXkU
         Mli4+RA1uhPl795oYEqXnWl8xZIVWwveHlrbrh0a3qr2JWfQ1wjsX4UTZbQ3vwBiIX5i
         AYlGbMpH64FAZ8TKuWXUdiaKsYgtGkdVKdb+r09GurrfIufTxovpm1RG+Av/UhBPdta6
         bGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tmuxbxsyBl+aR/8Yk9i3+YtaNfXzCQa0pN64afvq3YU=;
        b=HQhOOLjtBrMNgLxk1qccVcM9BCNlRIu60DPwNxKrWWOj5FmWSU2p09BEKM594YDuzs
         scwVN5UW5aWV4x0fgiggKwOFtxhsloyjWBGo8YlA6Yl9qOOMGJquf/rntqmVT3PhE1Hp
         gyxsKgJnF76leQ9SFxUjmsd5ooymQ5+DhmopjQjPsGq1IvaV7b2Oq8o2Yf/JuKaNjAJC
         wdooMIbLbcvp0OvLXMy8XiC9xAq6/NAuSUiXShs7wL7px6Vd2uTRaUrT09jN6luJvr5Z
         PO1eizBOikmPrlT98TwstL16nv+v5qgrel6g6wHeh/HptcWknPAjo7AWsgLSK27+H06T
         o/UQ==
X-Gm-Message-State: AOAM533xu0abJSgY7DI0lXLE2etGM+0IREF3a8PW4RPCNBK8QEeS//BY
        CSxXJk2WgU2PhyrFQvFmrvnXNOoE
X-Google-Smtp-Source: ABdhPJwnE1Ny/ImpGF+O2HMjvgz7pp8ebs8JH0P0mo380ozT/8miY6ZO2hYYr2FOhlJW0f4V02LCJQ==
X-Received: by 2002:a17:90a:1a8a:: with SMTP id p10mr6978940pjp.236.1590740426663;
        Fri, 29 May 2020 01:20:26 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id q44sm7756307pja.29.2020.05.29.01.20.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:20:25 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hji@dyntopia.com, gitster@pobox.com, peff@peff.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] t: avoid alternation (not POSIX) in grep's BRE
Date:   Fri, 29 May 2020 01:20:08 -0700
Message-Id: <20200529082008.26880-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc2.257.gaada2199e1
In-Reply-To: <20200528083745.15273-1-carenas@gmail.com>
References: <20200528083745.15273-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f1e3df3169 (t: increase test coverage of signature verification output,
2020-03-04) adds GPG dependent tests to t4202 and t6200 that were found
problematic with at least OpenBSD 6.7.

Using an escaped '|' for alternations works only in some implementations
of grep (e.g. GNU and busybox).

It is not part of POSIX[1] and not supported by some BSD, macOS, and
possibly other POSIX compatible implementations.

Solution: Use `grep -E`.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t4202-log.sh           | 2 +-
 t/t6200-fmt-merge-msg.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index f1ea7d97f5..a0930599aa 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1692,7 +1692,7 @@ test_expect_success GPG 'log --graph --show-signature for merged tag with missin
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-nokey >actual &&
 	grep "^|\\\  merged tag" actual &&
 	grep "^| | gpg: Signature made" actual &&
-	grep "^| | gpg: Can'"'"'t check signature: \(public key not found\|No public key\)" actual
+	grep -E "^| | gpg: Can'"'"'t check signature: (public key not found|No public key)" actual
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag with bad signature' '
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index b15582a7a2..e4c2a6eca4 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -103,7 +103,7 @@ test_expect_success GPG 'message for merging local tag signed by unknown key' '
 	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
 	grep "^# gpg: Signature made" actual &&
-	grep "^# gpg: Can${apos}t check signature: \(public key not found\|No public key\)" actual
+	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
 '
 
 test_expect_success 'message for merging external branch' '
-- 
2.27.0.rc2.257.gaada2199e1

