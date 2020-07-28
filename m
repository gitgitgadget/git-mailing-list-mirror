Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E9EC433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 13:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EEB2074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 13:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJk2cU/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgG1N6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgG1N6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 09:58:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360D6C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 06:58:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so9936382plr.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bYlkt8ldpqcWk8T0SL7s+fcmXoeXXaWgH6TalrdGcHo=;
        b=mJk2cU/TNpLWHISCvvJW/KWVGAf6adKb8260CClKii1fq7vIFUKygsEr7hAg6qLh9o
         xM8XwU8/taOwOuSdCkZvOyKEMabvJ4/D7xGEeZ9aJ9IvheV0zE9D3nYTo9AStLptPwrj
         oC5E0bXqXS/vp5sOh2AaJFLyv6IMJw9Ygy40QaZvHkg95/SVbfCTjDbs9zwn5HggirKG
         C+rvZXISNbKOvhy1rTA2yyW5FiHqKl9BWoqV0AF3QJ6FJ0EzlLYf63e9NCKA5z/D5kDY
         d1MyDtC58MolfvhcxGEAnpHh87VxBbSXvVYkOVgBAdQENJqtVHipfxdW8guRQJj0WgSQ
         q4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bYlkt8ldpqcWk8T0SL7s+fcmXoeXXaWgH6TalrdGcHo=;
        b=ZbF9N74O2jQb8wkvvHCIkTgcBHUo1utoQbMx56ROjeACxWLiT53vydpByhvaFCjlVD
         idC/KIy/viN72zQ3rgH2QIWqfFSDRpNR3Vt4rcHLwcgAErhj/DgbJHOSoOUWETUCw056
         f2XF5IMXbulhsGh6oXBpowBPwe1aU74P3AuD13w3fzzKIWqGvZqgGLuS+YqmJfVZTBxV
         Z9EvpFbkAQIDrEVumdm1vsOaDt3/Hl/o8BNl4hsxQUm29Q2BwS8Ge9eB3kUzXkUVnChj
         ILvhFe7GWZL9Ezs+Vs5MAbig6c9fP62bRXlIvoPkDJi+DqW4+EDb3bS4aZRY+owwNqXl
         IowQ==
X-Gm-Message-State: AOAM533DYyAifWpjC+1quRDuxL5A2m41DHmdN0FW5EwYS6I+sdsGMf1j
        FSAsyZyNNICMX+4mHKxIPJo+Nzpq
X-Google-Smtp-Source: ABdhPJy1KpFfUztCmfeHhIaZwgb+NSMwNP3E/dM3Cl5qWVXcZJTh+Q9ruQBlgmvkaGnc1nmTgcg1zg==
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr23037125plb.95.1595944685742;
        Tue, 28 Jul 2020 06:58:05 -0700 (PDT)
Received: from localhost ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id i13sm3134548pjd.33.2020.07.28.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 06:58:05 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:58:03 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/5] ref-filter: support different email formats
Message-ID: <20200728135803.GD24134@danh.dev>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
 <aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ade8.1595882588.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ade8.1595882588.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[this is a resent, my previous mail couldn't reach the archive]

On 2020-07-27 20:43:04+0000, Hariom Verma via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Hariom Verma <hariom18599@gmail.com>
> 
> Currently, ref-filter only supports printing email with arrow brackets.
> 
> Let's add support for two more email options.
> - trim : print email without arrow brackets.
> - localpart : prints the part before the @ sign
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Heba Waly <heba.waly@gmail.com>
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
>  ref-filter.c            | 36 ++++++++++++++++++++++++++++++++----
>  t/t6300-for-each-ref.sh | 16 ++++++++++++++++
>  2 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/ref-filter.c b/ref-filter.c
> index 8447cb09be..8563088eb1 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -102,6 +102,10 @@ static struct ref_to_worktree_map {
>  	struct worktree **worktrees;
>  } ref_to_worktree_map;
>  
> +static struct email_option{
> +	enum { EO_INVALID, EO_RAW, EO_TRIM, EO_LOCALPART } option;
> +} email_option;
> +
>  /*
>   * An atom is a valid field atom listed below, possibly prefixed with
>   * a "*" to denote deref_tag().
> @@ -1040,10 +1044,26 @@ static const char *copy_email(const char *buf)
>  	const char *eoemail;
>  	if (!email)
>  		return xstrdup("");
> -	eoemail = strchr(email, '>');
> +	switch (email_option.option) {
> +	case EO_RAW:
> +		eoemail = strchr(email, '>') + 1;
> +		break;
> +	case EO_TRIM:
> +		email++;
> +		eoemail = strchr(email, '>');
> +		break;
> +	case EO_LOCALPART:
> +		email++;
> +		eoemail = strchr(email, '@');
> +		break;


This is not correct.
RFC-822 allows @ in local part,
albeit, that localpart must be quoted:

        addr-spec       =       local-part "@" domain
        local-part      =       dot-atom / quoted-string / obs-local-part
        quoted-string   =       [CFWS]
                                DQUOTE *([FWS] qcontent) [FWS] DQUOTE
                                [CFWS]
        qcontent        =       qtext / quoted-pair
        qtext           =       NO-WS-CTL /     ; Non white space
        qtext           =       NO-WS-CTL /     ; Non white space controls
                                %d33 /          ; The rest of the US-ASCII
                                %d35-91 /       ;  characters not including "\"
                                %d93-126        ;  or the quote character
        quoted-pair     =       ("\" text) / obs-qp

IOW, those below email addresses are valid email address,
and the local part is `quoted@local'

        "quoted@local"@example.com
        quoted\@local@example.com

Anyway, it seems like current Git strips first `"'
from `"quoted@local"@example.com'


-- 
Danh
