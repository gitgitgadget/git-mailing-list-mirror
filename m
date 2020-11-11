Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE7BC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E44A206A1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic6PLehD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgKKP0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKP0s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:26:48 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC73C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:26:46 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id i12so1539965qtj.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5EkYvPNfN401NoSJc2/cuFRtKLBGNiXv5Gwj3kXtfps=;
        b=Ic6PLehD2rnj3uy0GLFkr6xpVTHcGfNzyJqxJzTJXhSUu5cBnAoPmlAJI5hW08U2R3
         fd3ggjxC1cwySX+9FF1ia+/ungBBJOeZtZFB0sYy+reaJOFxGdOtE6XBn8iWxO7/DOC3
         WP63YZKl1HUXd0xBh5voJ+xNjlYH9DUABFvjoIlEcn31x56l/ECX7Mho7My+fGIHZNto
         JeHL/6VCdml4Gdxet3lnGnfKcY7Rpvs+n7ra31RbjojmHo+/vMp572ZgVYphmXqTvXuw
         jzSBqotXkyeqqvW+hgsmVyZ2/bIRY3k451unKpMrNDr/Mgx0gxIYOcYCeemlMg2RN7F6
         bfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5EkYvPNfN401NoSJc2/cuFRtKLBGNiXv5Gwj3kXtfps=;
        b=mUeRms9M7POWE170i6xKVYtRJBuuk39S4S9Ea0ulSO8Ifls00MFDzyiWg+qdkqylYw
         YWo+Ak/whKpsvMj6HQMzbULbXGE4QFDJPwm3crUj0HxVp4Bjz3tiy93eGG0KGAsq2/nq
         TkwSR4WKwQVsxfzTsjqucq/nkgcDYLjZK16Ms0OquWlGH+tIdYD5rA1jqQvoYdtAcjal
         2+e76v61AisRVH9OEL5npelVcOTK6JH+/JfGmorX0W2XSGLWtskdRFtfaEPEn98bLuIV
         eNDiXFGjVgS4rt+e7slzMWKK8rZNgmnMHJYpDKXEL723Ss2O4db9Xkbv8afw1qghjnYa
         HDpQ==
X-Gm-Message-State: AOAM531rF8IwPYBF5LrvAontAz3qEQfGktDozdc47E2fjsW/RbkWpYyn
        Gt30e972LVZNwwT5VunYmfI5jDxu1T4qbQ==
X-Google-Smtp-Source: ABdhPJxc2ayxsd4PKbnuLlI6Kmu7OZ7US0MhouQGtSY4gktRrphOw3r4bqurVX41CVMuZCBBo+tPhA==
X-Received: by 2002:aed:2f03:: with SMTP id l3mr25024891qtd.303.1605108405315;
        Wed, 11 Nov 2020 07:26:45 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id 135sm2277789qko.49.2020.11.11.07.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 07:26:44 -0800 (PST)
Subject: Re: [PATCH v2 09/20] merge-ort: record stage and auxiliary info for
 every path
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-10-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <94bf9b69-5d13-c914-fb1a-bce912018a63@gmail.com>
Date:   Wed, 11 Nov 2020 10:26:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-10-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> +static void setup_path_info(struct merge_options *opt,
> +			    struct string_list_item *result,
> +			    const char *current_dir_name,
> +			    int current_dir_name_len,
> +			    char *fullpath, /* we'll take over ownership */
> +			    struct name_entry *names,
> +			    struct name_entry *merged_version,
> +			    unsigned is_null,     /* boolean */
> +			    unsigned df_conflict, /* boolean */
> +			    unsigned filemask,
> +			    unsigned dirmask,
> +			    int resolved          /* boolean */)
> +{
> +	struct conflict_info *path_info;

In addition to my concerns below about 'conflict_info' versus
'merged_info', I was doubly confused that 'result' in the parameter
list is given a variable named 'pi' for "path info" and result->util
eventually is equal to this path_info. What if we renamed 'result'
to 'pi' for "path info" here, then operated on 'pi->util' in this
method?

> +	path_info = xcalloc(1, resolved ? sizeof(struct merged_info) :
> +					  sizeof(struct conflict_info));

Hm. I'm happy to have a `struct merged_info *` pointing to a
`struct conflict_info`, but the opposite seems very dangerous.
Perhaps we should always use sizeof(struct conflict_info)?

We can use path_info->merged.clean to detect whether the rest of
the data is worth looking at. (Or, in your case, whether or not
it is allocated.)

I imagine that in a large repo we will need many of these structs,
but very few of them will actually need to be conflicts, so using
'struct conflict_info' always will lead to memory bloat. But in
that case, would we not be better off with an array instead of a
scattering of data across the heap?

Perhaps 'struct conflict_info' shouldn't contain a 'struct merged_info'
and instead be just the "extra" data. Then we could have a contiguous
array of 'struct merged_info' values for most of the paths, but heap
pointers for 'struct conflict_info' as necessary.

It's also true that I haven't fully formed a mental model for how these
are used in your algorithm, so I'll keep reading.

> +	path_info->merged.directory_name = current_dir_name;
> +	path_info->merged.basename_offset = current_dir_name_len;
> +	path_info->merged.clean = !!resolved;
> +	if (resolved) {
> +		path_info->merged.result.mode = merged_version->mode;
> +		oidcpy(&path_info->merged.result.oid, &merged_version->oid);
> +		path_info->merged.is_null = !!is_null;
> +	} else {
> +		int i;
> +
> +		for (i = 0; i < 3; i++) {
> +			path_info->pathnames[i] = fullpath;
> +			path_info->stages[i].mode = names[i].mode;
> +			oidcpy(&path_info->stages[i].oid, &names[i].oid);
> +		}
> +		path_info->filemask = filemask;
> +		path_info->dirmask = dirmask;
> +		path_info->df_conflict = !!df_conflict;
> +	}
> +	strmap_put(&opt->priv->paths, fullpath, path_info);
> +	result->string = fullpath;
> +	result->util = path_info;

This is set in all cases, so should we use it everywhere? Naturally,
there might be a cost to the extra pointer indirection, so maybe we
create a 'struct conflict_info *util' to operate on during this
method, but set 'result->util = util' right after allocating so we
know how it should behave?

> @@ -91,10 +136,12 @@ static int collect_merge_info_callback(int n,
>  	 */
>  	struct merge_options *opt = info->data;
>  	struct merge_options_internal *opti = opt->priv;
> -	struct conflict_info *ci;
> +	struct string_list_item pi;  /* Path Info */
> +	struct conflict_info *ci; /* pi.util when there's a conflict */

...

> +	setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
> +			names, NULL, 0, df_conflict, filemask, dirmask, 0);
> +	ci = pi.util;

Here is the use of 'pi' that I was talking about earlier.

Thanks,
-Stolee
