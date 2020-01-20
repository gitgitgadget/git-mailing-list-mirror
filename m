Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C9DC2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D7822314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+c8Sxqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgATRJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:09:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33286 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRJw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 12:09:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so284366wrq.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5zTYATfusYEcgOQ9564/vPVzd7OutcRE3RFL32K5zZY=;
        b=a+c8SxqjhL8vUzv05HiI8rfsnggCerc+q6TUGwwLYme41QcjVXiE7uDfhUDICdENe4
         +QSCG/znZYqLP0b7T+anfgkpcn/BzXLhCEWNI+jKR6hmQZWTOjVssDYms9AkmDE2SrLi
         iXseeYvsn3YsbLMQ4UsemfAFpXy3fiigjtYcGA1NF6UTO0KipRgbgYwpMTlrhZkOmcsk
         jZ4FmY+fzCGz47up8dVncN1rjTE+F+IkQyavxkXQjXlFcKWqHg5soZ87e3rcRqVxjcoV
         OHvK1t18EEfzNEI+kr+NA4a6rmhuEz4MUI2nBqQcqoK+MsUD8nNQSGL6rRBxdq245HvT
         +aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5zTYATfusYEcgOQ9564/vPVzd7OutcRE3RFL32K5zZY=;
        b=H9mvcbn/x/hVNfyA/GKXHpb55FLHK4TIN2RQwulzEu2KdOj1mNcWpH+Zv7xdQJQJf4
         eo9noYLZlhaTSol4+8MEpdjWQDOvALFYKF20Eqb7OZKke/DwvPTPbWhoL9rTc/I/PSc7
         pc+E7gjcoRgaHTnenE3XHE5Ld28TC+YvnHrbhDdW18urutIJ7m95OC3fM/DOCK1v9iNA
         npat6F2qMY58WVdpac0I1CvNh6CkmsFRYy5qCceZUEZ/uV5dOkPaTGgvSXHGSbQ8s9M2
         Ge+2yY/Wa0BepElJKx8NykwGcE+PSV/OGeJtUgGKkopM4AmfWL1tzNxX/KF1+1+z0YcD
         nORA==
X-Gm-Message-State: APjAAAVMOIETxyzNjnNIV3hOXn2MqjuBPchLF9FJl5MtkKXSr0vkgnfS
        FNWBwJ+He2GTAEQRNqctc+E=
X-Google-Smtp-Source: APXvYqxGlszEg+raJhtvKx4c9h1d+KtrTJ/WOzR53+5rIHzPJegpl/3lnJ7kxIExasWlDaTCOmtdIw==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr424804wrt.381.1579540190183;
        Mon, 20 Jan 2020 09:09:50 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-19-5.as13285.net. [92.22.19.5])
        by smtp.gmail.com with ESMTPSA id z8sm47578222wrq.22.2020.01.20.09.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 09:09:49 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] commit: replace rebase/sequence booleans with single
 pick_state enum
To:     Ben Curtis <nospam@nowsci.com>, git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, phillip.wood@dunelm.org.uk,
        Ben Curtis via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.531.git.1579268705473.gitgitgadget@gmail.com>
 <17b57e7f-7f3c-abab-1da6-d2e5c9ff893d@gmail.com>
 <bb0e232924305697596743d3fa93d5bf3b0e8d4d.camel@nowsci.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <bfe569ea-93c7-382f-18fe-d81d8f9cbf4f@gmail.com>
Date:   Mon, 20 Jan 2020 17:09:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <bb0e232924305697596743d3fa93d5bf3b0e8d4d.camel@nowsci.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben

[Cc'ing dscho as it relates to issue management on gitgitgadget]

On 18/01/2020 16:34, Ben Curtis wrote:
> On Fri, 2020-01-17 at 20:01 +0000, Phillip Wood wrote:
>> Hi Ben
>>
>> On 17/01/2020 13:45, Ben Curtis via GitGitGadget wrote:
>>> From: Ben Curtis <nospam@nowsci.com>
>>>
>>> In 116a408,
>>
>> That commit is no longer in pu, it has been replaced by 430b75f720
>> ("commit: give correct advice for empty commit during a rebase",
>> 2019-12-06). There is now a preparatory commit 8d57f75749 ("commit:
>> use
>> enum value for multiple cherry-picks", 2019-12-06) which replaces
>> the
>> booleans with an enum. I need to reroll the series
>> (pw/advise-rebase-skip) that contains them, if you've got any
>> comments
>> please let me know.
>>
>> Best Wishes
>>
>> Phillip
>>
> 
> Hi Phillip,
> 
> Thank you for the feedback, I assume that means my patch is no longer
> required?

Unfortunately yes

> Also, is there a formal issue assignment method with `git`? I hopped on
> this particular issue on GitGitGadget to get my feet wet here but was
> not sure if there was a separate maintained list to track overlap like
> the above.

Unfortunately there is no formal issue management. There is the mailing 
list which is where patches are picked up but it does not provide any 
issue management. In practice when an issue is reported on the list 
there is either a fix posted relatively quickly or someone notes it down 
somewhere and may work on it later. There is a convention of adding 
#leftoverbits to an email in the hope that someone will search for that 
and find things but I've never seen someone reference that when 
submitting a new patch and if the fix comes in a different email thread 
then there's no way to see that the issue has been fixed.

There is gitgitgadet's list of issues but not everyone uses it (and it's 
only triaged by a small subset of people so there's no guarantee that a 
feature requested there will be accepted once it gets submitted to the 
mailing list). If someone posts directly to the mailing list then they 
probably wont see that there is an issue open there. Further confusion 
is provided by https://bugs.chromium.org/p/git/issues/list which has a 
different list of issues.

The best thing would be to check the history of the 'pu' branch before 
starting work on an issue to see if it has already been fixed.

I'm really sorry that you've had a bad experience, the idea of the 
gitgitgadget issue tracker is to make it easier for new contributors, 
not to waste their time. I hope it wont put you off making another 
contribution.

Best Wishes

Phillip

> Thanks!
> Ben
> 
