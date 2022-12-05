Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F88C4708C
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiLEXdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiLEXdK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:33:10 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C16DF65
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:33:05 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h33so11834205pgm.9
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jS9AjJHreYIBMgLWqgm14KfbY9OpWamdjiQrovaHoE4=;
        b=QSIJHmOgA9nc1sZ+42DHy5SUEWajFFN1lnIXXfdLQKArwodSNfeMRWkcR1+EOxYBv6
         nuDjaWF+lGqfzweMvcQ1RkDj9muvzOurFAYm5wUYDS6FjgZFnNjcc49cajt+kiO9QabB
         dcr1o0GfFiLkPmi9oCw+c3QNb/ToEFMbHbuL3NrcCbs5RfPhf5HxFcQCnWEJT7KGA2Qj
         9I5D4xk2RZMhnrFPEDZ+be4hzn1L479dXqHkszAAR7d7/+0VyG2zEG5SnFFIHHrXfaFU
         kqUXvWPgLP/azm9jnnF2e+/jPzh6agtbQlZA8IDE2MK08Nj0kf85ymnTsjvA03F+5hA9
         EFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jS9AjJHreYIBMgLWqgm14KfbY9OpWamdjiQrovaHoE4=;
        b=pJCGtlqKxZJY6TeX3vRwfFKV8G+tL1RWbCEDVN+qRWZs3QvInjg0THSAHesZcSZpD3
         E+TSwgelycoIXjWReWVfqsgqJKlOjgaNbnMjPKUoTBjiLrG0GkEVjnlM6slnxhQfGazb
         2b+mhLc8vHChrvIrOut7HLi7ywxRV9OR2THoKnp0yTzrouELKpO8Go7izpEpv/hwMOqk
         qH5s30i4gwnAeMRoyXRSK0FrkexC109WA0fGpd1IE9xT4vtySEkvkpc02qcENC3Uj9N9
         x9ngSKydJfY56pVFn3VblGyZTHNExoqaqYUlhWtvSJ8xWAvxSwDb1v3N6MaUAHcUUorB
         dumQ==
X-Gm-Message-State: ANoB5pkAgIxQw/dUsplFOkf5D1KJuhCBhL96Jh/nDsxuN6+cY7gsda2V
        VKjohueisAEH3rhAKnuQu53h
X-Google-Smtp-Source: AA0mqf7qC3QeVuTV2ak2bU2bjRQLXwyeZirjuTVSpyt3HjB9uILUMrlK1alMctXPOAKhFz+U3+ahtQ==
X-Received: by 2002:aa7:9150:0:b0:574:a3dd:d47f with SMTP id 16-20020aa79150000000b00574a3ddd47fmr52738276pfi.33.1670283184908;
        Mon, 05 Dec 2022 15:33:04 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id b66-20020a62cf45000000b0057534fcd895sm4084109pfg.108.2022.12.05.15.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 15:33:04 -0800 (PST)
Message-ID: <2b21f22b-b707-7705-a41c-9e4acbdb0405@github.com>
Date:   Mon, 5 Dec 2022 15:33:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 09/11] bundle-uri: allow relative URLs in bundle lists
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <48731438d6a289129a5768b80af856fb49692426.1670262639.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <48731438d6a289129a5768b80af856fb49692426.1670262639.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> Allow a bundle list to specify a relative URI for the bundles. This URI
> is based on where the client received the bundle list. For a list
> provided in the 'bundle-uri' protocol v2 command, the Git remote URI is
> the base URI. Otherwise, the bundle list was provided from an HTTP URI
> not using the Git protocol, and that URI is the base URI. This allows
> easier distribution of bundle data.

Thanks, this clears up my confusion about the source of 'baseURI'.

> +	/**
> +	 * The baseURI of a bundle_list is the URI that provided the list.
> +	 *
> +	 * In the case of the 'bundle-uri' protocol v2 command, the base
> +	 * URI is the URI of the Git remote.
> +	 *
> +	 * Otherewise, the bundle list was downloaded over HTTP from some
> +	 * known URI.

s/Otherewise/Otherwise

Also, this sentence is a bit more vague than what was noted in the commit
message; it doesn't actually say what the base URI is set to in this
scenario. Feel free to ignore if you think it's overkill, but that could
probably be cleared up by adding another sentence after like "The base URI
is set to that known URI."

> +	 *
> +	 * The baseURI is used as the base for any relative URIs
> +	 * advertised by the bundle list at that location.
> +	 */
> +	char *baseURI;

...

> +	# TODO: We would prefer if parsing a bundle list would not cause
> +	# a die() and instead would give a warning and allow the rest of
> +	# a Git command to continue. This test_must_fail is necessary for
> +	# now until the interface for relative_url() allows for reporting
> +	# an error instead of die()ing.
> +	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
> +	grep "fatal: cannot strip one component off url" err

Thanks for adding this, I'm content to leave this as a TODO for now.

