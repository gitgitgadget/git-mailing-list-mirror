Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9270C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 14:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbjELO4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbjELO4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 10:56:24 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF3E106DE
        for <git@vger.kernel.org>; Fri, 12 May 2023 07:56:06 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f38a2d9b3dso12821981cf.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683903365; x=1686495365;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjs5S8WSJvDKAUflx6SsDSXo6AcmIbniAZ63D1M1LEY=;
        b=C5nsNSdWLKsnbA2dxMOe4SwLvUL4hwqjzg54YFZ4jO3vhnQA3O3LBD4LX3HDTvU0PM
         KDsCsdjHTb8dXFffgu584XvdNptHXOglRLphIew31M2MoReBAzxBxCfuwSn0Xcvd7I2u
         CG5GxHNSrfNxeZuM9cBXdIJC/bt2BzGHMBoADrMvzxIaD6F3GqzauA+5KBMCr2cjhvoz
         v5AeiYizuvCn4bgFMUibgk7ZeFuxNlrH+++ZEjuHRbLTLQW9a4UHkUFA/P6kjiQXUbpm
         mSgU0e0PN6IXn6fE11f+2oxfRJZNkKFCB0aPmOquAxhsPJ3HPFk2QBf86mm7YYyGVmG1
         kDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903365; x=1686495365;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjs5S8WSJvDKAUflx6SsDSXo6AcmIbniAZ63D1M1LEY=;
        b=N2T3Ivu/YSwmDGRpqwjKhes9Nhcb703qbn41tTxGvD7gz+sRLDZB3W4Ha/dS3sVDXh
         RrdxshESWXDOZp1/uKqtuZrY0oQ6COD0GsMacM1Dw4vItQRmVC4AKjkF7MMp1SCBRFoC
         0+NtO0m0Gzb74HVuHApbqkP5jF6vFeXroKM9tZAdTBHbOcqy39Qbgz/8vVOnZWTh0+FI
         j/Ep0ffec/sCNwetU2/RBG0dVJkmAs0e0/t4KdaWqj63R/TBJ535mMF/zE2DTcEoNy1l
         fqhBGInzsgsm4sSFKagdNWvEsxcHl1Y/ECNv8nmJUpfWwY6KM/4Q4swRuBvoqg4XL/M9
         HeZA==
X-Gm-Message-State: AC+VfDy8juYKiGx8yfUL2hBL8N+d6gXLZwXvh9h3NPCwJLkj9+ULy+Pa
        3y+EZELtb3NOUxDw1SaK9hc=
X-Google-Smtp-Source: ACHHUZ7c9RXxQOr8fO6V4QuMcyS83iqAHSXrH37sq3oIp7edC4Et+HM6aPcutQva967vGZ8uCmdCBA==
X-Received: by 2002:a05:622a:1a29:b0:3ef:189c:8913 with SMTP id f41-20020a05622a1a2900b003ef189c8913mr41151642qtb.1.1683903364920;
        Fri, 12 May 2023 07:56:04 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:4533:8b00:18f3:8a21:eac1:94c8])
        by smtp.gmail.com with ESMTPSA id g9-20020ae9e109000000b00746a7945d87sm5341127qkm.52.2023.05.12.07.56.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2023 07:56:04 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 3/4] revision: modify ref_exclusions to handle inclusions
Date:   Fri, 12 May 2023 10:56:03 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <866E98A8-E622-43A3-BCEC-7B6E46D49D14@gmail.com>
In-Reply-To: <xmqqfs82ve34.fsf@gitster.g>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
 <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
 <0a0693ad612755e675861dfa5a660baf8d325ed0.1683828635.git.gitgitgadget@gmail.com>
 <xmqqfs82ve34.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 11 May 2023, at 15:54, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +static int ref_matched(const char *path,
>> +		       const struct string_list *l,
>> +		       const struct string_list *hidden_refs)
>>  {
>>  	const char *stripped_path = strip_namespace(path);
>>  	struct string_list_item *item;
>>
>> -	for_each_string_list_item(item, &exclusions->excluded_refs) {
>> +	for_each_string_list_item(item, l) {
>>  		if (!wildmatch(item->string, path, 0))
>>  			return 1;
>>  	}
>>
>> -	if (ref_is_hidden(stripped_path, path, &exclusions->hidden_refs))
>> +	if (ref_is_hidden(stripped_path, path, hidden_refs))
>>  		return 1;
>>
>>  	return 0;
>>  }
>>
>> -void init_ref_exclusions(struct ref_exclusions *exclusions)
>> +int ref_excluded(const struct ref_visibility *visibility, const char *path)
>>  {
>> -	struct ref_exclusions blank = REF_EXCLUSIONS_INIT;
>> -	memcpy(exclusions, &blank, sizeof(*exclusions));
>> +	return ref_matched(path, &visibility->excluded_refs, &visibility->hidden_refs);
>>  }
>>
>> -void clear_ref_exclusions(struct ref_exclusions *exclusions)
>> +int ref_included(const struct ref_visibility *visibility, const char *path)
>>  {
>> -	string_list_clear(&exclusions->excluded_refs, 0);
>> -	string_list_clear(&exclusions->hidden_refs, 0);
>> -	exclusions->hidden_refs_configured = 0;
>> +	return ref_matched(path, &visibility->included_refs, &visibility->hidden_refs);
>>  }
>
> It is unexpected that we do "hidden" inside ref_matched().  I would
> have expected that no matter what exclusion or inclusion patterns
> say, hidden things are to be kept hidden.  I.e.  I expected

Oops. Yes this was an oversight.

>
>  - ref_matched(), which takes a path and a list of patterns, checks
>    if the path matches any of the given patterns;
>
>  - ref_excluded(), whcih takes a path and a visibility, asks
>    ref_matched() if the path matches visibility->excluded_refs and
>    relays its answer to the caller.
>
>  - ref_included(), which takes a path and a visibility, asks
>    ref_matched() if the path matches visibility->included_refs and
>    relays its answer to the caller.
>
>  - ref_visibility(), which takes a path and a visibility, goes
>    through the following sequence:
>
>    - if ref_is_hidden() says that the path is hidden, it is not
>      visible;
>
>    - if ref_excluded() says the path is excluded, it is not visible;
>
>    - if ref_included() says the path is included, it is visible;
>
>    - if none of the above triggers, the fate of the path is
>      determined by some default logic.

That's a good point. I didn't think about adding a ref_visibility() function
that conslidates inclusion and exclusion.
>
> or something along that line.  That would also allow us to avoid
> having to call ref_is_hidden() more than once when we need to check
> both inclusion and exclusion list.
>
> But perhaps I am missing some requirements to be taken into
> account, so let me read on.
>
> To be honest, I didn't expect the "exclusions can be extended",
> which I alluded to as a future, possible, follow-on work, to be
> included as a part of this topic.  I appreciate your going an extra
> mile, but I am not sure if it was a good change in the context of
> this series.  With this patch, it is not trivial to even validate
> that there is no behaviour change to any users of "struct
> ref_exclusions" when the included_refs list is empty, which is an
> absolute must to avoid regressions.

Okay, maybe we can include this refactor in a subsequent series then.

thanks
John
