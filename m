Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570701F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeBVAfe (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:35:34 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:40824 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBVAfd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:35:33 -0500
Received: by mail-pl0-f51.google.com with SMTP id i6so1926034plt.7
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJWT0iY4pOCWeLL7MVTZDR+vI0SMIbMY//6CS+pf6c0=;
        b=CuYYNFiiY+ISfVdwRfMPS2NySkmm5NOgXcwKgLkEsEg8sVyughTFj3jd2gO0n7D9Pg
         +8Fxa2fMkW2zGVcELUJeXWkjCxPsWcHnYP/JZkWXvMUhbYWGZllaPcnq7V2ujlGlLHo/
         6awJR2ZoSQpN+6K494f3A/VAtUGhulIfibqJUMxcHAtW0THkpOuzyebhb6Eg0DuTwdP0
         DfqAX9mVcvLvDtNNjBr852PT0kxwcSs1jWMN9XJUqtqH9A53kb673/gFNjchJaa35FRu
         L/rj1M8IhzSaYm1cfzLuoyri2FjFIo2cGT7Ion3bwcUxbhqFtIh4RmIo1RKb2YjCfFCi
         1hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJWT0iY4pOCWeLL7MVTZDR+vI0SMIbMY//6CS+pf6c0=;
        b=oWhcMa9LgShWd0HX5+1ii1V+J54V89RHtqfgba96ePnV18Mol5aC3homR6X5ESiiRX
         PVQGJCJWrHcSjzYOVJrNS8DUAre/mRepZlntbveN4b3OG7NCbrlb3rH/kZNp6nhG3EbT
         4z9zYRTBBI7KSMJf/oGDXFg5/BP9IUwo9XXRZIJbjaI4FYZEXjPkZueG1ic+kbZ7xt9o
         b5Yo5iGnAAIMbelYQ7UniCljlsXohwM7wQCBeei6ECcGdVE4UwGkmcUZslG/zpY6za7D
         IMmVKTsJy/SpFx9OEmFzk6gn+yDzJgK3OjZTOPnOzPlV6oQoK1PnFxZ6iLZfFHQ18KFa
         iR3A==
X-Gm-Message-State: APf1xPDUQOwRZwM/O7Gfo8nK4Wx9Y4Nz/Yhrw0ej1mNMEXy5JFQ2NCsS
        O4ioIMvjklcR4UCgibO8fp8pmA==
X-Google-Smtp-Source: AH8x226pvE4dnl+zIj3ql78Ygpqq5RypZep1FYPK0TvYKdeuEsfiHL83aq+MPjAkZeJcAnfdXjYI/A==
X-Received: by 2002:a17:902:9343:: with SMTP id g3-v6mr4839459plp.319.1519259732896;
        Wed, 21 Feb 2018 16:35:32 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id d124sm68869379pfc.83.2018.02.21.16.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:35:31 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:35:30 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH 15/27] sha1_file: allow prepare_alt_odb to handle
 arbitrary repositories
Message-Id: <20180221163530.3a6659b8e0bec5dfab835232@google.com>
In-Reply-To: <20180221015430.96054-16-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
        <20180221015430.96054-1-sbeller@google.com>
        <20180221015430.96054-16-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Feb 2018 17:54:18 -0800
Stefan Beller <sbeller@google.com> wrote:

> -void prepare_alt_odb_the_repository(void)
> +void prepare_alt_odb(struct repository *r)
>  {
> -	const char *alt;
> -
> -	if (the_repository->objects.alt_odb_tail)
> +	if (r->objects.alt_odb_tail)
>  		return;
>  
> -	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> +	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
> +
> +	if (!r->ignore_env) {
> +		const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> +		if (!alt)
> +			alt = "";

alt can be NULL, just like in the existing code, so these 2 lines are
unnecessary. (link_alt_odb_entries() will just do nothing in either
case.)

(I also think that the check of absence of alt should be done by the
caller of link_alt_odb_entries(), not by link_alt_odb_entries() itself,
but that is much beyond the scope of this patch set.)

>  
> -	the_repository->objects.alt_odb_tail =
> -			&the_repository->objects.alt_odb_list;
> -	link_alt_odb_entries(the_repository, alt,
> -			     PATH_SEP, NULL, 0);
> +		link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
> +	}
>  
> -	read_info_alternates(the_repository, get_object_directory(), 0);
> +	read_info_alternates(r, r->objects.objectdir, 0);
>  }
