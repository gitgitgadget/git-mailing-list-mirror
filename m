Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCADF201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdBXUrm (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:47:42 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33924 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBXUrk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:47:40 -0500
Received: by mail-pg0-f67.google.com with SMTP id s67so4298976pgb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2F70oxXMr0edTEjo0MbLvBJifkTOirJLwmDMQp391no=;
        b=rVUbScYacsCVI7hOovzLxQaVKOL1n8c3ANc+wZ2i1ltC4pe/SQ+IoWZZhiv1CtPbUZ
         ciIBXu2/C+tyqNujsedern1n4FS+48jfvI8NbPW2bTUN/RmDLuYXVsNlkdiUKFBqPe9n
         EVGcCjSwQhjE0QT5NxqDJGCz6mR4dbdiaDbvpLtgHg0wUdUujwDdz1G8G+LzPxxFve9G
         agPmAEG22sWoXaZ7SYrapz3byv2OCsG6z4TA0Kw2bxxkCXCUZE/8fHFLDt0YQTQFTukM
         kayTNiFf0CtIezOpZBrDg2OjiMVzYlEtf9WmWju+s/3YAeEK+eUgKwi7hY8LOTM6ne/c
         kEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2F70oxXMr0edTEjo0MbLvBJifkTOirJLwmDMQp391no=;
        b=jIiLeEzRhQYWNynGpX41O5aINv4y/feV5hs6cKiiMi04Xc+8RtaEPe/QrdzlyqstIO
         Lfc6TmroKBmrHR419mtPINi3tW90hYKzPwKXuvCCdV9fQtqhH2SRMjUphrEbb2V0xU2k
         TOnZ8dbLWRlP+zTDz/XwPXSiWhr0rUElNkqr3I7jw4Qceib7xnd1MJvh2nIPeYRK9e9L
         G7z8E9yNnf/ZZIr2ZMA+2v4cy4BQh2B5W3KNSNJL+aTd4iLovElj9BoJgXrhDdkUNWOy
         UV0wl3BorkQfb5Q5ZTdljpAeNf0TGdeVEp6PIoADSpk7u4Bt9wwd1Sb1ZjRItpZsiIoe
         NBDA==
X-Gm-Message-State: AMke39mzaYJakxaZ2JzOPuSaFWoUH4uh5+zjrI6uzeks1um2UIRvqihw8KwsIXm7pi5Mpg==
X-Received: by 10.99.104.133 with SMTP id d127mr6001493pgc.52.1487969259674;
        Fri, 24 Feb 2017 12:47:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id x15sm16733635pgo.56.2017.02.24.12.47.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:47:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] refs: parse_hide_refs_config to use parse_config_key
References: <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
        <20170224204335.10652-1-sbeller@google.com>
Date:   Fri, 24 Feb 2017 12:47:38 -0800
In-Reply-To: <20170224204335.10652-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 24 Feb 2017 12:43:35 -0800")
Message-ID: <xmqqd1e71fkl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> parse_config_key was introduced in 1b86bbb0ade (config: add helper
> function for parsing key names, 2013-01-22), the NEEDSWORK that is removed
> in this patch was introduced at daebaa7813 (upload/receive-pack: allow
> hiding ref hierarchies, 2013-01-18), which is only a couple days apart,
> so presumably the code replaced in this patch was only introduced due
> to not wanting to wait on the proper helper function being available.
>
> Make the condition easier to read by using parse_config_key.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index cd36b64ed9..21bc8c9101 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1034,10 +1034,11 @@ static struct string_list *hide_refs;
>  
>  int parse_hide_refs_config(const char *var, const char *value, const char *section)
>  {
> +	const char *subsection, *key;
> +	int subsection_len;
>  	if (!strcmp("transfer.hiderefs", var) ||
> -	    /* NEEDSWORK: use parse_config_key() once both are merged */
> -	    (starts_with(var, section) && var[strlen(section)] == '.' &&
> -	     !strcmp(var + strlen(section), ".hiderefs"))) {
> +	    (!parse_config_key(var, section, &subsection, &subsection_len, &key)
> +	    && !subsection && !strcmp(key, "hiderefs"))) {
>  		char *ref;
>  		int len;

Thanks for noticing.  "once both are merged" is a cryptic comment to
leave when somebody knows which two topics make "both" ;-)
