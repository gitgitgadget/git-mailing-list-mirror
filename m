Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F651F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeKHLVH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 06:21:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbeKHLVH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 06:21:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id z13-v6so17078846wrs.3
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 17:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x436CBIh3fXw4JbfvlmETh6T5cSnGt4Mw3rjtDa+BZU=;
        b=ZIKqDAMxVsJq4Yk7ytB5Zk9dbuTvZRphM9flY8WfmuY2Fo89zM8+GRJ4XBycytSMG4
         judhOrsviFoWVzfRgumyFVsRg6TChq6qAWmCw2ozks6B4a1BQ4QDY4AUoRFA/ASVq7Us
         UUxNxPlO7gvm3R9n7b99P3zG/R0zJg6NsVit/xymVilelBEGejHJrSokR1XalqkLhGRk
         g8PXf8wlYrNMLH8bgO+J4qw8NXwhWuD72DHa5B9TCQev2GeOIueJ13hnMJj/EK0tRkak
         D1mn2bKIvAPy+1NUw97OqFMH9Urt2lLjBzBY+kxrrxLbooWFyl59l1SJZSTTgi1+ROXi
         v5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x436CBIh3fXw4JbfvlmETh6T5cSnGt4Mw3rjtDa+BZU=;
        b=c03zSn9ubg/+f4yEjaasvzeHrtzzdURx+B1q9RYTIyW/UgxEBHM1FUu9Sfnfe1eLUH
         RswxRfYcdY585HbafXwZ6ouZT1NBKdIh3TqR8nk2sxZrhg3c9SdU02LUX1rsI35Qz/Ek
         DV0QW87sgdKLysMI3C6x/AXBK7FqeOCdxcsfP9QV0vdY3D1MYeI6rx2TdrVZMFiZ49uD
         U31eUv2HswU+qbCvsrJKMawqIrkhBReIOm+gNbglvzkpLwPzYJFTrWIACC7ainfngzhT
         T+h0Mfg917B5K8dhj2f2YKUMFLyrS8TViXknV7RSQSFXrSedaiJYUDVOxioBY38TdjQe
         N3hw==
X-Gm-Message-State: AGRZ1gKHZMKFswQtflPUaWFpelqbxR5mNviId8xemCBXZA0YxKVzatB8
        ogn2kVI5nWuXgoF8xEnjb3w=
X-Google-Smtp-Source: AJdET5fp2yQmwXKgcq0tgdLpo7cGHlxR90igoTqY7o2kIKpkAHNWYF/LP0NtalQc+WAKKGANrxtqMQ==
X-Received: by 2002:a5d:488a:: with SMTP id g10-v6mr2293580wrq.0.1541641682462;
        Wed, 07 Nov 2018 17:48:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j4-v6sm2515591wrp.68.2018.11.07.17.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 17:48:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH 1/1] http: add support selecting http version
References: <pull.69.git.gitgitgadget@gmail.com>
        <4f5a935c4355794effb23c979dcbaf77ed33da26.1541597633.git.gitgitgadget@gmail.com>
Date:   Thu, 08 Nov 2018 10:48:00 +0900
In-Reply-To: <4f5a935c4355794effb23c979dcbaf77ed33da26.1541597633.git.gitgitgadget@gmail.com>
        (Force Charlie via GitGitGadget's message of "Wed, 07 Nov 2018
        05:33:56 -0800 (PST)")
Message-ID: <xmqqwopo8hm7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Force Charlie via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Force Charlie <charlieio@outlook.com>
>
> Signed-off-by: Force Charlie <charlieio@outlook.com>
> ---
>  http.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/http.c b/http.c
> index 3dc8c560d6..99cb04faba 100644
> --- a/http.c
> +++ b/http.c
> @@ -48,6 +48,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
>  
>  static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
> +static int curl_http_version = 11;

Is there any reason that we need to have this variable's value to be
"int"?  I _think_ in this patch, the variable is used to choose
between the default and "HTTP/2", and I do not think the updated
code can choose any other new value that may be supported by an even
newer cURL library without further update, i.e. we'd need a variant of
"if the configuration asks HTTP/2 then use CURLOPT_HTTP_VERSION with
CURL_HTTP_VERSION_2" for the new choice.

So I'd think it would not add much value to force end users use a
rather cryptic "20" (vs "11") to choose between "2" and "1.1".  Why
not use spell it out, e.g. using the official name of the protocol
"HTTP/2" (vs "HTTP/1.1"), with a "const char *" instead?

The new configuration variable and the possible values it can take
must be documented, of course.  I think it would make the description
far less embarrassing if we say "HTTP/2" etc. rather than "20",
"11", etc.

> @@ -284,6 +285,10 @@ static void process_curl_messages(void)
>  
>  static int http_options(const char *var, const char *value, void *cb)
>  {
> +	if (!strcmp("http.version",var)) {
> +		curl_http_version=git_config_int(var,value);

STYLE.  Missing SP after comma, and around assignment.

> +		return 0;
> +	}
>  	if (!strcmp("http.sslverify", var)) {
>  		curl_ssl_verify = git_config_bool(var, value);
>  		return 0;
> @@ -806,6 +811,13 @@ static CURL *get_curl_handle(void)
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
>  	}
>  
> +#if LIBCURL_VERSION_NUM >= 0x073100
> +	if(curl_http_version == 20){

STYLE. Missing SP before opening paren and after closing paren.

> +		/* CURL Enable HTTP2*/

STYLE. Missing SP before closing asterisk-slash.

> +		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2);
> +     }
> +#endif

Shouldn't this block also handle the other values, e.g. "11"?

I _think_ the curl_http_version variable (be it an deci-int, or a
const char *) should be initialized to a value that you can use to
notice that the configuration did not specify any, and then this
part should become more like

	if (curl_http_version &&
	    !get_curl_http_version_opt(curl_http_version, &opt))
		curl_easy_setopt(result, CURL_HTTP_VERSION, opt);

with a helper function like this:

static int get_curl_http_version_opt(const char *version_string, long *opt)
{		
	int i;
	static struct {
		const char *name;
		lnog opt_token;
	} choice[] = {
		{ "HTTP/1.1", CURL_HTTP_VERSION_1_1 },
		{ "HTTP/2", CURL_HTTP_VERSION_2 },
	};

	for (i = 0; i < ARRAY_SIZE(choice); i++) {
		if (!strcmp(version_string, choice[i].name)) {
			*opt = choice[i].opt_token;
			return 0;
		}
	}

	return -1; /* not found */
}

which would make it trivial to support new values later.

>  #if LIBCURL_VERSION_NUM >= 0x070907
>  	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
>  #endif
