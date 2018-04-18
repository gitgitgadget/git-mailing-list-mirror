Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C0E1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 00:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeDRAeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 20:34:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36209 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeDRAeR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 20:34:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id q13-v6so76346wre.3
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 17:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kMGACKbPlSaWYQkNJkXxUcG/LtTBvfEXwmYYwQyJIcc=;
        b=dBsQ8DsqLxAqMcTevkPKXcsAfezA0812xN3GGq6Ga+cHGi4prLj6nHL2uHnEAUUEbV
         9OQNC5r76kG3wr16J9RuMAplt2s6NhK5phTs9zWvmg58m9jc9CnN9fq6XMufi1kxnsb7
         pqezrYqnbrU66tMZk5OI78QQBTob5VaHm0KKYRaz0Z1viKyfW2eEWSCmomY4jJ/xowhx
         ILaMSZvgAmxa/rMFnzUhFsWX4V7SI8O/hoeUaaBaZDdP5TAR9LD64rmbxz9P1mpcBKou
         f/YCt8zdZSbWxOfO4NYnL8vwPSAZub8SCXg4/atWu45eCEGQFtAwJT1Fliqr68saTzlP
         2XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kMGACKbPlSaWYQkNJkXxUcG/LtTBvfEXwmYYwQyJIcc=;
        b=hNJSPtGY4WS5J3wPfDqCMKcUPzEmiS5dCb1HStlHyNEXsNeKxw7XUN3IqZgTZrUjGO
         WrCAmjarTKUnVHnbeskqBjJYtri5lc0qfW62tXEu8F30fw9XBHG/pzQh+PkIRj9HYS8L
         J9PjYrQYIeUE+MQ/5A2RTKz+tabd+7pTW6gRAH2XmaauGCxMuc0nEjOcvgCILXEJUYb7
         d9fTnaKV+dxnGLi44uceaHEIDnukLfONEYnqU+y/WrWgDOkcSYIbnNMXnahZWckEhztk
         a6dVzVRF/PzCMaEMM7YiRlnHl0Nt8K4sqvnnv4A4Pc2+d9AobMKWbLT2wucessWewjYY
         wABw==
X-Gm-Message-State: ALQs6tBDbNplZZoVP/RzIsiuq6KkrrlW1s1UcNjLZzFvQhazT0yfKhHP
        qHJszQ9DPeyhCo9jHSQtsjU=
X-Google-Smtp-Source: AIpwx4/B2m1U/q4qZjvvdQ+8LKifPbXnYuS8hIrxN0IfopzAnec8MVTf8HBHKQThMXe2NiUTtCbL+Q==
X-Received: by 10.223.179.18 with SMTP id j18mr3120346wrd.33.1524011656201;
        Tue, 17 Apr 2018 17:34:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 185sm470027wmj.46.2018.04.17.17.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 17:34:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/blame: dim uninteresting metadata lines
References: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
        <20180417213049.118995-1-sbeller@google.com>
Date:   Wed, 18 Apr 2018 09:34:15 +0900
In-Reply-To: <20180417213049.118995-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 17 Apr 2018 14:30:48 -0700")
Message-ID: <xmqqzi21jqt4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -375,6 +378,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  	struct commit_info ci;
>  	char hex[GIT_MAX_HEXSZ + 1];
>  	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
> +	const char *color = NULL, *reset = NULL;
>  
>  	get_commit_info(suspect->commit, &ci, 1);
>  	oid_to_hex_r(hex, &suspect->commit->object.oid);
> @@ -384,6 +388,18 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  		char ch;
>  		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
>  
> +		if (opt & OUTPUT_COLOR_LINE) {
> +			if (cnt > 0) {
> +				color = repeated_meta_color;
> +				reset = GIT_COLOR_RESET;
> +			} else  {
> +				color = "";
> +				reset = "";

Shouldn't these be NULL as you do not want to fputs() these when not
in painting mode anyway?  Which would make it consistent with ...

> +			}
> +		}
> +		if (color)
> +			fputs(color, stdout);
> +

... this thing which otherwise needs to be "if (color && *color)",
but if you do NULL, can be left as-is ;-)

> @@ -433,6 +449,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  			printf(" %*d) ",
>  			       max_digits, ent->lno + 1 + cnt);
>  		}
> +		if (reset)
> +			fputs(reset, stdout);

Likewise.
