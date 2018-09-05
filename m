Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 248BA1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIEVnz (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:43:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55513 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEVny (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:43:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so8742041wmc.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zZtqlkkHJ9vbL7IgKRkw+07YN7/OJanNHr/v30IoIn4=;
        b=pM0l8SZOMsWbl6iwHuIW8LxFxf+IXB4buJSDLzxKXNaDf4cmubWA70WliZKLzf8+dQ
         dckbBrSowdaJZLBzmmWeJvmxdezc4IozhDaDWvcY9jk1fvMr7aNX5l2A9pTd9b8yxOMB
         dPqKoaempfioqXdvo2xEjERkSubW4BSQD/w8QQAT4old5ISLDTdlGZmpTSnm+N8ABkgZ
         BEK986awjk1EZs4ve8Ty3zHoL+/iXFDLiBDe0upCsYp5YmxQ3inOotOQ5gehirzydUAH
         vJdw7vEu+f3bk5eogs9aPf7pau43Nl7kqeHCBNtM9te6A+tH+uNHTvRRMX95LHkCZ7Hs
         j5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zZtqlkkHJ9vbL7IgKRkw+07YN7/OJanNHr/v30IoIn4=;
        b=sPHFXiK+P9t1acUEFtDFwRCbkZRH3UrfLK1ITh2DhyeBkdT2YNmaYXgAYiOMSg+wDK
         TcFX1kwoaefiX4462dbCOjV8aB1hReCnYaryqCDw9BLY0Nu2Dwm74WPwbVY1YiSeY4Fi
         Gvbp5ROKw5Zwbr9hKff1fz8xRklzZjIML30ryb+dPGcu+MW9Hmlzl05PnBKuXAd1XZOO
         YOKulNcvgV+de25Xqv+YHDBxh7whXdxxQ99zPh6lGn3xH0gDgbJjXySuChEV7USU3Jrq
         00KgKm7RJIjzclmoEx6zqveKBbEI/ovFXcRxGXszXJ/b42Rq493UKZiXvdx77eGNYfJb
         EsUQ==
X-Gm-Message-State: APzg51CcqrqpfVotGNk1eiijpqSpUBd2qZYlFkaf4AtHpyjzflzkvCPl
        yaOrAaKAfbDgmKTEDAl1Kng=
X-Google-Smtp-Source: ANB0VdaNbFVC0zXxsgeiDDyonjhH4V2+KeQrFTXWCkYlDbM0dylgzG3Yaz2kmpP6Wg3Y5RqurqFglA==
X-Received: by 2002:a1c:b707:: with SMTP id h7-v6mr822550wmf.91.1536167567123;
        Wed, 05 Sep 2018 10:12:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w10-v6sm2805249wrp.31.2018.09.05.10.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 10:12:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
References: <20180905085427.4099-1-timschumi@gmx.de>
Date:   Wed, 05 Sep 2018 10:12:45 -0700
In-Reply-To: <20180905085427.4099-1-timschumi@gmx.de> (Tim Schumacher's
        message of "Wed, 5 Sep 2018 10:54:27 +0200")
Message-ID: <xmqqlg8f50mq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Schumacher <timschumi@gmx.de> writes:

> @@ -691,17 +693,34 @@ static int run_argv(int *argcp, const char ***argv)
>  		/* .. then try the external ones */
>  		execv_dashed_external(*argv);
>  
> +		/* Increase the array size and add the current
> +		 * command to it.
> +		 */
> +		cmd_list_alloc += strlen(*argv[0]) + 1;
> +		REALLOC_ARRAY(cmd_list, cmd_list_alloc);
> +		cmd_list[done_alias] = *argv[0];
> +
> +		/* Search the array for occurrences of that command,
> +		 * abort if something has been found.
> +		 */
> +		for (int i = 0; i < done_alias; i++) {
> +			if (!strcmp(cmd_list[i], *argv[0])) {
> +				die("loop alias: %s is called twice",
> +				    cmd_list[done_alias]);
> +			}
> +		}
> +

Wouldn't all of the above become three or four lines that is so
clear that there is no need for any comment if you used string-list,
perhaps?

>  		/* It could be an alias -- this works around the insanity
>  		 * of overriding "git log" with "git show" by having
>  		 * alias.log = show
>  		 */

	/*
	 * Style: our multi-line comment begins with and ends with
	 * slash-asterisk and asterisk-slash on their own lines.
	 */

> -		if (done_alias)
> -			break;
>  		if (!handle_alias(argcp, argv))
>  			break;
> -		done_alias = 1;
> +		done_alias++;
>  	}
>  
> +	free(cmd_list);
> +
>  	return done_alias;
>  }
