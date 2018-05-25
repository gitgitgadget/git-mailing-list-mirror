Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD4E1F42D
	for <e@80x24.org>; Fri, 25 May 2018 00:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972027AbeEYAz6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 20:55:58 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39532 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972021AbeEYAz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 20:55:57 -0400
Received: by mail-wm0-f45.google.com with SMTP id f8-v6so10083964wmc.4
        for <git@vger.kernel.org>; Thu, 24 May 2018 17:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vNSqYdemZXVoot07OqJZrqc73h84XXk5lcP6YTn/CbY=;
        b=miVIy+bkBhPcjxEOzXsBVYKdtUSv/Fhu/42DyvwMlWDjIq9abQjSJHnuO5Km96pht8
         KOcdeG5KjfgWaZB7iBwPRWNsCLzzkADIYoJ8hIuEUogVa1kNCdQu2VaicrzdrvYpeum7
         0wB1b55LWnVJWYtM1ILB3zNdUaHWpqYGZDM4BfJ+N6ERzBu9hEvgQvXF1wvIa2zbmIIR
         eyuImj1xZvZCg369at6zeCMFZCuH1vcH3fBEhoiGT7YWYFoOCMMefcsC8R0/3YEGBSV6
         FcCtXZ0/OaB0+MNXzj2xu/057YN9rxu03BPE1qmgMcR3KeIoU+6Ck7oxordUvhMr0wQS
         LUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vNSqYdemZXVoot07OqJZrqc73h84XXk5lcP6YTn/CbY=;
        b=EH89X2qqBsFgGd5/vFPDySUvV9tOk9SLQBtj4LKe/jiHNtCrg8gORaepWUNjShHPDq
         xWvWMxw9cbM+k6tX3oJxqf4035Xv3ZhyY6PFP01LzBWu9aA8vMGANoI2/lw4shFx8FiM
         2iimP97UP+Fi2Rmf9zEBiEMBdkoWY3IVZiJlU6BGAE0ppjxJch1SEgLxYdjYc5uSOGcx
         z41e52tNvRhsSHMr+9vxJrIyxLA6oHrtnJaN1g+MDOBeHWgUIjsDkT25xfWw9DzR33SS
         OAjqyid6N0iNK9rys3M3HVLkWeIFgGEEVjU+D4lLkns68gicUQSM2njJBlnSwolKMBpk
         hjmw==
X-Gm-Message-State: ALKqPweEcERCA84eRcQai5n7vXqslKyWMAsCwT+AV8G0r4I8APvwfNqA
        JTZV9txDFaNbbpGnXsvJU1A=
X-Google-Smtp-Source: ADUXVKLJB9UmOLfKzqjuVfNIupVkLcV5QnCE+ELXN9jOYcj2R3Dlf3Kg/winTG9E+Owan4UPz5zX+w==
X-Received: by 2002:a1c:8fd3:: with SMTP id r202-v6mr109332wmd.103.1527209755952;
        Thu, 24 May 2018 17:55:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v12-v6sm19124601wrm.68.2018.05.24.17.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 17:55:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git grep" and "working tree" vs "working directory"
References: <alpine.LFD.2.21.1805231434010.28811@localhost.localdomain>
        <CAGZ79kavmH5KVS2Byc5+Hg3dOvVwGD11KZ3yzZTLwp8Ok9ZDTg@mail.gmail.com>
Date:   Fri, 25 May 2018 09:55:52 +0900
In-Reply-To: <CAGZ79kavmH5KVS2Byc5+Hg3dOvVwGD11KZ3yzZTLwp8Ok9ZDTg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 24 May 2018 13:50:56 -0700")
Message-ID: <xmqqa7sor1t3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> There are 2 dimensions to it:
> * (where you are)
>   if you run git-grep from a sub directory of the repository, then the
> "sub-working-tree"
>   will be searched.

s/the repository/the top level directory of the working tree/, perhaps?

>>   also, at the bottom of that section, one reads:
>>
>>   <pathspec>...
>>       If given, limit the search to paths matching at least one
>>       pattern. Both leading paths match and glob(7) patterns are supported.
>>
>>       For more details about the <pathspec> syntax, see the pathspec
>>       entry in gitglossary(7).
>>
>> but, again, what if <pathspec> is *not* given? then what?
>
> Assume "$pwd/."

This is not technically wrong per-se, but I do not think there is
any reason to encourage it over just a simple "." dot.

>>   finally, the first example has the same problem:
>>
>>   git grep 'time_t' -- '*.[ch]'
>>       Looks for time_t in all tracked .c and .h files in the
>>       working directory and its subdirectories.
>>
>> in "the working directory"?
>>
>>   what is the proper terminology to be used here?
>
> the working directory sounds right, not sure which aspect you want to be
> exposed more clearly.

"The part of the working tree below and including your current
working directory", if you really want to be pedantic ;-).

But almost all the examples that show how to work _with_ Git
inspecting and manipulating tracked contents assume that your
current working directory _is_ inside a working tree of the
repository you are working on, so the above is equivalent to "The
current working directory" should be clear enough for most readers,
I would think.

