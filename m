Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B737C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 17:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390599AbiDUR3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352322AbiDUR3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 13:29:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C1F42A32
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:26:42 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso3732409otj.5
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VLRaHw8jYBFjs6u6tdfBSvq1TTF+T5lEnYDxUZ892Fk=;
        b=Y2Zm5GZDQHmzQ4nUJhXgNGhr/lP6zn2PNXxF2yZIbOQ7wP2IWsIRn1kXTX04LfWcIe
         29S/YE+aU00VYZdDkOk1UO3MFfkHjWPfGG4XGF6U0L04kc2h+F/I08ZRNohyPAA+KCLX
         ldh7nrVC/qc/tH+kAetn2s5LucZcnBPAbznjqVzWE1Zsnt6uwTMBpgrujkLAhsSwzUbT
         teGDktU1PPwpGLTzkXXV1aLJPTk0KuoA/wyHl9O/EPmKVPDKKHg4S3ykrgrMw5O7SJn6
         EB0744o604cYFqVL6FYCI4IImzS46vrHHXwuN1RThQQUg9ou5kPCZaB0ULstJUSGGW74
         ajYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VLRaHw8jYBFjs6u6tdfBSvq1TTF+T5lEnYDxUZ892Fk=;
        b=qJ/WtZRNxF1tHQzOm0EDU4jpPoBcCW/KyXBkbi1uKMbUVIpL0+fyv9yU/gjCabWHkr
         BHfraostuV9mGvFMEGO03EBhzHVjmo/oVxdiCSLw2s86HBH4W/rZLGk+LUA3uJ44Q07V
         UcjGRTOkSv2lOqd+8NQHoIIlTbllZ4WBZCSOcOBByr2vwNcyp9Xyu22enpN+uThgx0oV
         CiMCsAD/XDqtHbb6c+hWA6IKgH+pPEvbVl9XHkc6gsT6Z9BOEzHrZPu39K8h9pmC0V9l
         diQK0lBiO3YJEc9GCBuTHiEvdBWwyYExTj07FW7iT+F/9JWYewvwtvlIaoJZr/w6AjG8
         cUFw==
X-Gm-Message-State: AOAM530Eb2N9ZmZNRKLXkB/ibsODym+Tz0sQoZT2Fn6LrO4a5//YgUEc
        nZuykFTiXuJ7VlvWTW6BUjQOD07DtxpW
X-Google-Smtp-Source: ABdhPJxzNBlY9djoCFADiI46P10puL6euxwy2aoRY3HuuGbKWT/68iah8NrGtFUv/+8GmKq+M5nLag==
X-Received: by 2002:a05:6830:4d3:b0:605:558a:8a99 with SMTP id s19-20020a05683004d300b00605558a8a99mr359288otd.50.1650562002173;
        Thu, 21 Apr 2022 10:26:42 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id mk8-20020a0568700d0800b000e67b008f75sm549644oab.32.2022.04.21.10.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:26:41 -0700 (PDT)
Message-ID: <04b363f3-58d7-5cfc-6261-0ebcca18ecec@github.com>
Date:   Thu, 21 Apr 2022 13:26:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v2 02/36] dir API: add a generalized
 path_match_flags() function
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
 <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
 <RFC-patch-v2-02.36-8f6e4f12e8a-20220418T165545Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <RFC-patch-v2-02.36-8f6e4f12e8a-20220418T165545Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2022 1:23 PM, Ævar Arnfjörð Bjarmason wrote:
> Add a path_match_flags() function and have the two sets of
> starts_with_dot_{,dot_}slash() functions added in
> 63e95beb085 (submodule: port resolve_relative_url from shell to C,
> 2016-04-15) and a2b26ffb1a8 (fsck: convert gitmodules url to URL
> passed to curl, 2020-04-18) be thin wrappers for it.
> 
> As the latter of those notes the fsck version was copied from the
> initial builtin/submodule--helper.c version.
> 
> Since the code added in a2b26ffb1a8 was doing really doing the same as

s/doing really doing/really doing/

> win32_is_dir_sep() added in 1cadad6f658 (git clone <url>
> C:\cygwin\home\USER\repo' is working (again), 2018-12-15) let's move
> the latter to git-compat-util.h is a is_xplatform_dir_sep(). We can
> then call either it or the platform-specific is_dir_sep() from this
> new function.
> 
> Let's likewise change code in various other places that was hardcoding
> checks for "'/' || '\\'" with the new is_xplatform_dir_sep(). As can
> be seen in those callers some of them still concern themselves with
> ':' (Mac OS classic?), but let's leave the question of whether that
> should be consolidated for some other time.

This feels like it could be its own change before the refactor
of the starts_with_dot_{,dot}slash() functions. The diff is pretty
big and all over the place.

If you start with the addition of is_xplatform_dir_sep() (and maybe
the change of how is_dir_sep() is created) then the rest of the
change is more focused.
 
> As we expect to make wider use of the "native" case in the future,
> define and use two starts_with_dot_{,dot_}slash_native() convenience
> wrappers. This makes the diff in builtin/submodule--helper.c much
> smaller.

> +static int starts_with_dot_slash(const char *const path)
> +{
> +	return starts_with_dot_slash_native(path);;

Double semi-colon.

> +int path_match_flags(const char *const str, const enum path_match_flags flags)

I feel like "path_match_flags()" is too generic of a name here.

Maybe something like "path_starts_with_dotslash_flags()" would be
sufficiently descriptive.

> +{
> +	const char *p = str;
> +
> +	if (flags & PATH_MATCH_NATIVE &&
> +	    flags & PATH_MATCH_XPLATFORM)
> +		BUG("path_match_flags() must get one match kind, not multiple!");
> +	else if (!(flags & PATH_MATCH_KINDS_MASK))
> +		BUG("path_match_flags() must get at least one match kind!");
> +
> +	if (flags & PATH_MATCH_STARTS_WITH_DOT_SLASH &&
> +	    flags & PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH)
> +		BUG("path_match_flags() must get one platform kind, not multiple!");
> +	else if (!(flags & PATH_MATCH_PLATFORM_MASK))
> +		BUG("path_match_flags() must get at least one platform kind!");

These would be easier and more robust if we had a simple
popcount function. It's not worth extracting one out of
ewah/ewok.h just for this, though.

> +	if (*p++ != '.')
> +		return 0;
> +	if (flags & PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH &&
> +	    *p++ != '.')
> +		return 0;
> +
> +	if (flags & PATH_MATCH_NATIVE)
> +		return is_dir_sep(*p);
> +	else if (flags & PATH_MATCH_XPLATFORM)
> +		return is_xplatform_dir_sep(*p);
> +	BUG("unreachable");
> +}

Thanks,
-Stolee
