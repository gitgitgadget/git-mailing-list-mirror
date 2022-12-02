Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E10AC4708E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiLBQEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiLBQEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:04:30 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB13D969B
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 08:03:43 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n21so3335900iod.5
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 08:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meNr4qk8AKpse1yQj0RxxPi0nwrVp8S0cY1nQnJJ2uU=;
        b=TohKLEJ1+XTxKvddbQrDBc3p86ICC8P8+uJ5ULm+psS3FlesNJfBbUKa3WUcxAiOEN
         hDeRN2JhsDiDQB0pxQGq+4FoCXpbwwWqbEoPXSbsrdIQ4Wk+unYgA6qU6ZAhqWhy4ZgY
         OlzdyjV13yJHZzCMVNK2p07P4JHQ6eG+LWSTxNHc9CjsZc8YSkVXVAF9QVmNSJAwQ0VS
         xgh6U3zFJRRpAMcpkDpN7DTqejsHXXCF4bEiL8h7klcBzkBXIbbjWCwr18d7vOPHUOcM
         UNMPCjO6rpQajB57UsClFg9QeV5T1bBNhXW1dDw/p7S+iXuO4L450fib/OnFO2rwn41B
         GM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meNr4qk8AKpse1yQj0RxxPi0nwrVp8S0cY1nQnJJ2uU=;
        b=zMOUxmFqY+5uOl1XGjmWNDjxq3jHxlKhA2ZPzSJd6WXhzILM5ELzPwZGqzT6OWRKxs
         OiyeBTIAlHuDRc4DWpBjkaZe6r027pCrbcSskSPtT4YyiL+cS94sxx4JAqI/V5gOJfE+
         rC7S7dUFfcZl/YDfADR8LSAGkqJlJWhyLkK4Iw9e1n7Zq9ECiHXK72cojc8Pf2/gYnZd
         s3euTbvf7+1OJ3RIooS91XIqxXi0W6kjWCFyjuzkX/axzoXcIcb+XEPYYcUtD2UDrkSR
         MlYCwmGgc/pKpIsU54gaWbUd0NKjVbcNtAik4UXPfSjdedz2sZN7lI0IqstUhYu3EPum
         S9og==
X-Gm-Message-State: ANoB5pmBdUBjHTs+txQNdYIoIeYElZmGxwaSLFIn2g5Fu7hOOHDpfIC2
        p4aLUuk0/3w0nzQR4BAALsQj
X-Google-Smtp-Source: AA0mqf4+q3R343Xk/87LR2NqzFxZTbGDav3mzfep4XVCa08wbPD/Ixb3i4WAKw5aFjsmIus1KxKnqg==
X-Received: by 2002:a02:9141:0:b0:389:f4de:f5cf with SMTP id b1-20020a029141000000b00389f4def5cfmr7670630jag.43.1669997022618;
        Fri, 02 Dec 2022 08:03:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8051:a31f:2c93:87e9? ([2600:1700:e72:80a0:8051:a31f:2c93:87e9])
        by smtp.gmail.com with ESMTPSA id s8-20020a92d908000000b00302f8863878sm2571733iln.24.2022.12.02.08.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:03:42 -0800 (PST)
Message-ID: <7000a8f3-9b80-75e9-3d36-36982ef5dbb3@github.com>
Date:   Fri, 2 Dec 2022 11:03:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 7/9] bundle-uri: allow relative URLs in bundle lists
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <186e112d821d9a42ffbc3c8b46e24b2b4bb3dfe8.1668628303.git.gitgitgadget@gmail.com>
 <06e45662-699b-52f9-2fdf-6e621444f446@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <06e45662-699b-52f9-2fdf-6e621444f446@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2022 8:25 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:

>> +	if (!list->baseURI) {
>> +		struct strbuf baseURI = STRBUF_INIT;
>> +		strbuf_addstr(&baseURI, uri);
>> +
>> +		/*
>> +		 * If the URI does not end with a trailing slash, then
>> +		 * remove the filename portion of the path. This is
>> +		 * important for relative URIs.
>> +		 */
>> +		strbuf_strip_file_from_path(&baseURI);
>> +		list->baseURI = strbuf_detach(&baseURI, NULL);
>
> Is the 'baseURI' is set to the URI of the first bundle (ordered by hash)? If
> data is distributed across multiple CDNs, couldn't this be a suboptimal
> choice? For example, if the first bundle is on 'A.com', but every other
> bundle is on 'B.org'?

The baseURI is set to one of two things:

1. The URI used for the clone, specifying the way the client connected to
   the Git server, or

2. The URI used to download the bundle list itself.

This allows the same bundle list file to be distributed to multiple CDNs,
assuming that the bundles themselves will have the same relative position
to the list.

>> +	/**
>> +	 * The baseURI of a bundle_list is used as the base for any
>> +	 * relative URIs advertised by the bundle list at that location.
>> +	 *
>> +	 * When the list is generated from a Git server, then use that
>> +	 * server's location.
>
> Hmmm, I think I'm missing something with my earlier comment. I thought the
> 'uri' argument to 'bundle_uri_parse_config_format()' was an individual
> bundle's URI? What's the "server's location" in this context?

I can work to make this concept clearer by rewording this comment.

>> @@ -40,6 +40,8 @@ static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mo
>>
>>  	init_bundle_list(&list);
>>
>> +	list.baseURI = xstrdup("<uri>");
>
> Using a hardcoded value here leads to pretty different behavior in
> 'test-bundle-uri.c' vs. starting with an unset 'list.baseURI' in something
> like 'clone'. Why does this need to be set to '<uri>' for the tests?

In this part of the test helper, we are not making a connection to a server
and instead parsing a bundle list file directly. To demonstrate how the
relative paths work during this parsing, we add a bogus baseURI here so
we can clearly see where the relative paths were parsed versus using the
URI as an absolute URI.


>> +test_expect_success 'bundle_uri_parse_line(): relative URIs' '
>> +	cat >in <<-\EOF &&
>> +	bundle.one.uri=bundle.bdl
>> +	bundle.two.uri=../bundle.bdl
>> +	bundle.three.uri=sub/dir/bundle.bdl
>> +	EOF
>> +
>> +	cat >expect <<-\EOF &&
>> +	[bundle]
>> +		version = 1
>> +		mode = all
>> +	[bundle "one"]
>> +		uri = <uri>/bundle.bdl
>> +	[bundle "two"]
>> +		uri = bundle.bdl
>
> This seems a little strange, but it looks like '<uri>/../bundle.bdl'
> normalizes to 'bundle.bdl' because '<uri>' is treated like a regular path
> element (like a directory).
>
> Out of curiosity, what would happen if 'bundle.two.uri' was
> '../../bundle.bdl'?

It will fail! The error message is

	"fatal: cannot strip one component off url '.'"

This is disappointing that an erroneous bundle list could cause a 'git
clone' command to die(), when we want the bundle URI feature to allow the
clone to continue normally even if the bundle downloads fail. I will mark
this for #leftoverbits, since it would involve changing the interface for
chop_last_dir() and relative_url() in remote.c.

At minimum, I will document this with a test case.

Thanks,
-Stolee
