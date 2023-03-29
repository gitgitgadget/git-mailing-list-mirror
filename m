Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCEDC6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 07:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjC2HoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjC2HoF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 03:44:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30981211B
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 00:44:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h25so18982781lfv.6
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680075840;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnrbFIC+4FwKZr5gT1Wijy/vP/xAzAxrqQHobTtT0qA=;
        b=ArkpsAGdtL9fdPwJkpusJhIqJ4NaMr/qfF237ytA6WH2YdIasHuOwrw1OSGdUyY/zx
         Br+Blw75rxzXHKqxlveqjP5fnN92wu/TYFsIjjS1gGHer3yoHEl/Cec33JX9mKdipPIX
         KsfCMgXInh81iOImHRl32TUnWi0SezTzc1+8eEUidj1WSgnLBUul54AOz/Bgk/5SApwv
         Ay3Ior+jyRUJY4a5vzR7SCx6BCStk8WLESXuxS8FGCie+Nq+Cz5BRIAomhfGRZAWG2w4
         Nt3km3R/tVVihIrVc9auS/24TBMKn+BMxWGCS5t6YS9cQbpBRvnpGePt8wkJSRsybKnY
         T33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680075840;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnrbFIC+4FwKZr5gT1Wijy/vP/xAzAxrqQHobTtT0qA=;
        b=3K+/Gc6K+ljGVhKG3gipVQehC79o5v2KZyJ4TEet2NOAngJGS9ZsqYL3aSji1+eQPm
         WNf6V4LNyqOL2d6r3kUV6EUJdg/GKycA94gdM7Hl4oHFbdDKi4niRxpeGUKINcFrAx3k
         W64mAYiqRwzakU1LDqujVIDDJgZOMjfbU32/cXtxpwIbPkYu56RQ0W1BfHOzS/6nmA7Z
         UA1pnjLhsqhMGaRf4/DEI0Vqa0YuqUK8Zpqj8LCLilSrLkfk2Z1Ra9EskpVLTLbdhI/c
         HRa0rywMxkSlU7aA2zuObttnggiMice00Ls4nKdXsSBzSR0FsSMufN06VS2Zqgyd09B8
         dYfw==
X-Gm-Message-State: AAQBX9e/WRgplDDPjmetUDsQLHDvsF/SaFbEA7zZ4d4e6ber5OEDJtg3
        IP3wkZqI7LHt23lZBrXY2eDsIIPG0uk=
X-Google-Smtp-Source: AKy350YAki8EgFiDieJryOmBHWE1hC1N4OLtWFwnD1OOK+C7cgxzaGYO9wBJ5vNxI4RONAQ13kLgmA==
X-Received: by 2002:ac2:550f:0:b0:4d7:44c9:9f4c with SMTP id j15-20020ac2550f000000b004d744c99f4cmr5080077lfk.4.1680075839894;
        Wed, 29 Mar 2023 00:43:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u18-20020ac243d2000000b004e9c8290512sm4258956lfl.82.2023.03.29.00.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:43:57 -0700 (PDT)
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
        <87y1nk6aa5.fsf@osv.gnss.ru>
Date:   Wed, 29 Mar 2023 10:43:55 +0300
In-Reply-To: <87y1nk6aa5.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        25 Mar 2023 19:55:14 +0300")
Message-ID: <87r0t80zpg.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>>> I do not quite understand the last one (#4),
>>>
>>> Well, -m does not imply -p, whereas the rest of diff-merges options
>>> (-c/--cc/--remerge-diff) do imply -p. This is what half of this
>>> lengthy discussion was about.
>>>
>>>> own 4., it would be that introducing --diff-merges={kind} may have
>>>> been a mistake.  It would have been fine and better to just let
>>>> users choose from whatever set of options we support, i.e. (-c,
>>>> --cc, --remerge-diff, -m -p, -m --raw, ...).
>>
>>> It's fine with me that --cc is everything you need, but what I need is
>>> rather diff to the first parent, ...
>>
>> I think "show --first-parent" should give that already.
>
> Well, for "git show" even "show -m" does the right thing (once properly
> configured), as "-p" is implied by "git show".
>
> Taking "git show" into the picture brings yet another argument if favor
> of new "-m" behavior, as then "git show -m" and "git log -m -n1" will
> finally start to produce the same result, that I'd find desirable.
>
> That said,
>
>   --diff-merges=first-parent
>
> that could be shortened to
>
>   --diff-merges=1
>
> is the universal answer that works out-of-the-box for any command the
> same way, reliably, and then it's also
>
>   -m -p
>
> if configured accordingly, that has been made available by previously
> accepted patches.
>
> These series just did the last logical step: allowed it to be just
>
>   -m
>
> if configured accordingly.
>
>> One problem with "-m implies -p" is that it is unclear what should be
>> done to things like "-m --raw".
>
> Nothing specific is actually needed, as far as I'm aware, as implied -p
> doesn't interfere with --raw. Please give particular example of a
> problem if you foresee one.

In fact there is already a test for it that I added some time ago (as
well as for --stat), so a problem would have been caught. Please also
notice that it was an agreed goal for "-m" to finally imply "-p" at that
time:

commit 48229c193d2e6e728d3243bacea2f1e1490ced8a
Author: Sergey Organov <sorganov@gmail.com>
Date:   Fri May 21 00:46:55 2021 +0300

t4013: test "git log -m --raw"

This is to ensure we won't break different diff formats when we start
to imply "-p" by "-m".

Signed-off-by: Sergey Organov <sorganov@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks,
-- Sergey Organov
