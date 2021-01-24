Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EADC433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FFE22D73
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 14:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbhAXOum (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 09:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbhAXOul (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 09:50:41 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D68C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 06:50:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ox12so14371026ejb.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gvLQSzrHz89H4Xg79yeKNUT+kq+gGwreFcQSleRuNtE=;
        b=qM9nAIDgHxHhb+pf5wwDwYSUz0bGt95GcrjkbpoLrRJGep8arKdUbwGoA7NulLbA5B
         apciY7W7SZQ805R0R/o36DVwI8+qSSNCtk9ZifaM/RdSkxsDi3JEv+X+66UiapEIaeHG
         5JgwCbt1Ywrrn8YToXlQahIMJDoe1/fpCNzEwSCSdiPHnfQN8Uvu03xujZoN31RgdfAE
         J2NDSZf4cFiK78AUf4mJB+qw2f1WFrtt/iuWG5rf9R2mSYqDPeNIWZXPlUsv59Z/4O0w
         3Hn2X+TIFQn7rqsBN37ZfOvxnFP83WBS8xqNzLWA0MNoPkt1v2BQurwyjVSmVAXfOTLe
         NqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gvLQSzrHz89H4Xg79yeKNUT+kq+gGwreFcQSleRuNtE=;
        b=JPZaCAZIUnduh9bt1+mESQ6zKBvPLMQDc5rLu0woz8aCGgwOUqY13OCoRVoPyQ4M9o
         IGz+7N5fw2VUF1qUM9Ypf8wbLdHI9qNYhRT0RoxZZ4wDQdfKFXNbi2L/WQ40nLFOLBJt
         8CxH0I0gRmzE7xEgGnfsX3WD6/5tan9RwM32SBcUzBOXGSFvvYKo+45fyt9lvDK3FqJc
         ss5+/iMcwNciycsXvhdS1E3cxWW1kJFW0GFKVKp+NowjvfYALbwbWsfOXBryLVZ3xzoJ
         PRnq3rfzJOaHHkVMFEj4T48zT2QpLvJguIg1dRX0rhogOqhjTkFjtM+BSYZjlsGMaTtA
         tFiw==
X-Gm-Message-State: AOAM531Z39ZWpYQxTkhGQ2SRaDp4/y7SkArV3SeSM0YZqhWbZCDdH1le
        PwlPH70Cw8lWaubnE6osBwChLOc3ONaHZQ==
X-Google-Smtp-Source: ABdhPJz1LfOumGWr+mDBH85sLKnS/uW60Erh3tIezo1XhcVVfmfqLboTLzXqoPkUN7o3W+Qo8OC1pA==
X-Received: by 2002:a17:906:1b0d:: with SMTP id o13mr1681204ejg.232.1611499799145;
        Sun, 24 Jan 2021 06:49:59 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id w6sm7015100ejj.116.2021.01.24.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 06:49:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/2] grep/pcre2: better support invalid UTF-8 haystacks
References: <20210124021229.25987-1-avarab@gmail.com>
 <20210124114855.13036-3-avarab@gmail.com>
 <6fe69ede-d24b-1742-f699-c9af05560c0c@ramsayjones.plus.com>
 <3f32c0da-ddb9-d821-5d37-5c002b48f9f9@ramsayjones.plus.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <3f32c0da-ddb9-d821-5d37-5c002b48f9f9@ramsayjones.plus.com>
Date:   Sun, 24 Jan 2021 15:49:57 +0100
Message-ID: <87a6sy75ka.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 24 2021, Ramsay Jones wrote:

> On 24/01/2021 13:53, Ramsay Jones wrote:
> [snip]
>
>>> diff --git a/grep.c b/grep.c
>>> index efeb6dc58d..e329f19877 100644
>>> --- a/grep.c
>>> +++ b/grep.c
>>> @@ -492,7 +492,13 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>>>  	}
>>>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
>>>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>> -		options |= PCRE2_UTF;
>>> +		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>>> +
>>> +	if (PCRE2_MATCH_INVALID_UTF &&
>>> +	    options & (PCRE2_UTF | PCRE2_CASELESS) &&
>>> +	    !(PCRE2_MAJOR >= 10 && PCRE2_MAJOR >= 36))
>>                                    ^^^^^^^^^^^^^^^^^^
>> I assume that this should be s/_MAJOR/_MINOR/. ;-)
>> 

Oops on the s/MAJOR/MINOR/g. Well spotted, I think I'll wait a bit more
for other comments for a re-roll.

Perhaps Junio can be kind and do the s/_MAJOR/_MINOR/ fixup in the
meantime to save be from spamming the list too much...

FWIW I have tested this on a verion without PCRE2_MATCH_INVALID_UTF, but
I think I did that by manually editing the "PCRE2_UTF" line above, and
then wrote this bug.

> Although, perhaps you want:
>
>             !(((PCRE2_MAJOR * 100) + PCRE2_MINOR) >= 1036)
>
> ... or something similar.

Probably better to use pcre2_config(PCRE2_CONFIG_VERSION) at that point
and versioncmp() the string.

FWIW we used this pattern (I added) before with PCRE, see e87de7cab4
(grep: un-break building with PCRE < 8.32, 2017-05-25).

And if you want to be clever ((PCRE2_MAJOR) | ((PCRE2_MINOR) << 16)) is
probably better, then you can get it out with bit operations :)


