Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE41B1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 11:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbcIALKg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 07:10:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32862 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbcIALKf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 07:10:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id w207so7888027wmw.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rs1H7anykA8vDMLNjWEE7e4FfNZIgkRxMy1397czzRU=;
        b=wih4oOiay0nTDPwN+KoHF2iEUqPhfU2vCYrey13mu/CE8wUAuWps3SjMrRE5xoKGbU
         waYvk7L/k3GmDt571ImjgYqYrTsx5RAo9TxDq5lf5wYF7gIZcoJuy7YLbCYBpO0gQtrB
         Yabw+otUjP8/DeSkc0ABTPxp68QPSwivGd53GRan12mBRacFxRRkq3Due6L680JReEhM
         4KKEfrVmVg67N7ICqSxHzaF6bP4ir13UCg1wU/ug7+RAfx9JEWZOofInlQdv86ziiEzr
         hlnqB0DtNizj2SsmeJgSZRnq60YjTc9EqfZorms5OtScJ4+YWzLy+58emMnxTugZp3hB
         nDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rs1H7anykA8vDMLNjWEE7e4FfNZIgkRxMy1397czzRU=;
        b=gIm3V8T4BVXfzAqWJ70luKT0z/wTJFCzUd+o02vXDhPAAu8lGX2jEWprYVhnuXx9kE
         OvUqt+b0QS8f9Xxxk3dG6yrea4W9ItltXaHreKcn0y46f9lRPiKOxHItF9LnPLqmko+f
         E71FufPshWC94Adglbt1/8Da1RiRmCt3XdRVOtHruNbMTMYMuKj5z8iAQ6xD1gunyIWx
         BGb1Xx+J9fF6r6UkNWmCFQHc7x/pQV7NtAeh4lCpJcGakmXnlMxuaMO7kAIOVYFwfd1V
         qErzloog3D8uBxzNQ89aq6jh6CBNkoTIeIVJHdxIfmuC4bD9KsZ2ji2lJfgUnchcFM8P
         eA0w==
X-Gm-Message-State: AE9vXwPSGu3VgySyRG35Sf4/dK+BCLdwHjKe67CPeA+XaCPJwbV1aJ27il+n3TaxJF3LOg==
X-Received: by 10.28.61.11 with SMTP id k11mr13798119wma.34.1472728227935;
        Thu, 01 Sep 2016 04:10:27 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id u124sm8922579wmu.10.2016.09.01.04.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 04:10:26 -0700 (PDT)
Subject: Re: [PATCH 22/22] sequencer: refactor write_message()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <cb4253698ae3eca066c031e0aec4e83ede1fa3e5.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4c0ee8f6-1302-1dcc-602d-7a84150ec39d@gmail.com>
Date:   Thu, 1 Sep 2016 13:10:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <cb4253698ae3eca066c031e0aec4e83ede1fa3e5.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

> The write_message() function safely writes an strbuf to a file.
> Sometimes this is inconvenient, though: the text to be written may not
> be stored in a strbuf, or the strbuf should not be released after
> writing.

By "this" you mean "using strbuf", isn't it?  It is not very obvious,
and I think it would be better to say it explicitly.

>
> Let's allow for such use cases by refactoring write_message() to allow
> for a convenience function write_file_gently(). As some of the upcoming
> callers of that new function will want to append a newline character,
> let's just add a flag for that, too.

This paragraph feels a bit convoluted.

As I understand it, you refactor "safely writing string to a file"
into write_with_lock_file(), and make write_message() use it.  The
new function makes it easy to create new convenience function 
write_file_gently(); as some of the upcoming callers of this new
function would want to append a newline character, add a flag for
it in write_file_gently(), and thus in write_with_lock_file().

Isn't it better / easier to understand?

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 5efed2e..f5b5e5e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -239,22 +239,37 @@ static void print_advice(int show_hint, struct replay_opts *opts)
>  	}
>  }
>  
> -static int write_message(struct strbuf *msgbuf, const char *filename)
> +static int write_with_lock_file(const char *filename,
> +				const void *buf, size_t len, int append_eol)
>  {
>  	static struct lock_file msg_file;
>  
>  	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
>  	if (msg_fd < 0)
>  		return error_errno(_("Could not lock '%s'"), filename);
> -	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
> +	if (write_in_full(msg_fd, buf, len) < 0)
>  		return error_errno(_("Could not write to %s"), filename);

You could have, for consistency, add quotes around filename (see previous
error_errno callsite), *while at it*:

  		return error_errno(_("Could not write to '%s'"), filename);


> -	strbuf_release(msgbuf);
> +	if (append_eol && write(msg_fd, "\n", 1) < 0)
> +		return error_errno(_("Could not write eol to %s"), filename);

Same here, and it wouldn't even be 'while at it'

  +		return error_errno(_("Could not write eol to '%s'"), filename);


>  	if (commit_lock_file(&msg_file) < 0)
>  		return error(_("Error wrapping up %s."), filename);

Another "while at it"... though the one that can be safely postponed
(well, the make message easier to understand part, not the quote
filename part):

  		return error(_("Error wrapping up writing to '%s'."), filename);


>  
>  	return 0;
>  }
>  
> +static int write_message(struct strbuf *msgbuf, const char *filename)
> +{
> +	int res = write_with_lock_file(filename, msgbuf->buf, msgbuf->len, 0);
> +	strbuf_release(msgbuf);
> +	return res;
> +}

Nice.

> +
> +static int write_file_gently(const char *filename,
> +			     const char *text, int append_eol)
> +{
> +	return write_with_lock_file(filename, text, strlen(text), append_eol);
> +}

Nice.  And it is static function, so we don't need to come up
with a better function name (to describe its function better).

> +
>  /*
>   * Reads a file that was presumably written by a shell script, i.e.
>   * with an end-of-line marker that needs to be stripped.
> 

And thus we got to the last patch in this series.  I have skipped
patches that already got reviewed; are there some that you would
like to have second review of?  Is there patch series that needs
to be applied earlier that needs a review?

P.S. I'll try to respond to your comments later today.

Regards,
-- 
Jakub Narębski

