Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE202C7EE23
	for <git@archiver.kernel.org>; Mon, 29 May 2023 19:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjE2TtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjE2Ts7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 15:48:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1BB7
        for <git@vger.kernel.org>; Mon, 29 May 2023 12:48:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so3553312f8f.0
        for <git@vger.kernel.org>; Mon, 29 May 2023 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685389736; x=1687981736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GWHB/9KsnobkQbj3kTLC1q6GbFZiXXUZzkld+b1ZWZA=;
        b=U/8v4lK6eHEtcKxBaIRCbMG7n5RCB6QylcYQrtbZUeDDuD3JyaMEzGZNy/ghxwnyD+
         Jif8h7HaFf2YCPZ3BUOLbk8J3Q5qsthRVZQgpAurX3RTGJF7jldnHNM5AYMJ0SeVKj1j
         FINxjxlHJyZXCrC7dm9oBgyVCG6YcUe/mxydoostIfxQvnoq99UTXWw/nuWy5U/aO6hp
         OS/bqO25Uh2GzOuwOQ465R/E5OxXltJN2oGB+Qz61szYZ8mdMXHY/kuNTmoq7Y4tDosf
         LsxbCsj8XnBkLteM60UYTFqcCuerMrqQOe2bBFrCiPJ/9pEAtyMG1VpbHOAlUzFNB2FF
         EdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685389736; x=1687981736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWHB/9KsnobkQbj3kTLC1q6GbFZiXXUZzkld+b1ZWZA=;
        b=kS4CJBYMYRe27m8qZh2EGrRL1pqV0CdIj6JXr1NudBG7h9am0+i/12P/Lkh8A3PaNO
         tIKx55bzbbANJh87Wzlqz49Wf4q86FZaBdTiu4Oe5xKnEuSlT76Rh59viSnkA05xRa1b
         6rSq8tXEEQxJj8sl7+oALVvu8wlJ5lLxtlbuWBMH+Ma4Fe0Xmv1y5sLAoji6CUASBZ0j
         wJ7K+y5kIc78ji3yeB4i8SEv7tp2lkJ/lFtfPEFW9c+KQ3z038PPoD7GHSHbvBxCJ4G7
         Xprh8qRbLUgNe4FqJkBXyjB99rjBdzaP33iRZ2b1QAt4MaEJqURGvZtDnJYVDEB6kOSE
         Zn6Q==
X-Gm-Message-State: AC+VfDwtqGg94o3p+GV8OVllTlgx5Z+kwx/ZEHIPXlLRmgpw0oImdSKC
        q3znEAPplCSnps/+I03ncOs=
X-Google-Smtp-Source: ACHHUZ7XYsuEfwcFvY77roYfLdlt4iMT6wBurwl/fd9OFFrXxeBMrZ1TOma+2LxTC8k28ZLVuwzMiQ==
X-Received: by 2002:a5d:4644:0:b0:30a:eac4:26a0 with SMTP id j4-20020a5d4644000000b0030aeac426a0mr3276283wrs.18.1685389735932;
        Mon, 29 May 2023 12:48:55 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id j27-20020a5d453b000000b003095a329e90sm852256wra.97.2023.05.29.12.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 12:48:55 -0700 (PDT)
Message-ID: <cc93b0ed-1167-a017-2138-181a490d26e2@gmail.com>
Date:   Mon, 29 May 2023 20:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
Content-Language: en-US
To:     Paul Jolly <paul@myitcv.io>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
 <CACoUkn6F_=JR5SYBWL2sVDxDVAZbxcV5Ruif6wLba-_q_QNiZg@mail.gmail.com>
 <198eea19-fc40-de0c-8854-3cdc94925f32@gmail.com>
 <CACoUkn4TOGi7xojSatEowF0CcFJHJof+F5XR-QtPTL5iznZDKw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CACoUkn4TOGi7xojSatEowF0CcFJHJof+F5XR-QtPTL5iznZDKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul

On 29/05/2023 20:08, Paul Jolly wrote:
> Hi Phillip,
> 
> Many thanks for your response.
> 
>> I think you could get around this by using a script that wraps "git
>> rebase". Something like
> 
> That's an interesting thought. I will give this some thought, thank you.
> 
>> I did wonder if you could use a custom merge driver (see man
>> gitattributes) for the file with the checksums but that would be run
>> before all the other files have been merged. Another alternative might
>> be to use a custom merge strategy that runs "git merge-ort" and then
>> cleans up the conflicts in the checksum file. You can specify a custom
>> strategy by naming your script "git-merge-foo" and passing "-s foo" to
>> git rebase.
> 
> This approach with a custom merge strategy is very much closer to what
> feels like it will work best.
> 
> I just gave this a try, and I seem to be falling at somewhat the first hurdle.
> 
> I have a custom merge strategy working, insofar as I've written a
> script that is being called. The script simply wraps "git merge-ort"
> as you suggest.
> 
> But I can't seem to work out how to actually run 'git merge-ort'! I've
> tried 'git merge -s "$@"' in my wrapper script, but doing so my custom
> strategy behaves differently to if I use no strategy, which seems to
> suggest I'm doing something wrong.
> 
> Do you have any suggestions/pointers?

Sorry, I'd assumed there was a merge-ort command in the same way as 
there is a merge-recursive command but it does not exist. I think the 
best you can do is run "git merge-recursive" rather than "git merge-ort" 
in your script. I've cc'd Elijah in case he has a better suggestion.

Best Wishes

Phillip

> Best,
> 
> 
> Paul
