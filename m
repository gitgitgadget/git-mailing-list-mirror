Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C91C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbiA0QnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiA0QnK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:43:10 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E9C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:43:10 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso3091834ott.7
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OSyTbPCrYpoFa2xh3L+xg/+d9BOwztBfAwkRZPkw3z8=;
        b=AkkFGw629Hc/6SaBRcFiRl2RooJTJ1iJLyHL7eTnazi4zQex8xtE+WVru3cm7kI/WA
         wZTvRBu+65aPtFFBL/sfP4hc/t24Se9Cp0zw3PGbeMJyVErPF9aUMaX2ontz5DhbsLu1
         2I451flPiUtCSTN+CE9joe1nFfQhLoVtmDyKI1l2pTZfLCOXUQJGsN7mOpeFQhXVZ15a
         uNHEcZSBP+++91/FLZW9wDBo6NEhjodP4O717l46I6ibiW0fVy3tohbb4EJ5FXtbppNj
         iMdsnPzfLrSnDUxlPIpioW/0yVLM5Cxl+hvXjawAZ/Kd1ivehf561Bz9bq93Rr1lWMHV
         be/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OSyTbPCrYpoFa2xh3L+xg/+d9BOwztBfAwkRZPkw3z8=;
        b=OQwaN5yVTOlMQWuOxIe9m0Mmed77XxF07ixqNuTVuFSiByHgNZRz1SWWvAGn6KLiVx
         LTwytd2JMXhYUywQ19/gxYnQ5eFO0FThcAzgnzbxx/5lFJNEVyS8fjff3Y0I/u7H6YmQ
         tBchx53QhleCJjYMUpVoRgfeKKJSIUTSnnCupfxz6qvQJ0v+ZzQKUHOR6VNBPBUWgeER
         phEn6k2fRe9fNo80LNNWj2U0RbHwKOJ+rziEQ+adlFeMBh1RAzBDCvpN6i7UGRtDIRWl
         f94HNbrQp4nAHNL0Iie2ev3UN5n3RIiZAXP1m+3+OMEQylFqWtrJcDwzbxfDVPv7wRxm
         EWpg==
X-Gm-Message-State: AOAM5325CVlFXfWR+XWF6/Um2OnQOeOris548Hb9yOsDa8IQ8a4+GjKe
        xnm44zfOVhgvJHtZsN4V8yg=
X-Google-Smtp-Source: ABdhPJwNvnrvbK0KlqWrN1sbUgzYlSWNjSst11jdCqLsJ3gJj4Sj8oC6uxoebf7zk+MQsgEUeEChnA==
X-Received: by 2002:a9d:6e90:: with SMTP id a16mr2682575otr.206.1643301790090;
        Thu, 27 Jan 2022 08:43:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id o144sm6969211ooo.25.2022.01.27.08.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 08:43:09 -0800 (PST)
Message-ID: <e1934710-e228-adc4-d37c-f706883bd27c@gmail.com>
Date:   Thu, 27 Jan 2022 11:43:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Bug report - sparse-checkout ignores prefix when run in
 subdirectories
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
 <xmqqsfu1g64s.fsf@gitster.g>
 <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/5/2022 6:19 PM, Elijah Newren wrote:
> On Wed, Jan 5, 2022 at 2:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Lessley Dennington <lessleydennington@gmail.com> writes:
>>
>>> Hello everyone! See the following bug report pertaining to sparse-checkout
>>> when run outside top-level directories.
>>
>> In a bug report it is fine, but "outside top-level" usually means
>> above the top-level of the working tree.  Here, I think you meant
>> running in a subdirectory of the top-level.
>>
>> Perhaps something along this line?
>>
>>  builtin/sparse-checkout.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git c/builtin/sparse-checkout.c w/builtin/sparse-checkout.c
>> index 45e838d8f8..4e5efbb85e 100644
>> --- c/builtin/sparse-checkout.c
>> +++ w/builtin/sparse-checkout.c
>> @@ -753,6 +753,16 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>>         if (!core_sparse_checkout_cone && argc == 0) {
>>                 argv = default_patterns;
>>                 argc = default_patterns_nr;
>> +       } else if (argc && prefix && *prefix) {
>> +               /*
>> +                * The args are not pathspecs, so unfortunately we
>> +                * cannot imitate how cmd_add() uses parse_pathspec().
>> +                */
>> +               int i;
>> +               int prefix_len = strlen(prefix);
>> +
>> +               for (i = 0; i < argc; i++)
>> +                       argv[i] = prefix_path(prefix, prefix_len, argv[i]);
>>         }
> 
> This looks good (sparse_checkout_add() needs a similar fix), at least
> for cone mode.  There might be a small pickle here that I didn't think
> about before.  --cone mode always uses directories, so we expect
> people to provide directory names.  Because of that, I think it's fair
> to expect the arguments passed to `set` or `add` to be paths relative
> to the current working directory.  In contrast, for non-cone mode we
> do not expect pathnames but gitignore-style globs.  And when we get
> gitignore-style globs, we don't know if they were intended relative to
> the current working directory or the toplevel, because we only have
> one $GIT_DIR/info/sparse-checkout file versus many .gitignore files.
> So, should "**.py" go directly into the sparse-checkout file as-is, or
> be translated to "my/current/subdir/**.py" first?
> 
> Maybe translating is always fine, or maybe we want to throw an error
> when: (not using cone mode and prefix is non-empty and any patterns
> are provided).
> 
> Thoughts?

You seem to have worked it out in the other threads, but I came here
to agree: we should not do this transformation unless we are in
cone mode. We should also do this when "--cone" is supplied.

The prefix_path() collapses "../" entries, right? Just making sure
that we test that scenario when writing a full fix here.

For example, if we added a case to t1092, we should be able to
do the following within any of the example repos:

	git sparse-checkout disable &&
	cd folder1 &&
	git sparse-checkout set --cone . ../folder2
	git sparse-checkout list >actual &&
	cat >expect <<-EOF &&
	folder1
	folder2
	EOF
	test_cmp expect actual

Thanks,
-Stolee
