Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0751F454
	for <e@80x24.org>; Mon,  5 Nov 2018 02:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeKELXd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 06:23:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41325 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeKELXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 06:23:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so7685627wrw.8
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 18:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9NqgZVMOaQf8pUrRq9V6pQRxcE68feEyhE5RhatYlGQ=;
        b=WVmkbHef+rq69bnTfdnLd8BhmBFrMeqyGSOJqyqKAqOs4Q2P9Xn3PDLIiQhYS1LUSZ
         FRtFuUFPXkA0YyMwABSxvy+ZPmFTewDuZ94k9qdKQUNJyuMjzsQVW9k69Evt9eIOLeq4
         ss2UwlphCyvCS2IpMcct35qmweqCvGxhjHaqhjzyMCo+xAYyjhdlt+RXYTRm+hLMDfac
         1YdMDhd59McZHDFJyjLX6+g9qe8CY+4syrGgPdVLALV23FRsG1DZjz3hlma+ROEcSBc8
         YBfaASnTBsieLNJjjQIbXV9kA5cFFreJrxVmwJbq7faMsjsjOAnZF9jekeWrgbvGR8SC
         kUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9NqgZVMOaQf8pUrRq9V6pQRxcE68feEyhE5RhatYlGQ=;
        b=T8acoNKU2/Iabfn1bnWyL4sFMT9Ne28OIMee6BFxjwOl27/20nqlRyuFKztCYyQHpo
         iyBjRoEDq/mu3ehiToDQ2EL42vTzHrmgqiF5Wy/PsYVIxKxss7hR3rw7xejZu5Q+mgUg
         7n15KXUnCw77dLj+uUxG6/oTSK2xyhL9sfagpbsFUWyJMPmswlcQ8c/HD3ynOPpCo8+H
         Mdc9n0AdP9X9td2thBKpoSFJsTG9vI8ZRA+MV3YhHl1qx2dAYXwRvN593DZDlnAKmFxR
         L7DQfcIBr9f5j+k/cxWIYr6dp8cXXQfNuYs3CY+XHHfdfgN1zCMsQ90Nnw5qtvaa+Q3z
         z11Q==
X-Gm-Message-State: AGRZ1gJkp46wI2ESLBdEWYu9Viy8C3Ee/OLoK40LGsfm911vlgJwwQVA
        mq7q7hQD6x94Uz8g/2V+QUo76pcaWz0=
X-Google-Smtp-Source: AJdET5f2oxfE692Hcd81gLI2cfgFfvjP7wWyKXvr5Djj/6Drto8AcPY97y1Ls0y9n7x3J2K/pED1tg==
X-Received: by 2002:adf:edcf:: with SMTP id v15-v6mr16746655wro.182.1541383577298;
        Sun, 04 Nov 2018 18:06:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t17sm25820651wrx.9.2018.11.04.18.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 18:06:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 4/5] pretty: extract fundamental placeholders to separate function
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181104152232.20671-1-anders@0x63.nu>
        <20181104152232.20671-5-anders@0x63.nu>
Date:   Mon, 05 Nov 2018 11:06:15 +0900
In-Reply-To: <20181104152232.20671-5-anders@0x63.nu> (Anders Waldenborg's
        message of "Sun, 4 Nov 2018 16:22:31 +0100")
Message-ID: <xmqqtvkwjn1k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> No functional change intended
>
> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
> ---
>  pretty.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)

I do not think "fundamental" is the best name for this, but I agree
that it would be useful to split the helpers into one that is
"constant across commits" and the other one that is "per commit".

> diff --git a/pretty.c b/pretty.c
> index f87ba4f18..9fdddce9d 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1074,6 +1074,27 @@ static int match_placeholder_arg(const char *to_parse, const char *candidate,
>  	return 0;
>  }
>  
> +static size_t format_fundamental(struct strbuf *sb, /* in UTF-8 */
> +				 const char *placeholder,
> +				 void *context)
> +{
> +	int ch;
> +
> +	switch (placeholder[0]) {
> +	case 'n':		/* newline */
> +		strbuf_addch(sb, '\n');
> +		return 1;
> +	case 'x':
> +		/* %x00 == NUL, %x0a == LF, etc. */
> +		ch = hex2chr(placeholder + 1);
> +		if (ch < 0)
> +			return 0;
> +		strbuf_addch(sb, ch);
> +		return 3;
> +	}
> +	return 0;
> +}
> +
>  static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  				const char *placeholder,
>  				void *context)
> @@ -1083,9 +1104,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  	const char *msg = c->message;
>  	struct commit_list *p;
>  	const char *arg;
> -	int ch;
> +	size_t res;
>  
>  	/* these are independent of the commit */
> +	res = format_fundamental(sb, placeholder, NULL);
> +	if (res)
> +		return res;
> +
>  	switch (placeholder[0]) {
>  	case 'C':
>  		if (starts_with(placeholder + 1, "(auto)")) {
> @@ -1104,16 +1129,6 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  			 */
>  			return ret;
>  		}
> -	case 'n':		/* newline */
> -		strbuf_addch(sb, '\n');
> -		return 1;
> -	case 'x':
> -		/* %x00 == NUL, %x0a == LF, etc. */
> -		ch = hex2chr(placeholder + 1);
> -		if (ch < 0)
> -			return 0;
> -		strbuf_addch(sb, ch);
> -		return 3;
>  	case 'w':
>  		if (placeholder[1] == '(') {
>  			unsigned long width = 0, indent1 = 0, indent2 = 0;
