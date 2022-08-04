Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ABBC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 15:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiHDPel (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 11:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiHDPek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 11:34:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C71FD11
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 08:34:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w29so49388qtv.9
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f+peXnX2FS53X9FIPQzcEHopepREmUSHxsUwbqP4sXE=;
        b=jKz6YeiXfvD4u0S4a0iJdfMZowgHPPvG+vpORdwl1S97m8HuTZfCKhZ8Adj5Ja7m5i
         WIDrwhizWvQt2IItfEabsFWBY/G8f1FY3BVJha6Vm9RasPWHw66EOZfdAcUSieiA6jKd
         PrrDfk420FDT2VtGDRV999CVzbGmSjprFhkQq+TGHCpn/HsFm/0ICNHg14OKccwov3ZE
         3skUePvVrWar1p8Bv2LUgUascxzuG0/A6kAGdCt5U7T+ErjvkLVnW+OKOy2ghcOHvvEa
         CevRZgstR++0DQzZrmdND2F/6ap7SBnad6u5NLMPSEN+GkM0qppPj2ZEaPTvlLRNEfkc
         6ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f+peXnX2FS53X9FIPQzcEHopepREmUSHxsUwbqP4sXE=;
        b=2WBkmGcSSK6GMxNp8GS05Vq1NT/HXS2q6sK0dr6IYRW/P1qrmGgu8Q4RP5lDg6jyRG
         67jm4H7ViUm6dQDMoYt3pAJvx2c4fEflrmn7+kqyzYRRYYZjpVtekagj6GxlWVYs8F18
         Fuv+az29g9Q+A8pYGuFgxhJgzgrMj1KJYRtdyzAuDWKNZGgJX1G/ozyQYAtFEhkkib3d
         D+9SL2kVC0kMxnYC/9llIqwrKiijLj37zb2wAKcu8vK7b0lhjlHnKYLtGVAbLQ1TPrRl
         PksgTnEZG1qVRdI6CYG2mZIaY7CbNY4D6Jb30TWtrukfxkTtLWA+vSnph/67EwQip+hR
         WWKw==
X-Gm-Message-State: ACgBeo2YLSjV7/NssH2OxNaXD31XNYKBbiYh+Nk9Bf+kR2YsL9LMCXn5
        GnizMEYm7US07ikhgdPtCrtA
X-Google-Smtp-Source: AA6agR7DHm389QOsikaC1geyN6tkdwhnwRhKjJLOzlCW+z8lZ5XpUhPmPnwSjxnbMG9O0urec3elhQ==
X-Received: by 2002:a05:622a:1d1:b0:33b:71bc:a081 with SMTP id t17-20020a05622a01d100b0033b71bca081mr2009302qtw.325.1659627278327;
        Thu, 04 Aug 2022 08:34:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id k22-20020ac86056000000b002f936bae288sm817592qtm.87.2022.08.04.08.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:34:37 -0700 (PDT)
Message-ID: <9afd5eb2-44a0-6342-6006-5dbdefba9947@github.com>
Date:   Thu, 4 Aug 2022 11:34:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/5] bundle-uri: add support for http(s):// and file://
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
 <e4f2dcc7a45388663aeac786e5abdcf2164cfe62.1659443384.git.gitgitgadget@gmail.com>
 <xmqq8ro6fi1j.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8ro6fi1j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/2/2022 5:32 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +static int copy_uri_to_file(const char *filename, const char *uri)
>> +{
>> +	const char *out;
>> +
>> +	if (istarts_with(uri, "https:") ||
>> +	    istarts_with(uri, "http:"))
> 
> Let's be a bit more strict to avoid mistakes and make the code
> immediately obvious, e.g.
> 
> 	if (istarts_with(uri, "https://") ||
> 	    istarts_with(uri, "http://"))
> 
>> +		return download_https_uri_to_file(filename, uri);
>> +
>> +	if (!skip_prefix(uri, "file://", &out))
>> +		out = uri;
> 
> If we are using istarts_with because URI scheme name is case
> insensitive, shouldn't we do the same for "file://" URL, not
> just for "http(s)://" URL?  IOW
> 
> 	if (!skip_iprefix(uri, "file://", &out))

Good ideas. Of course, we don't have a skip_iprefix(), but
I can use "istarts_with()" and then manually add the length.
If we see more need for that in the future, we can consider
adding it.

(It's interesting that these uses in bundle-uri.c are the
only uses of istarts_with() that I see in the codebase.)

>> +static int download_https_uri_to_file(const char *file, const char *uri)
>>  {
>> +	int result = 0;
>> +	struct child_process cp = CHILD_PROCESS_INIT;
>> +	FILE *child_in = NULL, *child_out = NULL;
>> +	struct strbuf line = STRBUF_INIT;
>> +	int found_get = 0;
>> +
>> +	strvec_pushl(&cp.args, "git-remote-https", "origin", uri, NULL);
> 
> Does "git-remote-https" talk to a "http://" URL just fine when uri
> parameter starts with "http://"?  Would it be the same if the uri
> parameter begins with say "Http://"?

I did a quick check of our HTTPS tests modifying the HTTPD_PROTO
variable in lib-httpd.sh to "HtTP" and we get this fun error:

+ git clone --filter=blob:limit=0 HtTP://127.0.0.1:5601/smart/server client
Cloning into 'client'...
git: 'remote-HtTP' is not a git command. See 'git --help'.

So I guess I can keep case-sensitive comparisons here.

Thanks,
-Stolee
