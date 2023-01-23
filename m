Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789CDC25B4E
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 01:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAWB5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 20:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWB53 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 20:57:29 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26FC172
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 17:57:27 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id m15so5402868ilq.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 17:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+9vwVS5vbVd1YcIIbBE1SXux/+A8m+ZUlqWjS0TYUxU=;
        b=m5Omo5Jl4cdz12W7JQrv63jws2T6NwV7AXDEJeW3WNRrHXzuM/bbjWpQTUTvEJwGsd
         glT3XYrknkm4DLBCwlz6X0vKFfgws2z6RIgfbc/EFvejp0RW4NPIYKaStWLhUvuWbSyo
         2v0ChLV1v4HDx5dzrhVJYcCfqZQ/ID+XRgjDfmuPSd9oq5vc5c+V3csadu61A6MMV4gS
         VEkZcDWeSPAWm/rve/NVkgfT1jDYbm3E5KW09R7x+TCNI3d9OUQMXVM6+L+Vz4WI4SZK
         kVotW06VL8OQweb/9kw5W1R8BuVyDzwg7POURfYywzLTBsgkQF0agZgmRwP4kUD25tFb
         XC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9vwVS5vbVd1YcIIbBE1SXux/+A8m+ZUlqWjS0TYUxU=;
        b=ugw7TiRb4e0asJ0NcEmEFLy+hVXw436eRpGQ/jEi8OY6mCT0jDERIWbbELgsgdhzhe
         nFNRmtzSUHPdP4ukcYBNYEBpZkSOk0Hnj4M3U4OmuVr6U91LfJJRrXoGafMWNK6p2giG
         5D4XiF52OeT/e0Ethsy/iS/dLF+OY0TUVlrL8U628L4iMJ2QQSOVTMoSYsbdlokDWA4n
         /H8MZHS7qhC5Bz8TuI38KutO6tsRKfCABaJK8gRqMUa2ep9I+JRPQY0u4erLTP9T/mY1
         wDo9fmMyGH5dgJCha6xbNKZjpSEbbsGUUqEE3tEstbkbH0GWj3+0IBoKMhsVX0KGdzJS
         QS1w==
X-Gm-Message-State: AFqh2kozShqy1j87qy9SnmEDk7+5fiJfdcOAne+3FmpmIUx27ec5Q4cw
        hIje296pb+XuMl0SeQdJIJlaHzCsacQ=
X-Google-Smtp-Source: AMrXdXs5WyNIkgo+9EJtWAEu+OcIYvuFkny4277A+nD1qJ7/IKW55lzDlBCywEtfjAnKYDAS8BTu1w==
X-Received: by 2002:a92:d3c2:0:b0:30f:4feb:50c7 with SMTP id c2-20020a92d3c2000000b0030f4feb50c7mr1448483ilh.3.1674439045864;
        Sun, 22 Jan 2023 17:57:25 -0800 (PST)
Received: from stargate ([2620:72:0:a40:a4f2:f04:1f26:7472])
        by smtp.gmail.com with ESMTPSA id v11-20020a02b90b000000b003a5f2e0bdb4sm5592921jan.68.2023.01.22.17.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 17:57:25 -0800 (PST)
References: <xmqq3583uyk0.fsf@gitster.g>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: refrain from self-iterating too much
Date:   Sun, 22 Jan 2023 19:47:45 -0600
In-reply-to: <xmqq3583uyk0.fsf@gitster.g>
Message-ID: <87cz76c8sb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First review on this list; let me know if I've missed any decorum :-)

Junio C Hamano <gitster@pobox.com> writes:
> +Of course, you still may spot mistakes and rooms for improvements
> +after you sent your initial patch.  Learn from that experience to
> +make sure that you will do such a self-review _before_ sending your
> +patches next time.  You do not have to send your patches immediately
> +once you finished writing them.  It is not a race.  Take your time
> +to self-review them, sleep on them, improve them before sending them
> +out, and do not allow you to send them before you are reasonably
> +sure that you won't find more mistakes in them yourself.

Something of a nit:

    do not allow you to send them...

should be

    do not allow yourself to send them...

You're also using 'them' a *lot* which took me for a tumble my first
read-through. I lost track of what 'them' actually was. Since this
documentation is especially likely to be read by those who are already
confused by the process, it may be beneficial to be more explicit at
some points:

    ...

    patches next time. You do not have to send your patches immediately
    once you finished writing them. It is not a race. Take your time to
    review your own patches, sleep on them, and improve them. Do not
    allow yourself to send out your patches for review before you are
    reasonably sure you won't find more mistakes in them yourself.

--

Thanks for all the work you do on this list; it's much appreciated.

-Sean

--
Sean Allred
