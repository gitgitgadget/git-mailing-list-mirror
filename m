Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ABAC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 19:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242195AbhLJTNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 14:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbhLJTNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 14:13:10 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E303C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 11:09:34 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d10so19771902lfg.6
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timining-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=imiX9l6rAZGH2tbVv3SQ0B8opPfxZzOyLoPN4RNhO38=;
        b=sjE+msNTO0uImIARoVCUVcfsAn3eulZI73ZazyUJKnh0czztFHM2o1QfFUipvebJjZ
         sLP5c5xvdZ9PzDOXK49WwEcx0o2cLlIHYxdP9gSaLhk/RVZiPW2BTnYiF7eJu5bCcmvc
         q84mhAV942YRQPEtsTB6q6JcOsRne1FbKAKbP6ZUA9AqmI5E0sPkV4peSYkj+ptUaLcA
         /qoYr/aLs2vM8ri3HjCpkfW/odas7Mgb2nhjBsrV5CJLK+SmcXOyKfMIaoLfLwPZVuGi
         Dz0aXrjOEFVzuYmLr1QIGVBQf15/PVL/XHX0n3u/XkfkwpmIvtLL+rAzRhd8FNQ+mpav
         Go5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=imiX9l6rAZGH2tbVv3SQ0B8opPfxZzOyLoPN4RNhO38=;
        b=6tKs+tVMI2ZFVxW+Gw6azxK6RIBUtZr4OQZvbxdS4+6DoOT8Ge63jglSi1R/QbbinI
         vapGF05WuMjMQFu921mOMmZWTp0HKWjlueyv9xM46pY+MNYJr+oiM69FvYUh1F3hbsbZ
         z/6iY4QYlkSSwCg0o3HQ6Nb8/9/6bFA6ZKB6SXbeQGJLgueJnaM5TCr0jRet9X9S6Qk7
         FhN+5M/B5Q7aSuSnW+tVm4MmAhE35zHEdU+Cv/73OFOBw4hmBBB4M7OO50sFfr2vHdGu
         W/kh+LPfEN25PjfARsSrVU/0Nd45ym1bqtH7Xr5NqgIeP2zeUYWHUdwp1w990Uw08UF5
         Bogw==
X-Gm-Message-State: AOAM531WjXmAlUUzFZKgO80whXCs76ef8RT9cqQ48xC6FMMArudAfqM6
        YTEF9S2PyagpNXrm1NC2m6ubzOMA4MTlhvJDbQMPAw==
X-Google-Smtp-Source: ABdhPJw0qprdL0VnMTFd93ykBVt6Q3OVCS0d/Vg+VDQ9onNTqJ9JbPIscQ0nX/vQB/fYYqiEleyCBoRcxufwdI0ySAU=
X-Received: by 2002:ac2:53ae:: with SMTP id j14mr13490345lfh.323.1639163372633;
 Fri, 10 Dec 2021 11:09:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:e346:0:0:0:0:0 with HTTP; Fri, 10 Dec 2021 11:09:32
 -0800 (PST)
In-Reply-To: <20211210164249.bahhe5ogjjhz4lxo@fs>
References: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
 <211210.86r1akbes8.gmgdl@evledraar.gmail.com> <20211210164249.bahhe5ogjjhz4lxo@fs>
From:   Jose Wielandt <jose.wielandt@timining.com>
Date:   Fri, 10 Dec 2021 16:09:32 -0300
Message-ID: <CAJrA3nKbUK=_5d5KTCDehrfge4y1aB9YGsFwQYNzUDWGcfog4w@mail.gmail.com>
Subject: Re: Please, paint new branch errors in RED (or any visible color)
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, I git switch has the same behavior.
I also agree that add hints could be a good idea.

2021-12-10 13:42 GMT-03:00, Fabian Stelzer <fs@gigacodes.de>:
> On 10.12.2021 17:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>On Fri, Dec 10 2021, Jose Wielandt wrote:
>>
>>> Hi community,
>>>
>>> At my work we've been struggling a lot with not realizing that our new
>>> branch creation actually failed, ending up with a push directly to
>>> develop. What are those cases?
>>>
>>> $ git checkout -b feature/solve p-eq-np
>>> fatal: Cannot update paths and switch to branch 'feature/solve' at the
>>> same time.
>>>
>>> What's my proposal?
>>>
>>> $ git checkout -b feature/solve p-eq-np
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++
>>>
>>> FATAL: CANNOT UPDATE PATHS AND SWITCH TO BRANCH 'feature/solve' AT THE
>>> SAME TIME
>>>
>>>                  YOU STILL IN THE SAME BRANCH ! ! ! !
>>>
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++
>>>
>>> ***(but in bright RED)***
>>>
>>>
>>> Another case!
>>>
>>> $ git branch feature/solve p-eq-np
>>> fatal: Not a valid object name: 'p-eq-np'.
>>>
>>> I'll let that one to your imagination but please, make it appear in
>>> red so we can easily (visually) realize that something went wrong.
>>>
>>>
>>> This has been the third time in a month we accidentally pushed changes
>>> to develop bc we didn't realize that the command failed.
>>
>>I think if we'd improve the output we'd probably add some "advice"
>>output, i.e. "hint:" lines, not ALL CAPS.
>>
>
> Adding some color for die/error/warning() in general if we detect a tty
> might not a bad thing. I have encountered similar situations where an err=
or
>
> gets lost in between `git log` output.
>
