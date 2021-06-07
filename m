Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5DC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3658260FF1
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGNJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 09:09:57 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:36550 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFGNJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 09:09:56 -0400
Received: by mail-io1-f47.google.com with SMTP id s19so8445250ioc.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0H8RCOTFAHGQ/eQRjY8qjje/51vOHgRWpmCVoJXp1XU=;
        b=aKq+cg0qw+SjpREni3WVR6pwu5bKesrMUJuIMB97cen4/gNCa9ZSBwtQ0ssdcbyiv1
         1eDE2BmFjDnrY1F39+1HkeclVrX+1U3Zudel2bHZiugXLi2Sy6ntPHC6L0Y8e6BMHo7t
         njbQ6xreatZqgnvYSKm5pyy2Lz89S8E/wgrp4sWPREpWpL/QtIUDQ7VRQ5JbaoL1CsVT
         2XZNJLPG5UFKsAnXW0iLClwnDJ6QQ32QBl9ReoN6Mb5+/mZZTiMitEGimcBfjcaeYyVT
         CbLXR5hmQD+YSjZO51hsU2dsudA3J4mT4N826d5tiGAFGl52+GqNsscweSBaWDCAeYR7
         HR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0H8RCOTFAHGQ/eQRjY8qjje/51vOHgRWpmCVoJXp1XU=;
        b=XSK0DjSL4dTGq//lMMzddkrt8S8juhHywsC2up7kJeIWa36afXSoDimT29AwUKaK9V
         TqtDK0ufT9HeuIc0VOICID8fZsUtpKUtPzaSw+SyxRvFo5WFC5tcPLH35KpmsVyKviNf
         xDReAgl8OHcGLVte2XH6q/LS3HKQLxbKYFxwycuJJqM4vNHW7Ur5WG0Lv33nPrkU2iRi
         jVSlQJJrHRlCPRKj+N79G0danbzT6y8YzGWPD0FzDPUA7UaJrnrja+wgvlhTI3lsh5w+
         MGPfc1WhUIq3pZsRdgR2WSQSZgZEGCPsvsTe8oryRO10shOl7P9a0lOW1QBA34ni8Owc
         /mvQ==
X-Gm-Message-State: AOAM530bGRQanYoi/XH7TvOowl50nTW9MuIh3v+IcNYeOz7eIsbUsOu2
        kji84Re51gamUn69Vsmm9n8Zy5xdPZGwk7VzO/E=
X-Google-Smtp-Source: ABdhPJyJ2i1ToBGmdMOqIq4veRb9hlm+qvS9owNH/drGWsne9K0Ocb8+J60laJpFhAEEiWZqRq69YvTLhnSc97U+Yi0=
X-Received: by 2002:a02:647:: with SMTP id 68mr15693277jav.29.1623071213952;
 Mon, 07 Jun 2021 06:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com> <xmqq35tuw74h.fsf@gitster.g>
In-Reply-To: <xmqq35tuw74h.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 7 Jun 2021 21:06:42 +0800
Message-ID: <CAOLTT8SXj0bo2iqr4OAHHaSDCVbjAogAEvgFjupJBS-2N6dxHQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] [GSOC][RFC] ref-filter: add %(raw:textconv) and %(raw:filters)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=881:56=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The current series is based on 0efed9435 ([GSOC] ref-filter: add %(raw)
> > atom)
>
> I do not have that commit object, but these six patches include the
> two commits that are %(raw) and %(raw:size), so I'll just discard
> the old round that wasn't based on the atom-type stuff and queue
> these six as a single series.
>

Well, it is a commit that has not been sent to the mailing list. But it=E2=
=80=99s okay
to treat the new 6 commits as a new patch series.

> As I already said, I am not sure how %(rest) makes any sense outside
> the context of "cat-file --batch"; I suspect it would make more sense
> to make it easier to arrange certain placeholders to error out when
> used in a context where they do not make sense (e.g. use of --rest
> in "git branch --list").
>

I agree.

--
ZheNing Hu
