Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC4C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 12:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA5B64FC3
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 12:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhBEMym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 07:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhBEMwD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 07:52:03 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C0C0613D6
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 04:51:11 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id y11so6782532otq.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 04:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mkpcYFn3wBnaa9ba7X4weZso9HR0RB7K3uKj/nHs9S8=;
        b=eCFm7eGNyg5KwilIFtG1uTdHCOYBl6iSCvyV7W5OfWYVhv6bjMRuGg0pk2or3JZB9N
         vXBgCQJ7xiWRDzMXdu7SqOcmfJ4rWFZpcUGgVAY22PvvzAqS4B5vP85GoEhpiIlO/ATo
         Hg8bIEA0NgrtEF43uefFgskUAzJLfXzyLV12rv7lYpas7EoFlHD610xHcSpVxmnlfRjJ
         WLPE2TUNB2635P35NZs1JouP2b5nUB7nMz/M2AfUw2TQF4FZmHKyXYt5rIG1m+zdJtM7
         cMYFNgZcBhntWjIkuke7elayrnBj2PkBww/20mimpCD7TAuAhxz8gxjcM7EGiNnpco97
         qE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mkpcYFn3wBnaa9ba7X4weZso9HR0RB7K3uKj/nHs9S8=;
        b=rbjYC1sTR/m328mlAcqU8+cFbbu5RHKvMl+2wWh3I+xW8v7//LUlBYY/5XVgwhZZ5i
         al5mhmIGqQNo/QURJYnHUY2zoAulRPXvr0JkXQVcQ+UtXVo7RuG58ZZFOkF+s3F3nTWl
         LiHfzQ7E0AAp/4LXesU4ejkOh6oLNRl3GzSsDKfOX3GO9YB101Qfd3lrp96Ctj5r4p3R
         +PBvfQ2ht4SLreAPK7TbjkPHGMeI5MDPbjviJUMHIUHNoDfRaTZAF0qamUEdqEMZHe3j
         PsqmXjmm4Nxoa39uBywU/NsKmgUpoQuk09XxjjRNPsEf5Wp8iNofhW/Hxv7Fq3TYJ3Bg
         lbEA==
X-Gm-Message-State: AOAM530FPpHADIJk7WHw4V2Y2xs0Mx85YF/+CrA9lUULZWaLaJY86cx6
        4FEPPxYhMhdCIe+VFAdjcfI=
X-Google-Smtp-Source: ABdhPJyq+BeJwteNdVpRnUMwMlLSUoDVRWtCA2BXOqVdvO9hhwdcX78veKUhI+hpWml1LUVFB53x7g==
X-Received: by 2002:a9d:7519:: with SMTP id r25mr3342411otk.339.1612529470953;
        Fri, 05 Feb 2021 04:51:10 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:4dc9:c09:30f7:a417? ([2600:1700:e72:80a0:4dc9:c09:30f7:a417])
        by smtp.gmail.com with UTF8SMTPSA id z4sm1699770ooz.5.2021.02.05.04.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 04:51:10 -0800 (PST)
Message-ID: <1051d473-5d1b-1155-8d9e-93eb2cc349f0@gmail.com>
Date:   Fri, 5 Feb 2021 07:51:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH] usage: trace2 BUG() invocations
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20210205054914.104640-1-jonathantanmy@google.com>
 <xmqq1rdv2g3q.fsf@gitster.c.googlers.com>
 <YB0JYPLMC+hbcxCa@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YB0JYPLMC+hbcxCa@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/5/2021 4:01 AM, Jeff King wrote:
> On Thu, Feb 04, 2021 at 10:17:29PM -0800, Junio C Hamano wrote:
> 
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> die() messages are traced in trace2, but BUG() messages are not. Anyone
>>> tracking die() messages would have even more reason to track BUG().
>>> Therefore, write to trace2 when BUG() is invoked.
>>>
>>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>>> ---
>>> This was noticed when we observed at $DAYJOB that a certain BUG()
>>> invocation [1] wasn't written to traces.
>>>
>>> [1] https://lore.kernel.org/git/YBn3fxFe978Up5Ly@google.com/
>>> ---
>>>  t/helper/test-trace2.c   |  9 +++++++++
>>>  t/t0210-trace2-normal.sh | 19 +++++++++++++++++++
>>>  usage.c                  |  6 ++++++
>>>  3 files changed, 34 insertions(+)
>>
>> Sounds like a good idea.  Expert opinions?
> 
> I like the overall idea, but it does open the possibility of a BUG() in
> the trace2 code looping infinitely.

I also like the idea. This infinite loop is scary.

> We've had a similar problem on the die() side in the past, and solved it
> with a recursion flag. But note it gets a bit non-trivial in the face of
> threads. There's some discussion in 1ece66bc9e (run-command: use
> thread-aware die_is_recursing routine, 2013-04-16).
> 
> That commit talks about a case where "die()" in a thread takes down the
> thread but not the whole process. That wouldn't be true here (we'd
> expect BUG() to take everything down). So a single counter might be OK
> in practice, though I suspect we could trigger the problem racily
> Likewise this is probably a lurking problem when other threaded code
> calls die(), but we just don't do that often enough for anybody to have
> noticed.

Would a simple "BUG() has been called" static suffice?

diff --git a/usage.c b/usage.c
index 1868a24f7a..0d2408f79e 100644
--- a/usage.c
+++ b/usage.c
@@ -265,7 +265,11 @@ int BUG_exit_code;
 
 static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
 {
+       static int in_bug = 0;
        char prefix[256];
+       if (in_bug)
+               abort();
+       in_bug = 1;
 
        /* truncation via snprintf is OK here */
        if (file)

Note that the NOTRETURN means we can't no-op with something like

	if (in_bug)
		return;

so the trace2 call would want to be as close to the abort as
possible to avoid a silent failure. So, in the patch...

>>> diff --git a/usage.c b/usage.c
>>> index 1868a24f7a..16272c5348 100644
>>> --- a/usage.c
>>> +++ b/usage.c
>>> @@ -273,6 +273,12 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
>>>  	else
>>>  		snprintf(prefix, sizeof(prefix), "BUG: ");
>>>  
>>> +	/*
>>> +	 * We call this trace2 function first and expect it to va_copy 'params'
>>> +	 * before using it (because an 'ap' can only be walked once).
>>> +	 */
>>> +	trace2_cmd_error_va(fmt, params);
>>> +
>>>  	vreportf(prefix, fmt, params);

We would want this vreportf() to be before the call to
trace2_cmd_error_va(), right?

Thanks,
-Stolee
