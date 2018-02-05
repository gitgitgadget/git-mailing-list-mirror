Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979231F404
	for <e@80x24.org>; Mon,  5 Feb 2018 21:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeBEVTm (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:19:42 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34026 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBEVTk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:19:40 -0500
Received: by mail-wm0-f68.google.com with SMTP id j21-v6so14989367wmh.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=moNLulBwbT4Aztkts1uiK7xF6BswYPnKTSzkbNxsit4=;
        b=ZwaZvOIbHKiBjDzX+IyRfzniQ70ASBf2UPWMPjojE36j0jIb2LDKihS9K4rROj5UWM
         0sEAlROHJ7B8UzHY3IydBLSZrJtZZ8lwk6f8CkYstY5diwuFWI92gckMCQQ0t6gZcYbi
         2UPpfDHlEEcnCWVB+B0p2zqsbLbH7Wd7gYeCQo6ps7V4vtYhTglfgoIA6uTSAWhAZOnV
         E3g6lGjm2lbfoUZ8yzpTp4B3JeUzdptoNqH3A+KO6Kt0x5KBx4KwwgzRtDD+CH6jQ5GJ
         qAwQbXA2ZTVAriUZG1apWGXJ+F9h9CZBmBnBK2G6BhjY82A4rjlV9+HI6SG5LB0O08x3
         i1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=moNLulBwbT4Aztkts1uiK7xF6BswYPnKTSzkbNxsit4=;
        b=aSNPGWr3zLiSKsb8Xik+YGZ7s4X94JUYm/WpevTH4c9YZvbL70WqOH5oyuU4dLFk+o
         Y9k3bUMA6HcIPuCv4uDvhsWNJszozH3bXZ3muoQlolY5Lj1doBJJcwQTRtrPakwoHJNM
         BFULTiZaLS3nsAK0Di7a6Y8tL7hvC5TNK/vw9WqjqpcvXya9F0F37tMpROKFnZE0IoL8
         NdUu6nKrDLIpTGs7sYJi4d8ECLx8QsKvGWIyLt7Pr6LAM6N7fm2bfIF7X1rgk9nF+y69
         fCUWAY/4dlgtDyHe26ChevIYwWCXUalKD6HRRoES7kj92WXlH/r0uhak+ewlgHF3xqAY
         wx3g==
X-Gm-Message-State: APf1xPCptmSmPhKtcnvRSVHpoqyNPe4x51ghRjM0aRPld47ZXDb8Lbqe
        SO4MUtSAQYKBlqQlZpu38Fw=
X-Google-Smtp-Source: AH8x227If0WsFMMFTv1uc1RG1mcIgfU9AACcdjbVIZg8DkEn8GOTivPfob2JjonyMPOHdnfA9pFaTQ==
X-Received: by 10.28.199.201 with SMTP id x192mr85855wmf.45.1517865579303;
        Mon, 05 Feb 2018 13:19:39 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 5sm5613694wre.35.2018.02.05.13.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 13:19:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC v2 14/25] ref-filter: add is_cat flag
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
        <0102016165b8b44c-a6d5c188-a9f2-4c5a-8cfb-6094af8f0163-000000@eu-west-1.amazonses.com>
Date:   Mon, 05 Feb 2018 13:19:37 -0800
In-Reply-To: <0102016165b8b44c-a6d5c188-a9f2-4c5a-8cfb-6094af8f0163-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Mon, 5 Feb 2018 11:27:39 +0000")
Message-ID: <xmqq4lmv9lsm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> diff --git a/ref-filter.c b/ref-filter.c
> index 34a54db168265..91290b62450b3 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -101,6 +101,7 @@ static struct used_atom {
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
>  struct expand_data *cat_file_info;
> +static int is_cat = 0;
>   ...
> @@ -739,6 +740,7 @@ int verify_ref_format(struct ref_format *format)
>  	const char *cp, *sp;
>  
>  	cat_file_info = format->cat_file_data;
> +	is_cat = format->is_cat;

Eek.  The global cat_file_info itself may already be bad enough, but
now we have another one?

Hopefully these are all cleaned up in later steps in the series?

>  	format->need_color_reset_at_eol = 0;
>  	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
>  		const char *color, *ep = strchr(sp, ')');
> @@ -748,7 +750,7 @@ int verify_ref_format(struct ref_format *format)
>  			return error(_("malformed format string %s"), sp);
>  		/* sp points at "%(" and ep points at the closing ")" */
>  
> -		if (format->cat_file_data)
> +		if (is_cat)
>  			at = parse_ref_filter_atom(format, valid_cat_file_atom,
>  						   ARRAY_SIZE(valid_cat_file_atom), sp + 2, ep);
>  		else {
> @@ -1438,7 +1440,7 @@ int populate_value(struct ref_array_item *ref)
>  			ref->symref = "";
>  	}
>  
> -	if (cat_file_info && check_and_fill_for_cat(ref))
> +	if (is_cat && check_and_fill_for_cat(ref))
>  		return -1;
>  
>  	/* Fill in specials first */
> diff --git a/ref-filter.h b/ref-filter.h
> index 5c6e019998716..69271e8c39f40 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -125,6 +125,7 @@ struct ref_format {
>  	 * hopefully would be reduced later.
>  	 */
>  	struct expand_data *cat_file_data;
> +	int is_cat;
>  };
>  
>  #define REF_FORMAT_INIT { NULL, 0, -1 }
>
> --
> https://github.com/git/git/pull/452
