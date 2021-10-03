Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2BEC433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB65361AFC
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 13:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJCNcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCNcT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 09:32:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97254C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 06:30:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w14so17648pll.2
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=XCnPdvPmI2uf6M12HCMbjsivSiKTE9+F+XnGdHdfDHo=;
        b=jB9jMbdJHWFTAvALFzwfw+gF7gZi3L552V5+OKusbfYbZIZLmQxoKOCnCHJjo8C6+s
         YEPT4OU3x7gUcNfJ1KcVm85YzHG72Rgxi4HKdA8q3F3FvglUhhb4TgEf5/2T6+FKEXiw
         jIHpF/ODZQtwi3vYVNTwvYasnjDwp4PXosxYbSdt6rmQ9mFx3o4SzTAp2MxYX1wP4PG+
         5zQBezXYlXhvz5WTJ7cOQglL9c/cY2sjFWeT9KfjZ+Mm/pkLwH6J3OGgY5JRtOCW3j9W
         yteValtJATftvr8ZuYjUw0ks03Ft4ZRNGtGi/jUCiDE/pT3nh0BZay4shA0Ui1rQPBXf
         R9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=XCnPdvPmI2uf6M12HCMbjsivSiKTE9+F+XnGdHdfDHo=;
        b=kk6sa5GhTXQV9Llnyc4zNpfXA1YxkWQkw86sJSsZAG11mu/C1o9vaBdZ+WiHdQqp0K
         4I9XqAUFO1XZGtezB6DJneU7NozRlDS9HDxtyAVdhoV/vSw21C04JMxD8ZZrE7uSGNCc
         YKK6KtK3dYkDMQRLPMdFcNeh4842gcHKOtzJSsymx1VZbyTgMNOgMfOgr9VZ8//7ZJ3o
         kDCDygTHqx6nhoZ777Sl3DR9MdXtb1IS2jC7U8B/5eTXkLvoQzpoFSIfk+PmNl6IRGTV
         /JhfMH1//r/fROO9Nl5mRtlKbQgLoeQmMrbk3gpciQIYb3le23X2uXYBce9+R+KBry7i
         ta3Q==
X-Gm-Message-State: AOAM533hlzs2YKLoKfNHTxKyi8e+0bOxI0iiN2wdqYzUhesiAr3Xe2DG
        xJoTo7Sdlx2+7+X7qJUiCHU=
X-Google-Smtp-Source: ABdhPJyy6DS5G8CND9lGw9qzn8iPQV709KKOZiQSz2Y+buHEwWcIXzT0kbpr7tPISGWhIt9vtU3iUg==
X-Received: by 2002:a17:90a:351:: with SMTP id 17mr24941954pjf.145.1633267830954;
        Sun, 03 Oct 2021 06:30:30 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.146])
        by smtp.gmail.com with ESMTPSA id q12sm11400468pfg.136.2021.10.03.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 06:30:30 -0700 (PDT)
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
 <20210916103241.62376-3-raykar.ath@gmail.com> <xmqqr1djchp5.fsf@gitster.g>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 2/8] submodule--helper: get remote names from any
 repository
Date:   Sun, 03 Oct 2021 18:52:51 +0530
In-reply-to: <xmqqr1djchp5.fsf@gitster.g>
Message-ID: <m2k0iui6by.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Atharva Raykar <raykar.ath@gmail.com> writes:
>
>> `get_default_remote()` retrieves the name of a remote by resolving the
>> refs from of the current repository's ref store.
>>
>> Thus in order to use it for retrieving the remote name of a submodule,
>> we have to start a new subprocess which runs from the submodule
>> directory.
>>
>> Let's instead introduce a function called `repo_get_default_remote()`
>> which takes any repository object and retrieves the remote accordingly.
>>
>> `get_default_remote()` is then defined as a call to
>> `repo_get_default_remote()` with 'the_repository' passed to it.
>>
>> Now that we have `repo_get_default_remote()`, we no longer have to start
>> a subprocess that called `submodule--helper get-default-remote` from
>> within the submodule directory.
>>
>> So let's make a function called `get_default_remote_submodule()` which
>> takes a submodule path, and returns the default remote for that
>> submodule, all within the same process.
>>
>> We can now use this function to save an unnecessary subprocess spawn in
>> `sync_submodule()`, and also in the next patch, which will require this
>> functionality.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Shourya Shukla <periperidip@gmail.com>
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 34 +++++++++++++++++++++++-----------
>>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> The above covers a lot of stuff, because this change does a lot of
> things ;-)
>
> The commit could be split into 3 logically distinct phases (two
> independent, the third depends on the other two):
>
>  - extract the part that uses the run-command() API to run
>    "submodule--helper print-default-remote" from sync_submodule()
>    and create get_default_remote_submodule() function out of it.
>
>  - move bulk of get_default_remote() into repo_get_default_remote()
>    and reimplement the former as a thin wrapper of the latter.
>
>  - using the repo_get_default_remote() created in the second step,
>    update the get_default_remote_submodule() created in the first
>    step to work in-process without a subprocess.
>
> but a bit larger granularity used here is probably OK.
>
[...]
>>  	strbuf_reset(&sb);
>> -	if (capture_command(&cp, &sb, 0))
>> +	strbuf_addstr(&sb, get_default_remote_submodule(path));
>> +	if (!sb.buf)
>>  		die(_("failed to get the default remote for submodule '%s'"),
>>  		      path);
>
> There is this line after the post context presented here:
>
>         strbuf_strip_suffix(&sb, "\n");
>         remote_key = xstrfmt("remote.%s.url", sb.buf);
>
> The LF was expected to come from the capture_command(), but it no
> longer is needed after get_default_remote_submodule() switches to
> use the in-process method.  In fact, the use of sb for the purpose
> of forming remote_key is not needed.
>
>     tmp = get_default_remote_submodule(path);
>     if (!tmp)
> 	die(_("failed to get..."));
>     remote_key = xstrfmt("remote.%s.url", tmp);
>     free(tmp);
>
> Yes, I think the new code leaks, and makes it impossible not to
> leak, the returned value from get_default_remote_submodule() by
> passing the call as an argument to strbuf_addstr().

Thanks, this was a good catch.

> Both of the two bugs pointed out here would have been easier to spot
> if the commits were smaller, I would think, but as I said, a bit
> larger granularity used here was still manageable.

My initial series had this patch split up similar to what you suggested,
but I ultimately chose to favour the larger granularity to make the
whole series a bit shorter. This patch definitely towed the line a bit.

> Thanks.
