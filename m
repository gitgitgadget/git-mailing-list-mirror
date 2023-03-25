Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0304C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 16:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCYQzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 12:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCYQzT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 12:55:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60110C1
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 09:55:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g17so6105671lfv.4
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679763316;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWt73U7oCuTjnpI0rZ/wTPl6FH7UK8DmyRQvSJy8aeI=;
        b=XmFXfSohH4wsW1NzZ3EfWhhnwRn8Ix6Ph5ZLk0atqwwsqWca1maqRMk8uDL70rm70r
         G1Ujz5GZgH9jPDbVxOidoqHc4ReRtTA9ydEFDBLqU5JoBfgs0Orll0q+gcWaN1YE4yfb
         MJypg2+ZYpfp2D4KwwV0VYBJzjA17y3+23SbQvIx3d+hngpff15voIvhwiViPR7rI+6p
         7WjvcmLkGp78gXR7lGyTJkGn7iIndy6g7eEl7D/kqDxXOJW6epNCN0m+JVBYIyUs/kdk
         cpfQLUh9ZUsSwgjuXLUxh8ylxEhiM91Hl38ys0/zxhrTSkr9Ck4U3//GSgEnXJqEiqj9
         tJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679763316;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWt73U7oCuTjnpI0rZ/wTPl6FH7UK8DmyRQvSJy8aeI=;
        b=scaORQejL704gHC+JqP+apkjpera5EkxwwT3eunXOpBAa3PB441DZ8IQhwoWEqWY21
         9sd5XMATFs0UCAmjaNszTK3xqJYYHkGgVXvSv/RxsQVaVYPIv1ZZ5xrnBLButFrm8/U6
         xLpgnlmpQKh9e4jCRPk/3gGHi7kknFVELuOE/a4SN09IPM4UXkm4Z4aH0yjQwBFH2MyN
         O80PT3xZvr+VAxayRO0axJaKae6PacS2n2e3mNSLEJdlXRCUMRGsWW5q4a0MOpwsjUJy
         UA7UKjxC4h81c/IWLuxLSD/UYb5pdYftNqIj7lnowNrA2gNsHtnN/vljZalW1u5Uc9Mn
         x0AA==
X-Gm-Message-State: AAQBX9fzJvXNxLDhygyP12QEJjQ4WaQnhmaRJGE50Q7TYq5snlYVMI8i
        IT+qJX5rprdJmZkErUpingn2O2t/rrA=
X-Google-Smtp-Source: AKy350Z8G8Lzfzbrxyc/HMAe8b2+I8AzrXWkvCsrzD7GIpRIskHC0uiwbNa7fjhwuAfuwKEK/ZMtzA==
X-Received: by 2002:a05:6512:3cc:b0:4e9:aeaa:ddb5 with SMTP id w12-20020a05651203cc00b004e9aeaaddb5mr1724474lfp.14.1679763316481;
        Sat, 25 Mar 2023 09:55:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e4-20020ac25464000000b004d58e782886sm3865669lfn.303.2023.03.25.09.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 09:55:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g>
        <87jzzqzy20.fsf@osv.gnss.ru> <xmqqzg8mrgc8.fsf@gitster.g>
        <874jquxc67.fsf@osv.gnss.ru>
        <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg5vgvc.fsf@osv.gnss.ru> <xmqqjzzo46tv.fsf@gitster.g>
        <874jqj31gv.fsf@osv.gnss.ru> <xmqq8rfugbuy.fsf@gitster.g>
Date:   Sat, 25 Mar 2023 19:55:14 +0300
Message-ID: <87y1nk6aa5.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> I do not quite understand the last one (#4),
>>
>> Well, -m does not imply -p, whereas the rest of diff-merges options
>> (-c/--cc/--remerge-diff) do imply -p. This is what half of this
>> lengthy discussion was about.
>>
>>> own 4., it would be that introducing --diff-merges={kind} may have
>>> been a mistake.  It would have been fine and better to just let
>>> users choose from whatever set of options we support, i.e. (-c,
>>> --cc, --remerge-diff, -m -p, -m --raw, ...).
>
>> It's fine with me that --cc is everything you need, but what I need is
>> rather diff to the first parent, ...
>
> I think "show --first-parent" should give that already.

Well, for "git show" even "show -m" does the right thing (once properly
configured), as "-p" is implied by "git show".

Taking "git show" into the picture brings yet another argument if favor
of new "-m" behavior, as then "git show -m" and "git log -m -n1" will
finally start to produce the same result, that I'd find desirable.

That said,

  --diff-merges=first-parent

that could be shortened to

  --diff-merges=1

is the universal answer that works out-of-the-box for any command the
same way, reliably, and then it's also

  -m -p

if configured accordingly, that has been made available by previously
accepted patches.

These series just did the last logical step: allowed it to be just

  -m

if configured accordingly.

> One problem with "-m implies -p" is that it is unclear what should be
> done to things like "-m --raw".

Nothing specific is actually needed, as far as I'm aware, as implied -p
doesn't interfere with --raw. Please give particular example of a
problem if you foresee one.

As I see it, if there is indeed some problem with this, it should
already exist for -c, --cc, and --remerge-diff, and then probably needs
to be fixed anyway. Moreover, it should also exist for "git show", as
the latter implies -p, and there is:

       -s, --no-patch
           Suppress diff output. Useful for commands like git show that show
           the patch by default, or to cancel the effect of --patch.

[As a side-note, current behavior of implied -p, explicit -p, -s, and
--raw with respect to each other that I figured by experiment looks
suspect to me. E.g., once explicit -p is given, and then canceled by -s,
I can't get bare --raw output anymore]

> Yes, we can declare an arbitrary choice (like "-m implies -p unless
> --raw, --stat, etc. are given") but that is just replacing an
> arbitrary rule [...] with another one.

Uh, this would be too cumbersome indeed, but fortunately it does not
seem to be needed, see above.

Overall, letting -m imply -p just makes things more consistent, even on
the problems side (if any), and I honestly still don't see'em.

Thanks,
-- Sergey Organov
