Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0018AC433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 18:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiEUSHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiEUSHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 14:07:20 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C1662200
        for <git@vger.kernel.org>; Sat, 21 May 2022 11:07:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c1so10164409qkf.13
        for <git@vger.kernel.org>; Sat, 21 May 2022 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3MF11N3A4hzbfNnd0qSFaUvp9O/e/pqKMUSnB/2qyn8=;
        b=iJR8ENdyMrfaQH0P1cVjonaFm510Sndf2kTT0cMqiBa/KU3y0xUoDFeMmYVu02tzDH
         pbdP6r06xXYLuGEBq2nVsN0IZFAMoeYTJD4CiQd1IweY9wY/zX2qSgLUihjKSji7UQsh
         FmkEa76Ox6uS1mIHnYC3cTfrc6hsjuHrrQy4mJqWtpJ6quHiqZ+vSHkHoXDluEVVyc2s
         V3htU+YYx2j6W3x+Ao0ZdmfPwul+xbHk7ZQSpbji9uYY3uOmXD6J/ZWMfBnrlqXZ6iih
         DVAq0MvJGpMW8mJvCx9X/XYYAByU1+BKyTv7Rs9S171MaUmdfFeqLUqmuKgoWK9Z6+Wt
         RaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3MF11N3A4hzbfNnd0qSFaUvp9O/e/pqKMUSnB/2qyn8=;
        b=20eKMqO92jLWvEGYd1xBv4irAKWMnOg+ZvbnSZGdR6Z/r/KyykuAmHUv57P0aSphf9
         OtrC5JTvjWktztFqJe/vKsEmjJkiB4FmhWygvZMLk3DTAGew85QEndBxd1pK0W7n//Oq
         K3D7N8ACSb7aJFdwkfn6oN/eTOpscEwhMS935FFkLfx2AegXumPaqX/p00oT65cJSoIh
         hwSO9oPAzgPjNImqobuf352iSCkWhB9aVqmNlr2P+0O2AlWQe05WwgtRkvDmAxG1kVaC
         N1ujKu26xTq+MuKSKZCQGvmKcN3bfslF6CtCi9qDad6Z0NBWpQyp6Slh6/IKOZS83U2m
         Gb6w==
X-Gm-Message-State: AOAM531B2XcPidjAHvQ9xuXM3j7tJX4ZJA+IwHBApus/PunOBXqXSFqt
        tw64dQlNf1gJwrOIIClDlMTS
X-Google-Smtp-Source: ABdhPJxlqFj3VNpQpgNcdJKzDdM6EoXFQ0N/jR5VCv6juJ5wh4J/KNIB5K6vjzVp5L6CPhwespcuiA==
X-Received: by 2002:a05:620a:284a:b0:67b:637d:5858 with SMTP id h10-20020a05620a284a00b0067b637d5858mr9537003qkp.572.1653156435505;
        Sat, 21 May 2022 11:07:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9c4b:60f0:2f0f:a56c? ([2600:1700:e72:80a0:9c4b:60f0:2f0f:a56c])
        by smtp.gmail.com with ESMTPSA id c14-20020a05620a268e00b0069fcf0da629sm1606323qkp.134.2022.05.21.11.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 11:07:15 -0700 (PDT)
Message-ID: <a467d972-85a6-f4b0-7ec7-184add308e25@github.com>
Date:   Sat, 21 May 2022 14:07:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: ds/bundle-uri (was Re: What's cooking in git.git (May 2022, #06; Fri,
 20))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
References: <xmqqmtfbcoaa.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmtfbcoaa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/21/22 3:55 AM, Junio C Hamano wrote:

> * ds/bundle-uri (2022-05-20) 32 commits
>  - t5601: basic bundle URI tests
>  - clone: unbundle the advertised bundles
>  - bundle-uri: download bundles from an advertised list
>  - bundle-uri: allow relative URLs in bundle lists
>  - bundle-uri client: add boolean transfer.bundleURI setting
>  - bundle-uri: serve URI advertisement from bundle.* config
>  - bundle-uri client: add "git ls-remote-bundle-uri"
>  - bundle-uri client: add minimal NOOP client
>  - protocol v2: add server-side "bundle-uri" skeleton
>  - bundle-uri: fetch a list of bundles
>  - bundle-uri: parse bundle list in config format
>  - bundle-uri: limit recursion depth for bundle lists
>  - bundle-uri: unit test "key=value" parsing
>  - bundle-uri: create "key=value" line parsing
>  - bundle-uri: create base key-value pair parsing
>  - bundle-uri: create bundle_list struct and helpers
>  - clone: --bundle-uri cannot be combined with --depth
>  - clone: add --bundle-uri option
>  - fetch: add 'refs/bundle/' to log.excludeDecoration
>  - fetch: add --bundle-uri option
>  - bundle-uri: add support for http(s):// and file://
>  - bundle-uri: create basic file-copy logic
>  - remote-curl: add 'get' capability
>  - docs: document bundle URI standard
...
>  source: <pull.1234.git.1653072042.gitgitgadget@gmail.com>

These patches are for the combined bundle URI RFC. I
appreciate that you're tracking them, but they aren't ready
for full review, since they are missing a lot of tests.
First, we need to establish that the overall design is a
good approach. After that consensus is reached, I expect
that this series to be split into several parts that are
more manageable to review bit-by-bit. 

>  - bundle.h: make "fd" version of read_bundle_header() public
>  - remote: allow relative_url() to return an absolute url
>  - remote: move relative_url()
>  - http: make http_get_file() external
>  - fetch-pack: move --keep=* option filling to a function
>  - fetch-pack: add a deref_without_lazy_fetch_extended()
>  - dir API: add a generalized path_match_flags() function
>  - connect.c: refactor sending of agent & object-format
> 
>  source: <pull.1233.git.1652731865.gitgitgadget@gmail.com>

While these are for the patches leading up to it, which
are ready for review.

I think the two should be tracked independently.

Thanks,
-Stolee
