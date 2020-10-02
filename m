Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C13FC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F7B206E3
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsVko+oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbgJBGPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 02:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgJBGPy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 02:15:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB3C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 23:15:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so222615pjb.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tvH446wV2pixLb0eJfcb6Y+12XL1PBBZ7ef3Ie8PdVk=;
        b=CsVko+oAZiWbSMWs+QBYCvLCSMUiOUGB9SGxVPbxPyQC6LbpnDphSEfUbIpCJgoeDe
         K0cDL2q8MFKU4EBmv4wigkotD46cem4589I8rTbkWshtFdRoAThQisc/QlcYBnQA+hUx
         yFGfidBcX9xhgj6y988+100dIAdm67ITHaq8WB/iqIugXoz7r5sazOC1z9fnmtLOI1K0
         mFR5/5nSawrM0rNwZSzWbP3GP3wNl6f0fTgV1wf3LBUA7EjyzM2i+5a+VBWBiQwQb+2y
         5ex7jnclkfCcbfp68AKfd3F1eCovX/alDCvE9KAwpI/thfX9J8vca/2k12wmR/KKWLES
         HLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tvH446wV2pixLb0eJfcb6Y+12XL1PBBZ7ef3Ie8PdVk=;
        b=f+FyX5DPtl/bnvXiyNFErAbHaQG6NQbtpJogN5XMhcbJ+GDZ32JXmytTU0x7V7MfmY
         0YaaNP9UmIxxmJ9AWZ5lSX0AiS+dWM4oACKmeVpAUD8Im0m1vW2J0W80oGfJpFreIGUB
         MZLY0/e7JGcl7XISxjjVRTpPe9fm34O/Ytp9oO3Y5okepBGXj/7omapLs6VxarK4193/
         4LS29Vd5S7BbdEKFdHUAwyuIeamTvpsNZMsn3TciU2Sxp/3sfzYmDdfMG2NrhqYqssFU
         mNbX0gQlKORaxMyxaKaqV1No8DAHqXGNMZmB4+m5ArC6cYb8Yp2SLTPpmfkeZU/g05/H
         MC1Q==
X-Gm-Message-State: AOAM532W4ERryxKmrIA5rOfamorTr2XXC6ElIl4VRxH1DOWaSRcjoiWi
        PIbOY9rXEOqhZPNxv6andz8=
X-Google-Smtp-Source: ABdhPJxDJAl+SFJZiy+E3Zf6uXuZQkGS9U4lbjdtzpYXLx8jpvqFYU8qiaqzul8A/jTfQz255NLwoQ==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr1118696pjb.20.1601619353470;
        Thu, 01 Oct 2020 23:15:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id j24sm471946pjy.35.2020.10.01.23.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 23:15:52 -0700 (PDT)
Date:   Thu, 1 Oct 2020 23:15:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
Message-ID: <20201002061550.GF3252492@google.com>
References: <xmqqpn62essa.fsf@gitster.c.googlers.com>
 <20201002060200.4073817-1-shengfa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002060200.4073817-1-shengfa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Shengfa Lin wrote:
> Thanks for the comments.

>>> +user.hideTimezone::
>>> +  Override TZ to UTC for Git commits to hide user's timezone in commit
>>> +  date
>>
>> One level of indentation in this codebase is a single HT.
>>
>> Unterminated sentence.
>
> What does HT stands for? I will change the indentation to 8 spaces.

HT means "horizontal tab", like might be shown with "man ascii".

Git uses tabs for indentation.  This file is documentation instead of
source so clang-format doesn't know about it, but I might as well
mention anyway: if you run "make style", then clang-format will give
some suggestions around formatting.  The configuration for that is not
yet perfect so you can take its suggestions with a grain of salt, but
they should get you in the right direction.

[...]
>>> --- a/builtin/commit.c
>>> +++ b/builtin/commit.c
>>> @@ -1569,6 +1569,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>>  	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>>>  	s.colopts = 0;
>>>  
>>> +  git_config(git_default_config, NULL);
>>
>> Declaration after statement is not tolerated in this codebase.
>
> If I use the DEVELOPER=1 flag in config.mak and call make again, would the compiler
> catches this as an error?

Yes, DEVELOPER_CFLAGS includes -Wdeclaration-after-statement.

>>> +  int hide_timezone = 0;
>>
>> Unnecessary initialization.
>>
>>> +  if (!git_config_get_bool("user.hideTimezone", &hide_timezone)  && hide_timezone)
>
> Is it unnecessary because I am checking the return value from git_config_get_bool so
> that the uninitialized value won't be used?

By leaving it uninitialized, you can help avoid the reader wondering
whether there is some code path where the default value is used.

[...]
>>             Instead, make sure it is set to some timestamp in some
>> timezone that is not UTC, and the timezone of the resulting commit
>> author date is in that timezone.  But that must have already been
>> done in basic tests on "git commit" that we honor the environment
>> variable, no?  Which means there is no need to add yet another extra
>> baseline test here.
>
> I am not sure if this test has already been done in commit basic tests.
> Will remove this test.

Let's see: *checks with "git grep -e TZ -- t"*.

Looks like t0006 tests various aspects of TZ handling pretty well and
t1100 includes of test using TZ with commit-tree (good).

Thanks and hope that helps,
Jonathan
