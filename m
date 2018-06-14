Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02491F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbeFNRhU (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:37:20 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35386 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754616AbeFNRhT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:37:19 -0400
Received: by mail-wr0-f196.google.com with SMTP id l10-v6so7319824wrn.2
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OXZDoYIxNdM56Xk/afGOV/mzEEimC2kvc+WabUVHknM=;
        b=Hzg5lGz1O8yFW7FxgtSitHRG9aC7ond/Vj5hj5Ue5iOP1uzGgyuNPlsSAbU44jIRou
         M725yC3MEIYqT8+ehD0vvXDWEm+VrMIzqdESb20kGceddNnesS7PKd6Hi0An+evii7DM
         AgQOfa/6kg4dXkllPQ1FKT260Z92LJ/8JzxP33S05awzWLLuV10+7MQNdkw3iPa/KH+o
         P+DzkeArJjDS0ZwSNUSKbZeAICiyjSZ3lbFKZrsU7I3P2wQM4QK1TEIwzDc5aJhQPywy
         Zszo9iuwaU0D5MpeVzuaEXUJ/LLtUiYbT0cBWm8VMa6NeSKgPkFJOCo1FQ8BZ20Xj7wY
         Gsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OXZDoYIxNdM56Xk/afGOV/mzEEimC2kvc+WabUVHknM=;
        b=mVZh68dlqcyFAijSQvjBPFacyPgJLQSgX7jXRzeaiV3jDjjLDSjHExb6BxhtLcOBDH
         yRHzhsjhEO5LT69MwrDjWZIQovr2mRLY4yJj04uqgQ+mUt2WL/YnuRqHXdFrwyU4wFv/
         B3bX+C+b2A8i0MgFFDEu+3xUUzQfENNi3lpdL6bIp69f+IpMimTUzXjSProt4YIYWOhT
         9PmjgkclDcf0ZWgZSH/w77qxhfgjEr/XGlUY4hfQ1aPMu4L6zQExGTNs0TCFMRhhSnKl
         ZSq4kkOAde7AxTvxU8WmgR6tTJbB8wzuKWxZ5UNM85ITTkaMjJ4Pg+0Vg4VA+rxbRIc3
         +JYA==
X-Gm-Message-State: APt69E0JmY3nCwGtTGbC4aoi/izQBoArLkGJv2jBmPDlco63a4rcNeQp
        o01L22Vpce9Qvn9IJfn36eo=
X-Google-Smtp-Source: ADUXVKK1p3JREVO5rTGRXQCz+oFRX2/NYwLBmlHFbB2pqHdSuDRHRTzkkfu6GYxFoB+WWYPhYxgleg==
X-Received: by 2002:adf:8361:: with SMTP id 88-v6mr3053359wrd.17.1528997838417;
        Thu, 14 Jun 2018 10:37:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i46-v6sm12519947wra.36.2018.06.14.10.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:37:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
References: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
        <20180417213049.118995-1-sbeller@google.com>
        <20180417213049.118995-2-sbeller@google.com>
        <737e4f2e-9896-0119-2c43-655ac29fe018@web.de>
Date:   Thu, 14 Jun 2018 10:37:17 -0700
In-Reply-To: <737e4f2e-9896-0119-2c43-655ac29fe018@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 9 Jun 2018 13:26:53 +0200")
Message-ID: <xmqqmuvx46cy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>
> This adds a minor memory leak; fix below.
>
> -- >8 --
> Subject: [PATCH] blame: release string_list after use in parse_color_fields()
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Thanks.  Will apply.

>  builtin/blame.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 4202584f97..3295718841 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -411,6 +411,7 @@ static void parse_color_fields(const char *s)
>  		die (_("must end with a color"));
>  
>  	colorfield[colorfield_nr].hop = TIME_MAX;
> +	string_list_clear(&l, 0);
>  }
>  
>  static void setup_default_color_by_age(void)
