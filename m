Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7436C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 19:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbiBBTDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 14:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBBTDm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 14:03:42 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89999C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 11:03:42 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d8so495157qvv.2
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rnbdQOI20IiEpwVhe0Ych5hWodL9bzeB+L51zqGC0wE=;
        b=P6l6QpMyxKMt+O1FvwHSVh4fwWE3MRzUcnLSV/me2AurwvnE8/1q/QxT2VUTD6L11Z
         41agjFGgKhHDaLkX95JUs6Jtaicw/nyGmVrFSkb/9Q8/YGQ2+8xlmXrEJ2VUxoQSfMJ7
         mIdI5l2QxhMCO4Mavx76bpwIr6nMzjYQEE0U6YMtF5HsKm/RxudK2w4q5qDN/XDr5Iry
         dpKUaa6P94sc06IOFqGJuBewQXXyiElmDVT+tttcpMOcFLb7sNxL3MIr+KiQfCakV8iB
         /wqBlnOueDKxjLs0N/A5m2x2jOt2qOJcPElDTmyHIlgPTe3xh45ThxD1WbaM1xlgQkmx
         k8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rnbdQOI20IiEpwVhe0Ych5hWodL9bzeB+L51zqGC0wE=;
        b=4P8/T2hB5GNGL4TkoJKkByIPPyxx3kubd/8DMzPBySjxD+il941qyMbr76h1AQhFnh
         Yr1tPlwmIoA8RWk8xB6hPInrxT1J+Y3XeljU5DhHdWa8t6WeVCgVwnqCKe0LrTe7LZD3
         chOrT0ugBbRI3hPcMBPEsWg4m/2BwSxH/+LSi/HKuNS2mk+y0rR/gGMEradTyuKohruS
         sedmWimXe1dReBLvPK8JmM0seCbe/sFxwgUlMjk189nmw0HQMlht98yLlfyLqjPZw7Os
         WmvpMgXHDTV3Omj5LKOC0E8+9ixsnLlOqImgeWdEI46319UXsV2rD7t4Pf4DCoVwHJ4D
         ZM7g==
X-Gm-Message-State: AOAM531VDZ43KSHnEJFAHN0/waOb26uXVEx5rX1W0CjSAGUJZOf+aLSo
        rOZqBCEYhwFgcXNwz16vOZpo+wQCZeU=
X-Google-Smtp-Source: ABdhPJx73UMweZEavNTLpm7VUnhIHYBn5xGq06yj9L346u7huCnTaBKrHmQEKJuZK5HEryM6O5xCxA==
X-Received: by 2002:ad4:5ded:: with SMTP id jn13mr27236611qvb.31.1643828621363;
        Wed, 02 Feb 2022 11:03:41 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id y18sm5532383qtj.33.2022.02.02.11.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 11:03:40 -0800 (PST)
Subject: Re: New `--reapply-cherry-picks` warning
To:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>, git <git@vger.kernel.org>
References: <CAHMHMxUZpR8MBj+9mSb1Cr3PBCsAx=6zLo9mKpeD_ehqDP4nvQ@mail.gmail.com>
Cc:     steadmon@google.com
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <31e822be-b7c1-acb2-20d5-6db2200c3383@gmail.com>
Date:   Wed, 2 Feb 2022 14:03:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHMHMxUZpR8MBj+9mSb1Cr3PBCsAx=6zLo9mKpeD_ehqDP4nvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ntentos,

Le 2022-02-02 à 03:56, Σταύρος Ντέντος a écrit :
> Hello there,
> 

Hi !

> I have noticed the new warning that's coming in the
> https://github.com/git/git/commit/767a4ca648f8791c1fb623bd9f79fd8d7f026499

Nice archeology work. It's always a good idea when mentioning specific 
commits to CC the commit author (which I've done here).

> I am currently using the `[pull] rebase = true` option; and basically
> that warning is also coming every time I am pulling.

OK, that would mean either:

1- each time you are pulling, the upstream branch *did* get some of your
local commits somehow, so the warning is justified

or 

2- the upstream branch *did not* get some of your local commits, so the warning
is shown but shouldn't be, and that's a bug.

Which one is it?

> I have tried doing `git pull --reapply-cherry-picks`; however, it
> seems that the `git pull` cannot pass options to the underlying `git
> rebase` invocation.

Indeed, it can't. I agree it would be nice to be able to do that, and the 
same for 'merge', I would say. Right now a lot of 'merge' options are 
duplicated in 'git pull'.

> 
> I noticed that there is no way to "set" the `--reapply-cherry-picks`
> in the gitconfig options.

Yes, that would be a nice option to have indeed.

> 
> I prefer the rebase backend for the `git pull`; however, I see no way
> of doing "what I want", with the exception of:
> git fetch --all ; git rebase --reapply-cherry-picks
> 
> Which is two steps, technically.

Careful, as this is not the exact equivalent of 'git pull --rebase', as
the documentation for that option states [1]:

    If there is a remote-tracking branch corresponding
    to the upstream branch and the upstream branch was rebased 
    since last fetched, the rebase uses that information to 
    avoid rebasing non-local changes.

(see also paragraphs 2-3 of [2], [3] [4] and [5]).

> 
> Also with every rebase I am doing, I'd have to remember that.
> And it is probably not possible (by design) to do `alias.rebase =
> rebase --reapply-cherry-picks` - which I understand.
> (however, allowing aliases like `alias.x = x --cmd-opts` does not
> sound "so bad" with me)

Yes, that's considered "by design" that you can't alias an existing
command using the exact command name. That is to make sure that scripts
have consistent behaviour across users (other config options can still
affect behaviour, but anyway that's the justification I've read before
on the list). What I can suggest is using 're = rebase --reapply-cherry-picks'
and then retrain your finger ;)

> 
> Would you consider adding a configuration option for the
> `--reapply-cherry-picks`?
> 
> With regards,
> Ntentos Stavros
> 
> 

Cheers,
Philippe.

[1] https://git-scm.com/docs/git-pull#Documentation/git-pull.txt--r
[2] https://git-scm.com/docs/git-rebase#_description
[3] https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---fork-point	
[4] https://git-scm.com/docs/git-merge-base#Documentation/git-merge-base.txt---fork-point
[5] https://git-scm.com/docs/git-merge-base#_discussion_on_fork_point_mode
