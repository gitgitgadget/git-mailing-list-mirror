Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0570AC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 16:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA78D2176D
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 16:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujQDPeSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLGQVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 11:21:05 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35848 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfLGQVE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 11:21:04 -0500
Received: by mail-qv1-f65.google.com with SMTP id b18so1102940qvy.3
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 08:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MxT0F62tjHvZI9C173lq+3JzCqr7F0cMvOr/d9QmnWw=;
        b=ujQDPeSXe7cDEuaz1174sPMfJo4HbuCluk58rr9/tilRnOfNnfeWQKOmJcxg2lqUTt
         om6EMcrNiaUgWX78XYGJLgs5T53sSMLsOgGMb6wKwoxMsvrl9LzbysOpFbUbLJZ1PYvo
         f4edDVSYmPypeoD35+TiGSIeqddHQixYq5YQQyC6gJbTfNpjkAxWxeOfQbnMCJGQo0YK
         w3lCWkwFiL5+O5UMLBqkj4p17VwlniqnEXzMvnEoDQWleMs88HZ9wu3Bhal66tykqur4
         z8UUIoAxwO+4qgk6BZRtLzMvlQ9mBz+41+UGb4U5FVwUTH0Y/Y4sjDhampHebpq9kXMo
         mbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MxT0F62tjHvZI9C173lq+3JzCqr7F0cMvOr/d9QmnWw=;
        b=PlpZc2yBtJq2c4FRROTFDCQ0r275JvFOs/HJetkeedIMQNaufdN5TdU+u28Izsjvgc
         c1Nipw/3jeeKRlwQT1R4KAAuFO6NSoi5FweBtXSZ8xLjCvlo5ixspCx3aB0NV+6IIfOt
         JwQWE3Zw5a5LoOHXpGU9m4FL1PyeP1SEC2d/ZghSU6PWh8TPBs8WlW/0aDxnxJN6unMU
         FQ1Rh3TQ3JBYdbErvdiUOS0bmM68ZD+2OZeqT04EG/yTVHXpR4NnIa3elcv1cu7iI6eq
         Nroj+PL67NYRvCLwQz/yhfaAHAY4n5tI3GwgbmnLlrN3Bua1BZDkEJv9bL+G3eI5xu4x
         Rm4w==
X-Gm-Message-State: APjAAAUwSYG1Y483ZSL9HLUou6oT4P8sJqhTRov7o2EKtPSzTWcQ1l+s
        x4isAJQoVslFyGDVplZCvxvthK/I
X-Google-Smtp-Source: APXvYqxcz4IgHwh6jf92i2gLdAf1/+YUKBTcIzMnwuDLz5Nd7A1gsK2U53iyIIHbGK4rLnzdPuf7lA==
X-Received: by 2002:a0c:f987:: with SMTP id t7mr16309193qvn.90.1575735663492;
        Sat, 07 Dec 2019 08:21:03 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id k67sm6889555qkd.105.2019.12.07.08.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 08:21:02 -0800 (PST)
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
To:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207010938.GA75094@generichostname>
 <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com>
Date:   Sat, 7 Dec 2019 11:21:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/7/2019 2:29 AM, Yang Zhao wrote:
> On Fri, Dec 6, 2019 at 5:09 PM Denton Liu <liu.denton@gmail.com> wrote:
>> On Fri, Dec 06, 2019 at 04:33:18PM -0800, Yang Zhao wrote:
>>> This patchset adds python3 compatibility to git-p4.
>>> ...
>> Currently, there's a competing effort to do the same thing[1] by Ben
>> Keene (CC'd). Like the last time[2] two competing topics arose at the
>> same time, I'm going to make the same suggestion.
>>
>> Would it be possible for both of you to join forces?
> Yes, I do believe we are aware of each other's efforts. I had submitted
> an RFC patch set around the time Ben was preparing his own patchset.
> I have not reviewed Ben's first patchset as I did not feel that I understood
> the systems well enough at the time. I've briefly skimmed through Ben's latest
> iteration and it would appear the general approach is very similar, but there's
> more added abstractions and just general code change in his version.
>
> Regardless, I'm open to working together.

I am also open to working together, and could really use the help, as I'm
not a python developer.

I have taken all the suggestions from my first patch set and have reworked
my code and commits and will submit them now for review.  With the smaller
patches and cleaner commit messages I hope that it will make it easier
to see what I've done so far and what is still open work.

> Ideally, I would prefer we land something minimal and working in mainline soon,
> then further collaborate on changes that clean up code and enable more features.
>
> My end-game is to have P4 Streams working in git-p4, and maybe LFS-like support
> that uses p4 as the backend. It would be great to not be the only one
> spending effort
> in that direction.
>
> Yang


I have similar goals.  I would love to get the smallest set of non-breaking
changes in that allows the program to basically work with Python 3.5+.

My rush has been because I need to use git-p4 for work and have been 
working
on the project at the office.  Once I reach a point where I am able to
generally work (when t9800 is complete) I'll really not be free to spend 
too
much work time on the project, but I am eager to see this through!

As far as status, the last time I ran tests, python 2.7 passed all the tests
and Python 3.5 passed some of the tests.  I know it is not passing t9801
at this time and I'm trying to find out why.

So, Yang, I am very interested in working together.


Kindest regards,

Ben Keene


