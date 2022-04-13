Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC22C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 17:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiDMRvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiDMRvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 13:51:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590DC6D3BE
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:49:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p135so2752484iod.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFmtuDl5TQoMSE59eERO37nn14d3rd96w++D6NuWTN4=;
        b=fjGFxggS2g94T7LSnKsqOZGfA3/ggfdI2abiXmGayQ//v7Itv8JvpI0So483/NS3Z8
         yZJV7uZQEjcV1OIH1Q3tf7/69GIPMQL2px5LuwpBGYGkM1oV64lqi/xSYbTAFUYPefYU
         qIw1fSu5xfTaI4qywH2MzXrmYVuAxnEok16pVuVqFbS55ShAKBTwHCj6SUh0zmAj/VI5
         XbxSjC97tBUG+4c7pWW7bC3F5iAjGFLWi6Eu1uUp7M9npw8iDImhF4FTHn5Ma/9MTmGq
         ip6wmQebTyHf0zeilYbzv0MNJbUgoffRFLMiFVAAqhi4nQdE2TuB/VBt0KW+sJ5RYimn
         qx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFmtuDl5TQoMSE59eERO37nn14d3rd96w++D6NuWTN4=;
        b=Ne9keVxB6XI1uMePbyayILSGT/ltEqaZiCiCWxNvhtuHw64BaUiMKl12Zy7W7ZFE8J
         qsBn4e842Oo8GA1tO5BDRopECH6cyuhXyr++2PLW1L4145P60LHJ+ZbrMbfMk2miWK0X
         qZZvY6WP3u5dCoEVipFX0dULGbEERWcy0r9+HtNR3tqUtU9KNqFIb8tdJCcLpkOY1KMW
         PnRcA5MwcSNc4km/fz2F9u1NAIjg9RVl+/wNEvdw1zB/UIW4qVGGGhb0fIwknOdAgmTR
         78mkM5u31tDkX+ZE7Zu1HMmT6OgxhT9htdjUVq6N6ucUI3jJ1aEUS28o24btrbpfLW1r
         BBrQ==
X-Gm-Message-State: AOAM531N5pSaLEDhDxQYMd3PDJgZdTZtM4NJOmvOwcdlFWKxRDoHM97d
        Ef3B8RRXmXD7aYhI8jtIAOanzIytmOyP6sGzrWGZ9TDh4hZCtA==
X-Google-Smtp-Source: ABdhPJykrVpO6uAVkLb78o1g7GOhufKPhP5BqwmZ/+HpMsB7qiqebmXpzUmlx8SYKTAbuG8wWpFzMpj5N32K9I22EfQ=
X-Received: by 2002:a05:6638:1384:b0:323:a81f:666a with SMTP id
 w4-20020a056638138400b00323a81f666amr22430114jad.39.1649872156851; Wed, 13
 Apr 2022 10:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <8735iglvxq.fsf@vps.thesusis.net>
In-Reply-To: <8735iglvxq.fsf@vps.thesusis.net>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 13 Apr 2022 19:49:05 +0200
Message-ID: <CAOc6etbheKZ9CYJ+6Chz9gDj1WGK_5hQeHYTmhOKiUtDd0RKtQ@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Phillip Susi <phill@thesusis.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 7:45 PM Phillip Susi <phill@thesusis.net> wrote:
>
>
> Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:
>
> > If HEAD and v2.35.0 share the same tree, it _should_ be possible
> > to recreate the commits that make up the range v2.35.0..v2.36.0-rc1
> > on top of HEAD without requiring any real "rebasing". Just creating
>
> Isn't that literally the definition of rebase?
>

Well, yeah. :-) What I mean is to skip the rebase _engine_. No
merging/cherry-picking/conflicts along the way of recreating the
new revisions. Say, clone the exact same revisions that we want to
_rebase_ and adjust their parents, nothing else (or little else, like adjusting
the committer).
