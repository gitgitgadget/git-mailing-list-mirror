Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85144C5517A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F27022202
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASKnyemJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgJ1Bie (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 21:38:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50877 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833074AbgJ1AGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 20:06:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id 13so2965145wmf.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ow5uyOR/zpDmplmlW2dk8e5QpR63o2hZWI2pSUpQvLs=;
        b=ASKnyemJoYK3mPPajTGKyqo1LIJfgrMf9de7sP32GphUzCQFZYlreGuIUH9gYK3S1n
         MmIkUiNp4muvPbUUE84CIqGg1KUgSTOVO4QyOV6jgubD11ColoYW35PewtTdnP4GGL9R
         MBM9aHlbQaGOFtf/vRVozfcCEIMECv677hbKzat+qXCfkgeVNuW+8hbtTXcGD/hpeJev
         3+kUbit/aPsLJ0ah7+mBXkx7z7qNOKAZld4zoJZ4zLw4AkW3/ooT74oiaY6nocHFO8M9
         WwdY4TDTdJfH0tbjRz+1fX89Nz1MBzSUrLLX3CKWu5D2q0umk/gZotVK2OUDHIAlvT8P
         GBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ow5uyOR/zpDmplmlW2dk8e5QpR63o2hZWI2pSUpQvLs=;
        b=bGWm9rMl5FSK1xEZcVtim5RvBhsxi6oTR5vPOAz0K0bIwCN7CT5fOknpdRy982mnCm
         Y9uWy7aXZtYA36dcoq7oljgX2ybLPUXt+EUxdjIW7vz4o6QeMkLrVmzX/mVulWyyXDB2
         ziQnZwLCUZ230J5t1FT1KERVuqlIhfgAEpD4yCIShx7PA0sBHrqOMVWb8Ca0oWWnMknk
         8S+KMQEtvanLiSDR+P+K7oTXaPHxsZpp/llM/Z7DgFcgjQUobiPpsC4Gh/yWmY4la3/y
         pKMBRfeDoYt9lc7Y4myvXBQ5DAqF+6l/hbaEJ93QRRMnt5zGDO8AIVMEgAf2ECDtxVLU
         /Clw==
X-Gm-Message-State: AOAM532XZ9vyGx5rzaQ4NZRR8xyL9/bD9YlfYfbjzYn6tjiSjdPC3vym
        rmsqdjMuoAb9SMqhLekrhaflUcMFnq9MRB2Kz3c=
X-Google-Smtp-Source: ABdhPJxqAPP5sCDVSsWXImZDXL8BaKtyosjuN7KBjXb4JPs4PZremS6HObMAAjLolLTi7DWjjlKjl2RjxhwS1WFWwy8=
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr5352807wma.100.1603843595561;
 Tue, 27 Oct 2020 17:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 27 Oct 2020 18:06:24 -0600
Message-ID: <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> >> (they will get
> >> their zsh/git completion from their distros---I am assuming that the
> >> distros get theirs from us in contrib/completion/).
> >
> > I don't know of anyone that relies on the zsh completion shared by
> > their distribution.
>
> Hmph.  If the real users don't get the completion scripts from their
> distribution, is there still a point in having them in my tree?  You
> are certainly not suggesting me to remove contrib/completion/ at
> least for zsh part, but then it is unclear what you want.

I didn't say the users didn't get the scripts from the distribution, I
said I didn't know of anyone that did. I just checked the installation
instructions of Homebrew, and they do seem to install the zsh
completion from contrib, whoever, by the time I see the bug reports,
those users already downloaded the most recent version from GitHub
[1].

On the other hand my distribution (Arch Linux) does not enable the zsh
script by default, it just lies dormant in /usr/share/git/completion,
which nobody uses. So users in Arch Linux naturally would download the
latest version from GitHub [1] as well.

So, which distributions package and enable the zsh script by default? Who knows.

I suggested you to graduate those scripts out of contrib so
distributions would trust the scripts enough to enable them by
default, but you refused.

What you do with the scripts is up to you, I only know what would
happen depending on what you do. 1) If you leave them as is, some
distributions would enable them, others don't, and people will keep
downloading the scripts from git's GitHub [1]. 2) If you graduate
them, more--if not all--distributions would enable them by default,
and less people would download them. 3) If you remove them, people
would look for another git repository to download those scripts from.

> Are you saying that by adding the latest and greatest, these real
> users who so far couldn't rely on distros now can start to do so,
> and we'll make their life easier by updating the 29-patch series
> (which I presume is the v2 of this 14-patch series)?

No. Many of them will keep downloading the completion from git's
mirror in GitHub [1].

Unless you graduate the scripts out of contrib.

> In any case, some Zsh users, even though they are not active
> developers for the completion script, may have something good to
> say, now the 29-patch series has been posted to the list and queued.
> I didn't look at the zsh part, but I didn't find anything glaringly
> wrong in the changes to the bash completion.

That's great. Although I have v3 already, since I found a couple of issues.

I'll send those.

Cheers.

[1] https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

-- 
Felipe Contreras
