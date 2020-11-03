Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54144C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B24216C4
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a535k4tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgKCSqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSqP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 13:46:15 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6654C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 10:46:15 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id p3so15855482qkk.7
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EkWHpYw+RPVnEABk6nSQhb073DpN3Zd0bUQ+baxRhi8=;
        b=a535k4trr+c+usTSMdXAapibBKnHv5a5CdyUvfiTRgxPSkLNlz/DPV4wbdy+UFvJnV
         HbhsM9JYgwLSNJOpNeiUQwyb5uUH7YHWvE5CyGI90NBDCbBN85Yx447M8tFewBRlpiYz
         j14Ulz0cOg5tEYkFpFVHS/2iBXjqX/crRHdNRtp6bIbcCu60nm9nQNbGW0+AkQf+pZTr
         ZpaaIC7WA6wwjggvwjz44sSzhRe/N2jAit/wa1gGGwgI6UIKJ14PUHFmol+jugixplII
         C48funmhUQaw+rWvXOhfpDWuhv1afpvRv51o7Gd0jR3yMkDGPyZ7U153cFnYtYQ4p2Oh
         DFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EkWHpYw+RPVnEABk6nSQhb073DpN3Zd0bUQ+baxRhi8=;
        b=eSThWrStq9cA+V++9nsgBDKo2s60kiT9zVa/SGqoOBYSZ/WGRYHBzXl6/SMSbOJFyE
         4yywAlxnRSQWBRhmqLkBvDFF+pUIjxxlsKVmEsP6SSCOabAvS/Dl58rY1bPRJJEZuWML
         AE4S5CPQwZ4LlFBa8uWQWK+x9P+w6YYDGJf3tuCQyjWsli03gSYinU/HiZgGzmuoRsnn
         vzF3CGF6Oa6GU9fwOFXy3vLznCZSczLTStkQ2lFlS128SxEfQp+tFXYD5cwkued27Cl/
         naq24lrrJANyfC6yaEz8fP+gu0+JqLugXc5ERDZMPrGMo9xD9RGyhtxsZSuIYi3peBQY
         Ix1A==
X-Gm-Message-State: AOAM531ajNL+KpRzp4spV7jqRWbOFWbSO+Cmg3c24QNlqRRxq/Xt/7/4
        Buz6n6fZvEgn2Jot1gZ7cy/IyW+EHJQ+Sw==
X-Google-Smtp-Source: ABdhPJx6xHRAfcA3+myiQmFqMzWSaiLYuesrmUCIJ9itXMybFjTjGkUTMEFS17YbschxAyA6IOrVdg==
X-Received: by 2002:a05:620a:408f:: with SMTP id f15mr7510435qko.276.1604429174520;
        Tue, 03 Nov 2020 10:46:14 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id r62sm11400690qkd.80.2020.11.03.10.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 10:46:13 -0800 (PST)
Subject: Re: Segfault in git when using git logs
To:     Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0581272e-6ad2-42d9-0196-b804ee304619@gmail.com>
Date:   Tue, 3 Nov 2020 13:46:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 8:59 AM, Sathyajith Bhat wrote:
> Anything else you want to add:

Hi Sathyajith,

It seems like others have some good approaches to handling
this segfault and making sure we find the right balance
between supporting existing behavior and helping callers
who might be using this command incorrectly.

> Note that I am not calling the git log commands directly, my editor VS
> Code was repeatedly crashing and I searched in syslog and found this
> error.

I started filling out an issue on the VS Code GitHub repo
so they could perhaps fix their usage of "git log" in this case.
However, I started searching their code for where they might
be executing the command, and I didn't find anything!

Is it possible that you have an extension that enables Git
history commands like this?

The VS Code bug report issue template [1] has this bit of
advice to find out if an extension is at fault:

> <!-- Launch with `code --disable-extensions` to check. -->
> Does this issue occur when all extensions are disabled?: Yes/No

[1] https://github.com/microsoft/vscode/issues/new?template=bug_report.md

Could you re-launch your editor with "--disable-extensions" to
see if this is reproduced? Also, which extensions do you have
installed that might be adding Git command calls? We might need
to find the extension authors instead of the core editor team.

Thanks,
-Stolee
