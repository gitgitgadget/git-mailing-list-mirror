Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169C81F516
	for <e@80x24.org>; Sat, 23 Jun 2018 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeFWQwr (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 12:52:47 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34166 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeFWQwq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 12:52:46 -0400
Received: by mail-wm0-f43.google.com with SMTP id l15-v6so8747689wmc.1
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAWfm6bjMBy2Ykr9dBXX8fbLLp2gB4z2g36ulol70UY=;
        b=rks09j1he/p73hcMvRCGNugu4cDkohYyjgKzqrd8J+KDleOaOZfvembfkDqJNRGamO
         gsmMMNlXeIToAsrWSejCOaE3XIDz5ws3xH2/+q2aKBN9SKmLlRD7CCte3L+O5ghucr0B
         IkthvLBFKnatCkUwcNF5YAjLj7WcN1X+DaTv8DF7rnJMNZTeKUb+wAwgsRyXhfiO3m6p
         uKaBpuRB04Is5qGqA3nDCpQM3vgOQsQK0KYx727MZ2hQ67uatomYq47q17oLabRhrP80
         7ZTB5nIk6kG/gHfrAZxdkqJftNb0h3H5hU7Yqtv9D3jEaFBImN0ebaIaY7rQ3R07MbNQ
         7W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAWfm6bjMBy2Ykr9dBXX8fbLLp2gB4z2g36ulol70UY=;
        b=UNjA/OceQHP6Ln3pKaAyesJ1e86OM1w1w4L72cFJC2i53jyEYnHuP/RPx3q+ylac8m
         Z5VwK1/dpp4XwnEMi5xPqDme1k7Qx6SujhT/Q1/graa2pxTKg4diskUpURndC9QCVr6q
         0xsKK/70g/9RHTxuW8ng7NxrUnzeYCrO7V8mUHq+DCPQ71BeiqqiVDG3EUdHtHurDwxN
         lRcE2hhCVBDymFJMdLk+7rb3+jzer38YTkl45xsZIWYVD8iWGiSgDZW4zsvb+PDMYNYf
         y8g2M33T9bMiEuefEumG1kRdpxM9Aiyu9Fdmub72uX7PHbx5r8mZOsHcjm60UfebXqaI
         EJAA==
X-Gm-Message-State: APt69E3O8Q8SE11mwLOmHp23ED9EZRo3C7VsV0hfD7qQR+WM4UeKooV0
        rEQPAnWoVcSLfa0mEFNDnVY=
X-Google-Smtp-Source: ADUXVKJ76SSJ3qk3+BQOnn539PzJrMf7edzL2DIFOQz+3KUOe8KnVe5znHCTUCPCDrL7nWq+kO0CjQ==
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr4505106wmd.96.1529772764738;
        Sat, 23 Jun 2018 09:52:44 -0700 (PDT)
Received: from localhost.localdomain (x4db055f1.dyn.telefonica.de. [77.176.85.241])
        by smtp.gmail.com with ESMTPSA id j131-v6sm9712426wmg.24.2018.06.23.09.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jun 2018 09:52:43 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org
Subject: Re: [PATCH v3 8/8] diff.c: add white space mode to move detection that allows indent changes
Date:   Sat, 23 Jun 2018 18:52:33 +0200
Message-Id: <20180623165233.23653-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.171.g58aaabc06c
In-Reply-To: <20180622015725.219575-9-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com> <20180622015725.219575-9-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/diff.c b/diff.c
> index 040b46545e5..9e357111864 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -302,12 +302,18 @@ static int parse_color_moved_ws(const char *arg)
>  			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
>  		else if (!strcmp(sb.buf, "ignore-all-space"))
>  			ret |= XDF_IGNORE_WHITESPACE;
> +		else if (!strcmp(sb.buf, "allow-indentation-change"))
> +			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
>  		else
>  			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
>  
>  		strbuf_release(&sb);
>  	}
>  
> +	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
> +	    (ret & XDF_WHITESPACE_FLAGS))
> +		die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));

Note that this is a translated error message.

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index aad0870c8a1..13b20be591e 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1827,4 +1827,94 @@ test_expect_success 'only move detection ignores white spaces' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'compare whitespace delta across moved blocks' '
> +
> +	git reset --hard &&
> +	q_to_tab <<-\EOF >text.txt &&
> +	QIndented
> +	QText across
> +	Qsome lines
> +	QBut! <- this stands out
> +	QAdjusting with
> +	QQdifferent starting
> +	Qwhite spaces
> +	QAnother outlier
> +	QQQIndented
> +	QQQText across
> +	QQQfive lines
> +	QQQthat has similar lines
> +	QQQto previous blocks, but with different indent
> +	QQQYetQAnotherQoutlierQ
> +	EOF
> +
> +	git add text.txt &&
> +	git commit -m "add text.txt" &&
> +
> +	q_to_tab <<-\EOF >text.txt &&
> +	QQIndented
> +	QQText across
> +	QQsome lines
> +	QQQBut! <- this stands out
> +	Adjusting with
> +	Qdifferent starting
> +	white spaces
> +	AnotherQoutlier
> +	QQIndented
> +	QQText across
> +	QQfive lines
> +	QQthat has similar lines
> +	QQto previous blocks, but with different indent
> +	QQYetQAnotherQoutlier
> +	EOF
> +
> +	git diff --color --color-moved --color-moved-ws=allow-indentation-change |
> +		grep -v "index" |
> +		test_decode_color >actual &&

Please use an intermediate file for the output of 'git diff', because
running it upstream of a pipe hides its exit code.

> +
> +	q_to_tab <<-\EOF >expected &&
> +		<BOLD>diff --git a/text.txt b/text.txt<RESET>
> +		<BOLD>--- a/text.txt<RESET>
> +		<BOLD>+++ b/text.txt<RESET>
> +		<CYAN>@@ -1,14 +1,14 @@<RESET>
> +		<BOLD;MAGENTA>-QIndented<RESET>
> +		<BOLD;MAGENTA>-QText across<RESET>
> +		<BOLD;MAGENTA>-Qsome lines<RESET>
> +		<RED>-QBut! <- this stands out<RESET>
> +		<BOLD;MAGENTA>-QAdjusting with<RESET>
> +		<BOLD;MAGENTA>-QQdifferent starting<RESET>
> +		<BOLD;MAGENTA>-Qwhite spaces<RESET>
> +		<RED>-QAnother outlier<RESET>
> +		<BOLD;MAGENTA>-QQQIndented<RESET>
> +		<BOLD;MAGENTA>-QQQText across<RESET>
> +		<BOLD;MAGENTA>-QQQfive lines<RESET>
> +		<BOLD;MAGENTA>-QQQthat has similar lines<RESET>
> +		<BOLD;MAGENTA>-QQQto previous blocks, but with different indent<RESET>
> +		<RED>-QQQYetQAnotherQoutlierQ<RESET>
> +		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Indented<RESET>
> +		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Text across<RESET>
> +		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>some lines<RESET>
> +		<GREEN>+<RESET>QQQ<GREEN>But! <- this stands out<RESET>
> +		<BOLD;CYAN>+<RESET><BOLD;CYAN>Adjusting with<RESET>
> +		<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>different starting<RESET>
> +		<BOLD;CYAN>+<RESET><BOLD;CYAN>white spaces<RESET>
> +		<GREEN>+<RESET><GREEN>AnotherQoutlier<RESET>
> +		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Indented<RESET>
> +		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Text across<RESET>
> +		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>five lines<RESET>
> +		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>that has similar lines<RESET>
> +		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>to previous blocks, but with different indent<RESET>
> +		<GREEN>+<RESET>QQ<GREEN>YetQAnotherQoutlier<RESET>
> +	EOF
> +
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'compare whitespace delta incompatible with other space options' '
> +	test_must_fail git diff \
> +		--color-moved-ws=allow-indentation-change,ignore-all-space \
> +		2>err &&
> +	grep allow-indentation-change err

A translated error message should be checked with 'test_i18ngrep'.

