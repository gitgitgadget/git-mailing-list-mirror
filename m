Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9552B1FC96
	for <e@80x24.org>; Sun,  4 Dec 2016 10:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbcLDKr0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 05:47:26 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34982 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbcLDKrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 05:47:25 -0500
Received: by mail-wm0-f47.google.com with SMTP id a197so56162273wmd.0
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 02:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RIGRYL1auhXfJLnQW9JgnSYIM1wZu+69jyeeAX9nbJM=;
        b=mvHc5sH/F/GAswaval8lm6zT0FSosNQ5G3qzLOtJPz62xd4RYHoEYkvsRfSArff+KC
         wJ+GehDuXOBSW+mqIHiOuch1asqNqmr+Rd7gZgigVE8Q8SsK69Bw8RXFNJJnYcpMJX1c
         f0J0xa5RQgxKiutz6IbHucOedRj2LP0+8z6hgbUExinfo8yftuJIFtbYAhHiNVJogOX+
         5kDUm+ug5oYDKZF2eJ4knFq5tOwDDnohiiC+U+yRNm9YNeqFBWS0Ba9YZDO4giWQv4E7
         9r+wpxD+uQDCYw8WP1BCELUJjVbTW69yyQAHFHocO4u/vKmirDGDYfumao48c3Yahhr6
         ycYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RIGRYL1auhXfJLnQW9JgnSYIM1wZu+69jyeeAX9nbJM=;
        b=f+ZOk/V6DRACUTb72gmP25Ergv5q0q757jYpTixZ8wnZ6AyMKCnoTSPBrEqWUvTAJv
         mYz7h32FPDyhBNdiAc0W5sCRiyuDSR8CspEiezdR01yoieMcr8vWyvPDxVIggzKXMrtY
         Alo/MtHCt3mjRmCo8HZ4iCYAnJtih4df918s4ddL2mG/S0R69NDxoK6nsZbL2IczerRY
         iVkVq9TixccztXsLPxLtq5wCpZhx5CkyQ75rZnVBGZTtsVHBwZCwCnbl5U1ZSkDOhwQs
         64/fXwuDeNUsg4iNrnQ7CQdjNwr9BVZa9MpVOsLw9OHHM59gCaiO8A5ZlA/+M6DeM91+
         APJQ==
X-Gm-Message-State: AKaTC016Vu7iVsgH8uCtKyMGxdVOHodllOZgDGbYVyzeSKg1SDJKY5ZjOEew6ox254pQ6bFZYa8XGQcFi2ZuCA==
X-Received: by 10.25.209.73 with SMTP id i70mr14277854lfg.24.1480848443713;
 Sun, 04 Dec 2016 02:47:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Sun, 4 Dec 2016 02:47:23 -0800 (PST)
In-Reply-To: <CAJZCeG0p5UrqM4oSOJ1ALKqNG8SyYh8cexKaN9R6RYYzPsMfxQ@mail.gmail.com>
References: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
 <CAP8UFD0ipS_4p+njfbbDGpYSDJhp43e9XDP69MOruZz9c136ew@mail.gmail.com> <CAJZCeG0p5UrqM4oSOJ1ALKqNG8SyYh8cexKaN9R6RYYzPsMfxQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 4 Dec 2016 11:47:23 +0100
Message-ID: <CAP8UFD2rsxjmmVnPBmDFDx_-+Xr12wqGRqOMuMfrnu_ReSCm1A@mail.gmail.com>
Subject: Re: git reset --hard should not irretrievably destroy new files
To:     Julian de Bhal <julian.debhal@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 4, 2016 at 1:57 AM, Julian de Bhal <julian.debhal@gmail.com> wrote:
> On Sat, Dec 3, 2016 at 6:11 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Sat, Dec 3, 2016 at 6:04 AM, Julian de Bhal <julian.debhal@gmail.com> wrote:
>>> but I'd be nearly as happy if a
>>> commit was added to the reflog when the reset happens (I can probably make
>>> that happen with some configuration now that I've been bitten).
>>
>> Not sure if this has been proposed. Perhaps it would be simpler to
>> just output the sha1, and maybe the filenames too, of the blobs, that
>> are no more referenced from the trees, somewhere (in a bloblog?).
>
> Yeah, after doing a bit more reading around the issue, this seems like
> a smaller part of destroying local changes with a hard reset, and I'm
> one of the lucky ones where it is recoverable.

Yeah, but not everyone knows it is recoverable and using fsck to
recover is not nice and easy for the user.
So having a bloblog for example in .git/logs/blobs/, like the reflogs
we already have, but for blobs, could help even if (first) it's just
about writing the filenames and sha1s related to the blobs we stop
referencing.

> Has anyone discussed having `git reset --hard` create objects for the
> current state of anything it's about to destroy, specifically so they
> end up in the --lost-found?

Well, when we start talking about creating new objects, then someone
usually says that it is what "git stash" is about. So the discussion
then often turns to how can we make people more aware of "git stash",
or incite them to create an alias or a shell function that does a "git
stash" before "git reset --hard ...", or teach them to use "git reset
--keep ..." when it does what they want and is safer...

> I think this is what you're suggesting, only without checking for
> references, so that tree & blob objects exist that make any hard reset
> reversible.

I suggest we start with just logging blobs that we have already
created (when they have been "git add"ed) but that we are
dereferencing.
If we can agree on that, it will already help and not be very costly
performance wise. After that we could then start thinking about
creating blobs for all the content we discard, which could be done
only in a beginner mode (at least at first) to make sure it has no
performance impact if people rely on "git reset --hard" being fast.
