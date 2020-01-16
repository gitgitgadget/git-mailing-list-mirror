Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A0BC33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 08:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1BB2077B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 08:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFT7GQ6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgAPIdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:33:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgAPIdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 03:33:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so18184191wre.10
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 00:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xy5zpyZpBlRDsLQr63r8Pm6MiLygSuffFFjgx+67h80=;
        b=NFT7GQ6haaf3eH2zD49mdOIV8GUkb9qBgwHCee/KPKPecj/uKi/Wb99DjVam7U1EOd
         8I5ZQ+WrTyS0X+zH4IRRsn4UzK5k/xiI+hl11EWgB0f2i1qJCR1neb+zQxpHcEviDg/0
         hhdI/0rxsPivYDZCduY5aRp94WS5mRYpOlN1Dpss12o7ngfvJxkbqZVEsjRGuJKdI8kH
         13s0bVYVwGJsGzXNk+lNk/sLC5vjd+fh2fJUbqitwhw8z9MNgSIWlOF0ggo9BIqzykUU
         KYO0J4Sv36UxP2bUDY1DzeIrtqeCFbw5x7pXhpPz5bO53LMMvWvkd/0sFbUkQ0monpqj
         JW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xy5zpyZpBlRDsLQr63r8Pm6MiLygSuffFFjgx+67h80=;
        b=JHizsVMwtjuSo+82x1gZWIZ+EZOovVK/i1F4dR17diE/TmOIZ/xEr7jay0jQY4inDE
         KGAynvPAVya7fsKhT4uk/cH7SHQU5wTEn4EfePn02rB/epaei3L22NBBp/fm5Y8J6f0v
         iUNtGs4S3eehNP6RegFiKcv67eVgNBdtx1DWe3pEKGPnuSAiMnqLZ9kILZ6Po5MlrKrM
         CbIzMEIcKE3U3olYJn8MUkiFSaSulPEqXXNSXhHhuSGPPmO8hVLTQkei8g/BoijEFCZW
         xeM6300klUNsNc4cRdZkfg5zvrNaiV99Etuoqvt+/aAnTxrE/dIQzsEfGq3RRtc9s4Dv
         eXqw==
X-Gm-Message-State: APjAAAWx803vT6d6nMjStOPmyWRJE8ontKmf5llhNGocWUvcyLX+JX/P
        2zVdQ1MXkgfQil8uoEu2FjxCqoN/
X-Google-Smtp-Source: APXvYqzuJKD7fqlPgxTfrsnKxd9INBf5nFZ/ge4AG0MnfymnUStx7SL5aaawE+inhWNQzMmDF067OA==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr2092877wrm.80.1579163590244;
        Thu, 16 Jan 2020 00:33:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm27348308wrs.53.2020.01.16.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:33:09 -0800 (PST)
Message-Id: <7e4bf4bbbcd8c81a19d690aee379042e47246947.1579163587.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.528.git.1579163587.gitgitgadget@gmail.com>
References: <pull.528.git.1579163587.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 08:33:07 +0000
Subject: [PATCH 2/2] built-in add -i: accept open-ended ranges again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The interactive `add` command allows selecting multiple files for some
of its sub-commands, via unique prefixes, indices or index ranges.

When re-implementing `git add -i` in C, we even added a code comment
talking about ranges with a missing end index, such as `2-`, but the
code did not actually accept those, as pointed out in
https://github.com/git-for-windows/git/issues/2466#issuecomment-574142760.

Let's fix this, and add a test case to verify that this stays fixed
forever.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c          | 5 ++++-
 t/t3701-add-interactive.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 14d4688c26..396066e724 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -328,7 +328,10 @@ static ssize_t list_and_choose(struct add_i_state *s,
 				if (endp == p + sep)
 					to = from + 1;
 				else if (*endp == '-') {
-					to = strtoul(++endp, &endp, 10);
+					if (isdigit(*(++endp)))
+						to = strtoul(endp, &endp, 10);
+					else
+						to = items->items.nr;
 					/* extra characters after the range? */
 					if (endp != p + sep)
 						from = -1;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d4f9386621..b02fe73631 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -57,6 +57,15 @@ test_expect_success 'revert works (initial)' '
 	! grep . output
 '
 
+test_expect_success 'add untracked (multiple)' '
+	test_when_finished "git reset && rm [1-9]" &&
+	touch $(test_seq 9) &&
+	test_write_lines a "2-5 8-" | git add -i -- [1-9] &&
+	test_write_lines 2 3 4 5 8 9 >expected &&
+	git ls-files [1-9] >output &&
+	test_cmp expected output
+'
+
 test_expect_success 'setup (commit)' '
 	echo baseline >file &&
 	git add file &&
-- 
gitgitgadget
