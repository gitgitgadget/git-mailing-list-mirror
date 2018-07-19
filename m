Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2131F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbeGSXXt (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:23:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40998 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbeGSXXt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 19:23:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so9513112wrr.8
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MluJNY7uEw1cE592U9T/6Lr9T5PKIQXpyG3AC+qkQNI=;
        b=lKFxn/ewwXoNFeY9Yl3eTSMUShT7dYWxCwtG9QYrSYskxzPgjRT7O5z35HE1SPBoXR
         zSvKIcERdhLb1R5D2JgzBn3hDSn+pf1tOCbfFBzUGYjYRlxqKI5e3sHaIcNBx18A8sw7
         Rh3vxuKrCotOBPoTjS8fNFdyQxHymIEBwrjzeZTHUCKObIpSuCOBB2I+RinO4OjbhnYz
         3UEBjNYLA2eGL4nA5IAnHzUha3qQ+X5KxaUwRklVURadqrES/QaeaLDlQBTjwYN1ExR7
         xYi2KS3L2PAq/O+CnInf8qK9J6D+oW287lr84rff/8X84DpGGySprfGzSxXSA8ezetJ3
         EByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MluJNY7uEw1cE592U9T/6Lr9T5PKIQXpyG3AC+qkQNI=;
        b=CcrJ2LpVUJAWiis9XGWbXJ/iDR//ZRHNmjY8l/ROdNoloFYGLrBH7y/Pvhwr5xRvIN
         0ZlY1vF6QWU+Mv4qu970KlmRZ1LzoW2hnSR2g9maZrjnq3gW7z4a+tPy/Y9wE3O71j1x
         np+Loafppb7A7tFGYUK3GwVl6m+v3qGKLLEkkoGYI0F4GQzOe2Oq4okH0lnrDQoQnlIK
         M14kQrimkWP42dnl2SUF66CoU7YcxX7HrRNoqDKO97OQXxLt4oS+XyCgZy0quZQGJOGA
         nA1RUFMTIHE5KJsJUIrA0/Gjp6SrK7FFR29GiNM25d3NyeRL4bP4ar//tfKUkSgjvgZ5
         Yf7Q==
X-Gm-Message-State: AOUpUlFfn3oUkSZkG9Bn/uLTSzceTMsRnjqKH9GrkMNDnR8PNiV9/LAp
        z13t1MoXY9VeeIS53CXtmn+6oDb/
X-Google-Smtp-Source: AAOMgpeqcDBqwKcUax3QWfY2VGkSTka7yiEgs9+jd07X5v9f+0YBqV2MIC2iJxsZsGVb7rG4LqupNg==
X-Received: by 2002:adf:ae51:: with SMTP id u17-v6mr8337517wrd.201.1532039916703;
        Thu, 19 Jul 2018 15:38:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u14-v6sm612855wrs.57.2018.07.19.15.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 15:38:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        primetheus@github.com
Subject: Re: Find commit that referenced a blob first
References: <C00CED1F-D685-40E5-A5CC-4040BFD82886@gmail.com>
        <CAGZ79kbJnyRbeH8yMa=QaqNofA_Ek_SwmH5qRaCaq4cyQ26Kqg@mail.gmail.com>
Date:   Thu, 19 Jul 2018 15:38:35 -0700
In-Reply-To: <CAGZ79kbJnyRbeH8yMa=QaqNofA_Ek_SwmH5qRaCaq4cyQ26Kqg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 19 Jul 2018 14:19:34 -0700")
Message-ID: <xmqqr2jydf6c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Jul 19, 2018 at 2:02 PM Lars Schneider <larsxschneider@gmail.com> wrote:
>>
>> Hi,
>>
>> I have a blob hash and I would like to know what commit referenced
>> this blob first in a given Git repo.
>
> git describe <blob>
>
> If the given object refers to a blob, it will be described as
> <commit-ish>:<path>,
> such that the blob can be found at <path> in the <commit-ish>, which itself
> describes the first commit in which this blob occurs in a reverse
> revision walk from HEAD.

You walk from the latest to earlier commit (because there by
definition can be is no reverse pointer from older to newer commit),
and see if it has the blob, and stop when you find one.  Wouldn't it
generally find the most recent use, not the earliest use as Lars
seems to want?

>
> Since
> 644eb60bd01 (builtin/describe.c: describe a blob, 2017-11-15)
> (included first in 2.16.0
>
> You're welcome,
> Stefan
