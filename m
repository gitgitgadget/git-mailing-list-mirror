Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021F71F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKNUr1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40864 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfKNUr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so4536484pgt.7
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0xO0lyTJrWByytXScHwPBPvY8wmak2TTIeuNrAkareg=;
        b=WdsOw3jsBQBUIb6+B/+R1+JO9AMUM1d0QddJ5H5HSwueHElpsqJhwj/hl893zlShEk
         BVftDidUX84McxyN2AoRqnu6KqJdu2+M7vLc402MUxIMrWaMF7ylYPaxlTeQiirJOLzE
         ffxjDY93dTZR0mGgXaXYcWrg9wghK6fNr3qA4oIRhZmzFFryD6bAHvJIOrkwXWBK82Wb
         Dg9QR84phAcz9Y7u0Ff483PyBKg9gzFgFgwE8ZMjGL/3Y3UgXD5QaNvvtQorBiKBihiX
         WwBOa6xIyUt+xXsl6SdONrc9+xemHXqVZ5N4NLyRJ0mguvUsOeX5iPa/WkbczAfUPKRD
         8mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0xO0lyTJrWByytXScHwPBPvY8wmak2TTIeuNrAkareg=;
        b=WxIbXnM8sBU/6nd70AIfjeECUsmlHANG+42tJf32Zm+uFM2NYM8hC713dxDpHOIkGZ
         /BPQWnHzPKfSPwRO1X0ofgLBdUKd3wWc43aNyhUWzqafDWqieVlO1SVn98DPuoFFqLCr
         xFJnV+advrLKbCUAZ7enuWlZk3tJEF8OWrkoUL2KOb65WrHej5PqVFjdV6eC0DE4Z5K8
         Y7NWGUnYiKnMjsnhJfJGXxU+DkcbCYtaH168EFGV1r1f6qjQBmLPeqQBuUQ7Go4IKroh
         61Ou2G5WJ7Pwu0da6E9rUIlajlhmv+K2uRVSXkpzbRYX6LJu1JpCbbRnab+Z8vBwkzLg
         gsrw==
X-Gm-Message-State: APjAAAVCYWvsu8xyY1gILnbpxXeTvanu+JYovao/2L9sBH81lKUmh5gj
        JLvsCuKvDm6UEX2FIjOAMGGfEwTh
X-Google-Smtp-Source: APXvYqzPX9+8ZRGwcNRHiazAk9jhQHbKIUeCfXT0Y4rMgcS9aa1O9z6X3lxu3vXaDqk8dhVKDLu4yQ==
X-Received: by 2002:a17:90a:634a:: with SMTP id v10mr14961533pjs.4.1573764445796;
        Thu, 14 Nov 2019 12:47:25 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id w2sm8074933pgm.18.2019.11.14.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:25 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 08/10] pretty: provide short date format
Message-ID: <fe5cb165ae9550673bcc61057672381c4f524e46.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Add the placeholders %as and %cs to format author date and committer
date, respectively, without the time part, like --date=short does, i.e.
like YYYY-MM-DD.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-formats.txt | 2 ++
 pretty.c                         | 3 +++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 4cefa64eeb..11979301ff 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -172,6 +172,7 @@ The placeholders are:
 '%at':: author date, UNIX timestamp
 '%ai':: author date, ISO 8601-like format
 '%aI':: author date, strict ISO 8601 format
+'%as':: author date, short format (`YYYY-MM-DD`)
 '%cn':: committer name
 '%cN':: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -187,6 +188,7 @@ The placeholders are:
 '%ct':: committer date, UNIX timestamp
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
+'%cs':: committer date, short format (`YYYY-MM-DD`)
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
 '%S':: ref name given on the command line by which the commit was reached
diff --git a/pretty.c b/pretty.c
index 4d633f14fa..4d7f5e9aab 100644
--- a/pretty.c
+++ b/pretty.c
@@ -738,6 +738,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'I':	/* date, ISO 8601 strict */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
+	case 's':
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
+		return placeholder_len;
 	}
 
 skip:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 0335b428b1..da9cacffea 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -533,6 +533,12 @@ test_expect_success 'ISO and ISO-strict date formats display the same values' '
 	test_cmp expected actual
 '
 
+test_expect_success 'short date' '
+	git log --format=%ad%n%cd --date=short >expected &&
+	git log --format=%as%n%cs >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 test_expect_success 'set up log decoration tests' '
 	head1=$(git rev-parse --verify HEAD~0) &&
-- 
2.24.0.346.gee0de6d492

