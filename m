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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6066C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA4320E65
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtn+GwT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgKCUHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 15:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgKCUHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 15:07:19 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0C7C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 12:07:19 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n15so17145051otl.8
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7PZBNOtKmmAhsjziXam15560gEdELmhC1qrC7v6lLeg=;
        b=Gtn+GwT32pCCxEL2suKXPtvuE4LkHaHxmiMu62f0K9WK5xxxwM2QtSv7rbKvCBP6Uc
         n8XEO3fZQcOoRetHM57kf5zVZGIdJlcotclRtrL6xJLv2ZCVnkE8wrc0GHR3jepxQV7C
         T4nj297a0D+Dxa7oEDhQJQbrh783wlsM2wYqeE6mr5P3kASqXw/4eoyP9zUq2kZUgo+e
         SCsq+e7oFKqt/CKJ4nmvQjVU4ScTl9IMcFWMX2X5c5l5eCfok+yJ7kZ/AGY4znbgJ7wq
         1prrjVXFKwkhvGS1rlz27AzrdmEBYEIcKlVh+DbjTd6HtsIcc7F0+ky0GCQR5ruQ53vT
         LdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PZBNOtKmmAhsjziXam15560gEdELmhC1qrC7v6lLeg=;
        b=oaxyGPZv7LX1aCk0mR3skRvcDosPxbsW5pxsaDEmViYeuk4BKqLe5m5Wg0R8+I+Scc
         bptm4cOeYQ+wTkV8XdJY3TH5yrBsvbAvf9aoRBjQVK4YxBX5DU5lXvuuIKOV7zgXTKs/
         KpEbA4mCbp/c0w6tCJib99vAct9lc7AKjA2+59QMMbiK4o3aeVbxEGhBdbIFflU0GGzv
         1JG3BlDM+/CTWBSqoR0fxxXUp7Fk7x+9wiDfs40RtqjY33Yyw4EsF7/e7pk/JRUZVrj8
         WkMSQGbzgDFLUXXSlvg+uIV0AgiTJUkJBk6peuMegQDzgBXDPg8+Jf0SmkV4YvZQsm9a
         4ZSQ==
X-Gm-Message-State: AOAM533ABIovF+HjwCGHKNPoNWJeGlpnHTmKj6k2stA8GfdQP664lwGX
        53oDhTgXKySCuBbzTZGSUhRpiShE8YHmsQ==
X-Google-Smtp-Source: ABdhPJxM7VhCrH9gVmTkfICzYkmmw5J9+ooCidmw+06eym3c1BS4tWwmowgY9XhbhHt2oK+xCr9AvQ==
X-Received: by 2002:a9d:7a7:: with SMTP id 36mr9016082oto.14.1604434038111;
        Tue, 03 Nov 2020 12:07:18 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id v10sm1022102otq.69.2020.11.03.12.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:07:17 -0800 (PST)
Subject: Re: Segfault in git when using git logs
To:     Jeff King <peff@peff.net>, Sathyajith Bhat <sathya@sathyasays.com>
Cc:     git@vger.kernel.org
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <0581272e-6ad2-42d9-0196-b804ee304619@gmail.com>
 <CAMsWJsxyW=JUh=XGCkGG3LhOsZASwFHtx9b6ziNi_uHa918Scw@mail.gmail.com>
 <20201103192327.GA462936@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0b6657a6-afc2-7862-de43-94868f9419a5@gmail.com>
Date:   Tue, 3 Nov 2020 15:07:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201103192327.GA462936@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 2:23 PM, Jeff King wrote:
> On Tue, Nov 03, 2020 at 08:55:52PM +0200, Sathyajith Bhat wrote:
> 
>> I believe it is GitLens [1] which is causing the incorrect behaviour.
>> I haven't had any crashes after I disabled GitLens, and that's the
>> only extension I've had which interacts with scm.
>>
>> [1] https://github.com/eamodio/vscode-gitlens
> 
> That makes sense. It seems pretty clear that its log__file() function
> will produce this bogus combination. Despite having some indication that
> it knows about the documentation forbidding it:
> 
>   https://github.com/eamodio/vscode-gitlens/blob/6cfd9fdedd7c6ec3bfa732af7c418bbbecdfba54/src/git/git.ts#L805
> 
> I don't know that project's code well enough to say whether there is a
> higher-level bug there (the issue seems to be the "renames" flag being
> enabled along with startLine; maybe the caller is wrong to specify
> both).

Thanks, both, for confirming the extension and the likely
line of code causing this problem. I submitted an issue [1]
on the GitLens repository. I'll continue watching it, but
feel free to chime in yourself if you are interested.

[1] https://github.com/eamodio/vscode-gitlens/issues/1139

Thanks,
-Stolee
