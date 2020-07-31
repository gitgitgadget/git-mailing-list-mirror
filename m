Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F4C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 13:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65DE2245C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 13:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilevmdf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgGaNxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGaNxv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 09:53:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC91C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 06:53:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so12926926eds.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K9U4bqezjC7M2JB/7GINNU9n3AbN/2biMkOX0Q3gHl0=;
        b=ilevmdf8CeGDx2WXAsg6sgRoI0sC5NSMC9/xV6bi0H+4mR2W75vt34FFbJkDAydOL7
         8hU/diwpIevav7MJ4JprG8h9wU9TKCvz4W36VZkIu/larEu1OFYyv0yd3u60Xnh9EWla
         j5Y1zUwv7MAervf5jWoYHIACellySVhW50DzRmCros6Os3kS6HyU5ctco2sRq7KUGZTb
         uJaKmF2QHzG1xLhBzLH7HENKrTYu9b5FBPOkzukV15LUWCv3/QlKud4eZO/O+U8BEkeA
         ytbN7Kv1nEUxeoLOTz6n1MzzOHZzkhrbLiddDAHv2P7OFSsZkkV2qZNJMC3Qj/KBqrxk
         cjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K9U4bqezjC7M2JB/7GINNU9n3AbN/2biMkOX0Q3gHl0=;
        b=ABOFeiunnfJGhKlJJzcAXoGX+K2AuWe6P1IW7ab2fOw9YPzoCKf+bZ5IQ8+sjLxsHS
         qpYBEds5Y5BGvokVRokBaXCHlU44wo+MJK39io8sghDy+tDVMgdcE4qGvn75UkyOR2dH
         4U/feAnJxfvL/hwaZu75sguNRfBljxklc5SGAvCquk7H7sbhhaFjkqYBWm5oUXBIOGHa
         +kOklB+k0AqsKxeQ8BedkFC06pnVIxHUDnswkCpj5VOjpNm6F9UDlOFDPBZaZLzCmBF3
         3K88ATHYUYO2W1cjTO1O7wDhDRYYJX7wiA8fqAIY/t+elFHv4gXygcygANH2s6NxmD98
         rfcQ==
X-Gm-Message-State: AOAM532FXkPdd6TZM7i3/UnUwhhuNPMvs33z4+i+EU08EvKcuoBRTCAr
        so0tbZHl2TNBs/wTGbQs22wX9J97Bt7ZA5c18RA=
X-Google-Smtp-Source: ABdhPJxp/2Z2ncJanjPceRUuMWR20Db7O1gLY0Utuc5BCEJcZlQSG9+LGOknOLCaZgRtLlNsKiNT0qAhDpEX7LLYLrQ=
X-Received: by 2002:a05:6402:16c2:: with SMTP id r2mr3873673edx.127.1596203629865;
 Fri, 31 Jul 2020 06:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200630151558.20975-1-alban.gruin@gmail.com>
In-Reply-To: <20200630151558.20975-1-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Jul 2020 15:53:38 +0200
Message-ID: <CAP8UFD3ywqAG4qtc8mYUOE_DMN8HhpE1nZO=9cBYkt0kHZ+83A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] stash: drop usage of a second index
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 5:16 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> The old scripted `git stash' used to create a second index to save
> modified and untracked files, and restore untracked files, without
> affecting the main index.  This behaviour was carried on when it was
> rewritten in C, and here, most operations performed on the second index
> are done by forked commands (ie. `read-tree' instead of reset_tree(),
> etc.).
>
> The goal of this series is to modernise (a bit) builtin/stash.c.

This patch series looks good to me. I found only a small nit or typo
in the commit message of patch 5/6.

> Originally, this series was also meant to fix a bug reported by Son
> Luong Ngoc [0], but as emphasized by G=C3=A1bor [1], the issue is not lim=
ited
> to `git stash', so this series is not a good fix for this particular
> issue.
>
> This series is based on a08a83db2b (The sixth batch, 2020-06-29).

It seems to apply without conflicts on top of current master.

> Changes since v1:
>
>  - Lots of rewording, following comments from Christian Couder and Son
>    Luong Ngoc.
>
>  - Removed a useless function call.

[...]

>  builtin/stash.c | 156 +++++++++++++++---------------------------------
>  1 file changed, 48 insertions(+), 108 deletions(-)

I like very much how it simplifies a lot of things.

Thanks,
Christian.
