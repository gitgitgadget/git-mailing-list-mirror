Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B915C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 23:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhL2XPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 18:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhL2XPo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 18:15:44 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E44C061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 15:15:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j6so91351156edw.12
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 15:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6JY1pn6b//1KttX7chIx0l/TJRmyUY6ziJWfTyZ4Fk=;
        b=XLB9YKsYygQg6LB8oi8bQL6X1968BjT6wS6mPmxSZUMnw9TfK3e6YQ6p3/xclCgWzu
         pgpXtxYnlaovNVZ/K1HX9zqTZgQe5fyXO/4AdhWK2SnBzlkLCY93APU6xill5Nv6qJRI
         /E0Ksb5VbB7b8OdZt+/0SzTxolns4kuQuD+e7AnHGOS9nb9CU6wdQ0KovqOCui8ZPwcM
         yY170EGCtvcOrJ2C5D1MFwy5KgrNOROLnPsy8hQC160hI1PKejsjLHP6q2H1GpP1GhiX
         mbQpFPERsVeIn1JAJJxeQ/ayaoCx+GjTR6kXrEofBs6Nj1CERfBA4+blfYR4yY+IYr98
         J0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6JY1pn6b//1KttX7chIx0l/TJRmyUY6ziJWfTyZ4Fk=;
        b=Wvxz3UXMRnUDnT96MCtqi3qb1fht5OhNTq+t2bLzv46mFRgp8dUEIgrKull26Ug2M9
         /usJ3KnM1BRR3XNtx4EbNwx66h1suiLA0+57h9wKCMWUT6lO4vLoodaX+91VDW2Tmi5B
         6+CrJdlT1EI0q/X6g/DHpddtp5AgGXMpJWckfL1qYBU5q4COl7/uJF69kGDUkcNqSVDH
         KOLmfNl9ZXSFqoGoSkLbuKGAeIy1unRKjBRaeWeW1pMXDPufCqilzSVcZqRK6ugg4WVT
         3mbSf3AVYnO56o85Zgxywce1SNJEGNELmBiy0NWvJIL7HQFXAa6Y4++qunyEmg9GK8Iq
         y9aA==
X-Gm-Message-State: AOAM533vqWcI2V6zlT9wRPhFP7fcrjKvb1FlphbnZ5DgLq+BlPVPIQMf
        QvDmOlMlMne9TpuKrwbAXS+sk9wuhqDqvu8UUdt/zR4z8mk=
X-Google-Smtp-Source: ABdhPJwvjxXkpBvfHDupnIUlQ1bAaVdQxEC+6Kn+/bO/6idWYpllgXrglLDMqTcyg2fqliqQGkvGpgdCX7Bg1WARjJ0=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr23467505ejc.476.1640819742970;
 Wed, 29 Dec 2021 15:15:42 -0800 (PST)
MIME-Version: 1.0
References: <CAC4O8c-2sxHyAjtd4jZQcjzX4d9+19AUx-h13nttjwP=pd1Ukw@mail.gmail.com>
In-Reply-To: <CAC4O8c-2sxHyAjtd4jZQcjzX4d9+19AUx-h13nttjwP=pd1Ukw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Dec 2021 15:15:31 -0800
Message-ID: <CABPp-BEQdpO5=j_f2MjgZjhudNZgKhDgV31M_Cy6Agx_U=KweQ@mail.gmail.com>
Subject: Re: something like git-check-ignore but considering only patterns?
To:     Britton Kerin <britton.kerin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 12:54 PM Britton Kerin <britton.kerin@gmail.com> wrote:
>
> I'd like to query if a file e.g. symLinkToDir/foo.o would be ignored
> if it were in a real dir instead (don't ask) but in a general way and
> hopefully without parsing and matching all the .gitignore entries
> myself.  Is it possible?

How would that even work?  If there is just one gitignore pattern and it was:

    build/*

And you tried to ask (making up a new `--patterns` flag):

    git check-ignore --patterns '*/foo.o'

What should the command return?  True?  False?  It kinda depends on
what that '*' actually is.  If it's "build" then it's ignored.  If
it's not, then for this example it wouldn't be ignored.  So the best
answer we would be able to give is "maybe", which isn't particularly
useful.  Also, typical cases will be much more complex than that.  So
we can only answer whether specific paths are ignored, not whether
various globs would be.
