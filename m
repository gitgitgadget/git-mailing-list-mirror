Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A87C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 22:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiGYWED (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiGYWEC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 18:04:02 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7371F601
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:04:01 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10cf9f5b500so16537247fac.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z9bmfGXuiP0CPhu/zQe1BanqcxonpyvEjZPgkxxnzbs=;
        b=K7mS/JqTTARSMHXeGPTkYAqKoHFMgg/NfvXrpJHz72NLRHCeAHyfZdAiaTsIHahfKe
         MgxDzISA/UTxmYCsSfrLk6Sgs5+XB6hMl0sqpZLlqHDs8nqh56bDIaKrprX2U01esf6r
         39QUwbK0+3Bc62pr2jxwN58sesnZkkq6ZlGswLozAO2n5X0eAvRVFSGxSm6AnhCTuPgb
         sMzOnDqLA57s0YiaNqB5IRp3mh+avswBx7JIthEmuVWTvIka6h/VQats+fLf/ymuJuI3
         M8WDwf3il6E6WUYgNNB2SHbUhbK/zSOU/QuLEtVAFVGABCo/8OTTSiKWTtd8QwmagFUF
         JXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z9bmfGXuiP0CPhu/zQe1BanqcxonpyvEjZPgkxxnzbs=;
        b=ggLoyrgzL593o2ynQAC68wqYX0rY0Yr/f38A9+I1SftH9JsTWnUU7COCjkSO1+GuYo
         0WhPcBaE2osVe5PxKkg2XsOw0S44VlThkytfV4dxKSOfP0oPZiRT7V787tOQDVent7w2
         XowtEjvSWLTZzWok/MYX8Yprm6DHoIVkgQT+JlnnGBEDxH4EIOJzzS1sDnFGp7ZC0tML
         qhLZrZvwHzgOfvxmQw/9Fit86u3ldn1WgRajAtJRFPOMNvI2gieS8eHBfa5lDPvLzhAo
         tdZbXR28N7cmz7sD+aggdBcL7xn0Rafp0bCazFRhBID9TbjVe7JrXA006EHXBZIfd+zP
         iC8w==
X-Gm-Message-State: AJIora95t4yswaSNiOmkTdBJePx+MLV5xv1dDYNYLmBma4ICjnPz+BKV
        F32SKj2p5HYicQ3qwWSOsh0MXyY6Ie3ecIAj+6CUBA==
X-Google-Smtp-Source: AGRyM1ufHboK+qEeY0Bz+ccYer7bdeleSb/NXzmq2a1g8Bk59OnEBHxTsj4Bbkrl3QTf2shC0HU+5xn/4aPad+d911U=
X-Received: by 2002:a05:6870:c0d2:b0:10d:7752:e02e with SMTP id
 e18-20020a056870c0d200b0010d7752e02emr7320353oad.236.1658786639993; Mon, 25
 Jul 2022 15:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231935.2979727-1-calvinwan@google.com>
 <20220718214349.3379328-1-calvinwan@google.com> <220725.868rohragt.gmgdl@evledraar.gmail.com>
 <220725.86r129pd8m.gmgdl@evledraar.gmail.com>
In-Reply-To: <220725.86r129pd8m.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 25 Jul 2022 15:03:49 -0700
Message-ID: <CAFySSZDrXiiStn9BfKzxjXU-QsR6Bq1cWf9FQHTG-D9kUyHhng@mail.gmail.com>
Subject: Re: [PATCH v5] submodule merge: update conflict error message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com,
        newren@gmail.com, levraiphilippeblain@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

Thanks in advance for the suggestions and catching my memory leak.

> Perhaps we could also continue down that path and do this with just one
> allocation for that "oid/resolution_exists" side-data. I.e. you'd have a
> second string_list in the struct, have a non-NULL util mean "resolution
> exists", and the "string" there would be nodup'd (we could refer to the
> "string" in the first one).

Since I am removing the "resolution exists" field, I modified your changes
to use the util to only hold the abbrev.
