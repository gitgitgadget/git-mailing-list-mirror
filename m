Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69131C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 01:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiBQBqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:46:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiBQBqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 20:46:51 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474B2CCA5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:46:38 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hw13so3357579ejc.9
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ImIkRYKx4YUXgh8+/zg4oSvF3gpf9P4amJ9+rn4zjdg=;
        b=XwJq7xGxmIQkNqDTHpkX5Qcvr/AHz2GGYx4mFqVRBr9MWZI9FEybc9dwRh2RWdpHkz
         85v0v1S6bF65ka0eYoyc6Xe5AzAfXdPqey5vq1l+EV2pBcrhRPoqjHA1RKSPXskcq8/E
         5n02lRIaXANw9m/hGmvUBHvrtuPJHjo0BqpgPS7lZ1rRwRGf/9V6gCg02VL4S9oYQJJv
         X35JwA77vJFrV3Wx75/YNMrhQA0eoixuYX18NjGpFcGezlCK2yfNOlQx0t+6/7VpbYXw
         RFgosDzNxRcGNH/G6DjMO6yGha+gcxI7LRXUlA3GUGvTxPHlWt2RKySb9SHPfyzUPGLY
         uS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ImIkRYKx4YUXgh8+/zg4oSvF3gpf9P4amJ9+rn4zjdg=;
        b=YJ8Zgs1MiXQE0NOCWFjnqih933TmTSdd9K4ezlpXsAMX5CXClYU2tK1Ym1ISi9g0O6
         82eS636QMOBXvjVy0RnOvU2Yv8pR1AGwOCrQHAuVb5sd1OMjra2n0iUuKjUBhhrPH2u2
         sGl9X+Ul/t5urNc2qV6oUhoZdRMJbXVBOE5if5LZiJKttfF4ytOvHfYDp546GB/FWT+r
         fXKiaVOPeN1HfZQB8A34KBebL8LiNYWulVGTlc1pGYbEk+0balgqEtWJrfX+gjHqQ+Yh
         Pj2ZBi5MGm0gDgX7Ai4dG7ozeTxusxGQ8TV/gocOml4lbFGvHjxrd+EW7ZPVJV1Fy5m4
         rAsw==
X-Gm-Message-State: AOAM530WxG0W4DQxyaA4AT/rVzIqB5U76BTwKhDnQZsH8xCd1vQou6qz
        2VJ6NJKV2TLCqCVTnK2KIxlNlHYUygEdL+DksaY=
X-Google-Smtp-Source: ABdhPJyEWuWrSuQPOzx5UoZb0yrcQke2IwTbpTRTQRdSax47PoSsBRZiQUASr9GxYO3JHKdIabVVdhPlaRm0QTlaX3Q=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr629310eje.328.1645062396608; Wed, 16
 Feb 2022 17:46:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
 <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com> <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
 <220216.8635kjuob0.gmgdl@evledraar.gmail.com> <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
 <af439020-8314-9171-4300-94a5102c8a38@github.com> <xmqqpmnmsl2n.fsf@gitster.g>
In-Reply-To: <xmqqpmnmsl2n.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 17:46:25 -0800
Message-ID: <CABPp-BH2Jy8esb52JBZvFOk9CcBMk41oDzDZX6t3G+M9tiao4w@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode
 that look like patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 10:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Victoria Dye <vdye@github.com> writes:
>
> >> I considered strtok, but strtok & strtok_r are documented as modifying
> >> their argument.  Perhaps they don't modify the argument if they don't
> >> find any of the listed tokens, but I didn't want to rely on that since
> >> I found no guarantees in the documentation.
> >
> > Maybe `strpbrk` would work? Unless I'm misunderstanding, it should
> > consolidate the condition to one line without potentially modifying the
> > arguments. E.g.:
> >
> >       if (!strpbrk(argv[i], "*?[]"))
> >               die(_("specify directories rather than patterns.  If your=
 directory really has any of '*?[]' in it, pass --skip-checks"));
>
> Yes, either that or strspn() are good match for the problem (I
> suspect =C3=86var actually meant strspn() not strtok() in the first
> place, though ;-).

After reading up on it, I think you mean strcspn() rather than
strspn(), yes?  Either way, strpbrk() seems more direct to me, so I'll
use it.
