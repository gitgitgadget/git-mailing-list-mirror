Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36296C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B171613C8
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 20:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhJDUIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 16:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhJDUIO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 16:08:14 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31232C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 13:06:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i132so17770220qke.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e+XzUFSzyn+Mg00NGTnHYpk0Sebf2Czc5n3rMHm7njU=;
        b=Uo6vgN0En4klwpHtx+TmXhASuBsKzRENaREzzBtZdqDbQZCJPstXP3vDby7Fqrpcp8
         2UjjKzjCG9H3wNscOTE2ns05yCVH5LjcYpapp00VeEjGJEPSDUW5ZqUjYlBzeUFA+ChD
         D385f5NRhtYQxvaAQGZCdb6MWneGDBcRhvAD1pyqo3ISIzougNGWr5Ci1Wh71Rh5wXBQ
         2xj3qT9m7VcbCZNVJUH8QR59myUs1M4P9mp9R/Tk9kncRBHBAwqwnifjcTg2bDwAe29l
         Mw9Vo6Sj5Ab5cTZ1BxA27+VMONnKwbPlRg9EFvL1SCsFjkPW/nEYtud5sra6bdnvFLVa
         /qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e+XzUFSzyn+Mg00NGTnHYpk0Sebf2Czc5n3rMHm7njU=;
        b=GvrNRrnzOhg52BkcndsQsy4LOWgm/lNrfQEuHYv9SvjzDqmOYIx0kDysDA954uUA67
         Am9uxgLMsKhojH3ymO6LrJ/Ni7fUGPep3MUoxg4hdooRZV5Oaqdix2BhSTyDcA3HPHJ2
         2v/F8wWnFSvtL7zM3KDIBNfTBB1n0HFk/nJug9IKz5UPZgMbvtGP8mTuLAaU55umv3tm
         ESuVcPk37yOikbuMeNj/6nXPIG3XtF2CIol9GrZKS7+pm60L/xcC6Ai5L8Nh9xQCH8A4
         JO2tgq+uqNvdykpiFuLI6IN3FwUsHMNmMrx393sWwLjnmHr1l3XCm4wDXbCQgY0xldv7
         xYeQ==
X-Gm-Message-State: AOAM531FpVnvBVvqzFpT81JutnA9Vc69hscWfYfBnl1c5eubpOo/7LIt
        wm9jUevCNWT3Z2aNwEa1pIAG+em91Emreg==
X-Google-Smtp-Source: ABdhPJxaF2p2qbygQwRUq8yUzGl4e7QBAaABbY7jeOPQI4GJr/EADlwn9MSK9Lm2d2a/6WYRkNwCaw==
X-Received: by 2002:a37:6558:: with SMTP id z85mr11941603qkb.310.1633377984106;
        Mon, 04 Oct 2021 13:06:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2960:f424:587d:3bfa? ([2600:1700:e72:80a0:2960:f424:587d:3bfa])
        by smtp.gmail.com with ESMTPSA id v3sm8272470qkd.20.2021.10.04.13.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 13:06:23 -0700 (PDT)
Message-ID: <6df361a5-8e15-63a7-dbb8-77405c6edf0e@gmail.com>
Date:   Mon, 4 Oct 2021 16:06:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: Bug/regression report - 'git stash push -u' fatal errors when
 sub-repo present
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Robert Leftwich <robert@gitpod.io>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
 <7b83c77e-dd87-f688-3da1-7826cf6b0d4e@web.de> <xmqqk0iydns7.fsf@gitster.g>
 <1d26a9f3-dcb5-408a-581e-40411e6a2179@web.de>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <1d26a9f3-dcb5-408a-581e-40411e6a2179@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/1/2021 10:25 AM, René Scharfe wrote:
> Am 30.09.21 um 18:35 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> Looping in Stolee as the author of 6e773527b6 (sparse-index: convert
>>> from full to sparse, 2021-03-30).

Thanks for looping me in. I'm still getting caught up from some
time off.

>>> Here's a raw patch for that.  Versions before 6e773527b6 pass the
>>> included test.
>>>
>>> The magic return value of 2 is a bit ugly, but allows adding the
>>> additional check only to the call-site relevant to the bug report.
>>>
>>> I don't know if other callers of verify_path() might also need that
>>> check, or if it is too narrow.
>>
>> The callers inside read-cache.c, which I think were the original
>> intended audiences of the function, always call verify_path() with
>> the pathname suitable to be stored as a cache entry.
>>
>> The callee never has to assume an extra trailing slash might exist
>> at the end.  And verify_path() said "no", if any caller passed an
>> extra trailing slash before the commit in question.
>>
>> I _think_ we defined the new "tree" type entries the sparse index
>> stuff added to be the _only_ cache entries whose path always ends
>> with a slash?  If so, perhaps we should audit the existing callers
>> and move the "paths that come from end-users to be entered to the
>> index must never end with a slash" sanity check this function gave
>> us, which was broken by 6e773527b6, perhaps?
>>
>> "git update-index" should never allow to create a "tree" kind of
>> cache entry (making it sparse again should be the task of systems
>> internal, and should not be done by end-user feeding a pre-shrunk
>> "tree" kind of entry to record a sparsely populated state, if I
>> understand correctly), so its call to verify_path(), if it ends with
>> a directory separator, should say "that's not a good path".
>>
>> Prehaps we can rename verify_path() to verify_path_internal() that
>> is _known_ to be called with names that are already vetted to be
>> stored in ce_name and convert callers inside read-cache.c to call
>> it, and write verify_path() as a thin wrapper of it to fail when the
>> former stops by returning S_ISDIR() at the place your fix touched,
>> or something?
> 
> Restoring the stricter check for the general case and providing a way
> out for the code handling sparse indexes sounds like a good idea.
> 
> I don't know which callers are supposed to need that, but the following
> patch passes all tests, including the new one.

I like this new approach.

> +enum verify_path_result {
> +	PATH_OK,
> +	PATH_INVALID,
> +	PATH_DIR_WITH_SEP,
> +};
> +
> +static enum verify_path_result verify_path_internal(const char *, unsigned);
> +
> +int verify_path(const char *path, unsigned mode)
> +{
> +	return verify_path_internal(path, mode) == PATH_OK;
> +}
> +

I was confused at first as to why the verify_path() implementation is
not near the implementation of verify_path_internal(), but I see how
you use the _internal() version in make_cache_tree(), justifying this
position.

>  struct cache_entry *make_cache_entry(struct index_state *istate,
>  				     unsigned int mode,
>  				     const struct object_id *oid,
...
>  			/*
>  			 * allow terminating directory separators for
>  			 * sparse directory entries.
>  			 */
>  			if (c == '\0')
> -				return S_ISDIR(mode);
> +				return S_ISDIR(mode) ? PATH_DIR_WITH_SEP :
> +						       PATH_INVALID;

The rewrite of this method is mostly mechanical except for this one
bit that is solving the issue at hand.

> @@ -1349,7 +1364,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
> 
>  	if (!ok_to_add)
>  		return -1;
> -	if (!verify_path(ce->name, ce->ce_mode))
> +	if (verify_path_internal(ce->name, ce->ce_mode) == PATH_INVALID)
>  		return error(_("invalid path '%s'"), ce->name);

And yes, I believe that make_cache_entry() and add_index_entry_with_check()
are the only places that need this internal version. If we find others,
then we can add them as necessary. The tests in t1092 are getting rather
robust, although they don't do much for this test case:
> +test_expect_success 'stash -u ignores sub-repository' '
> +	test_when_finished "rm -rf sub-repo" &&
> +	git init sub-repo &&
> +	git stash -u
> +'

Seems like a good test to have, anyway.

I look forward to seeing this as a full patch.

Thanks,
-Stolee
