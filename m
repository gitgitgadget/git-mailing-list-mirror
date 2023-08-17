Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE2C27C7A
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 06:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbjHQGva (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbjHQGvV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 02:51:21 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0112102
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 23:51:20 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d6a5207d9d8so901792276.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692255080; x=1692859880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MuEwDgd3FeY9ied+90W4hJL6DFg8NWXP6jrChiqy0Q=;
        b=RTOhx+h71+y0UyRg8P0NEK0U/X5gVjSbL1jReViPvAeUIoJS4SnUsrX/zUZE88TY5t
         bX2hzyDTHMNTcape51J1y9PpGGc2Tt+sUV6/IW6rc8qcbJOyfFVgYWuVFMyes2hXNXqr
         g2z2hrPS8Tof9zO0JVlJWZ43RFr/cmhDug32lEJIeKt+jRFIxF8dSLBnZn2aC/pAjLQV
         GUvNX4C9/ScoJYzcRmcCP952ZeauzcDa/VW/MDLJfEmt5SK78kI8uaB8BN8TlDtXW67d
         XgP0Q/mxC2wBd36FRCusBOMeHQ/hk4GZJHVOwM+Tu0X4PmwYY4XezjhFWUGcCbj/TK1H
         CeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692255080; x=1692859880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MuEwDgd3FeY9ied+90W4hJL6DFg8NWXP6jrChiqy0Q=;
        b=OiCUCNw9GR1bw5C/rfTRB1fFDi3EQrPxKuRNarba7qsLzEKVWsQi45F80qNuy3SmPz
         RZ6zHg5PtOYt6YrswSIsG+bg2SmSr/J8Sb/AfhZzdXeRkV+lXBQ+urvShVQMEKvIvj0M
         ddhpOijW0QpYQusFNiN2m9fgQBYNNcEXmcAkuXY8fHVcZig4BzAYIC6Km1TeCNX9T9Qe
         BYLZXXsktjRY3+l+rh1jeYq2xOiX/aHwwbe6UAeoniOmUyfIcRilmJB66F0fCbGUcXBa
         Oq+mPptmIAvg5TA5sCCC2xFXAeV//F6xwVXEMFLA7mIeklcwTOSky8mzFbNUc49dtDTv
         Nilg==
X-Gm-Message-State: AOJu0YxK3QLYxDflBY6BJzY6ScDPlyK0wZRTKG1vv6tmkY3QKeLfmwpi
        6tMGttW4eu9pwk02booXy4rB47YiVKPzSGN0eItNty/K
X-Google-Smtp-Source: AGHT+IG4B3OYB1cdziUUVnWJTcsDRGBh34NXiFDy66/ccNkQhxY72Vj/GkYyRQxkZol7rwA0ThMxRTZ5FWgTEcSBOuI=
X-Received: by 2002:a25:aca6:0:b0:d62:81c4:1f73 with SMTP id
 x38-20020a25aca6000000b00d6281c41f73mr2172506ybi.10.1692255079767; Wed, 16
 Aug 2023 23:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692194193.git.martin.agren@gmail.com> <b1b3f1d10b64e63c62db0105957a4ad5e0295d34.1692194193.git.martin.agren@gmail.com>
 <xmqqzg2qesoq.fsf@gitster.g> <xmqqv8dees64.fsf@gitster.g>
In-Reply-To: <xmqqv8dees64.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 17 Aug 2023 08:51:07 +0200
Message-ID: <CAN0heSq_H4Z4cD8GXG3h_C8x2LoQwP_BvNHmGTBNBGZsoEa-pA@mail.gmail.com>
Subject: Re: [PATCH 4/4] rev-list-options: fix typo in `--stdin` documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 16 Aug 2023 at 20:52, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Martin =C3=85gren <martin.agren@gmail.com> writes:
> >
> >> With `--stdin`, we read *from* standard input, not *for*.
> >
> > True, and the name of the stream is "the standard input".

That's a good point, I hadn't really thought of that.

> ... but there are too numerous instances of unadorned "standard
> input" in the documentation, let's leave it for now.

Ok.

Martin
