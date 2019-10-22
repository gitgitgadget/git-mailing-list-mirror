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
	by dcvr.yhbt.net (Postfix) with ESMTP id 009201F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfJVKUd (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41912 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so9659018pga.8
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIiffT/wTCLcDiOOUgSgbOKq+qcZ+pfAGNxqb45C5s8=;
        b=RpC39L0b96f4ZCwh978V1GR1Q+L0OWdUwBt3N0QRIQgYmQ41pb9W8qPFGVyatbhGqu
         WopQOtmlKjrAjQvzKINTfRK1EmeEQ9g3GN55+Yy7/rbq/4YqUMbC4glLl6kglUOXS6J0
         eLcxu4N4gqzM8e4Wdh+cFdatr6NUuRkUgmxBn4SG03eMHoLJILyPfLA1SUEFxc65uG0a
         y5+IU8WZFNx/oOFkOT36OIYD3o3auGNBIdWBVO3j6bRb+/5TzHjQbsgXD/222X4itILv
         ZEEHIOaKq9Ep4OAoptoRTQsKpKbVkwvjmoCaAprt/6mMbFfXR7c2f5DcR3+xNCwJzFcn
         H93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIiffT/wTCLcDiOOUgSgbOKq+qcZ+pfAGNxqb45C5s8=;
        b=HV35LrAxgVV34T7ysENY9VsmZvBigjQCrcxx5nr1/k05BJNYwVjqRWSJd6umZ6isE8
         DjNbGghR8gGjNSVbHvaeJKyOpjhGF8+lLoWeqjlBSTXNb+WLfmY5SMPt/U8A8BsLpf96
         s4MSonWQaQLdEoWrDpl466K8xde+3T/1T7U3nOrXiPOIhuQQVbl2lReccI7Y84M5v5nI
         IEVxqPJ6Q5anSDaK6SyxXIj9hOl0rr9HCslHOxsC5QrtSw0YH5cTMauB8R9z8D6duaci
         1XdanKq5+VTu0jv8cqlMCL7XGCxc3MSs2ulVp1vyCPydw83R+BhMEkJclca74apEB/ce
         4IBg==
X-Gm-Message-State: APjAAAUPoHw4MqX1mdsSLhg5cafUcQI5mFO2ubhW1CpPS8B5rfTVZJxz
        pI4cC9NMIjgA9Z3X697N2xpaESRF
X-Google-Smtp-Source: APXvYqxTGG4kTTDCGyuI18Wfij5BbmibWQeM592KYMZKIViY6pV8ML43pJAW+FS27kcptUHGBb5UHQ==
X-Received: by 2002:a65:4189:: with SMTP id a9mr2904334pgq.380.1571739631558;
        Tue, 22 Oct 2019 03:20:31 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id m2sm23850443pff.154.2019.10.22.03.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:30 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:29 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 14/14] t5520: replace `! git` with `test_must_fail git`
Message-ID: <a721d5f119c18c13584f648cabfbffecf9b0db21.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if a Git command fails in an unexpected way, such as a
segfault, it will be masked and ignored. Replace the ! with
test_must_fail so that only expected failures pass.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ef3dbc201a..602d996a33 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -537,7 +537,7 @@ test_expect_success 'pull --rebase=i' '
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-	! git pull . copy
+	test_must_fail git pull . copy
 '
 
 test_expect_success '--rebase=false create a new merge commit' '
@@ -572,7 +572,7 @@ test_expect_success REBASE_P \
 
 test_expect_success '--rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
-	! git pull --rebase=invalid . copy
+	test_must_fail git pull --rebase=invalid . copy
 '
 
 test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
-- 
2.24.0.rc0.197.g0926ab8072

