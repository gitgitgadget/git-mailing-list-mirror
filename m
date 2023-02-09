Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D19BC05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 01:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjBIBCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjBIBCN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 20:02:13 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30FA12851
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 17:02:12 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4a263c4ddbaso6096607b3.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 17:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bZ0MUcHy1nNa2WMMik5U+gQVbDddc9OciUx/KinXJA=;
        b=cPMznC0adYy5heNqxgIx5eVxTs3/Q1uaLUnz4SoKFXWSgOYFfise0P+nmcV/NZHene
         CwI9zCGry/L3t7Und3b/b5K0AAqE7O2xQbcf45GG/+3BtGqzBzjdsx3pqBZnR9WDPAbk
         VUgtH1HsW6nCHtT+W3EXBWj74IXoAqxENi6YtEzQFaGKJP2Euf2PPgOPBTm3nSIYnDfr
         tDcPPPqazpjKAFlpUp3umiP8AzvqJAZ55ZWcQAXRgzijlGLQfWaOdcZnaFH+hRaVA/03
         9P5ueZ2ZaiqFsD0YftC8jv2kYY1jW2Mg0Ny8FAtQiRYTZvoe8UVzYMyUFdDGmmklhcVH
         SrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bZ0MUcHy1nNa2WMMik5U+gQVbDddc9OciUx/KinXJA=;
        b=tltWaWD6UeoQxH7OHbSHe94cl8QYWa6BkyXwzqgXJqacUm9ZDsCJOIN0rx1013+tVC
         0XU1XvJ8hkGUIuQ93dkGDIC5DRrDnIXP857XexZ76CMHqt7nwbRNgudnbQGwZQM6Cj1v
         XufF516BvwF6ZSU63tUY7NjPSxlQyEMgA5fP+lGealmiBkAJrn88tAuZSMIXuyI9fdsd
         cwQwKQ4jbNTjcECGM/1NLdQoYGawQJ4XhF0/EFatpUy8oeewcrAj5PC1QmDoRKAQJ82P
         LW5Tumj6oBSuj7/oJ1lABWDrrP9Niv80y+36RdGyv4v10dx2w2nVFucmNiL1mElTFrcO
         RXSw==
X-Gm-Message-State: AO0yUKU8snB5hlaVGUZPvLsKhsHlIG8JhY8oHqwDAzg5UHgnTHOhOu1n
        ODjdqk2YbPVf26WQ7+ssdkAK5Ym1XLJDMNRW6SFCKFpt
X-Google-Smtp-Source: AK7set8tC9BRbsnCkvgNjtXrVbcc7Nfi7fcvC9nVvoBACqd76FR1iPlhzHAKLOF5qY3wqaRXIcSKTDJPQudpz5OFq3Q=
X-Received: by 2002:a81:5c85:0:b0:4fe:5d55:368 with SMTP id
 q127-20020a815c85000000b004fe5d550368mr1069898ywb.407.1675904532018; Wed, 08
 Feb 2023 17:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20230207235238.1850757-1-kolyshkin@gmail.com> <20230208161222.guqqwlceqiy3jq7e@tb-raspi4>
In-Reply-To: <20230208161222.guqqwlceqiy3jq7e@tb-raspi4>
From:   Kirill Kolyshkin <kolyshkin@gmail.com>
Date:   Wed, 8 Feb 2023 17:02:00 -0800
Message-ID: <CAGmPdrzpEvjCh8u4-FjsaE3tmqfiE3xyytO-++56JrjcMEgP=A@mail.gmail.com>
Subject: Re: [PATCH] remote: align columns on -v
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, Roman Dodin <dodin.roman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2023 at 8:12 AM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
>
> On Tue, Feb 07, 2023 at 03:52:38PM -0800, Kir Kolyshkin wrote:
> > Currently, git remote -v produces a misaligned output when a remote nam=
e
> > is more than 8 characters long (i.e. longer than a tab step). Here's ho=
w
> > it looks like:
> >
> > giuseppe      https://github.com/giuseppe/runc (fetch)
> > giuseppe      https://github.com/giuseppe/runc (push)
> > kir   git@github.com:kolyshkin/runc.git (fetch)
> > kir   git@github.com:kolyshkin/runc.git (push)
> > lifubang      https://github.com/lifubang/runc (fetch)
> > lifubang      https://github.com/lifubang/runc (push)
> > marquiz       https://github.com/marquiz/runc (fetch)
> > marquiz       https://github.com/marquiz/runc (push)
> >
> > Let's find the maximum width and use it for alignment.
> >
> > While at it, let's keep the \t in case some tools depend on it
> > for parsing (there will still be trailing spaces in the remote name).
> >
> > With this change, the output is like this now:
> >
> > giuseppe      https://github.com/giuseppe/runc (fetch)
> > giuseppe      https://github.com/giuseppe/runc (push)
> > kir           git@github.com:kolyshkin/runc.git (fetch)
> > kir           git@github.com:kolyshkin/runc.git (push)
> > lifubang      https://github.com/lifubang/runc (fetch)
> > lifubang      https://github.com/lifubang/runc (push)
> > marquiz       https://github.com/marquiz/runc (fetch)
> > marquiz       https://github.com/marquiz/runc (push)
> >
>
> Thanks for working on that  - I had the same wish as well.
> However, I am tempted to comment on some details here.
> Especially, what happens if a remote is named with a non-ASCII
> character (unicode code point would be a better term) ?
> To determine the width on screen for aligment, strlen()
> does the wrong thing here.
> This has been done at other place (being UTF-8 aware),
> you may want to have a look at this change:
>
>   commit 12fc4ad89e23af642a8614371ff80bc67cb3315d
>   Author: Torsten B=C3=B6gershausen <tboegi@web.de>
>   Date:   Wed Sep 14 17:13:33 2022 +0200
>
>       diff.c: use utf8_strwidth() to count display width

Yes, I have seen now that neither strlen nor printf with the specified widt=
h
do a good job with unicode. Thank you for pointing this out, I'll send v2 s=
oon.
