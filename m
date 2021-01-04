Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8635AC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 01:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DFB20936
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 01:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbhADBCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 20:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbhADBCS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 20:02:18 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C6C061574
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 17:01:37 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id l200so30338585oig.9
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 17:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iLBhOMGBDohvcyTIoh8QM/50YlYvpsQgqoiK3phjggU=;
        b=LJ1e51zBCOaec/hAnk/OuiqV7xReTcujIcrfm06MYrQoLjpbAr71nu+c335ZHVJhP1
         IAz8yHG6enbFiI33PUKOC8GAufy52MGKqz7nYgTvXL8oyRWJLI3NE1uDC6iALpq0JVMn
         joOJ83lzkGd3pjx9QcnB+tj49G6BR7dM9y3nGKjQNhyExNA+dQWJKsz4ypKhXZiBHhzw
         z9AjLLUTKlqNIQDJ8pSQ3lBh/+qpxaa5KkUX1e9jyf6FT7VB7EX8D0vACFWyNIcqAsQd
         s8f7wzy8ENTspx0nK+QKzfyVYDGpBlSmZhLfqOCdvNhMalHnRWKsTaSvzTCyif467RVs
         iapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iLBhOMGBDohvcyTIoh8QM/50YlYvpsQgqoiK3phjggU=;
        b=lBtEQHKZRdj1DojWT2iw6PnURCOaoHIWhp8Rl1fnNp5cNVrfZHa4dWs3I+4MTFRpSs
         YfQGsWKOkhf4o414i9ZJYQwDXVEYJm8mOoTZ5Pjef9oj2eU5DzSp0p2yyc8I1y7YxyEk
         uNnLckVyvu7WiJdTrzHyktXinrnNvlSkAkn0SBYnRrblbOe2O7Hd3esRIAPrE/DMPI88
         p/wFGlkRXUgErUKc1T2OXzxQzX1VgDou4bJnrqzxn2m1o6oYW+8YLWsKMLydlDVxfONQ
         ADFdP9oHrZIiaY49c7eMTWekRsOA246tnp2GKxMSvTyjecCC/T8GhHRVMNj/HRyxSZLT
         qffQ==
X-Gm-Message-State: AOAM530BJpqJMGMMPmXCQxKBfs3dv6tgmhjmV5jmO2IMcgK0BHk+2OWo
        eewtbJ+4BcGQoaqcYZtV9gc=
X-Google-Smtp-Source: ABdhPJxCVBXXcDR3tby40X08R/fBoXzvHXedNQq6jbFQoEK62Wm67h1czpTcYhUwnvBpItaLIxYTKw==
X-Received: by 2002:aca:cd8d:: with SMTP id d135mr16654082oig.143.1609722097146;
        Sun, 03 Jan 2021 17:01:37 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id q1sm14341848oij.9.2021.01.03.17.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 17:01:36 -0800 (PST)
Subject: Re: [PATCH 00/12] Remove more index compatibility macros
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <CAPig+cS-oDfCX-LaDEW2U+9Aa9VNZUPs54isODoHCv6HxAdZeQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <65af825c-00b1-5852-3a4a-81babfc5040f@gmail.com>
Date:   Sun, 3 Jan 2021 20:01:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cS-oDfCX-LaDEW2U+9Aa9VNZUPs54isODoHCv6HxAdZeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/2/2021 1:12 AM, Eric Sunshine wrote:
> On Fri, Jan 1, 2021 at 8:09 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> My strategy for update-index was to create static globals "repo" and
>> "istate" that point to the_repository and the_index, respectively. Then, I
>> was able to remove macros one-by-one without changing method prototypes
>> within the file.
>>
>> I had started trying to keep everything local to the method signatures, but
>> I hit a snag when reaching the command-line parsing callbacks, which I could
>> not modify their call signature. [...]
> 
> You should be able to do this, not by modifying the callback
> signature, but by taking advantage of the `extra` member of `struct
> option` which is available to callback functions or arbitrary use. If
> you need to access the index in a callback, then assign a `struct
> index_state *` to `extra`; likewise assign a `struct repository *` to
> `extra` to access the repository. If you need access to both the index
> and the repository, then just store the repository in `extra` since
> the repository has an `index` field.
> 
> You won't be able to use any of the canned OPT_FOO() macros to
> initialize an entry in the update-index.c `options[]` array which
> needs `extra`-initialization since the macros don't let you specify
> `extra`, but you can easily bypass the macro and initialize the
> `struct option` manually. (After all, the macros exist for
> convenience; they are not a hard requirement.)
> 
> Within the callback, extract the `repository` or `index_state` as you
> would any other field. For instance:
> 
>     const struct repository *repo = opt->extra;

Yes, this is definitely the way to make it possible.

> This should allow you to get rid of the globals introduced by patch
> [4/12] (assuming passing the index and repo arguments around
> everywhere doesn't get overly hairy).

My attempts just getting to the point of hitting these callbacks was
already making me frustrated with how complicated the code became with
that approach.

Perhaps now that I've removed the compatibility macros, it would be
easier to insert the method parameters since most of the lines that
need to change would be method prototypes and the calls to those methods
(plus the callback function details).

Is that a valuable effort? I could give it a try, but I want to be sure
that adjusting all of those helper methods in the builtin would indeed
have valuable improvements over the static globals used here.

Thanks,
-Stolee

