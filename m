Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6F9C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 10:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKXK4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 05:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKXK4U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 05:56:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C7C48424
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 02:56:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x5so1913305wrt.7
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5X2FHiViSBlWG6DQ5AUuNV/j7xyoAD7LR/HT2Qdz+y4=;
        b=gXKR4VJ1YeOnXQ8+EQlu6IqSbUiEYkpDQbb01yK/T7xyNcC9wkQWqiQMp0oFMIhQ3Q
         qPot1zSR5Nnq2stNEruVJDZXm9kznQGcZyz73b2STigvFVH0muP4RPkLSXSU8N9GJxbL
         GJZ0JhLchMWnWag1xyc/U6+C0BEZ1JpaJyJw8mtSUBD0/Qa7xANjOk6v/IcUUPi4z4oo
         Xah5S5z+tFQt4Vpf3prrabbvVaWSvrvpkarpvAQhZZ33kCFxCwxWHzVlAmfqT6KoVlYq
         nBKBDrGFczKuLjIq0g1A0JOAwiKly9MtzEAAH/EgCfBYosWlCkjMJvFEfncZEcGhEV9r
         CniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5X2FHiViSBlWG6DQ5AUuNV/j7xyoAD7LR/HT2Qdz+y4=;
        b=jEZTa8tFBvPJndpa6vrS+CW3QBU+jvbP6b0NjGyJt54HLzEk57PIu7kCPC9pnASM0D
         UL6Jx2OGSYvgAAyd88Rj7Ga6ccYPgH1477T1AWCgQoHoEWCMyPS98XDDUgKet7fNoU2Z
         8tplUK2e1CwKY9BUQMYvOHKaFSiBP7Zn9AlbA1UUC6LYR8sb0Wb4Jth+KZcdQf2RERo4
         l0nziIJ923eFK0SQ5rte5oXV9BZUyBEdORFcycnp+pUu/EQaMF8BwAuZlyaUFevrOu+F
         J+adxFThvZuCQZ2dly3GA+/TSaj8mHhijbwLP15HNoX7YM/HCWz5SU2aAfHUW/27Gpi1
         UfdA==
X-Gm-Message-State: ANoB5plqmKZO5Y7CeriyTlmP2s+kw3NXuVXGL8cUJy0G0KtemUc4crjR
        TbAc0fwlwwdWPhcxXmQ0oNIYzQlDzehssg==
X-Google-Smtp-Source: AA0mqf4TflFrD7hVBD6GARo6bJDVJcW0e7k3OMv82i7sMKaq12v6AIukYzWip0cZ44vbiolJLYwjqw==
X-Received: by 2002:a5d:6243:0:b0:236:6b05:a8be with SMTP id m3-20020a5d6243000000b002366b05a8bemr19211328wrv.346.1669287373993;
        Thu, 24 Nov 2022 02:56:13 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b002416e383e1csm1074762wra.25.2022.11.24.02.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:56:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oy9rl-00069O-2j;
        Thu, 24 Nov 2022 11:54:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/3] github-actions: run gcc-8 on ubuntu-20.04 image
Date:   Thu, 24 Nov 2022 11:46:17 +0100
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221124090545.4790-2-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221124090545.4790-2-worldhello.net@gmail.com>
Message-ID: <221124.86mt8gpqra.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> GitHub starts to upgrade its runner image "ubuntu-latest" from version
> "ubuntu-20.04" to version "ubuntu-22.04". It will fail to find and
> install "gcc-8" package on the new runner image.
>
> Change the runner images from "ubuntu-latest" to "ubuntu-20.04" in order
> to run with "gcc-8" as a dependency.

I very much like this direction, as we shouldn't have to scramble to
update our CI every time GitHub switches defaults, and by using "latest"
in general we also break e.g. re-pushes or re-rolls of outstanding topics/PRs.

I.e. you'll push today, it'll work, tomorrow the "latest" image has
changed and your CI breaks, but through no fault of the code you're
testing.

But per previous discussion on this exact topic at least Junio & Derrick
(CC'd) disagreed with going in that direction, see
https://lore.kernel.org/git/220825.865yig4bd7.gmgdl@evledraar.gmail.com/
(and the E-Mail it links to).

Now, I think that if we have some notification so we'll update the
"pinned" image sooner than later it'll address the concerns they had,
but do we have that? I've seen notices from GitHub CI about e.g. some
things in the main.yml file being deprecated, will we get those for
these "pinned" images too in a timely manner?

Because while I think a non-pinned "latest" sucks because it forces us
to scramble with updates like this, having a "pinned" image go away
entirely (because nobody noticed we should update it sooner-than-later)
would suck more.

> Instead of use the environment "$runs_on_pool" as below:
>
>     case "$runs_on_pool" in
>     ubuntu-20.04 | ubuntu-latest)
> 	;;
>
> we can reuse the os field in the matrix, and use a new environment
> "$runs_on_os" as below:
>
>     case "$runs_on_os" in
>     ubuntu)
>         ;;

I think this is probably a good change, as we won't need to
search-replace the image name in as many places in the future.

But let's have this as a seperate change. Here you're just refactoring
the selection behavior of the main.yml + CI lib, it doesn't need to be
bundled up with the change to change the target image.
