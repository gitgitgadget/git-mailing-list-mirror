Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B672C04A94
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 08:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjHDI3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 04:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjHDI33 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 04:29:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15114C38
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 01:29:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5231f439968so246863a12.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691137745; x=1691742545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o09gS5nJtGrwgpp1IED1bOXEdJpSWW0zCpAmMESUB+0=;
        b=IZWOpU5lYWN4ErxQRjZSp7XEYAn7OPwplau5FL1tqMAIJQEi8WotDFJipmR648FKHV
         Mim/D6jA+wROebIzr/AFYMREFBXD3Ekob36Fe47EBnqJeFSVIuVCKB/0W/OclsDLGv2T
         LXVykm5qBLmGKSPT2TWRwbqVkm9QBbE8LSyx8j2KV1Kmx4/lJcS8/jdO2+oy99i2C4Mp
         OjhaHRPzYWB3i+8o+frY66BCXGvS2hs6bpEatWCP8lAUGZt/Qq54gV0M6ddMvkpP/vQn
         5W5gVfK2MupFphMtfN19AIY6V9H0g+HyJN+SoulCMaf6PsnM18iAZ+ZQcQCI0sfGiMcs
         o0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137745; x=1691742545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o09gS5nJtGrwgpp1IED1bOXEdJpSWW0zCpAmMESUB+0=;
        b=EBvTysUvMbQMPruPcJveyLuljYOtBxi1lFmN2S+D5Vqt6NPV/rjSeq2XodY2x4C/lQ
         sSUekkt1JQRaD3RI2hAx5xIubFfMSYzPAd56pJwTQcy83mU3zsIvdzoglht2jxJjtV05
         x1Bpzf9EWobqX4LNgABSbDtET7Isoda6B6PY6piDAxwfXzjIuEMO1gdV1ISm9qNqkqXR
         28W5BYrgt2ckyzyQn39B+VH+LlaszkrM265TyRUpx/HU4lXA+dbTeRfdCMSrrVth9la9
         lb7FWRAwUVymFzYfuGwT7ok4I15+f0j24gNzQlFLKMG9ZvR13BM/SxjUsza12ncNXPhP
         055w==
X-Gm-Message-State: AOJu0YyHSJgiuIU+5RvYfX64tcfgzqVv6p5ac99mq8me9VWj8rWqI5Kk
        1nAAGaUyklvjCwSuBIU5Jb87r0sauJbAYU/CokA=
X-Google-Smtp-Source: AGHT+IHr0YjMLxZWg3CmusYcotid2huxKiVKwSbkmRrQGnb8sp+VbddGNG/2y5J57+ggt0W4QKB0MPiwrOtL7kh476s=
X-Received: by 2002:a05:6402:1111:b0:522:30cc:a1f4 with SMTP id
 u17-20020a056402111100b0052230cca1f4mr1115700edv.0.1691137745152; Fri, 04 Aug
 2023 01:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g> <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <xmqqila6cz0n.fsf@gitster.g> <ZMKtcaN7xYaTtkcI@nand.local>
 <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
 <CAOLTT8S=_1Vd2Y4rBqq03JsJ1megRBcx9v-HYAWXe88jDek98Q@mail.gmail.com>
 <ZMvGsYSystLu6oBY@nand.local> <CAOLTT8Tc9NevyUfwiPscEH7BqShSscb=iZP4r+7mjsEwouLeXg@mail.gmail.com>
In-Reply-To: <CAOLTT8Tc9NevyUfwiPscEH7BqShSscb=iZP4r+7mjsEwouLeXg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 4 Aug 2023 10:28:53 +0200
Message-ID: <CAP8UFD2GV+1LhZDrSsgQ5=gRgYSTYsS36i2ugoBEHu-Oto-Sow@mail.gmail.com>
Subject: Re: [QUESTION] how to diff one blob with nothing
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 4, 2023 at 6:42=E2=80=AFAM ZheNing Hu <adlternative@gmail.com> =
wrote:

> Actually, there is no need to support a default empty blob.
> For example, with the command "git diff --no-index <file> /dev/null",
> it can compare a file with /dev/null, but it can only compare <file>
> and not <oid>.
> Therefore, using commands like "git diff <oid> /dev/null",
> "git diff --no-index <oid> /dev/null", or even "git diff <oid> --stdin"
> could potentially solve this issue.

Maybe it would be clearer to have a new option, called for example
"--blob-vs-file", for that then. It could support both:

$ git diff --blob-vs-file <blob> <file>

and:

$ git diff --blob-vs-file <file> <blob>
