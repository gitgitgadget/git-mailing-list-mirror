Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8092013C
	for <e@80x24.org>; Wed, 15 Feb 2017 01:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdBOB2k (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 20:28:40 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34143 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdBOB2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 20:28:39 -0500
Received: by mail-it0-f68.google.com with SMTP id r141so8420212ita.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 17:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/GohLMAzzB1W8lqZ1UpDbJFByBQLji/OS28vys/yyHM=;
        b=B8wzWXG8+Kqq4zALfMkUcasupJT1vs+RLsNJEvbf6Vsw8Efk60fRVDlh6s/oBqeiHx
         F5Ic4fnawszomiy9/IJPrYGiE4heKNiRMS8VDrqay73qWlWBtCo71TdQNnDmHXIZ1tcw
         wcsvzKgOSN0JPPgg+DPfpUOUmI61z2zXrCUSEGIJlu/tQ08Dqb3w9sHrS043dBio2pVj
         wAEkeke5eTEHCWzwfvyaL4g1Xj7v2kv5LNdWtsk/BgveUBZbzt2I3+chJng/8+fw8sqq
         W3KBReH3b1P+ZDrhjnR573jqJqp12pLP+EpngJooeIDsQlhxt8oCkLilPSbfJTdrV+fE
         EDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/GohLMAzzB1W8lqZ1UpDbJFByBQLji/OS28vys/yyHM=;
        b=TH0ZX7OLB5gABhyp61F/UY4+I4MAW3auJHBxwqqwka4wKSYm+cLsfuy3v8arc66FZH
         gkN2H6owksEEkXDEOs/XbO+mGtMOID6IiP+Jt8qzHl0njrbn9bqZ+wXhb3d/0kEi7kUh
         CCYxsucQvvVWia1eSlwkSsOxAKlRDhqN+ThKPIOPa4EriuzM09MMFnwxbQWPQ9xbMEoX
         4Z/Hzg9IbM2r8f2+WD+ajrQMShhvtj94lNI8rnTGyly29krSuwgoLpeL256PST3CBNAF
         c4Sx/DTAyxSwntv8bUaJI1WHmUsv14GcctfHvrpDYDsywr9iMuYun9R+5Mr/mMeWbMD3
         usUg==
X-Gm-Message-State: AMke39kvjDxweU9Jx9Pj/7trp/i9igq/bKv4e1Xf4xzYxpFYD7FHnekBgOjiksQyk06NgQ==
X-Received: by 10.84.135.34 with SMTP id 31mr39662493pli.50.1487122118071;
        Tue, 14 Feb 2017 17:28:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id 66sm3409446pgg.47.2017.02.14.17.28.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 17:28:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] clean: use warning_errno() when appropriate
References: <20170213092702.10462-1-pclouds@gmail.com>
        <20170214095449.15585-1-pclouds@gmail.com>
        <xmqqh93wabev.fsf@gitster.mtv.corp.google.com>
        <CACsJy8BXSAUr2knrkOfO0gXYAwQoJpL2hCXy44Q37H4GE_-yVA@mail.gmail.com>
Date:   Tue, 14 Feb 2017 17:28:36 -0800
In-Reply-To: <CACsJy8BXSAUr2knrkOfO0gXYAwQoJpL2hCXy44Q37H4GE_-yVA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 15 Feb 2017 07:49:48 +0700")
Message-ID: <xmqqfujg5jjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Feb 15, 2017 at 1:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> The reason to store the errno in saved_errno here is not because we
>> want to help code after "if (res) {...}", but the patch sent as-is
>> gives that impression and is confusing to the readers.
>>
>> Perhaps all hunks of this patch share the same issue?  I could
>> locally amend, of course, but I'd like to double check before doing
>> so myself---perhaps you did it this way for a good reason that I am
>> missing?
>
> One thing I like about putting saved_errno right next to the related
> syscall is, the syscall is visible from the diff (previously some are
> out of context). This is really minor though.

I agree that this is minor.

I care more about looking at errno ONLY after we saw our call to a
system library function indicated an error, and I wanted to avoid
doing:

	res = dry_run ? 0 : rmdir(path);
        saved_errno = errno;
	if (res) {
		... do something else ...
		errno = saved_errno;
                call_something_that_uses_errno();

When our call to rmdir() did not fail, or when we didn't even call
rmdir() at all, what is in errno has nothing to do with what we are
doing, and making a copy of it makes the code doubly confusing.

Rather, I'd prefer to see:

	res = dry_run ? 0 : rmdir(path);
	if (res) {
                int saved_errno = errno;
		... do something else ...
		errno = saved_errno;
                call_something_that_uses_errno();

which makes it clear what is going on when reading the resulting
code.

For now, I'll queue a separate SQUASH??? and wait for others to
comment.

Thanks.
