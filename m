Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824FAC4708C
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiLEXcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLEXcO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:32:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A61759F
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:32:13 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d82so4181390pfd.11
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyQ8neM57cTG4KbURBWNbgRggHcfbtZ0zZEtltVvw2Q=;
        b=e92sLWjTl0WMHU2UDmpuSBKy+tivh2uMvvPLOizqjCkkuMOAh6ID3sysdOaFKEJjQL
         r9cXIfrb5rM3tOHajxSJJks1TblfeH9XNey+5/8qWALiNcAsNhCUequTewMsNxD5a3F/
         eNtpZ7EXXVA8nLnTwzoj3ruCLscDK6orH80B89L6XAwjSlGIsoBhmaJmdu6nHgyaQJGR
         BTcV92/K7UszYHmlDEyuxxwQwC4N25jZtjJSTV1xgg2DjsSW0AnHCE/7y0g//akW3ssE
         fHsb9ZSUsEBVnkgHum6kzEvnGma+8S6wbmKHjc+jidNtNdcerm1ek/3PbRhUxM1E0MRs
         vhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyQ8neM57cTG4KbURBWNbgRggHcfbtZ0zZEtltVvw2Q=;
        b=gh+rNJTOIcu8cnCdTri8yBmuaKBX++4M16S0V3OXiJ6kf1DstsqQ9tqy5WYuv0J7Cl
         a3uhn3rxvbSpEU9qguz5XJncVQpKH4sS0YIlItQGAE+qiZ2RGjGAKaro4SGyt3QNbNFH
         tzGcAcoqy6kTx3OTkfqmmprNbfP2mz99Rbh/Ym0eNY7HogtX+QWSe/5IbIFQUDqp0VwF
         RUv24llXi12Qt19GuJ8gk1C5E6/WKOOHQXL9JEXJIf1hDjWUgjBd+n+RcsS6+ATUTyk+
         r6rFwlYRdVcej8FsLx6wM1xPr+2/mBNBv7Kr9jK88ie+WnlMym1aNzxbhx258Uzgh5/C
         I8yg==
X-Gm-Message-State: ANoB5pnU5y1bgdFaJuU32umdv73/sMsGHZa9h4Y0n/7c3Xasfj41E+Xz
        1TEL7GbWoXWqtZz3osXihvDW
X-Google-Smtp-Source: AA0mqf5gQ9bIOkF7xRzMAQnQv8TbS+hAZXf2MQvjpPEk7917b2xkq8YBaz5PD51iIUh08K/5l3H/vA==
X-Received: by 2002:a62:1855:0:b0:576:9ced:ebf7 with SMTP id 82-20020a621855000000b005769cedebf7mr12999956pfy.80.1670283132894;
        Mon, 05 Dec 2022 15:32:12 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b0056d98e31439sm10763799pfl.140.2022.12.05.15.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 15:32:12 -0800 (PST)
Message-ID: <b7b98123-0e78-757e-404d-024e167bfe60@github.com>
Date:   Mon, 5 Dec 2022 15:32:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 04/11] bundle-uri client: add boolean
 transfer.bundleURI setting
Content-Language: en-US
To:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <e46118e60f7a59ef25edf5f1378b4ef0c007cce8.1670262639.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <e46118e60f7a59ef25edf5f1378b4ef0c007cce8.1670262639.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>  <avarab@gmail.com>
> 
> The yet-to-be introduced client support for bundle-uri will always
> fall back on a full clone, but we'd still like to be able to ignore a
> server's bundle-uri advertisement entirely.
> 
> The new transfer.bundleURI config option defaults to 'false', but a user
> can set it to 'true' to enable checking for bundle URIs from the origin
> Git server using protocol v2.
> 
> To enable this setting by default in the correct tests, add a
> GIT_TEST_BUNDLE_URI environment variable.

It wasn't immediately clear to me from reading this patch, but it looks like
'GIT_TEST_BUNDLE_URI' is mainly used to allow 'test-tool bundle-uri
ls-remote' to issue the bundle URI command (since it can't use a '-c
transfer.bundleURI=true' command line option) in patch 7 [1].

If that's the only use for 'GIT_TEST_BUNDLE_URI', could you avoid the
environment variable altogether by setting 'transfer.bundleURI=true' with
'test_config' before the 'test-tool' call (and 'test_unconfig' after, if
needed)? Alternatively, if you do want to be able to test the bundle URI
protocol wholesale across all tests (e.g., in the 'linux-TEST-vars' CI job),
then I think the environment variable makes sense.

[1] https://lore.kernel.org/git/acc5a8f57f903342c47802115f8e3de9e9d588dc.1670262639.git.gitgitgadget@gmail.com/

> diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
> index d44c6e10f9e..77bfd4f0119 100644
> --- a/t/lib-bundle-uri-protocol.sh
> +++ b/t/lib-bundle-uri-protocol.sh
> @@ -85,9 +85,10 @@ test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
>  '
>  
>  test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
> -	test_when_finished "rm -rf log cloned" &&
> +	test_when_finished "rm -rf log cloned cloned2" &&
>  
>  	GIT_TRACE_PACKET="$PWD/log" \
> +	GIT_TEST_BUNDLE_URI=0 \
>  	git \
>  		-c protocol.version=2 \
>  		clone "$BUNDLE_URI_REPO_URI" cloned \
> @@ -99,6 +100,22 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
>  	# Server advertised bundle-uri capability
>  	grep "< bundle-uri" log &&
>  
> +	# Client did not issue bundle-uri command
> +	! grep "> command=bundle-uri" log &&
> +
> +	GIT_TRACE_PACKET="$PWD/log" \
> +	git \
> +		-c transfer.bundleURI=true \
> +		-c protocol.version=2 \
> +		clone "$BUNDLE_URI_REPO_URI" cloned2 \
> +		>actual 2>err &&

If 'GIT_TEST_BUNDLE_URI' is set to '1' in a more global scope (by a CI job
or user running the tests), then the '-c transfer.bundleURI' config isn't
actually what's enabling the behavior. To make this more directly comparable
to the case earlier in this test, could you add 'GIT_TEST_BUNDLE_URI=0' here
as well?

