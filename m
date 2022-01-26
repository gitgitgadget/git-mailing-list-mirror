Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45FC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 16:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiAZQfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 11:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243110AbiAZQfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 11:35:50 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB94C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 08:35:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id k9so285466qvv.9
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 08:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Q8T2KDY8LJMvD+gqIQ1bNci7zlT+sDJhVnila5JIGc=;
        b=KQUxMHA+bi5TGPEpB1MFYSvtY3ff73unQwS1G6SaF2pZkXCqxIfnhb2xx9If3CO+/b
         iiiuqt/233XucjFfVS+7jZ+HBELC2L74ttPxIKI6U5xh0W0+YkGpTIV1GjB3DKaeGRjq
         ICGwSSscl/5LFxoqfNkIMJn7R75aBGGuSUPndsoxYy8doXBj2L/NpIAxe/PhTPZdftJz
         ZFy5P++ZnlPrj75H+wm7gCwLhYO9PbXZLW/yCcwBkqVfVCxAWDVx56wDuAR+OzZJXTWW
         DBDQGEzX8/9/rzbRbhBgX3SF6dU9vyS0EnmwwD68qJtycpjbDlRuW/Fa0NzO3u2Acmiq
         0srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Q8T2KDY8LJMvD+gqIQ1bNci7zlT+sDJhVnila5JIGc=;
        b=7icRBCWE5uC5vMHfQo78zDqdqrlP0RM6eAh9s1KekYDQROf9UAba6cIvRsK25liu3u
         yArvDAMARhnsZf6SHfSor5vkq1VoeiFwMEiLIJgQWZ/q+tYaYhCeK99MrBDi8L1x8gwC
         96c9KSaNPcUTIgWlMbRlW5qzaboRKbHMbn75VRXGS+u5kHajTLQwn5eC4RR1upJHd5ZC
         mYO/SZe0TWVcCgoEtLCz0jx14L3iSwM6Jf6+a0AqbQLr7P0hHrQFNdbsFtRgPumX69cD
         kl1SQvG7Kd5bECECqLzIBuhPg2CpIa3hluLcmaCGhxSXcjoDaK1y5zwJWRMJPTNsJxww
         E+Jg==
X-Gm-Message-State: AOAM53114SkBcvN9jGJlofquy6SG6SfLpScCoS7ZltqU/Ott5tpS+SVe
        nx1GOy+rlTYC+xn9IXlHWND63wuMT2CjAtx1g1U=
X-Google-Smtp-Source: ABdhPJyGzQ9IJhlNmD/52FouyF8L9ePJQIDCshO4P2SJWXHvHpJsspTTnx7DGme8+814X5q/HtWLuhIsNZPwkrVvgME=
X-Received: by 2002:a05:6214:2a49:: with SMTP id jf9mr16548407qvb.121.1643214949744;
 Wed, 26 Jan 2022 08:35:49 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35lc53e9.fsf@gitster.g> <YfBTRuPrGGjepe+D@google.com>
In-Reply-To: <YfBTRuPrGGjepe+D@google.com>
From:   Atharva Raykar <raykar.ath@gmail.com>
Date:   Wed, 26 Jan 2022 22:05:38 +0530
Message-ID: <CADi-XoThCqfvPnBd0p6yAhrtotK_3z2pQQMugWPsYpHLbXge7w@mail.gmail.com>
Subject: Re: Submodule UX overhaul update (was: What's cooking in git.git (Jan
 2022, #07; Mon, 24))
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        gitscale@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 2:02 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> Finally finding the time to write up another "what's cooking as pertain
> to overhauling submodules UX" reply.
>
> [...]
> >  Rewrite of "git submodule update" in C.
> >
> >  Expecting a reroll?
> >  cf. <YWiXL+plA7GHfuVv@google.com>
> >  source: <20211013051805.45662-10-raykar.ath@gmail.com>
>
> Sounds like Glen is interested in this series with regard to some edge
> cases about cloning newly added submodules during a 'git fetch
> --recurse-submodules'. I'm curious to hear from Atharva about the status
> of this work :)

Hi!
I'll preface by saying that I haven't had the time to keep this up to date
with the other submodule developments.

My recollection was that this series had some small conflicts with
es/superproject-aware-submodules. The last thing I had done was to
rebase this on top of es/superproject-aware-submodules [0] and try to
fix those conflicts. I had not rerolled that branch as a patch series yet,
because I had thought that superproject-aware-submodules was still
in flux.

I won't be able to actively work on this in the near future. Feel free to
pick this up in case this patch is a blocker for yours or Glen's work.

[0] https://github.com/tfidfwastaken/git/commits/submodule-update-on-es-superproject-aware
