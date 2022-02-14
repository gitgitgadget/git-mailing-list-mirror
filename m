Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E748C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 20:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiBNUpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:45:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiBNUp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 15:45:28 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE63C15C67D
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 12:42:22 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so20827910oot.4
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 12:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VoqHHU+QxJdEfI0kmCk1CAG4PDNh9U2hdOX9fQrr8Fo=;
        b=ecrpyBrrCpFFzrrUnq4DN4//pyWXYKNszTJBJjniyqJq6Q7QZlsUZ3glKzhRvlg6Tk
         V6zOkQk3HYMpov12/QJBzdcdZtiPGRkfVWn7i5XvFXYY05TaxS9xC03E0a7zlyBMPz1Q
         NlscOZsWMX6XgR9xUvnlMA/YgInKdR/N5oLayZuXrdy5TUJ/2Pk9qZ5IibAId84CKL3l
         SXFTEs2Fnpfh6PDK2VTZ+XtNjIXDktzgwD5GCt/RQh1DYFNB1iFTJpxNMWY2tiFFykzH
         uKNQtuwOluDRtg9Ooe8Jly/Gsu9L9BIVpYqL+Hj/ya4Evv4XNe5gx8/+r3HjTdyokhMF
         963Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VoqHHU+QxJdEfI0kmCk1CAG4PDNh9U2hdOX9fQrr8Fo=;
        b=Y8g+FYkWNtMqJvTAwNTYmoAqfCoCIt3vP3+ZP8VlTQOgBhcnQUiuAd+hbVPejf+ct9
         gMF+/zwe7bTIqMB6V+Qb3d9lYMgKUZ5EzzMrvqj3wH1N3FXoTOQBLsF+iRE714QOluxy
         7uSLPcQ8JU9pJp50RbnLK/rhM+ZDVAkvKJPK20SCtCNifFRR1K4kZOK8v5DlSR3zvKpq
         zxHPAeOcalfQgDtFp/9vLC/XIDXi63A8esvJKbuVkPbXjhobqQn/RmGTLwaTHhJ28BXL
         k4lqgNDbiB6wiwv+ac4hEMXEfzM+ZfM+uIduOopg5/1iK2jW83bAuOU9UbCjfaP0sJEs
         yo8Q==
X-Gm-Message-State: AOAM530X0jnMbRu0NVDEH4vTayoEPzwsWzrlnjpk024GRQsBtH9YBZh9
        NfUiiKyP1++WGdqjqM1s4rAWia7ldhuJ
X-Google-Smtp-Source: ABdhPJwo/KH66bGkR19KCVcCIMLYR02BkAZK0QYC2I10Uc/+x7JxMwCkgyuYyf6bFHijBGyGilB0gw==
X-Received: by 2002:a05:6870:5606:: with SMTP id m6mr220654oao.343.1644871230026;
        Mon, 14 Feb 2022 12:40:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:eccf:bfbc:c638:47f4? ([2600:1700:e72:80a0:eccf:bfbc:c638:47f4])
        by smtp.gmail.com with ESMTPSA id c29sm12881238otk.16.2022.02.14.12.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:40:29 -0800 (PST)
Message-ID: <3dd526a6-9160-97cd-05a3-769f5871587d@github.com>
Date:   Mon, 14 Feb 2022 15:40:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dir: force untracked cache with core.untrackedCache
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
References: <pull.1058.git.1644860224151.gitgitgadget@gmail.com>
 <xmqqzgmt19w6.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqzgmt19w6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2022 3:16 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The GIT_FORCE_UNTRACKED_CACHE environment variable writes the untracked
>> cache more frequently than the core.untrackedCache config variable. This
>> is due to how read_directory() handles the creation of an untracked
>> cache. The old mechanism required using something like 'git update-index
>> --untracked-cache' before the index would actually contain an untracked
>> cache. This was noted as a performance problem on macOS in the past, and
>> this is a resolution for that issue.
> 
> "The old mechanism" meaning "core.untrackedCache does not add a new
> one; it only updates an existing one"?  What "this" refers to that
> was noted as a problem on macOS is not quite clear; is "writing
> untracked cache is a performance problem"? And the last "this" which
> is a resolution is "not to add untrackedCache merely because the
> configuration variable says we are allowed to use it"?

Right. I can see how that is confusing. Here's another attempt:

   The GIT_FORCE_UNTRACKED_CACHE environment variable writes the untracked
   cache more frequently than the core.untrackedCache config variable. This
   is due to how read_directory() handles the creation of an untracked
   cache.

   Before this change, Git would not create the untracked cache extension
   for an index that did not already have one. Users would need to run a
   command such as 'git update-index --untracked-cache' before the index
   would actually contain an untracked cache.

   In particular, users noticed that the untracked cache would not appear
   even with core.untrackedCache=true. Some users reported setting
   GIT_FORCE_UNTRACKED_CACHE=1 in their engineering system environment to
   ensure the untracked cache would be created.
 
>> The decision to not write the untracked cache without an environment
>> variable tracks back to fc9ecbeb9 (dir.c: don't flag the index as dirty
>> for changes to the untracked cache, 2018-02-05). The motivation of that
>> change is that writing the index is expensive, and if the untracked
>> cache is the only thing that needs to be written, then it is more
>> expensive than the benefit of the cache. However, this also means that
>> the untracked cache never gets populated, so the user who enabled it via
>> config does not actually get the extension until running 'git
>> update-index --untracked-cache' manually or using the environment
>> variable.
> 
> OK.  It was invented solely as a test mechanism it seems, but at
> least to the workflow of Microsoft folks, once we spent cycles to
> prepare UNTR data, it helps their future use of the index to spend
> a bit more cycle to write it out, instead of discarding.
> 
> I have to wonder if there are workflows that are sufficiently
> different from what Microsoft folks use that the write-out cost of
> more frequent updates to the untracked cache outweigh the runtime
> performance boost of not having to run around and readdir() for
> untracked files?

I think the only difference here is the transition state from no cache
to an existing cache. From then on, the cache is kept up-to-date with
the same frequency as without this change.

> ad0fb659 (repo-settings: parse core.untrackedCache, 2019-08-13)
> explains that unset core.untrackedCache means "keep", and "true"
> means untracked cache is "automatically added", which this change is
> not invalidated, so I guess there is no need to update anything in
> the documentation for this change.  In fact, we might be able to
> sell this change as a bugfix (i.e. "I set the configuration to
> 'true' but it wasn't written out when it should have").

Yes, I believe this to be the case. Hopefully the rewritten
paragraphs above make this more clear.

Thanks,
-Stolee
