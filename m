Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B77C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 00:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhLJBBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 20:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhLJBBq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 20:01:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E61C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 16:58:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so24605925edq.7
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ELqTtZOrWAHct9GB6blgHoDBTmgRCwdKaoNFA4ci5nY=;
        b=Yv+58WlXNbrCv/SGt3e66S78oBke0JtJNDFNTqY0aLpJYFkpL2+Ysp3KPJx5C51zMm
         sw7SRZiM5e2DOg7ZTJ8TxhTBCfv1yV3QW/VzlEKzsol5147MkQkDu2Vr+oUiwYe4f1Lp
         qNee55R/+pAow6V41QvJLAPHbUkW3jDAxgk0lcCu5VkrVnqi3aYwqW151p8zX2EhtRsG
         B8KaU4kqeZyzZGUBSVIyrFfFvXI83YZhhGACaJMA+tFKrrcs4QJWnPyijmjac1FMmojn
         +K7pAEdWBF3GIuGJ371SUq1nrs5jkpTnQX69YBrusVpc9tn5CFepf5oXQCKyfsKS6sYj
         gSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ELqTtZOrWAHct9GB6blgHoDBTmgRCwdKaoNFA4ci5nY=;
        b=XHE0iqADPVldtrwsCM6bTehP0TiATNeLlJT8UTvKxIPIgElPRv6Eu+eoHuNVUgTTNR
         N0ZHxFcOIrbvpx0dPW/SHDv+6xtAq/pAJvBjQ1PXI13j8R0Hzn+E1SS+3WAgRzheRUiK
         pORda8W6UT1iYTwTBmS/h0dyQu2ep6av8qLcaPINeWfKm5kFE586SSH4uSrFRTjgVDkD
         OpDB6mkc2oNZsnspdk7eUSiLIhpuuUD8Qee7yABLDTOlVg/n/2dZurZGY8JuIQFLPSYO
         z8PELf43d1TlEJEJZ7/fnWBeudX3N1hyHFH1w5fyGvClMFmA61YUgp4eZL613TgVvBz/
         YEAQ==
X-Gm-Message-State: AOAM532XOYSVjD4H+m5WSX2W9D7+zL9L2Wpja5tvrumylPjyn5R23w2Q
        KU9W78+PuD7EuWhoNiK6VFzwkgRPHQ7ysQ==
X-Google-Smtp-Source: ABdhPJzIB4PRc4hBblsY0gt2UsDfI5CdML8uIssCfK6GffQWKHU4xVhOmZoBRg+7P7cmvEYjBJ4CKw==
X-Received: by 2002:a17:906:7198:: with SMTP id h24mr20102120ejk.59.1639097890485;
        Thu, 09 Dec 2021 16:58:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ch28sm603604edb.72.2021.12.09.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 16:58:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvUEh-0007FE-OV;
        Fri, 10 Dec 2021 01:58:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Date:   Fri, 10 Dec 2021 01:48:23 +0100
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211209201029.136886-1-jholdsworth@nvidia.com>
Message-ID: <211210.86r1ale0o0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 09 2021, Joel Holdsworth wrote:

> Python 2 was discontinued in 2020, and there is no longer any officially
> supported interpreter. Further development of git-p4.py will require
> would-be developers to test their changes with all supported dialects of
> the language. However, if there is no longer any supported runtime
> environment available, this places an unreasonable burden on the Git
> project to maintain support for an obselete dialect of the language.

Does it? I can still install Python 2.7 on Debian, presumably other OS's
have similar ways to easily test it.

I'm not that familiar with our python integration and have never used
git-py, but I found this series hard to read through.

You've got [12]/6 which don't make it clear whether they're needed for
python3, or are some mixture of requirenments and a matter of taste (or
a newer API?). E.g. isn't the formatting you're changing in 2/6
supported in Python3?

Then for 1/6 "pass cmd arguments to subprocess as a python lists" if
it's not just a matter of taste can we lead with a narrow change to the
new API (presumably we can pass to our own function as a string, split
on whitespace, and then pass to whatever python API executes it as a
list first.

Some of these changes also just seem to be entirely unrelated
refactorings, e.g. 6/6 where you're changing a multi-line commented
regexp into something that's a dense one-liner. Does Python 3 not
support the equivalent of Perl's /x, or is something else going on here?

You then change the requirenment not to python 3.0, but 3.7, which
AFAICT was released a couple of years ago. We tend to try to capture
some of the oldest LTS OS's in common use, e.g. the last 2-3 RHEL
releases.

We still "support" Perl 5.8, which was released in 2002 (although that
could probably do with a version bump, but not to a release to 2018).

I'm not at all opposed to this Python version bump, I truly don't know
enough to know if it's a good change. Maybe we can/should also be more
aggressive with a version dependency with git-p4 than with something
more central to git like perl or curl.

The commit messages could just really use some extra hand-holding and
explanation, and a clear split-out of things related to the version bump
v.s. things not needed for that, or unrelated refactorings.
