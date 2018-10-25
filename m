Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7091F454
	for <e@80x24.org>; Thu, 25 Oct 2018 08:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeJYR1n (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:27:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50715 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeJYR1n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:27:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so683551wmg.0
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sVv6SP+nCBYrbQ6WxmhIdjFswfBD/X6BG8AJacLl1fs=;
        b=Ke4uBBgjxCsZjH4bbL8bqniSCBc6uHjTA2auOUETA1MC2FFQEjkvzkSIpAbC0rbImK
         F0LKjESj7zM9V/SHcTn+X/SPAmorU7XN3tj3HUDPQzdMcZcz82+FmZu/wbdPag8up3su
         TrwbOdi+CHSO60/cD2ZreEBDWo+G4iwKTNb9yQRXpgtkBE/VD017ruv/mdJNvNdWpR74
         TRH9ot6xA0cPjkSb9vUWYG63jF4V4FAJymxIDjOv+F8FqUVJrvg0D9E57dgqGU4JninU
         w4Q4SA53vJ7W9p21GXcLfzsZEHVEKpqWFjdaJqnuQT2aLTAnt/guQLpeDjdVlejGvrcO
         jRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sVv6SP+nCBYrbQ6WxmhIdjFswfBD/X6BG8AJacLl1fs=;
        b=NcB1c21mTmmHG4/hco8Qx+NN+ngHPhI34xFIP4VrJRWM3PwWsgeqDLi8WnT4XZgBlM
         RAf4J7s4po5b0wVt7QiGEiwPpX9X1UzLl38uQBjTX+o653+FQefsb5nUeivAMxRV2VC9
         fG4suNGKUZmpXb6Zk2aIcSHi1Ji7eh2SIldPC8ct8qjrvjp9HIvIITpLgwL6Ln8mk4Ie
         zS55Wc1SA2JE2RXq3XanWhFtx7//p66yzpmjt5MUkeby+6txIvOhb7u0DqOgmAx7d1qF
         YhnaA1hXHHbXPrMZrjtknhKWX5F0Td9LX9+vj5t/ko3ZlCqUMfj30hm3ub42VlADRYeR
         djmg==
X-Gm-Message-State: AGRZ1gLPjMV2rtpA2LAkfcOjQvkDRUKzTtLXeYPIKWbC5n7Fh4dWOd2q
        En4GWTy3uqUv0EXDQPgKTRs=
X-Google-Smtp-Source: AJdET5eoXXZtQbqMSBDGyvkVonTMLCz0xoiSm6uKr1Ql92O9/UnPXLe0/BmKA4oWq+96auJ9Dwikag==
X-Received: by 2002:a1c:2746:: with SMTP id n67-v6mr911107wmn.116.1540457752890;
        Thu, 25 Oct 2018 01:55:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e21-v6sm878904wma.8.2018.10.25.01.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:55:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/5] am: improve author-script error reporting
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
        <20181018100023.7327-1-phillip.wood@talktalk.net>
        <20181018100023.7327-3-phillip.wood@talktalk.net>
Date:   Thu, 25 Oct 2018 17:55:51 +0900
In-Reply-To: <20181018100023.7327-3-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Thu, 18 Oct 2018 11:00:20 +0100")
Message-ID: <xmqqy3amh0bs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If there are errors in a user edited author-script there was no
> indication of what was wrong. This commit adds some specific error messages
> depending on the problem. It also relaxes the requirement that the
> variables appear in a specific order in the file to match the behavior
> of 'rebase --interactive'.

That relaxing is sensible; there is no reason to insist that the
file we are reading was written by exactly the same writer as we
have.

> diff --git a/builtin/am.c b/builtin/am.c
> index b68578bc3f..d42b725273 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -270,8 +270,11 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
>  		struct string_list_item *item;
>  		char *np;
>  		char *cp = strchr(buf, '=');
> -		if (!cp)
> -			return -1;
> +		if (!cp) {
> +			np = strchrnul(buf, '\n');
> +			return error(_("unable to parse '%.*s'"),
> +				     (int) (np - buf), buf);
> +		}

We are unable to parse because it is not of KEY='VALUE' form.  Is
that something worth reporting, e.g. "no key present in '%.*s'"?

> @@ -280,7 +283,8 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
>  		*np = '\0';
>  		cp = sq_dequote(cp);
>  		if (!cp)
> -			return -1;
> +			return error(_("unable to dequote value of '%s'"),
> +				     item->string);

At this point, item->string is what we earlier found on the left
hand side of the '=', i.e. the key.  The message makes sense.

> @@ -308,6 +312,7 @@ static int read_author_script(struct am_state *state)
>  	struct strbuf buf = STRBUF_INIT;
>  	struct string_list kv = STRING_LIST_INIT_DUP;
>  	int retval = -1; /* assume failure */
> +	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;

That -2 is somewhat cute.  If we find a dup, then it will become -1
so later check for missing field would not trigger.

> @@ -326,14 +331,38 @@ static int read_author_script(struct am_state *state)
>  	if (parse_key_value_squoted(buf.buf, &kv))
>  		goto finish;
>  
> -	if (kv.nr != 3 ||
> -	    strcmp(kv.items[0].string, "GIT_AUTHOR_NAME") ||
> -	    strcmp(kv.items[1].string, "GIT_AUTHOR_EMAIL") ||
> -	    strcmp(kv.items[2].string, "GIT_AUTHOR_DATE"))
> +	for (i = 0; i < kv.nr; i++) {
> +		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
> +			if (name_i >= 0)
> +				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
> +			else
> +				name_i = i;

However, if you have three instances of GIT_AUTHOR_NAME, then

 - the first one makes name_i point at it
 - the second one triggers an error and name_i becomes -1
 - the third one makes name_i point at it again

And name_i is not -2 so we won't give "missing" error, which is OK,
but we end up having a usable name even though we said we detected
duplicate!

You can probably compare name_i with -2 when detecting the dup to
fix it, i.e.

	if (name_i != -2)
		name_i = error("found dup");
	else
		name_i = i;

> +		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
> +			if (email_i >= 0)
> +				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
> +			else
> +				email_i = i;
> +		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
> +			if (date_i >= 0)
> +				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
> +			else
> +				date_i = i;
> +		} else {
> +			err = error(_("unknown variable '%s'"),
> +				    kv.items[i].string);
> +		}
> +	}
> +	if (name_i == -2)
> +		error(_("missing 'GIT_AUTHOR_NAME'"));
> +	if (email_i == -2)
> +		error(_("missing 'GIT_AUTHOR_EMAIL'"));
> +	if (date_i == -2)
> +		error(_("missing 'GIT_AUTHOR_DATE'"));
> +	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
>  		goto finish;
> -	state->author_name = kv.items[0].util;
> -	state->author_email = kv.items[1].util;
> -	state->author_date = kv.items[2].util;
> +	state->author_name = kv.items[name_i].util;
> +	state->author_email = kv.items[email_i].util;
> +	state->author_date = kv.items[date_i].util;
>  	retval = 0;
>  finish:
>  	string_list_clear(&kv, !!retval);
