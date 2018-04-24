Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362971F424
	for <e@80x24.org>; Tue, 24 Apr 2018 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbeDXWAk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 18:00:40 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:46459 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDXWAj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 18:00:39 -0400
Received: by mail-pg0-f42.google.com with SMTP id t12so11831008pgp.13
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t91GomudueULDTPa84kXvuUm/eLH4VUfejZfJKfgZCk=;
        b=R7suF3qzSgcwFJRnapB1Nkdk/n3xryrXhbpB84Wf/HPguVmpyaL8kpLQKSCUtaXT2G
         3o0eI+dpv7cDO6kUsX90zgkpqOwxF3cHnCTASbZmnTYRqtZWeynDM1PhCMPbqZUn+Kk/
         bWz8dQWj7KhXFlwlS7c4N3WJB/kgJioHe360x/RUcIYlMGk7ojAyYHzhoq+ngyAGrwR8
         WpaqKFORaZfqkAUHGVI6xfrmF8hi8zru+0ACVaFFdUpBpEg5w0pnx7o9wrRSpEwtc8c5
         kSr7ns5z68vwvBj6ZjopZJzitILvMHEZfRiTYgX7HVo5Go9PAqj1hZRsFh1I5KRaG6c0
         UgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t91GomudueULDTPa84kXvuUm/eLH4VUfejZfJKfgZCk=;
        b=Xw6K5es4a7XqCiHwB8BO15TRF+i09u/puyYsBDf0e7VGuUD6k9q3KWtRXdSb1GDxPN
         fnaGY3SorDccJdU5yUACkP6KWjUNxORefG3K2C+LaAA/kob8uLXFTub1NVAxakW1ZYhr
         9dJGihycg69Wd3dBwVgtDh2+BSqyCry5fPY99Xm02dlr/jqM159yaGXbdQC1Xt3FeF0T
         rwVtjI6gixAhZy2J06f7G3U/r3+0gln0BaDHBk3MVr3CjGPL5Ms2h57skbMm+CTn2S81
         9oi6aD1mf6uvki/7+NjAJ60l6hXZtufhXYq/omR6EvIjpUC/w9rpiUuuoTXVTOOiSx+E
         4TXQ==
X-Gm-Message-State: ALQs6tAnA8HJbElNgujnHNIIoVi75TZNICxDBN6Ixqnq41xEYoOJ9DWa
        QV91MmEJR+wQlrPAeZ6TNdWnGg==
X-Google-Smtp-Source: AIpwx4+JCbAc3BYV7EFV9rdz2HlNjPNfIM59j0XCEDdoSLmQ+Hr8d+shplmRxd2WOBEygMCafJX/hg==
X-Received: by 10.98.101.131 with SMTP id z125mr25506085pfb.208.1524607238603;
        Tue, 24 Apr 2018 15:00:38 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id w134sm32578573pfd.132.2018.04.24.15.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 15:00:37 -0700 (PDT)
Date:   Tue, 24 Apr 2018 15:00:36 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com
Subject: Re: [PATCH 6/7] diff.c: decouple white space treatment from move
 detection algorithm
Message-Id: <20180424150036.8e7ca862525bedb91673ae46@google.com>
In-Reply-To: <20180424210330.87861-7-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
        <20180424210330.87861-7-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Apr 2018 14:03:29 -0700
Stefan Beller <sbeller@google.com> wrote:

> As we change the default, we'll adjust the tests.

This statement is probably better written as:

  In some existing tests, options like --ignore-space-at-eol were used
  to control the color of the output. They have been updated to use
  options like --color-moved-ignore-space-at-eol instead.

> +	unsigned flags = diffopt->color_moved_ws_handling
> +			 & XDF_WHITESPACE_FLAGS;

No need for "& XDF_WHITESPACE_FLAGS".

> +	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;

Same here.

> @@ -214,6 +214,7 @@ struct diff_options {
>  	} color_moved;
>  	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
>  	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
> +	int color_moved_ws_handling;
>  };

Should the "int" be "unsigned"? I noticed that the flag-like xdl_opts is
signed, but I think it's better for flags to be unsigned. Also, document
what this stores. (And also, I would limit the bits.)

> +test_expect_success 'only move detection ignores white spaces' '
> +	git reset --hard &&
> +	q_to_tab <<-\EOF >text.txt &&
> +		a long line to exceed per-line minimum
> +		another long line to exceed per-line minimum
> +		original file
> +	EOF
> +	git add text.txt &&
> +	git commit -m "add text" &&
> +	q_to_tab <<-\EOF >text.txt &&
> +		Qa long line to exceed per-line minimum
> +		Qanother long line to exceed per-line minimum
> +		new file
> +	EOF
> +
> +	# Make sure we get a different diff using -w
> +	git diff --color --color-moved -w \
> +		--color-moved-no-ignore-all-space \
> +		--color-moved-no-ignore-space-change \
> +		--color-moved-no-ignore-space-at-eol |
> +		grep -v "index" |
> +		test_decode_color >actual &&
> +	q_to_tab <<-\EOF >expected &&
> +	<BOLD>diff --git a/text.txt b/text.txt<RESET>
> +	<BOLD>--- a/text.txt<RESET>
> +	<BOLD>+++ b/text.txt<RESET>
> +	<CYAN>@@ -1,3 +1,3 @@<RESET>
> +	 Qa long line to exceed per-line minimum<RESET>
> +	 Qanother long line to exceed per-line minimum<RESET>
> +	<RED>-original file<RESET>
> +	<GREEN>+<RESET><GREEN>new file<RESET>
> +	EOF
> +	test_cmp expected actual &&
> +
> +	# And now ignoring white space only in the move detection
> +	git diff --color --color-moved \
> +		--color-moved-ignore-all-space \
> +		--color-moved-ignore-space-change \
> +		--color-moved-ignore-space-at-eol |
> +		grep -v "index" |
> +		test_decode_color >actual &&
> +	q_to_tab <<-\EOF >expected &&
> +	<BOLD>diff --git a/text.txt b/text.txt<RESET>
> +	<BOLD>--- a/text.txt<RESET>
> +	<BOLD>+++ b/text.txt<RESET>
> +	<CYAN>@@ -1,3 +1,3 @@<RESET>
> +	<BOLD;MAGENTA>-a long line to exceed per-line minimum<RESET>
> +	<BOLD;MAGENTA>-another long line to exceed per-line minimum<RESET>
> +	<RED>-original file<RESET>
> +	<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>a long line to exceed per-line minimum<RESET>
> +	<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>another long line to exceed per-line minimum<RESET>
> +	<GREEN>+<RESET><GREEN>new file<RESET>
> +	EOF
> +	test_cmp expected actual
>  '

I know I suggested "per-line minimum", but I don't think there is one -
I think we only have a per-block minimum. Maybe delete "per-line" in
each of the lines.
