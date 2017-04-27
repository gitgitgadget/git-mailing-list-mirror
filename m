Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6997207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 09:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032076AbdD0JOh (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 05:14:37 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35897 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032071AbdD0JOf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 05:14:35 -0400
Received: by mail-oi0-f42.google.com with SMTP id w12so30407220oiw.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 02:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ikXQsG+QmbgLWdPAEIpmQPMNKmoPOTVZT5JNP7+SmDE=;
        b=KWKkWwXhu1mY+9gQe6YwDaLJVYbakeYBviw7GLRgNGOs7DbHhkhdYAcjLVzti3W1ox
         BchNX/36M58rbHOpJGu0F2391cLXU3/TjyDr9FgdCT4inzG7twXhXlaTs2rw9Mjsv7Wb
         kzz8Nq8tAfYg1mX4KcYgBQar0wxIOnxcNt/2pSdVcF7JeojuNl0z4Aoy3y1+LK+2SASv
         rLogIQVqIBc7jypi6kUAhRVvUAC954/dq8zdYwmkNBf8QJYP7+2rs5zrhJTDzYsHL/kZ
         zykjC2pgiG9ulnymuuSuyOCHzOUS2tmeOuWdyLm4gM8NmlJfOTvGDvyYmiAFH+JM9gVT
         UvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ikXQsG+QmbgLWdPAEIpmQPMNKmoPOTVZT5JNP7+SmDE=;
        b=mmjrDcNd1FbmUy877lPmzyu03rsKFisHGN5qGcCPvQEIAojwxbwAMl3fUlv0Plb8U7
         oGBPfGOtj3W50EujQl+AWR55NNCP1lc8bWvmfK+sZEew9oNLWBPBAoWvvw+Er5VfAQi3
         zm/lxuYpNcYLGv+G4nPxScgRrQjooG8W9lXQtH4dLeH8EOby6GmRGJEs8R4NCHCjnway
         3tJYTy1dJd/Je8n87SOwnEVIP5MkwnnH5nJ9qKbCOjkT7a/3ukvIg5WHaOQHFpXHFFX/
         CflyoRdGiICpQCNEAXxlb8BzEeauuUfhMdXMuSqOrgMFtLr7NMBS0oXt+FrrDABYt1Xu
         wBMQ==
X-Gm-Message-State: AN3rC/7CUIGC/7a5JgMk0j+BKsy6mEHiAhRrmCG6JSP6TkEJ+jv/k5nm
        d66RdXOwHMjJZARu6XelCSXm6fxqhg==
X-Received: by 10.202.93.85 with SMTP id r82mr2232184oib.5.1493284474870; Thu,
 27 Apr 2017 02:14:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Thu, 27 Apr 2017 02:14:04 -0700 (PDT)
In-Reply-To: <4ef2fe61-720c-6227-11b4-4a6be24a4918@kdbg.org>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170420112609.26089-8-pclouds@gmail.com>
 <3a2686c2-6766-1235-001f-1b5283b5f408@kdbg.org> <xmqqwpa6pt0b.fsf@gitster.mtv.corp.google.com>
 <4ef2fe61-720c-6227-11b4-4a6be24a4918@kdbg.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Apr 2017 16:14:04 +0700
Message-ID: <CACsJy8C6_9YjgqdU7pnpUwpwreruk8bs-WeKnNtEPT7QL6RjuA@mail.gmail.com>
Subject: Re: [PATCH 07/15] remote.c: report error on failure to fopen()
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 12:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 27.04.2017 um 02:57 schrieb Junio C Hamano:
>>
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> +++ git ls-remote 'refs*master'
>>> +warning: unable to access '.git/branches/refs*master': Invalid argument
>>>  fatal: 'refs*master' does not appear to be a git repository
>>>  fatal: Could not read from remote repository.
>>>
>>>  Please make sure you have the correct access rights
>>>  and the repository exists.
>>> +++ exit_code=128
>>>
>>> On Windows, it is not allowed to pass a file name with an asterisk to
>>> the OS. The test case contains this comment:
>>>
>>> # We could just as easily have used "master"; the "*" emphasizes its
>>> # role as a pattern.
>>>
>>> So, can we replace the name with a simple "master", our would this
>>> miss the goal of the test case? Should we make it conditional on the
>>> MINGW prerequisite?
>>
>>
>> I would actually be more worried about the real-life impact of this
>> change.  Those who did "git ls-remote 'refs*master'" merely got "it
>> does not appear to be a git repository" and that was entirely sensible
>> response from the command.  Can Windows folks live with an extra
>> warning before it, or do they object to see that new warning?
>
>
> I was also worried that the new warning may be irritating. However, I expect
> that it is seen in practice only after a typo. My gut feeling is that this
> is bearable, because the reason for the warning should be obvious.
>
> Unless a use-case turns up where the pattern occurs routinely. We'll have to
> keep the eyes open. Until then it is better to keep the change, IMO.

OK I'll just add MINGW to the test then. Windows folks can improve
warn_on_inaccessible() to suppress certain class of error messages if
needed.
-- 
Duy
