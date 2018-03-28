Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77CAB1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 05:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeC1FGk (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 01:06:40 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53267 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1FGg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 01:06:36 -0400
Received: by mail-wm0-f50.google.com with SMTP id p9so2412118wmc.3
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 22:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Brv3rV8vRDuAvm/LJhy2KkT1kVf65lK2MrsJ4vHxM4E=;
        b=YCPiKHcnaR1YsjNO9OD3YTqCpO7hwz6l4o+Ozrm7orRbfm8Y+OlyR/vn3BxWWzSaee
         K9j8i/Y1Guyza9zGThvfiRnXWMuu/tNnaxoP8DVW4GWCm6LiAMiNEHSTHXqPoSYIT1W4
         lsri7D9f7OAo5+Pf6zodyw8uHjd5In3l3ndzcb4A07aQlQKa2EId+yTO+hicnnXj2Ehc
         LSR05MaCNHcx8be2bo6LwPmWVX1UsaCXc4rr7aLqfqa+2XaZq6tX0A6EIiUjDmQnYhLy
         AQ3l5Sddjdl7ujp1OqCvtswUFYRnRyRY4yRM9vwrX3v5QQ4uMpRtmEa8RRETmBOx3Egc
         9Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Brv3rV8vRDuAvm/LJhy2KkT1kVf65lK2MrsJ4vHxM4E=;
        b=j63qXIHCFi2gI2oJH5LE494USlJNhx+HCyjat2Kv7HPPGNVRVJTQmN2YL/dZEifTJ7
         sPXbSBsZm4eS52jAOExUfallawzGVOf7pPIb0q/JeJviSoy45sDrJC7CBSSkFmBDSXJW
         lhmnoUZB/YBkDjLtbjF+N8ntaNQeO/0XSeZFqjvVc9hl4bwv+EYXTHEJut37YlMt3msx
         cWguojxEQevjOvgCso798FLbutabKf1mG586IQZsFM1bPiHpGw9LTP7+vPXt7KLfXckb
         5MUsnyAYBJH60/GJAteNeIZam56ULh17aSARAOjRynL2YdpTtNBowcTXiJAuI/zvlwr6
         Q1+w==
X-Gm-Message-State: AElRT7GpG8nwyyFnHxVXO2jxW8x2UufMgmsi91/7RrsQ9wzH4mgKjgni
        W3Fu/rfvjmzWqEMGLr1hMVA=
X-Google-Smtp-Source: AIpwx48JvjeLl75vfDxBlzGulymNqvPpd+aFaIO+FqQ0CqdWv6kF0qHLtWPHUA1LbCDr2Y+rJQwOuw==
X-Received: by 10.28.21.4 with SMTP id 4mr1278117wmv.34.1522213595176;
        Tue, 27 Mar 2018 22:06:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 137sm3824674wms.18.2018.03.27.22.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 22:06:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, kumbayo84@arcor.de, pc44800@gmail.com
Subject: Re: [PATCH] submodule deinit: handle non existing pathspecs gracefully
References: <CAGZ79kYGY5bjh0WPQh7xkXQxLkB9EQ-OcJhVuGE8YUnwmvk2Fg@mail.gmail.com>
        <20180327232824.112539-1-sbeller@google.com>
Date:   Tue, 27 Mar 2018 22:06:33 -0700
In-Reply-To: <20180327232824.112539-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 27 Mar 2018 16:28:24 -0700")
Message-ID: <xmqq4ll0aiw6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This fixes a regression introduced in 22e612731b5 (submodule: port

s/22e/2e/, I think.

> submodule subcommand 'deinit' from shell to C, 2018-01-15), when handling
> pathspecs that do not exist gracefully. This restores the historic behavior
> of reporting the pathspec as unknown and returning instead of reporting a
> bug.
>
> Reported-by: Peter Oberndorfer <kumbayo84@arcor.de>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It seems that all the other callersof module-list expect that a
negative return from the function is a normal "nothing to do"
condition and returns 1, and this patch makes the oddball "deinit"
do the same.

Sounds good.  Will queue.

Thanks.


>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ee020d4749..6ba8587b6d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1042,7 +1042,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
>  		die(_("Use '--all' if you really want to deinitialize all submodules"));
>  
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> -		BUG("module_list_compute should not choke on empty pathspec");
> +		return 1;
>  
>  	info.prefix = prefix;
>  	if (quiet)
