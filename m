Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164EFC43381
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77CF64E9C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhBIRgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhBIRfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:35:17 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8920C06174A
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:34:38 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l3so10321866oii.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PO4zBetmeYKkstCuMAjbpRxc1JP9g32YLaKcjBSRIW8=;
        b=D2shRjnS1OluIMW2OyO+7CuSaW6+pYTUEiMq/RFPiquNkIEd4ke/vWooPrpoytCF/Z
         Z8Ttevfuy+vJs4gWBBdO/2sJMqsIxWTAZC+hKoMLNbyqrJnBtHsBgqEki0xtuCbKwp0i
         DJiCeSEE1Zi58mBYNZbwtiZMwL+EFC1zzPqBGEqFh8S3brEdSU1BEJ1NtRqvJ6Rqfu8k
         1/y+WXaZkFFSshLrZJyLD2j+u3njkJ7VY0GUIHIlcvP2bvH3secuRr3IFx43s6BtGxM+
         +xpwJjgGl4iehIZM0LteQ7ZsYWJw4MPlmF0LBAjKTFDObvxc4S8ms4g0LfCxyJQj/j9N
         TrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PO4zBetmeYKkstCuMAjbpRxc1JP9g32YLaKcjBSRIW8=;
        b=ujMsh9NKfV1nek+mZnXWY86txL6lwdDRWWh4BITCah9qmBj7vyqSI/rP9jQ7Uuj8rL
         0pupeyNdK5Rg4oZ7WB22ZEuJXfut9zsnXTuxq5i3vlcQeC4nUTr+jsd5MzLwMW47YEpH
         zfT2TgqedTuBUf/hMDwZR3rAuBI7XUeC7JoketerBiIp6eW0DW0jjjYGuhQqPnXV1Aww
         J3NrWcGDEX56M8BuUThKXfuMIwsYlzUa+YdQosgy6EsXsRbzL+/EeipIFR7RAgqp2mDu
         7Xu8l9u0JmEAwH788hLuoX4OQKr04VAv1rLhUwp7uE7tzdGrfoLbSAXGHKt5xnhR57lf
         BMsg==
X-Gm-Message-State: AOAM531erhcvvGAzV25Q9qAUHwNAhHILirlMKyRTzGvnjyg01dJ4FL/j
        BaJ+25iPUw4cUy7iMdxsHJQ=
X-Google-Smtp-Source: ABdhPJzCZPwgZUl+QtL6bqfHOxV87VeAnZegAQD8JfOnEhqk9P/S7l+IdNXAUoIO5S9Kf2RLP6gCNA==
X-Received: by 2002:aca:4454:: with SMTP id r81mr3197407oia.129.1612892078096;
        Tue, 09 Feb 2021 09:34:38 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id i13sm2764861oth.52.2021.02.09.09.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 09:34:37 -0800 (PST)
Message-ID: <d0154183-371f-5ada-f4dd-dab7b3267c8c@gmail.com>
Date:   Tue, 9 Feb 2021 12:34:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 2/4] diffcore-rename: complete find_basename_matches()
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <dcd0175229aa6fba576425e78875b95385acb58d.1612870326.git.gitgitgadget@gmail.com>
 <b64e30ab-9cb3-ffee-ec5e-1b94529ce636@gmail.com>
 <CABPp-BEz7ZUUUPF6EkK0RzWq5O=kYbNFFtg=iMbk607kQ-nmbg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEz7ZUUUPF6EkK0RzWq5O=kYbNFFtg=iMbk607kQ-nmbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2021 12:17 PM, Elijah Newren wrote:
> On Tue, Feb 9, 2021 at 5:25 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 2/9/2021 6:32 AM, Elijah Newren via GitGitGadget wrote:
>>> +             /* Get the basename */
>>> +             base = strrchr(filename, '/');
>>> +             base = (base ? base+1 : filename);
>>
>> Here is the third instance of this in the same function. At minimum we should
>> extract a helper for you to consume.
> 
> Where by "this" you mean these last two lines, right?

Correct. The reason to use a helper is to ease cognitive load when
reading the code. These lines are identical and serve the same
purpose. By making a "get_basename()" helper and using it as

	base = get_basename(filename);

makes it easy to understand what is happening without needing
to think carefully about it. For example, I had to remember
that strrchr() returns NULL when '/' is not found, not the first
character of the string.

> And perhaps explain why I'm not using either basename(3) or
> gitbasename() from git-compat-util.h?  (The latter of which I just
> learned about while responding to the review of this patch.)
> 
> or maybe gitbasename can do the job, but the skip_dos_drive_prefix()
> and the munging of the string passed in both worry me.  And the
> is_dir_sep() looks inefficient since I know I'm dealing with filenames
> as stored in git internally, and thus can only use '/' characters.
> Hmm...
> 
> Yeah, I think I'll add my own helper in this file, since you want one,
> and just use it.

Right. I almost made a point to say "Don't use find_last_dir_sep()"
because it uses platform-specific directory separators. Your helper
is based on in-memory representation that always uses Unix-style paths.

Thanks,
-Stolee

