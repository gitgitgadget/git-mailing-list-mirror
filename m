Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6601C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C228D61504
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhKQLHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhKQLHR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 06:07:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD51C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:04:18 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4418508wmr.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IfQpmqUrXMIIR/BMeKlbAu1ZZfFhWZlmOWrm295FiVw=;
        b=pLJjSZSgW6DsvDYq7dUabG1psA7XjY2CtddqjbuMSfF+gmr9ZMxrQ0XLJ7aytt4V5U
         JmZiNZZwf4lNXY321zDFsjYXf9hYhuNOo1f435ZQ9bmEAxhapAoEk+BtKv8/9DBuGtT+
         7TY5iuc8195AI4UfVPnShidhfUkiK2ukEo1c1v7Ex96/jJbSWvUPtaLtpVtY9pRSjo1S
         FMV8xuC40nNbqa9uAas4PDLT4gdoHmh83ZklwuO/kqUlZHKXmNXSPQ0xDJUDwiJLOV3M
         he2UYZSQ26xRdCznVizlkYjV90tyOCEas+rWAZHli1OiPkx7ccdFkWa1B+liv+pvVgO2
         c92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IfQpmqUrXMIIR/BMeKlbAu1ZZfFhWZlmOWrm295FiVw=;
        b=0E0sivA8tWwYh7vcxvtj2FnMIITiWjxRW44sZxgBzg6jgGZmxDX0hk2CfhIa/NRbGC
         fmu3WmJrouFS/05xarvp5Px2UId268R5hocPBpT2KyUdbS7w3JB+wIITGjsqRMZdPhJR
         aqolWV3w9vTonXgnx+CNoPpge4L7jzcQ7gAK44t2KQJ0aFwJTWqWo3HhUZFTLcn8+T+2
         cQfuU/vQgWWu554DtCf7bZV1RQq0Wcle0KpPIJPRFAc/j9iUuXQBJrQJ9uQzqO9zGTT0
         9UrTPLDmGMaNMdf7sOM60DPYs4pdD9gQWNMMsfS1bmFYjkhQRhK0TTNpCfs3JAQbs86G
         LF0Q==
X-Gm-Message-State: AOAM532lZTm81dDB4QXwWLScUQeOvCcdZh8asXAY9Dql/eyyLZQJJuXa
        GCeuL58C2iU6ssZORa/A28/CbdsNJwco7g==
X-Google-Smtp-Source: ABdhPJwii9i1Qcm2ggh1txN5UEzVxjFbB8/zCQ+J4hTdfSoeDqodPPnQ5TBPyuAm4g2brxvZYuduUA==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr16307387wmd.143.1637147056966;
        Wed, 17 Nov 2021 03:04:16 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id s13sm5279441wmc.47.2021.11.17.03.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 03:04:16 -0800 (PST)
Message-ID: <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
Date:   Wed, 17 Nov 2021 11:03:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com> <xmqq7ddbme7q.fsf@gitster.g>
 <211114.868rxqu7hr.gmgdl@evledraar.gmail.com> <xmqqilwulims.fsf@gitster.g>
 <xmqqpmr2j5lq.fsf_-_@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpmr2j5lq.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 15/11/2021 06:27, Junio C Hamano wrote:
> There are certain C99 features that might be nice to use in our code
> base, but we've hesitated to do so in order to avoid breaking
> compatibility with older compilers. But we don't actually know if
> people are even using pre-C99 compilers these days.
> 
> One way to figure that out is to introduce a very small use of a
> feature, and see if anybody complains, and we've done so to probe
> the portability for a few features like "trailing comma in enum
> declaration", "designated initializer for struct", and "designated
> initializer for array".  A few years ago, we tried to use a handy
> 
>      for (int i = 0; i < n; i++)
> 	use(i);
> 
> to introduce a new variable valid only in the loop, but found that
> some compilers we cared about didn't like it back then.  Two years
> is a long-enough time, so let's try it agin.
> 
> If this patch can survive a few releases without complaint, then we
> can feel more confident that variable declaration in for() loop is
> supported by the compilers our user base use.  And if we do get
> complaints, then we'll have gained some data and we can easily
> revert this patch.

I like the idea of using a specific test balloon for the features that 
we want to use but wont this one break the build for anyone doing 'make 
DEVELOPER=1' because -Wdeclaration-after-statement will error out. I 
think we could wrap the loop in gcc's warning pragmas to avoid that.

Best Wishes

Phillip

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   revision.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 9dff845bed..44492f2c02 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -43,10 +43,8 @@ static inline int want_ancestry(const struct rev_info *revs);
>   
>   void show_object_with_name(FILE *out, struct object *obj, const char *name)
>   {
> -	const char *p;
> -
>   	fprintf(out, "%s ", oid_to_hex(&obj->oid));
> -	for (p = name; *p && *p != '\n'; p++)
> +	for (const char *p = name; *p && *p != '\n'; p++)
>   		fputc(*p, out);
>   	fputc('\n', out);
>   }
> 
