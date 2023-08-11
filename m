Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC22EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 18:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjHKSAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHKSAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 14:00:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E2FDA
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:00:49 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-686e29cb7a0so2659263b3a.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691776849; x=1692381649;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtxzRk9g2xGCgp1J0s0bgBa725MjzoS/xY1MIJbflYE=;
        b=p4uO+JRMgJObo3tzMgkYOJ9mV6OJsmf8J0Sjefxqf1S5EwR6i2t2Tz2sItx4YReSiC
         pemkjQFeRYIXNmDiOf1eKOOqo4SGTV7W5eNwO+Y7ohiwhdL4qZm/H4nbfnLfmmMv6ykc
         Y6JpL9SvIYuS8vAknVJ73Nxl6Z9yuI16qmvfeX4aTQwYj/89dP5ITHhVnwIo5ZO8jg+Y
         3rG72dyzXuAL2YSrIOQ9Rq+5y9r4yYUaHUJmxsiVuPNYU+78ikBf9Pt5Z6eNwQrMQLB3
         PqeySsACgk4I0G6bkIZ0I1XXs+YeX2ltukCfmr8xjK298epBIcwH9SZkDviIGhdxiTJT
         aZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691776849; x=1692381649;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtxzRk9g2xGCgp1J0s0bgBa725MjzoS/xY1MIJbflYE=;
        b=kcGgKpB1qcNTERmcvw4iL6v/KDT1itovJoeYj0Fj+MwIOrzGsC1CFtBQeDVeUuHX4x
         +Vjm60PwYuAgcItZxF6pvvnHCcQ1cfANa0D48uZzL5hKt4SP91sOJ5Q6i8d2gSYGxWp0
         nyWvRRQUEX+0lUAWj0RvwjUOyXMKYG6KSnw/3/H6kGsAHyydXVPpWFNM/4BbS22W/NdV
         oV49AbNaE5aaUfR6p5YsYlKYw+MV92VSrF8rZWRkXYjixUui9Jcp6LRTD5ATaXbvzksr
         46pN1aBGAiCC1YwWd6EkBZYgk5YUKFSL9izJzOEsXY3vq+IqdfB4kqzPaory7OgxsnNA
         AV5w==
X-Gm-Message-State: AOJu0YyVDeSg9aL4SN9HZXPFMna/vgNNg1NW/RhESkCt7QCO1dUiW7V0
        y7+Fn3MJv3fcp+n+ECuFnFfXoQ7Obeg=
X-Google-Smtp-Source: AGHT+IEChTCr9ElHvCg+R06FTJJ+vG69UM6ZvrGtXAde+rQcA0/OSmIp7U3Mhn2Z0EtdDIqK/sNNOfPbaLU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:c90:b0:681:3d96:bddc with SMTP id
 a16-20020a056a000c9000b006813d96bddcmr1187076pfv.2.1691776849413; Fri, 11 Aug
 2023 11:00:49 -0700 (PDT)
Date:   Fri, 11 Aug 2023 11:00:48 -0700
In-Reply-To: <kl6lv8dq8li0.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <7c9b63c26164b037272fde689bb3150b30aa7528.1691211879.git.gitgitgadget@gmail.com>
 <kl6lv8dq8li0.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <owlycyztfohb.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 5/5] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
From:   Linus Arver <linusa@google.com>
To:     Glen Choo <chooglen@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> (2) "Default" can also mean the "trailer.*" configurations themselves,
>>     because these configurations are used by "default" (ahead of the
>>     hardcoded defaults in (1)) if no command line arguments are
>>     provided.
>
> Interesting, I would have never thought of config as 'default'. In fact,
> I would have thought that this de facto behavior (which you also
> clarified in [1]) is a bug if not for the fact that in an internal
> version of this series, you cited a commit message that describes this
> as expected behavior. That context would be very welcome in the ML, I
> think.
>
> [1] https://lore.kernel.org/git/6b427b4b1e82b1f01640f1f49fe8d1c2fd02111e.1691210737.git.gitgitgadget@gmail.com

I forget the internal version/discussion, but I assume you're thinking
of 0ea5292e6b (interpret-trailers: add options for actions, 2017-08-01).
I will reroll and mention it to the commit message.

>> In addition, the corresponding *_DEFAULT values are chosen when the user
>> provides the "--no-where", "--no-if-exists", or "--no-if-missing" flags
>> on the command line. These "--no-*" flags are used to clear previously
>> provided flags of the form "--where", "--if-exists", and "--if-missing".
>> Using these "--no-*" flags undoes the specifying of these flags (if
>> any), so using the word "UNSPECIFIED" is more natural here.
>>
>> So instead of using "*_DEFAULT", use "*_UNSPECIFIED" because this
>> signals to the reader that the *_UNSPECIFIED value by itself carries no
>> meaning (it's a zero value and by itself does not "default" to anything,
>> necessitating the need to have some other way of getting to a useful
>> value).
>
> Makse sense. This seems like a good change.
>
>> @@ -586,7 +586,10 @@ static void ensure_configured(void)
>>  	if (configured)
>>  		return;
>>  
>> -	/* Default config must be setup first */
>> +	/*
>> +	 * Default config must be setup first. These defaults are used if there
>> +	 * are no "trailer.*" or "trailer.<token>.*" options configured.
>> +	 */
>>  	default_conf_info.where = WHERE_END;
>>  	default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
>>  	default_conf_info.if_missing = MISSING_ADD;
>
> As mentioned earlier, I find it a bit odd that we're calling config
> 'default' (and also that we're calling CLI args config), but
> renaming default_conf_info to config_conf_info sounds worse, so let's
> leave it as-is.

SGTM. Although, we could also just rename it to "conf_info" (same name
as the struct name). Unless such same-variable-name-as-the-struct is
discouraged in the codebase.
