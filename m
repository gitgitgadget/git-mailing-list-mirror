Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08788C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 11:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378092AbiDTLaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378099AbiDTLaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 07:30:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D480A41611
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 04:27:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c64so1837809edf.11
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 04:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpL0xJXaNjAZAj+bBQt85n2PmdXykRLUcxATa5Mu5UE=;
        b=OEDyd82Ft4e2zld5l+0znsgFjxYKkht5++iqGDi812STEaX4NPDYyBmllw0ij58v7u
         C5wfwJ4W+/m56QlMqDGaTqW3tpJJanfCtBN4tQXmBm0SfHKeF+zeoqieL2fZ01ZdT4A2
         Elf2mI/J0WDn8DYkJTdxDsnG8Li5jyzg51tsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpL0xJXaNjAZAj+bBQt85n2PmdXykRLUcxATa5Mu5UE=;
        b=i2L956QPBw215TKOy5mIjq6CMujtiLelX1I7Se84ZknGF67tmyBZjP2g9/dNDTCRFg
         uAUKl0HsdVrqfHlDCLU1vIqt5Lq4UWGUQ7sDey0ozGarR8sZ4rsZFzhdlgkyFgm6mFLZ
         jd2+Z3RXEi2qagTn5sjrOLBx8i8L/jfdEkq8gn2H3XHcHAiOfOKOZxPsO1FLdLW8oI4a
         m14zj59zd8naSreidcHrlsLqgpZtGtnUXcUstYwxJTatmXxPPG+yAsz5WE8bIkbVZYxf
         zDzesRwZ9lizhaUwfGwk4SDzRtN2ijtKsVntgQiYV0ixdMtvfgr2tSIHemxfMZk4TTE5
         HnZQ==
X-Gm-Message-State: AOAM530yJSTpKJJ/VrnmZY0QL6ulyg7M8D1aLpw2E2d+6ZUa+CRjrnmU
        FF78JJfTSAytnmQoLcbSTC1Eu1ufBL2Kwifeff2OdQ==
X-Google-Smtp-Source: ABdhPJw3VABdtRD60gcS/nMfp+mXql/Vib523Fqr1g4Fu2sV80lH39OTqiP5q99gBySwXI0QzSnWfP5ez44RlET4cLY=
X-Received: by 2002:a50:954b:0:b0:41a:c9cb:8778 with SMTP id
 v11-20020a50954b000000b0041ac9cb8778mr22781617eda.165.1650454039383; Wed, 20
 Apr 2022 04:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
 <xmqqbkx2ccj4.fsf@gitster.g> <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
 <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
 <87lew226iw.fsf@osv.gnss.ru> <CABPp-BGQSN2iRWco4pQCVKA3AM6J0L0vyFMnYdrOgK0Pa26tWw@mail.gmail.com>
In-Reply-To: <CABPp-BGQSN2iRWco4pQCVKA3AM6J0L0vyFMnYdrOgK0Pa26tWw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 20 Apr 2022 13:27:07 +0200
Message-ID: <CAPMMpoh9-sm57D_OSVpo4A3KdJypNZbZ2KTWURvcOW0690eviA@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2022 at 6:28 PM Elijah Newren <newren@gmail.com> wrote:
>
> If you read the suggestion I made (which I'll reinclude here at [1]),
> you'll note that I read the old thread you link to with both your and
> Phillips' suggestions.  I dug into them with some examples, and came
> to the conclusion that we needed something better, as I briefly
> commented when proposing my suggested alternative (at [1]).  I
> appreciate your suggestion and the time you put into it, but based on
> my earlier investigation, I believe my suggestion would be a better
> way of preserving user changes in merges and I'll be implementing it.
> The fact that Martin (in this thread) independently came up with the
> same basic idea and implemented it in jj (though he apparently has
> some further tweaks around the object model) and it works well
> suggests to me that the idea has some real world testing too that
> gives me further confidence in the idea.
>
> [1] https://lore.kernel.org/git/CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com/

Thank you for the clarification, and sorry I'm clearly missing
something here - the link you provided is to a deeply threaded
conversation about "[PATCH 08/12] merge-ort: provide a
merge_get_conflicted_files() helper function", in the context of a
server-side merge support patchset... I can't figure out how to relate
that conversation to the "how can safely reusing previous merge
outcomes when rebasing a merge work well?" topic I thought you had
introduced here :(
