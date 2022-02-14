Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C93FC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 04:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiBNEYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 23:24:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBNEYo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 23:24:44 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321714F449
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 20:24:38 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i16-20020aa78d90000000b004be3e88d746so10861186pfr.13
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 20:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tUCToz9fLrtP2QOOmJN1jyAaOcF9ux0CxhVA8/CpqVE=;
        b=AaNk+iNsthNmrR2EWj0zzn0I9PQU5eX7za2Wcfcir9K9oMZqDE4NpYIbWSftHKOnuP
         cVqDLWya3/biok/So1abVdTBFZoN60uYj5spTM8sagpOcDDc134+iu8iBnb80lSeypV5
         5KUbKOwHkSh1JuPs/X0UgNSjnxrNbfqjD8aZKxh+EnyWyFEkb70hRqW6lFFQBXY9YaUk
         /QQ2+e+Tu+lqFFuzjHRVt5ccaPHlt7/D2n3UJiLgfVLcsR9RZgxgP79Yde4Ek0DYryM9
         jf5gp7mRXqKzJC1CQffVS4/waqpn+QB8mDVIlHiIVQ8KgYtyWWZcA5jJ5infB9nxSPtI
         yyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tUCToz9fLrtP2QOOmJN1jyAaOcF9ux0CxhVA8/CpqVE=;
        b=hz9CBHIG16VdDJ55UHfji9yR9zz3lpmqqHh7kLSlTP5xinjAAEBIuRG5Q8tO/fGwyN
         aAGvK8P8jngINEsLmMIRwKZHDSIjA8IA2iBCn/1e560lMIvjAysaS+jYOtWJV9Ze1HGY
         ivvHSxbiDyHxuHDkHMzBiMOT9KrSoBjDDAj1xmDjV5DwyDxD0fh8qlqwzbk7j8o4AF0h
         95eoMtC7ZSU5mHl6Ke35Q6Lga97mNeZuBxIxxfN6ILhHpELvopw+6Ej00+tflM2KM+k0
         XfG3BLi7NNh1QgOgHt/1vhiD9ojG28zhVQo7DKuFhzpxRMAWRmV6KJhduZyv8Y2F7suf
         gl3w==
X-Gm-Message-State: AOAM533hZbX6uHB8blLByL1Rgdu3hfwZZnjZzwJRVIgOhpjantNWnQAd
        WMcrzMI4GL2XvJPon1goILzLu9HqPhiJdA==
X-Google-Smtp-Source: ABdhPJwt/Bc7jevQQkn05H5hPBxRSycDlELypGrIXZz6Gmdse/WiKlp6LVCWtWrVkLN9NXInEcOsRk4lDmIMfw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c40b:: with SMTP id
 k11mr9760623plk.58.1644812677588; Sun, 13 Feb 2022 20:24:37 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:24:35 +0800
In-Reply-To: <20220210225137.688066-1-jonathantanmy@google.com>
Message-Id: <kl6lh7926poc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210225137.688066-1-jonathantanmy@google.com>
Subject: Re: [PATCH 7/8] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> @@ -1495,6 +1499,15 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
>>  		if (!task)
>>  			continue;
>>  
>> +		/*
>> +		 * We might have already considered this submodule
>> +		 * because we saw it when iterating the changed
>> +		 * submodule names.
>> +		 */
>> +		if (string_list_lookup(&spf->seen_submodule_names,
>> +				       task->sub->name))
>> +			continue;
>
> [snip]
>> +		/*
>> +		 * We might have already considered this submodule
>> +		 * because we saw it in the index.
>> +		 */
>> +		if (string_list_lookup(&spf->seen_submodule_names, item.string))
>> +			continue;
>
> Hmm...it's odd that the checks happen in both places, when theoretically
> we would do one after the other, so this check would only need to be in
> one place. Maybe this is because of how we had to implement it (looping
> over everything every time when we get the next fetch task) but if it's
> easy to avoid, that would be great.

Yes, in order for the code to be correct, we only need this check once,
but I chose to check twice for defensiveness. That is, we avoid creating
implicit dependencies between the functions like "function A does not
consider whether a submodule has already been fetched, so it must always
be called before function B".

Perhaps there is another concern that overrides this? e.g. performance.
