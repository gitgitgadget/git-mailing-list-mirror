Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874B4202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 22:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbdGFWjb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 18:39:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33907 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbdGFWjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 18:39:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so1985411pfe.1
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ki5yo9uefBO0wnWUf7HWc0akJyOJyz9gA5PceonKvzU=;
        b=A/cEi5YNJjBSgtRgRYBwsn/TDo1t5TetoNZrhC2Eg23vFfVKOk1D6BjpikrEXLHJRx
         7U1xCtM0ebFK6aNKXiJYFsxEJvGoL9rBC/3elzLNbCncr98Q8g2oVHIkySq+lFE9/Px5
         LsdbRgcCJiuM+1TM8j1gfi70T+aCaLpzGeNkSznfiY6k0VpILKyw3jjkKtAHVJYqrHPR
         j3Jahu7QnfUW9ziOUi0cvHRZ2/Gy8remmNrVwPcdBEKlvqJx+l5LDZC5J8ERkDtqq/B2
         zb3PBR4RULcc8NsSzlmmByvcVTfJhVZzLsGq4ny/herTIWZU9LFXW1HUG5Bq5JhXzdwT
         rAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ki5yo9uefBO0wnWUf7HWc0akJyOJyz9gA5PceonKvzU=;
        b=YpkQZjfq75QKPVZdFcL+YvbpOpqrXFPII/VFRPLP0SgSP/ZoDIaO4Lxme9rrxpcrRV
         3M+OApIElhdjJXkh6DBXjTrKeANob9in6APvi6SSpUqK/aNctM83tPJPNRKSHfYpC5S1
         V6WT6lrZm3sXR09u3KVyzmQK9ZWYfZLZfBXjflSfZ0VCPlfRFGom5W27YiUwFDNfSOWV
         4bdqc3EORQJ41jrNInFlG2uzD4c0CehRGsm9cVECtaBOokGl2HVVMwFOnn0v1em3uhRT
         4a8sml780LAwiI5GU38WWC8ZVKpUY3H6ZX4NbfOt91T/Y9PzxMzF2+G0cvjYqcerFa+x
         wO2Q==
X-Gm-Message-State: AIVw111inLEZ1tIdjo9/9V2dDZlM/BUdi3tl9U3KDsBYXx/d7xC3EB4Z
        OqMdAx3CU9MjRQ==
X-Received: by 10.98.36.19 with SMTP id r19mr27419955pfj.95.1499380758459;
        Thu, 06 Jul 2017 15:39:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id r62sm2645591pfl.45.2017.07.06.15.39.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 15:39:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Haller <haller@ableton.com>, Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
        <1n47so5.9e6qvf1bbqww4M%haller@ableton.com>
        <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
        <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
        <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com>
        <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com>
        <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kbCo3EjRGR_iE=6CJ2ou=4gMv3=t+s1ctGhUbZg8UDixA@mail.gmail.com>
Date:   Thu, 06 Jul 2017 15:39:16 -0700
In-Reply-To: <CAGZ79kbCo3EjRGR_iE=6CJ2ou=4gMv3=t+s1ctGhUbZg8UDixA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 6 Jul 2017 12:38:34 -0700")
Message-ID: <xmqqk23ldwbv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index 0a639664fd..1fa01210a2 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -212,8 +212,9 @@ must not already exist.
>>  +
>>  Note that all forms other than `--force-with-lease=<refname>:<expect>`
>>  that specifies the expected current value of the ref explicitly are
>> -still experimental and their semantics may change as we gain experience
>
> This indicates that this feature is not 'experimental' any more, but disabled
> (for safety reasons as described below). This implies we will not change the
> heuristic for push.allowLazyForceWithLease easily.

I actually wanted to say it was a failed experiment, but I see your
point.  Let's leave the "still experimental" label.

>>  test_expect_success 'push to update (protected)' '
>> @@ -78,7 +79,6 @@ test_expect_success 'push to update (protected, tracking, forced)' '
>>         (
>>                 cd dst &&
>>                 test_commit E &&
>> -               git ls-remote . refs/remotes/origin/master >expect &&
>
> This seems unrelated, so ideally it is a separate commit?

Yes, I looked for other things that may be good to fix while at it,
and planned to make a separate clean-up patch if I found enough, but
this was the only one.

>> @@ -91,6 +91,7 @@ test_expect_success 'push to update (allowed)' '
>>         (
>>                 cd dst &&
>>                 test_commit D &&
>> +               git config push.allowLazyForceWithLease false &&
>
> Here I thought
>
>     test_config -C dst ...
>
> at the beginning might be useful, though ..

I did not think test_config would work inside a subshell.
