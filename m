Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB02C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D29E206A4
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSaV3tl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgFHQDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgFHQDm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 12:03:42 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642CC08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 09:03:42 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o2so10111589vsr.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=9kxvBotqW7DaiKfNoOKmrMnfxk5n0iaANVhPHuN8720=;
        b=bSaV3tl1vgaxXd+UFGVvzoVxXumCLzzNvG2i0JJIrTB9y6sBQ+DVsMDA+xN5aggdtR
         gt0D1hSTCeLNy1YeBBjecM5Fwj2v9ulBzYXv/gO/M6qh3VbJRuSXjjzVNxQPh7CM8Vc9
         hdKFgRLTnGd8Z9aAk7WF+YKWbXQk8Ob0lYt/HFMqHKcpW2cP7NgAwZXwdtYxUbWOxDk9
         odPyGNgv5u6d/uGstAYCqWSurdppCxFYyyYSJvrXp3AG88i9jnxTQh1wt7YAAIEIzW6A
         yxbBcySrQ/Lr0Ip3Y+go6NEJH/LdvjzNnEp2eFmYNefXJXW1UIYGbLIp6w4wliPi3jNB
         igbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9kxvBotqW7DaiKfNoOKmrMnfxk5n0iaANVhPHuN8720=;
        b=hwohWJMxb4frO9+dln2jogjRE8UYxB/Xks9RgL7hDrXCHWdwFTT8wIreNuwhh5KTX5
         Qmh1Q7CWELdsaR6r8/uFjQ8oncbgbrC4EXnv9u8DFNpL6k0HqEJ4MTOP+/SZ7n+MtA3V
         d+dQrbbOyBsTVUvf/nsF+aJCii3Mrp6GDCkB73dD4WZC5r5YyCSl3tQA3UKlcvVEs77M
         Y+L36/FeCHRVmEp/x9p+qhMFaBBJZwmQps7v38ZntjGQfwo4bxY1Fl6Z52/85FhFvgUW
         ynKGX3Vy7CKwk7tUImLibqYvBnNQS0346RxMBGY/e/zImhuiUv6d6iD946DXRjhgNQDO
         c8Kg==
X-Gm-Message-State: AOAM5321eI30zfSgIDWB+gKtaKACDTJCPi8Cf7TKE8cuRRNg4jAJ1/f5
        tzz7kDu3DoodsswijksUeH70BOhn
X-Google-Smtp-Source: ABdhPJyxPuMJ7aQbQaJGDuF6DBOXWnF5TRnHqqTewyr6athuZ5OKV99vLw6yUT4V/73DH0LlMdlNUg==
X-Received: by 2002:a67:b42:: with SMTP id 63mr16193181vsl.182.1591632220984;
        Mon, 08 Jun 2020 09:03:40 -0700 (PDT)
Received: from ?IPv6:2804:431:d77c:2b47:2e0:4bff:fe37:ec7? ([2804:431:d77c:2b47:2e0:4bff:fe37:ec7])
        by smtp.googlemail.com with ESMTPSA id 44sm16423uas.3.2020.06.08.09.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 09:03:40 -0700 (PDT)
Subject: Re: Fetching a lot of repos
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <ef6f2275-536b-f4dc-9012-0467b1a4134a@gmail.com>
 <20200607210344.GK6569@camp.crustytoothpaste.net>
From:   "Soni \"They/Them\" L." <fakedme@gmail.com>
Message-ID: <62cee46f-d37d-0e51-143e-b2e9c10f5b0f@gmail.com>
Date:   Mon, 8 Jun 2020 13:03:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200607210344.GK6569@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2020-06-07 6:03 p.m., brian m. carlson wrote:
> On 2020-06-07 at 20:04:03, Soni "They/Them" L. wrote:
> > -----
> > 
> > [soniex2@soniex-pc multigit]$ git fetch
> > https://soniex2.autistic.space/git-repos/ganarchy.git +HEAD:repo_a & git
> > fetch https://github.com/ganarchy/GAnarchy +HEAD:repo_b & git fetch
> > https://cybre.tech/SoniEx2/ganarchy +HEAD:repo_c & git fetch
> > https://soniex2.autistic.space/git-repos/abdl.git +HEAD:repo_d & git fetch
> > https://cybre.tech/SoniEx2/rust.hexchat.hexchat-plugin +HEAD:repo_e
> > [1] 2236
> > [2] 2237
> > [3] 2238
> > [4] 2239
> > remote: Enumerating objects: 87, done.
> > remote: Total 87 (delta 0), reused 0 (delta 0), pack-reused 87
> > Unpacking objects: 100% (87/87), 36.06 KiB | 225.00 KiB/s, done.
> > From https://github.com/ganarchy/GAnarchy
> >  * [new ref]                    -> repo_b
> > From https://cybre.tech/SoniEx2/ganarchy
> >  * [new ref]                    -> repo_c
> > warning: no common commits
> > remote: Counting objects: 113, done.
> > remote: Compressing objects: 100% (74/74), done.
> > remote: Total 113 (delta 48), reused 88 (delta 38)
> > Receiving objects: 100% (113/113), 30.07 KiB | 138.00 KiB/s, done.
> > Resolving deltas: 100% (48/48), done.
> > From https://cybre.tech/SoniEx2/rust.hexchat.hexchat-plugin
> >  * [new ref]                    -> repo_e
> > [2]   Done                    git fetch https://github.com/ganarchy/GAnarchy
> > +HEAD:repo_b
> > [3]-  Done                    git fetch https://cybre.tech/SoniEx2/ganarchy
> > +HEAD:repo_c
> > [soniex2@soniex-pc multigit]$ error: unable to write file
> > .git/objects/d2/5baa9c0a78b0007a34a569b774d983b905f0b5: No such file or
> > directory
> > error: unable to write file
> > .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66: No such file or
> > directory
> > error: unable to write sha1 filename
> > .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66
> > error: Unable to find baf9414a35a2f48ed1b22644fd4522272fb4bc66 under
> > https://soniex2.autistic.space/git-repos/abdl.git
> > Fetching objects: 12, done.
> > Cannot obtain needed blob baf9414a35a2f48ed1b22644fd4522272fb4bc66
> > while processing commit 3f9f66712aaa071bd3bb32c46e1e4dc1fed13378.
> > error: fetch failed.
> > Fetching objects: 78, done.
> > From https://soniex2.autistic.space/git-repos/ganarchy
> >  * [new ref]                    -> repo_a
> > 
> > -----
>
> So when Git needs to write a loose object, it will create the sharded
> directory if it doesn't exist.  If it removes all of the objects in that
> directory, it will remove the directory, which is likely what you're
> seeing here.
>
> In general, I wouldn't recommend fetching in parallel, but if you want
> to do it anyway, I'd suggest setting `receive.unpackLimit` to 1.  That
> will result in you keeping the packs you've fetched instead of exploding
> them into loose objects, which will help this case.  It may not help
> enough to solve the problem, though.

That didn't work either, unfortunately. It was worth a shot tho, thanks.
>
> > So I figured, "okay this is a git gc issue", and started over (rm -rf .git,
> > git init) and turned off the GC (git config --local gc.auto 0, and that long
> > command to run 5 git fetch at the same time). At first, it seemed to work
> > fine, but then...
> > 
> > -----
> > 
> > $ git gc --aggressive
> > Enumerating objects: 365, done.
> > error: object file .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66 is
> > empty
> > Counting objects: 100% (365/365), done.
> > Delta compression using up to 4 threads
> > Compressing objects: 100% (357/357), done.
> > error: object file .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66 is
> > empty
> > fatal: loose object baf9414a35a2f48ed1b22644fd4522272fb4bc66 (stored in
> > .git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66) is corrupt
> > fatal: failed to run repack
> > 
> > -----
>
> It looks like this particular object is corrupt.  If you fetch with
> packs this should go away, but you'll need to find which repo it's from,
> clone it (without receive.packLimit set), and replace it.  Then run git
> fsck to see if you have any more objects that are a problem.  Anything
> that says "dangling" can be ignored, but other issues can be a problem.

So I can do parallel fetches but I'd have to check that everything is 
good and re-fetch what got broken? That kinda defeats the purpose of 
parallel fetch. On the other hand, the repos with no shared commits 
don't seem to cause an issue, but the ones with shared commits do. 
However, I have no reliable way of telling which repos have shared 
commits, as one can merge unrelated branches.

Another idea I had was to make local clones using symlinks (IIRC there 
was a way to do that, but I can't remember how to do it), do parallel 
remote fetches into separate local repos, then do quick local fetches 
sequentially instead. It's probably the safest way to do it.

Relatedly, but not relevant for my use-case: Is it safe to assume that 
currently git breaks if multiple ppl push into the same repo at the same 
time, and they have not-yet-upstreamed shared commits, in particular if 
they're pushing to different branches?
