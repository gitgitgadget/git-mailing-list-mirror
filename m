Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72485C77B6C
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 10:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjDFKCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbjDFKCV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 06:02:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D8C2112
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 03:01:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so25228888wmq.4
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680775289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsyP4x6GZ/u/4FvKlk6dfrYbpqwSFMNv3zUXNq4BW9w=;
        b=NC6qbORD/Vpkj6CmlfonZaWu8C44QrnGpkx8UU0UyKUdIyZhyf5FpdrJ5CL7wzpdak
         rg8HQn2ZVoCfHLBhnrBoZEyewabXMEXTkySZLEiKiuEw+zUspS1S/TwGoj8kXJmfjUiP
         EyUSvmRPcXsIwsxA4PNXQJFwDSUDdoT2b94mxTQXvAyPtwpKfPr1fPNCHkd4kTiguD9j
         HClr6rEkT9PWzKIdW6iGXpUh8UjMJua5BDD+wnAlUlaAvnKa6wvf6ZTyycxfavCDL5YJ
         UXQo/ybSIwjnpmMN2wIWIXuVKeUvg2GwU0RovPMRTlHLUZfwBywPXBt4anf5vXqRl2pt
         sQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680775289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsyP4x6GZ/u/4FvKlk6dfrYbpqwSFMNv3zUXNq4BW9w=;
        b=27fP+Uwviqx7gfklBJOJH/9KzJyUevC5/5iWtV6FXbj1hQRBX2GeBV/p6L7QU73BFe
         TnvhwA1GDkI+d6+PeCAttZzvfYvpMzmV/P+ajbIVyXUniWB0cKQUjcHgbMb+989OJJB1
         CWVFiZSdg9FANXiaPEhjQvs+uoJLbltm+KR9+63n3kmnGtYGLZupuaS8W2s8CVLrjFTc
         ndI8o+BFi4OiI/VD9TFptNwrjdpImsBajkFZU6EYOGtf8JH22bg7xhRLVfOKNEZvPiLS
         XUoqbKo7kRzdMXjwsHUZ3673M3+vN0eznBWIwK+BBJW3qNaDsZnIpFyaQtW0OxwO3ulu
         rETg==
X-Gm-Message-State: AAQBX9esP0MZjOKsrwAxof9oCUFDnPcn02J/pBAw1YC1XhGO3X9y0zzB
        +nU70gLOM1/Q50wtQ82lGCU=
X-Google-Smtp-Source: AKy350Za6jchjOl1GPISh1sHSxDk8IgBZEIX6yCcfRBPbMACoXFzuuib/8bWO3KOUkskShtNkkX0qw==
X-Received: by 2002:a1c:7c17:0:b0:3eb:39e0:3530 with SMTP id x23-20020a1c7c17000000b003eb39e03530mr6239708wmc.41.1680775289404;
        Thu, 06 Apr 2023 03:01:29 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id y16-20020a05600c365000b003ee58e8c971sm1137055wmq.14.2023.04.06.03.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 03:01:28 -0700 (PDT)
Message-ID: <cfb0d0f2-dc82-885d-99d6-fa641b5a2923@gmail.com>
Date:   Thu, 6 Apr 2023 11:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] rebase: implement --rewind
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
 <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de> <ZCMRpnS9gzN1Rlbh@ugly>
 <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/04/2023 13:07, Johannes Schindelin wrote:
> Hi Oswald,
> 
> please do reply-to-all on this list.
> 
> On Tue, 28 Mar 2023, Oswald Buddenhagen wrote:
> 
>> On Tue, Mar 28, 2023 at 04:53:52PM +0200, Johannes Schindelin wrote:
>>> I do not think that the concept in its
>>> current form mixes well with being in the middle of a `--rebase-merges`
>>> run.

That definitely needs to be addressed, I'd be happy to start with an 
implementation that only rewinds linear history but it must error out if 
it encounters a merge and --rebase-merges was given. I'd also be very 
happy if we could rewind across merges by updating existing labels in 
the new todo list.

> [...] 
> What I need much, much, much more often is a way to redo only _part_ of
> the rebase. Like, the last 3 commits. And not from scratch, oh no! I do
> not want the original commits to be cherry-picked, but the ones that were
> already rebased.

That's what I want most often as well. Oswald's --rewind always rewinds 
to $onto but I think it does use the rebased commits in the new todo 
list. It looks like the new todo list will contain the commits 
$onto..HEAD plus the old todo list

> In other words, I need a nested rebase.

I can see the benefit in being able to checkpoint while rebasing but I'm 
not sure that needs to be tied to rewinding. For example if I'm making a 
change I'm not sure about I'd like to be able to set a checkpoint before 
that change so I can rewind to the previous state. I'd be happy to see 
checkpointing and rewinding added separately.

Best Wishes

Phillip

> Now, why do I keep bringing up this idea of a nested rebase, when such a
> nested rebase would not be able to perform a rewind as you asked?
> 
> The reason is that I am still very much unconvinced that `--rewind` can do
> anything that `git rebase --abort` and starting over cannot do. So: no
> patches required, right?
> 
> However, the use case that _immediately_ comes to mind when you talk about
> these rewinds is when a part of a rebase needs to be redone, in the middle
> of said rebase. And that _does_ require a nested rebase, and the
> `--rewind` would in most cases only throw away too much work.
> 
> Ciao,
> Johannes
> 
> P.S.: Yes, yes, I know, a nested rebase can be simulated via
> 
> 	git worktree add --detach /tmp/throw-away &&
> 	git -C /tmp/throw-away rebase -i HEAD~3 &&
> 	git reset --hard $(git -C /tmp/throw-away rev-parse HEAD) &&
> 	git worktree remove /tmp/throw-away
> 
> but that is of course not only inconvenient, but leaves too much
> book-keeping and safe-guarding up to the human user, e.g. to make sure
> that the `git reset --hard` does not overwrite uncommitted changes/files.
> 
> FWIW I simulate nested rebases in the illustrated way _a lot_.

