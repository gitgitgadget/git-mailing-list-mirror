Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F0B201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 20:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755150AbdBVUUO (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 15:20:14 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34927 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755125AbdBVUT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 15:19:58 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so1763134pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 12:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zXA10mjT1wnuXrdns2nDAhgn5vw3xk+VrlUG0a0wt1U=;
        b=fOtMYJdGH2+zwTL6ahn9YcKsBrCk4vU5BLLqoaNQ9s/fDKLk/1NGQy2lyTgTIk7IkA
         7ggFFBkVhgF4bzSV5NfYvBH9HtjfNd3h+puqTaFGQargbOiOtksW/W9aWD4Jgglfzi2o
         mjzXipv2lUkvG3tTmFPDcjZFbTzXIP7fZhyPKOznjpJYpStNdirmRPWdFgfTnIdfd0eB
         6IejAj1RrRxIQb+YtKFAiWhI+Brl/OUGQgmPYp7h10TLlinG7ERkTqDmsf0YI9YvTRg4
         +C0xbUWhqAzIgoI3kVdS/s7Ny+YEvA5jaUYshpmyEXP6+70NTbvAFjEqsGUu+danIhfQ
         paCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zXA10mjT1wnuXrdns2nDAhgn5vw3xk+VrlUG0a0wt1U=;
        b=K3ly49p2dCLOtxUoAA8EFYTk/ZD4pOh5Dt4mX6Q5j0KaaH9tKjA1Dwe6ak47fzuc4u
         AyJUmrnx5zbPHWx8Fdk5oCcMdw7T4iIIX5PGQ5Vevz9KZZYd3uh5x/Qk2UvV2Ph10L6U
         bCIjJlAzqWN9M9PFZsA/DQRUa3ipViSZyD1l0i9K8lNU6r8f8cNt4eGMZttItG7Gp+4r
         p47D+YNvefMdImMaFF/MnYNAi10kf+O/FkDlCD4oWLBMv1WOLPEgX+kplss4OrbS03h1
         15LGkuIgNyCAx5EOfEphADauVTs9JJbtBR3/CLc35HDaRnO3cdEvBPAyc109+MteA7Kc
         RODg==
X-Gm-Message-State: AMke39kPabZozoKVRHmqrYxVUtDqk2QxPp0J2eyrQZDps6OZgOqvPJYfj8YyVlWvGVQGcQ==
X-Received: by 10.99.37.135 with SMTP id l129mr43884311pgl.206.1487794797813;
        Wed, 22 Feb 2017 12:19:57 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id t22sm5216072pfa.114.2017.02.22.12.19.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 12:19:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
References: <20170222173936.25016-1-dturner@twosigma.com>
Date:   Wed, 22 Feb 2017 12:19:56 -0800
In-Reply-To: <20170222173936.25016-1-dturner@twosigma.com> (David Turner's
        message of "Wed, 22 Feb 2017 12:39:36 -0500")
Message-ID: <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is common in corporate setups to have permissions managed via a
> domain account. That means that the user does not really have to log in
> when accessing a central repository via https://, but that the login
> credentials are used to authenticate with that repository.
>
> The common way to do that used to require empty credentials, i.e. hitting
> Enter twice when being asked for user name and password, or by using the
> very funny notation https://:@server/repository
>
> A recent commit (5275c3081c (http: http.emptyauth should allow empty (not
> just NULL) usernames, 2016-10-04)) broke that usage, though, all of a
> sudden requiring users to set http.emptyAuth = true.
>
> Which brings us to the bigger question why http.emptyAuth defaults to
> false, to begin with.

This is a valid question, and and I do not see it explicitly asked
in the thread:

https://public-inbox.org/git/CAPig+cSphEu3iRJrkdBA+BRhi9HnopLJnKOHVuGhUqavtV1RXg@mail.gmail.com/#t

even though there is a hint of it already there.

> It would be one thing if cURL would not let the user specify credentials
> interactively after attempting NTLM authentication (i.e. login
> credentials), but that is not the case.
>
> It would be another thing if attempting NTLM authentication was not
> usually what users need to do when trying to authenticate via https://.
> But that is also not the case.

Some other possible worries we may have had I can think of are:

 - With this enabled unconditionally, would we leak some information?

 - With this enabled unconditionally, would we always incur an extra
   roundtrip for people who are not running NTLM at all?

I do not think the former is the case, but what would I know (adding a
few people involved in the original thread to CC: ;-)

>  Documentation/config.txt | 3 ++-
>  http.c                   | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fc5a28a320..b0da64ed33 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1742,7 +1742,8 @@ http.emptyAuth::
>  	Attempt authentication without seeking a username or password.  This
>  	can be used to attempt GSS-Negotiate authentication without specifying
>  	a username in the URL, as libcurl normally requires a username for
> -	authentication.
> +	authentication.  Default is true, since if this fails, git will fall
> +	back to asking the user for their username/password.
>  
>  http.delegation::
>  	Control GSSAPI credential delegation. The delegation is disabled
> diff --git a/http.c b/http.c
> index 90a1c0f113..943e630ea6 100644
> --- a/http.c
> +++ b/http.c
> @@ -109,7 +109,7 @@ static int curl_save_cookies;
>  struct credential http_auth = CREDENTIAL_INIT;
>  static int http_proactive_auth;
>  static const char *user_agent;
> -static int curl_empty_auth;
> +static int curl_empty_auth = 1;
>  
>  enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
