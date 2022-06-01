Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A387CC43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 18:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiFASmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFASmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 14:42:19 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765052E52
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 11:42:17 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f7so1927074ilr.5
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MF2AQ3hoP2P2CbzIVY76kR0K8QTSJLxFyO1G1Vr/HL4=;
        b=CP2m+GeBoCWI0ra7JpgPqf2Sw4wgqNH5vKGgYNr5Hlu5GbmaJBpnSymPtC3FjVlgaO
         Y/myjHeb7BGtVBDsX4b8UnExQMobJNR/6MpENC42Q+wC7pZtZik2VA3U59C7AzHfCPmM
         rKWFxiqwoFs8rpv8mdJ4i4ZgfCqfMfuCRqnPsCTN9WICqfYcv19b+rlExhybjcDVezFH
         SRD7XJckSfwQrBEIyTSRcD3X9VzuJW0zK9/4A6SxfgDuMCQQhysCQp/Ya3I4Rkc1O2h4
         3BlaMTwMifXeATxTvThD8z6izuu1GwlsBeJ/1wJmJB62yON2QvQavo6xRDxuCmxypVep
         unCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MF2AQ3hoP2P2CbzIVY76kR0K8QTSJLxFyO1G1Vr/HL4=;
        b=37LRfAWEzDij6lEX9GNYrmOpgX76xoWEK3rp48dc+yY+uksDnJ4zUix2iu+gdAY/gu
         E6wBv8Msz/rih9S+OaW3noZZzAfs6Q0vKLsJwZHE/ydvm0ZgUqfqRFp3Ohpq8rTITjmh
         CqaPmqLt6RckguyHnz0ypTKUQ4IxsHomtuSz0rLWYQ6Zqn9fSWbPT2a2Zrn7G8BI1bm3
         BXPbjKKQOgYvSigRwdBQoEXfHF/srGUDRZUrYpr+rScvOKu1ogNP38jB9yPzicv0k7Vd
         vVtrKc17QaVds98dk4fR4FvnsYuvFCuY/cXZvVT9cS2l9YqY3ozOmQNHU/no1hznciij
         7gBg==
X-Gm-Message-State: AOAM53113L30RRtWOvSktAteMVIWgC+cXlw+zdvvyU0Xjxb9/GjnG6Eo
        APHgepIkrHlC1e2O++K5Bw8PfAdH+9ib
X-Google-Smtp-Source: ABdhPJz/+cohJ3I65ihVJTfzWQ85DrrUW/gfOJ/7flWB5OV9PSIL1fSB+hdRpm/efw60Jnb5w6/9Ng==
X-Received: by 2002:a05:6e02:12e7:b0:2d1:7bcd:f7c8 with SMTP id l7-20020a056e0212e700b002d17bcdf7c8mr925455iln.51.1654108936742;
        Wed, 01 Jun 2022 11:42:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f5fe:7c12:b46d:1d17? ([2600:1700:e72:80a0:f5fe:7c12:b46d:1d17])
        by smtp.gmail.com with ESMTPSA id s29-20020a02b15d000000b0032e802256a9sm611643jah.163.2022.06.01.11.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 11:42:16 -0700 (PDT)
Message-ID: <8f96563b-87c5-2a8c-fe35-19fd0cc3c7d2@github.com>
Date:   Wed, 1 Jun 2022 14:42:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] usage: add warn_once() helper for repeated
 warnings
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
 <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
 <220601.868rqg1qo2.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220601.868rqg1qo2.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2022 8:29 AM, Ævar Arnfjörð Bjarmason wrote:> 
> On Wed, Jun 01 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The previous change added a warning when valid_remote() detects
>> credentials in the URL. Since remotes are validated multiple times per
>> process, this causes multiple warnings to print.
> 
> Why are we validating remotes multiple times per process? Can't we just
> do it once?
> 
> Is this a case of two callers going through the whole machinery and not
> being aware of one another?
> 
> Perhaps it's a pain to deal with that in this case, but it would be
> better to note why here than taking it as a given.

We could certainly investigate this more, but it seems like a more
problematic approach than the one taken here. We could add a "is_valid"
bit to struct remote, but then could some code path modify that struct
after it was validated?

>> To avoid these kinds of repeated, advisory warnings, create a new
>> warn_once() helper that behaves the same as warning(), but only after
>> formatting the output string and adding it to a strset. If that addition
>> signals that the string already exists in the strset, then do not print
>> the warning.
> 
> This feels quite iffy given the low-level API & the rest of it aiming to
> be thread-safe, see 2d3c02f5db6 (die(): stop hiding errors due to
> overzealous recursion guard, 2017-06-21) for such a case.

It makes sense to keep the low-level library as thread-safe as possible.

Would it be enough to document this particular caller as not thread-safe?

>> In the case of the credentials in a URL, the existing test demonstrates
>> this per-process limitation: 'git clone' runs 'git-remote-curl' as a
>> child process, giving two messages. This is an improvement over the
>> previous six messages.
> 
> If we know about this limitation and we're going to be checking the same
> URLs why not do slightly better and pass down a "don't warn please" to
> the sub-process?>> Or do we think it might warn about *different* URLs, aren't these always
> the same (i.e. we read the full config)?

While this example of 'git clone' to 'git-remote-curl' will not use a
different URL, I can imagine other child process connections that could
expose a different URL. Having a blanket statement "don't emit these
warnings" seems unlikely to be helpful for those cases.

> If you used advice instead of a warning you'd get a config key to pass
> for free to disable it, and that might be a better thing to do in any
> case (i.e. a better fit for this case). But we could also just check
> getenv("GIT_URL_REDACTED_WARNING") or whatever, which seems easy
> enough...

To make the environment variable work properly, we would need to pass a
list of URLs in the variable that could seed the strset, to avoid dropping
warnings for new cases as mentioned earlier.

>> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
>> index cba3553b7c4..6ae3eec9eb6 100755
>> --- a/t/t5601-clone.sh
>> +++ b/t/t5601-clone.sh
>> @@ -75,7 +75,10 @@ test_expect_success 'clone warns or fails when using username:password' '
>>  	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
>>  	! grep "URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
>>  	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
>> -	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
>> +	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err >warnings &&
>> +	# The warning is printed twice, for the two processes:
>> +	# "git clone" and "git-remote-curl".
>> +	test_line_count = 2 warnings &&
>>  	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
>>  	grep "fatal: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err
>>  '
> 
> Hrm, between 1/2 and this I think this is a good example of a "just use
> test_cmp" caveat.
> 
> I.e. reading 1/2 it's snuck past us that there's this existing caveat in
> the warning being added, i.e. that we should really warn 1 times, but
> are doing in N times, but as we use ad-hoc "grep" instead of
> test_cmp-ing the full output that's not obvious.
> 
> I think this would be much more obvious as:
> 
> 	warning="<your warning msg>" &&
> 	cat >expect <<-EOF &&
> 	$warning
>         $warning
> 	EOF

There are other warnings coming over stderr, including the "Cloning
into..." message and the resulting "fatal:" message because that URL
doesn't actually exist. I chose to decouple this test to the exact
phrasing of those messages.

> But even better (and per the above, I'm not convinced about the
> direction, but leaving that aside): Here we have a choice between having
> 1/2 and 2/2 in that order and having 2/2 add a new API that has its
> first user right away, but at the cost of fixing a bug we just
> introduced in 1/2.
> 
> I think even if we can't find another API user for this proposed usage.c
> addition, just adding it without a user & adding what's now 1/2 as the
> 2nd commit would be preferrable. Then we're not doing a "oops, bug fix"
> while we're at it.

I wouldn't call this a "oops, bug fix" but instead "let's improve what was
working, but noisy." This also gives us the opportunity to see the code in
usage.c get tested immediately as it is introduced, which is an important
property to keep in mind when organizing a patch series.

>> +static struct strset prev_warnings = STRSET_INIT;
>> +
>> +void warn_once(const char *warn, ...)
>> +{
> 
> If we do end up keeping this (per the above I'm thinking while it's just
> this caller it should probably own this problem):
> 
> I have a local change to clean up this warn v.s. warning inconsistency
> in usage.c, but now it's all in internal code.
> 
> But let's not add to it by adding a warn_once(), it should be called
> warning_once().

Sure. The phrase "warn once" is a valid sentence, while "warning once" is
not, but I can see some benefit to having consistent naming here.

If the "warning()" method was not already present so much throughout the
codebase, then I would advocate that "warn()" is a better verb form. This
would be similar to "die()" and even "error()" could be interpreted as a
verb. However, that would be too large of a change to be worthwhile.

> We're also missing an "errno" variant, which might be fine for now,
> ditto variants for the other non-fatal functions (error &
> die_message). That might be OK for now, but probably worth noting.

Noted.

>> +void warn_once(const char *warn, ...)
>> +{
>> +	char buf[1024];
>> +	va_list params;
>> +	va_start(params, warn);
>> +
>> +	if (vsnprintf(buf, sizeof(buf), warn, params) >= 0) {
> 
> It doesn't matter for the end result, but let's compare with "< 0" like
> the other vsnprintf() caller in the file.

Except that we do something after this block in both cases, so the
condition needs to be swapped or else duplicate code.

> And how is this unlike that vsnprintf() in not needing the same error
> handling vreportf() does here:
> 
> 	*p = '\0'; /* vsnprintf() failed, clip at prefix */
> 
> Seems like either a bug, or that other code being something we should be
> dropping.

No, because the params are passed to warn_routine() in the section of code
you cropped out:

+	va_start(params, warn);
+	warn_routine(warn, params);
+	va_end(params);

That warn_routine does the "clip at prefix" fix. if we have a failure in
vsnprintf() here, then we are skipping the "only once" check and going
straight to that logic.

>> +		if (!strset_add(&prev_warnings, buf)) {
> 
> More on the general API usability front: E.g. builtin/pack-objects.c
> seems like it could make use of thing like this in two places.
> 
> But the API you've added here would only be usable for 1/2, i.e. you
> format and de-dup on the full warning, whereas at least 1/2 of those
> callers wants to de-dup on the un-formatted string (grep for 'static int
> warned').
> 
> Which (and I'm sounding like a broken record:) is another thing that me
> wonder if the general API is premature, i.e. it's a red flag that we
> have existing code that could benefit from it, if not for an arbitrary
> limitation, in this case fixing the limitation would mean the churn of
> either adding a new function, or a new parameter to all callers. I.e. a
> "int dedup_on_args" or similar.

You are advocating that since there is one example of something that
doesn't fit this exact scenario, then we shouldn't move forward on
something that _does_ have immediate use (and potential use in other
places). This seem unnecessarily pedantic.

This specific method is a good foundation for possibly extending it if
there is value in doing so.

>> +			va_end(params);
>> +			return;
>> +		}
>> +	}
>> +	va_end(params);
>> +
>> +	va_start(params, warn);
> 
> I'm rusty on the varargs API (and haven't tested) but didn't we need
> va_copy() if we're iterating twice, or was that just if we're passing it
> to another function and using it ourselves...

Well, outside of the fact that this function is tested and it works,
the documentation says this about the 'params' argument (named 'ap'
in the function prototype):

  If ap has already been passed as first argument to a previous call to
  va_start or va_copy, it shall be passed to va_end before calling this
  function.

So, va_end(params) makes it safe to call va_start(params, warn) again.

Thanks,
-Stolee
