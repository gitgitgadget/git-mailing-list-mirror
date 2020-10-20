Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B3C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 12:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538AB22283
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 12:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8JkHvQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394297AbgJTMTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 08:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394292AbgJTMTH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 08:19:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCD0C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 05:19:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a72so1558713wme.5
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rrfD6G2GcQa1YTxLkfNe4CQ2ieO16S6J0BwxYDBDg48=;
        b=D8JkHvQF8YSSGlQVJKiu6ZjrcQKhILSbtUCrMZpIbWDwm7+1citGm8mCTOLNzNtwoB
         LSwbmX0z7OOMCNVaaDcrzkWa2QWp3nFdZ1NpHI+MJEbha4FdJ5B6ooykuvbcA6bNR7tG
         9k3zYCbz7/I0rQD4boAWnTYTtYsKmzcAmUwS+8XfH5eIxlTfHtDHE0oPdTdxeLA0yYxt
         Z0rv64emzwGL7N8YV0bbklVKZBD1JvRbnsp/h49mtr9MFXcjifrGtfcFxEs0Z0jldAU/
         WHz7f60SGgQRncLgfkwpTPP29k3R00x393dn2LfArfJSQUtIcG4WXz/C3lmQr+Ft2qYv
         PIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrfD6G2GcQa1YTxLkfNe4CQ2ieO16S6J0BwxYDBDg48=;
        b=MoGNyQO2OZfoTT5HWgNXEbHJQRfJoIub75DhqMYM5bIF27sIW6nDMhna30ETJDDFVj
         9UMG9DBUbq47aLf2oWZTX776UXxIOyHtXVg+U5FxrojKw5XjUiguZ6TzU2RVORJgUCRY
         CkyNsU6qT707/dGebt97gTSGTohv/tWLpKnIRkynIQnOhIAtqYlJ4ByLnF3e1LzKZMFi
         flkcfI8SIHvtbE8WTtoaqznt3ynCnJBECkiULqUNkKPM7wvb+tTg3/If8l3SExY4DFWA
         8pxPUpeSRCZmXRUXCMDGU+WmHhYc+JTguNiXoYN/GR7Yo0l75Pzf+DauJGWtLGCwjbVu
         fw6w==
X-Gm-Message-State: AOAM532NdGtJfSnmNyieZ+myCpRGhQnpJD4imtgB0qMNxsYe97U9JD8L
        4YNGLEpwPcjaDGrGeSv72X+BfEfYwpE=
X-Google-Smtp-Source: ABdhPJxXGzOiH0/nsovHtaUuSfG+/CBJAbMMj8m/EvRMLOkZ7Qaz3g8uX2TUeeGKvITgy/3XsemZTg==
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr2808982wmi.144.1603196345770;
        Tue, 20 Oct 2020 05:19:05 -0700 (PDT)
Received: from [192.168.1.201] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.googlemail.com with ESMTPSA id t5sm2824840wrb.21.2020.10.20.05.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 05:19:05 -0700 (PDT)
Subject: Re: [OUTREACHY][PATCH v1] t7006: Use test_path_is_* functions in test
 script
To:     Joey S <jgsal@protonmail.com>,
        "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>,
        "me@ttaylorr.com" <me@ttaylorr.com>,
        "emilyshaffer@google.com" <emilyshaffer@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com>
 <20201020001103.GB2774782@google.com>
 <xmqqpn5dd5dv.fsf@gitster.c.googlers.com>
 <O2ACwMmJ8_oj_OrMPF4bGf-9nctJiXbFxJ6yzlWWCob0Zr25aSCOfcCc8pGNukbReQQJi_6igxiEyQT1hWp3ccbY1pJr62Y4eNk097tInP8=@protonmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0c61c3cc-b6b6-84dc-7e3f-99a41f676e7f@gmail.com>
Date:   Tue, 20 Oct 2020 13:19:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <O2ACwMmJ8_oj_OrMPF4bGf-9nctJiXbFxJ6yzlWWCob0Zr25aSCOfcCc8pGNukbReQQJi_6igxiEyQT1hWp3ccbY1pJr62Y4eNk097tInP8=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joey

On 20/10/2020 08:24, Joey S wrote:
> Hi everyone,
> 
> Thank you very much for the input and feedback, it's much appreciated.
> 
>> All this text above is useful context for reviewers but appears as part
>> of the commit message which is not what you want. If you add notes after
>> the `---` line below then they will not end up in the commit message.
>>
> Understood, thank you.
> 
>>> Modernized the test by replacing 'test -e' instances with
>>> test_path_is_file helper functions.
>>
>> s/Modernized/Modernize/
> Will do in the amended commit next.
> 
>>> -   ! test_path_is_file paginated.out
>>
>> It would be better to replace`! test -e` this with
>> `test_path_is_missing` as the modified test will pass if paginated.out
>> exists but is not a file. `test_path_is_missing` will print an
>> appropriate diagnostic message as well.
> 
> Thank you for the explanation : )
> 
> After replacing `! test -e` with `! test_path_is_missing paginated.out` however, the changed test cases are failing;
> ```
> $ cd t/ && prove t7006-pager.sht7006-pager.sh .. Dubious, test returned 1 (wstat 256, 0x100)
> Failed 3/101 subtests
> 
> Test Summary Report
> -------------------
> t7006-pager.sh (Wstat: 256 Tests: 101 Failed: 3)
>    Failed tests:  7-9
>    Non-zero exit status: 1
> Files=1, Tests=101,  5 wallclock secs ( 0.03 usr  0.00 sys +  3.49 cusr  0.65 csys =  4.17 CPU)
> Result: FAIL
> ```
> Is this the behavior I should be expecting?

No it's not! As one aspect of this process is to help candidates improve 
their understanding I'll give you a hint rather than the whole answer. 
`test -e <path>` checks whether <path> exists and exits 0 if it does and 
the shell treats an exit code of 0 as success. `!` inverts the 
success/failure of the command  that follows it. Using that and looking 
at the definition of test_file_is_missing in t/test-lib-functions.sh see 
if you can fix the conversion so that the tests pass. If you get stuck 
do let me know and I'll try and help some more.

Best Wishes

Phillip

>> ...Alternatively, this would fit just fine in a cover letter. Usually
>> cover letters are not necessary for single patches (where the patch
>> message itself conveys the full message, or a little bit of additional
>> context below the triple-dash line is all that's necessary to clarify
>> the intent). But, if you want to introduce yourself, a 0/1 cover letter
>> is fine, too.
> 
> Will keep this in mind, thank you Taylor.
> 
>>> One thing missed by other commenters: the Developer's Certificate of
>>> Origin line - which is what this indicates - should have your "full
>>> name".
>>
>> ... and it must match the authorship.
> 
> Changed, thank you both for catching that.
> 
> Thank you all,
> Joey
> 
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Monday, October 19, 2020 7:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Emily Shaffer emilyshaffer@google.com writes:
>>
>>> On Mon, Oct 19, 2020 at 04:26:07AM +0000, Joey S wrote:
>>>
>>>> Hi everyone,
>>>> Hi Joey and welcome.
>>>
>>>> Signed-off-by: JoeyS jgsal@yahoo.com
>>>
>>> One thing missed by other commenters: the Developer's Certificate of
>>> Origin line - which is what this indicates - should have your "full
>>> name".
>>
>> ... and it must match the authorship.
>>
>>> So in my case, I sign my patches 'Emily Shaffer
>>> emilyshaffer@google.com'. If I'm wrong that's fine, but JoeyS sounds
>>> like a name and initial rather than a full name.
>>
>> Thanks for pointing it out.
>>
>> If somebody from the "mentoring" group is taking a tally, it might
>> not be a bad idea to identify which style and procedure rules are
>> often failed to be followed by new contributors so that we can
>> figure out ways to make them stand out in our documentation set
>> (e.g. Documentation/SubmittingPatches but maybe a separate cheat
>> sheet might be worth having).
>>
>> Thanks.
> 
> 

