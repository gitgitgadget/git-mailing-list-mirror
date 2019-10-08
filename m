Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B7CF1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 09:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfJHJOQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 05:14:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38948 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfJHJOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 05:14:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so9921163pgj.6
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ts594nS4zQHySY8BrkzPNC+WfSPHB45nmos2s9P03a0=;
        b=YkBLe+JubZa1NRYQLTfstIbmB39q/Pr2pLdvMw6TCJ5g+sXVsN+wTHtBfb1dfUB3yj
         n1qa73Cp2+C5xw6XdO5FMgfU5gh8+96w1XDwhoqmzwsM6RkHQg4kQNakYumzC8HwITdn
         2dSO4nOsO0/mqXQrV2yVI3VYraiMqiaiZ5sdtBLibATIxbl4s/9VfUrPXFFmarRQns1S
         ktfoKAqmKWTrdNMEJATsw32bGjeOkAQquHbePvm6NhybRtC2J6KyBkZ31TFdShXHWG7m
         ZJFYsRJFwh3Sal5KhyFg+fNe/DLTdM0/u2lzH2Xe6vWZYcDEcyh3+cVOuklkyel9jtXl
         /xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ts594nS4zQHySY8BrkzPNC+WfSPHB45nmos2s9P03a0=;
        b=KeLR5G0ZijqJeOqcklx9ehWW6asLFxw8qTGCp5vXgaRk0JyGALBFAkJAQKXdUXfrtX
         Q2Q6nqWZdJhDnyUS/VtpReu3ZUIYprvH5c5hcHqBGGED3oUjtnAb2WOeXqzLfy0v3L4a
         7FrkEk+eCZau21R9vXZyfNJxwN4UGLeX5bxUMr7EamP1YR5a2KubCRvpevgOGBVqWjnj
         WhGiAb5YBTl5bdd3EkZ341ywFr2+sykkNtwyUkWW5AyDpo3MDXPssC8DpUscn3BsPn3n
         MosDuG2w8z5UFC1JJshmJJOtpNh3Be/erKARitTNZS4D78eJTAXRtp/UBY8V9lCh8SCv
         EAGA==
X-Gm-Message-State: APjAAAXbgCdzqfB50T9OOMmiXP7US3Px2a7C6ojyLQ0ZraOMWjYEKOS1
        YhzcPHQvIVCL0CYPqTb1WqNmyTlr
X-Google-Smtp-Source: APXvYqwyRET/zBNygWIei190PttsMt0+5VgchXLWhdVGQVPazKye8GNMohZi/ka7DqPeYvY6nUCdow==
X-Received: by 2002:a65:6407:: with SMTP id a7mr13355364pgv.123.1570526053358;
        Tue, 08 Oct 2019 02:14:13 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id d19sm1509607pjz.5.2019.10.08.02.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 02:14:12 -0700 (PDT)
Date:   Tue, 8 Oct 2019 02:14:11 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t4014: treat rev-list output as the expected value
Message-ID: <30d03ed76e46a10bea883ba3fe85b186fbf31d25.1570526007.git.liu.denton@gmail.com>
References: <20191007210306.GF11529@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191007210306.GF11529@szeder.dev>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 6bd26f58ea (t4014: use test_line_count() where possible, 2019-08-27),
we converted many test cases to take advantage of the test_line_count()
function. In one conversion, we inverted the expected and actual value
as tested by test_line_count(). Although functionally correct, if
format-patch ever produced incorrect output, the debugging output would
be a bunch of hashes which would be difficult to debug.

Invert the expected and actual values provided to test_line_count() so
that if format-patch produces incorrect output, the debugging output
will be a list of human-readable files instead.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for point out my mistake, Szeder. This patch can be applied to
the tip of 'dl/format-patch-doc-test-cleanup' and then we should base
Bert's changes on top of this branch.

 t/t4014-format-patch.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 83f52614d3..72b09896cf 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1610,8 +1610,9 @@ test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
 	git format-patch master..side &&
-	git rev-list master..side >list &&
-	test_line_count = $(ls patches | wc -l) list
+	count=$(git rev-list --count master..side) &&
+	ls patches >list &&
+	test_line_count = $count list
 '
 
 test_expect_success 'format-patch -o overrides format.outputDirectory' '
-- 
2.23.0.248.g3a9dd8fb08

