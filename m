Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064AC43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 00:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiK2A76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 19:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK2A75 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 19:59:57 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C24286FC
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 16:59:55 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w129so12196841pfb.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 16:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9x7QPtamzprEczI+G43tIEI97rZkDNcfPLYB0slIDXs=;
        b=VerP1irpZqoCITyMIRNBCu2HoQ3I0v+xne3Zd0m4LHOrErHA7tcwoIBthcVJrCbw0s
         HEdkF69us2DZgEnZWd1+4Guz4MRUt3U4Q/v6DDCzqmBktYJr0SmjhEdEUV+ag4BxkmtG
         aUj+gft92UTT8ZK2pIDNbtHOWdXRVswYwG1iAvklS+5sWJZteheif0y4k69CofsuLvA1
         r1MXaH9dUR+agqSgJMFxvN70JaWosLxz7Ijj9CyOWpu2lOfP28cvdVV6Xce9/QJDV0cF
         tsC/lxpOB2lEWZI69iLDdCiBqwjkS+bF/yzSW9u43wJfSBNGk3IgBoOeh4LyhKVrKaim
         7z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x7QPtamzprEczI+G43tIEI97rZkDNcfPLYB0slIDXs=;
        b=bhzYrMv+OUWjof2EfanAHque2BfU6bAPatnBVYt971A6KX4tI23wp1eEsWfost2eAP
         Q4dpdEO8xiw98qVmJNgKh/NcJGq6YSlBMwaBs1DO/RgL4bIB1OYso4Mzd+GhtXPyIjSg
         c9cBwqCZLIM9fpnyppgZ+1CLi3KF4mjlEpJqqDDVhs+bAaTRWJJiGvBAR2497jFaJnKL
         D/saBMHymQOdzdrXkWXXsU0Ydjg3FN6V2co0h48jXuAEGmK786dJ1V5NzE1Y1YGgMlhB
         EDJWX9tiBYKPHNIps+puJndEYhp6AunVwJu9KvIeGPBy3BUJlXY2k3bwvbSOeZwrymO3
         oXvQ==
X-Gm-Message-State: ANoB5pks0QpAulhBl1ysWyROqt+dMb9nTS/IyfqlcLHF1s4nqXUAabGN
        9cR1ATVSgydU0h6dU0cZlVUO
X-Google-Smtp-Source: AA0mqf5v6qXpgnDmq1MbkUv144cKQhy1Z2ncLYyym3cX+pQIxVCRyTco40bMdPJrGV2V2ZE43opQ1Q==
X-Received: by 2002:a63:4e0a:0:b0:477:96e2:9264 with SMTP id c10-20020a634e0a000000b0047796e29264mr28874265pgb.422.1669683595353;
        Mon, 28 Nov 2022 16:59:55 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z32-20020a17090a6d2300b002190eabb890sm86080pjj.25.2022.11.28.16.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 16:59:54 -0800 (PST)
Message-ID: <84c07e84-0805-6163-d77b-cb9f42db402e@github.com>
Date:   Mon, 28 Nov 2022 16:59:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/9] bundle-uri client: add helper for testing server
Content-Language: en-US
To:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <c3269a24b5780023cbb4d173cb9cfb10c5a4b0d8.1668628303.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <c3269a24b5780023cbb4d173cb9cfb10c5a4b0d8.1668628303.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>  <avarab@gmail.com>
> 
> Add a 'test-tool bundle-uri ls-remote' command. This is a thin wrapper
> for issuing protocol v2 "bundle-uri" commands to a server, and to the
> parsing routines in bundle-uri.c.
> 
> Since in the "git clone" case we'll have already done the handshake(),
> but not here, introduce a "got_advertisement" state along with
> "got_remote_heads". It seems to me that the "got_remote_heads" is
> badly named in the first place, and the whole logic of eagerly getting
> ls-refs on handshake() or not could be refactored somewhat, but let's
> not do that now, and instead just add another self-documenting state
> variable.

Maybe I'm missing something, but why not just rename 'got_remote_heads' to
something like 'finished_handshake' rather than adding 'got_advertisement'
(since, AFAICT, it's always identical in value to 'got_remote_heads').

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>

This commit also introduces the 'quiet' flag to
'transport_get_remote_bundle_uri()', but there's no mention in the commit
message. The message also doesn't explain the changes to existing tests
(adding 'bundle.*' settings, swapping out 'git ls-remote' for the new
'test-tool bundle-uri ls-remote' in existing tests, etc.). I think these are
all relevant to fully understanding the patch, so could you mention them in
your next reroll?

> ---
>  builtin/clone.c                       |  2 +-
>  t/helper/test-bundle-uri.c            | 46 +++++++++++++++++++
>  t/lib-t5730-protocol-v2-bundle-uri.sh | 63 ++++++++++++++++++++++-----
>  transport.c                           | 43 ++++++++++++++----
>  transport.h                           |  6 ++-
>  5 files changed, 139 insertions(+), 21 deletions(-)
> 
> diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
> index 25afd393428..ffb975b7b4f 100644
> --- a/t/helper/test-bundle-uri.c
> +++ b/t/helper/test-bundle-uri.c
> @@ -88,6 +132,8 @@ int cmd__bundle_uri(int argc, const char **argv)
>  		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
>  	if (!strcmp(argv[1], "parse-config"))
>  		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
> +	if (!strcmp(argv[1], "ls-remote"))
> +		return cmd_ls_remote(argc - 1, argv + 1);

With this helper being added, I'm not sure if/why 'clone' was needed to test
the bundle URIs in patch 2 (I assumed integrating with a command was the
only way to test it, which is why I didn't mention this in my review [1]).
In the spirit of having commits avoid "doing more than one thing" could
these patches be reorganized into something like:

1. Add the no-op client & some basic tests around fetching the bundle URI
   list using this test helper.
2. Add the 'transport_get_remote_bundle_uri()' call to 'clone()' with
   clone-specific tests.

It probably wouldn't make the patches much shorter, but it would help avoid
the churn of test changes & changing assumptions around 'quiet' &
'got_advertisement' in this patch.

[1] https://lore.kernel.org/git/ca410bed-e8d1-415f-5235-b64fe18bed27@github.com/

>  	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
>  
>  usage:
> diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
> index 27294e9c976..c327544641b 100644
> --- a/t/lib-t5730-protocol-v2-bundle-uri.sh
> +++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
> @@ -34,7 +34,9 @@ esac
>  test_expect_success "setup protocol v2 $T5730_PROTOCOL:// tests" '
>  	git init "$T5730_PARENT" &&
>  	test_commit -C "$T5730_PARENT" one &&
> -	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true
> +	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true &&
> +	git -C "$T5730_PARENT" config bundle.version 1 &&
> +	git -C "$T5730_PARENT" config bundle.mode all

Why are these config settings added here? I don't see them used anywhere?

> diff --git a/transport.c b/transport.c
> index a020adc1f56..86460f5be28 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -371,6 +373,33 @@ static int get_bundle_uri(struct transport *transport)
>  		init_bundle_list(transport->bundles);
>  	}
>  
> +	if (!data->got_advertisement) {
> +		struct ref *refs;
> +		struct git_transport_data *data = transport->data;
> +		enum protocol_version version;
> +
> +		refs = handshake(transport, 0, NULL, 0);
> +		version = data->version;
> +
> +		switch (version) {
> +		case protocol_v2:
> +			assert(!refs);
> +			break;
> +		case protocol_v0:
> +		case protocol_v1:
> +		case protocol_unknown_version:
> +			assert(refs);
> +			break;

Why were these 'refs' assertions added? What are they intended to validate?

> +		}
> +	}
> +
> +	/*
> +	 * "Support" protocol v0 and v2 without bundle-uri support by
> +	 * silently degrading to a NOOP.
> +	 */
> +	if (!server_supports_v2("bundle-uri", 0))
> +		return 0;

I was originally confused as to why this was moved out of
'transport_get_remote_bundle_uri()', but it looks like the answer is "we
were previously relying on the handshake being done by the time we called
'transport_get_remote_bundle_uri()', but we can't anymore."

> +
>  	packet_reader_init(&reader, data->fd[0], NULL, 0,
>  			   PACKET_READ_CHOMP_NEWLINE |
>  			   PACKET_READ_GENTLE_ON_EOF);
