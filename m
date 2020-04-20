Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82168C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E80F206F6
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 16:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYeqetco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgDTQTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728619AbgDTQTm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 12:19:42 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF753C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 09:19:41 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 184so6389877vsu.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JM5aBCS41Ueium7HBIsBpkqwuPQSQ9+/mmOVNu4S7j8=;
        b=rYeqetcoi4f5M1Mk21ZsRs3huAc3O/rLAmzGkKiPGDAjF3dMqHky1XcXlu6NhvIoXt
         0jTE4skZUg3z0ctmofI2iWmhBRgSzhvc8d3L1YgSx2w6tT+TqX3LZObKsggpFq2YOEfp
         t/b4etdNDF3dHCiyFCrpjCTOrrfobF9LiDAkdOlovES4IoxXxweVStZc+AXcUePWMIrB
         yKAjNWYH7rOADFi+AgTu74OK3fMd0pQq9H2X85DfzJI6lncFNOZowaK7E+bSz4h8GtZ/
         Mhmn4M2u6QXuk0HCCPdw4MjBO4E670f4qfWilUZjupBpbF+nlHAuFNDt1JHIDZHq9+qC
         LT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JM5aBCS41Ueium7HBIsBpkqwuPQSQ9+/mmOVNu4S7j8=;
        b=nZHS0yjitKza7sCh6wOp+G+yrKFYHeJJ8DDnrZT7LGH0AE1JCAXOlqDahMp9GMUkFg
         eW/MLGUVlvUjFE27ZbJEQdCApYqHa0HCXJj99HME4rSpTaWMngUaLay9TG3bMuxAxjKo
         9ZTfWS6eg3TMk6UohGTWB6k6KoPd4rZ3/AJwVj+l8n0Wc3DMYc3Werc6pZhg/CdwGOpi
         uMjvXR4kbvbt8bWjscQB8tGhjiwvT5MyKwdes5S4HXldiB5UrIyPZpQVGmAHIqQl2paX
         uiZx3Qbu72mxy4MoTZZAIxfAz0CX2jaExmgtYegdwx4zNiYjpM6sSuAD9GFPb7bkrJN+
         awNg==
X-Gm-Message-State: AGi0PubZUGBJXZ/RW7r/G0PNf8uE/3xz2/+DK8CGaM7DhDeM1bXA0dRZ
        PJpZZwXyFaPfORpjaava0cmSXMNQL8kyDM7wKK4+R77A
X-Google-Smtp-Source: APiQypLwNE4U7+bzRvdGvgtmy+ZEI1735OndqeFFyruQYwcRRRKW2z7ucSBBF8pGIPbI4XND65z1vKVTOQfFjhPeZSk=
X-Received: by 2002:a05:6102:21d9:: with SMTP id r25mr11607445vsg.85.1587399580985;
 Mon, 20 Apr 2020 09:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9KuXwmk377rEPVrwwpWmwzyO8N20OZUkUTBRoQoo3OuVYbGw@mail.gmail.com>
In-Reply-To: <CAJ9KuXwmk377rEPVrwwpWmwzyO8N20OZUkUTBRoQoo3OuVYbGw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 20 Apr 2020 18:19:29 +0200
Message-ID: <CAN0heSpO3bsi9dc2p1W_DJf1i2kH+Y8XjGo2bvqLkYTPSsfxWw@mail.gmail.com>
Subject: Re: [docs] git stash show also accepts -p|--patch option
To:     Elijah Lynn <elijah@elijahlynn.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Welcome to the list. :-)

On Mon, 20 Apr 2020 at 09:36, Elijah Lynn <elijah@elijahlynn.net> wrote:
>
> Was reading `git help stash`and noticed the --patch option says:
>
> > This option is only valid for `push` and `save` commands.
>
> But this isn't true, the `git stash show` command also accepts the
> --patch command and is very useful as it shows the diff of the stash
> whereas without --patch it just shows the filenames that changed. I
> see this text in master too
> https://github.com/git/git/blob/master/Documentation/git-stash.txt.

Interesting!

There are two *different* "--patch" involved here. One is used to
interactively select hunks with "push" and "save". Another is the one
from the "git-log/diff" machinery. This is the one that can be used with
"git stash show" and "git stash list". That is, "git stash show" doesn't
really know about it -- it just passes on "--patch" and other arguments.

For example, for "list", the manpage for git-stash says "The command
takes options applicable to the git log command to control what is shown
and how. See git-log(1)."

So there are in a sense lots of options that aren't documented in
git-stash(1). But certainly "--patch" is a bit special in that there are
basically two *different* options by the same name.

> I can gladly submit a patch if this will be acceptable to update the
> docs to state that -p|--patch is applicable to the `show` command as
> well.

I think it could be useful to be a bit clearer about this. One question
is how... :-) Maybe under "--patch" one could make some short mention of
this. Perhaps

  (`--patch` can also be used with "show" and "list", but that is
  'another' `--patch`, see ....)

? Maybe you have other ideas?

Thanks
Martin
