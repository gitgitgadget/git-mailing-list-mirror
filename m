Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64619EE644B
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 10:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjIOKFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjIOKFg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 06:05:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B693A89
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 03:03:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502defbb0c3so3318205e87.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694772182; x=1695376982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqS96brzMVxcklx49frovKNPD+ZuTTmG1gYZNObqMw8=;
        b=CjSpu4psRcNIbNM+Uq7KygHWeOSotPjvio1/5oqztgSgl8ZdwMZLlwifAeGF9nN4Gl
         wiUNraIyP/CEMgk8fXRBtWGo1HjXmYtpHxlT52nyN6cusfREK+MTCPGGkFiZQf2zE2od
         DVdsRrNwK10Sc4bMpeacfhgiJ+sclTP0vywJG3P+my+XRZsy2qz/aPQy7oSbLkHIduIm
         08NBpOIEK/sdFYx4FlbASV0KKjcy2UdCouZJ6zACfh1pkMZQVtdHKL2cz4lxhFJKwTY+
         KkL4aacOD63HIv1AOStII+MCGGsEZjbmB3XwnCNgvSkw9YG+atFMF/bLZykVM5d9GPM1
         TG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772182; x=1695376982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqS96brzMVxcklx49frovKNPD+ZuTTmG1gYZNObqMw8=;
        b=DrG6wsSQw5+S1rZ7phtPR1HkndvO0AazwmeNsRnI2o3V+9iY9Yb7+49elDacUqoAYP
         zx37oqQ7v/tijRubHYDKfrhTLTBrYFiSpT0kCBFd7c9L0CVhRrctfQ4nLmIdoypLVzTR
         zyE/LeplooowM6faGUWU89S48axzkooTS1upPt3yemTq3OI7babMrig8pV/B/gCLlWQm
         IEmGRhXde6CpM7zsIADqybcdG5NfeVdjqI0DD643YSdIVQRR3UB8WsHW4NCJJ/KdQN2v
         SwQz7WpcvzTeDLXW0Tnt+D9FET3LfW9Rv6duQR5T+mH1luPE1q7U3iXacgKL7JTPybOi
         lsMA==
X-Gm-Message-State: AOJu0YyOg9rqY8AA4iHkUflXDQYyU1PKPTej6NQ/ztUvAo6Mx30EUKiW
        qFtvnMjofobcGRrI/OYgZ1uEO5S52bOAJqFShOQ=
X-Google-Smtp-Source: AGHT+IFncF7pbR9ykGenZOrNxYysivuLUCZ594iZMkLKBDRTISTP/sCetE2uU8S8LdZ2dsnto8Vy5/+L38LqZEaYP/Y=
X-Received: by 2002:a05:6512:2396:b0:4ff:a04c:8a5b with SMTP id
 c22-20020a056512239600b004ffa04c8a5bmr1329664lfv.47.1694772181417; Fri, 15
 Sep 2023 03:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693946195.git.me@ttaylorr.com> <cover.1694632644.git.me@ttaylorr.com>
 <f4f7b4c08f682b5ebca474e8c1d51d31a2da76b8.1694632644.git.me@ttaylorr.com>
In-Reply-To: <f4f7b4c08f682b5ebca474e8c1d51d31a2da76b8.1694632644.git.me@ttaylorr.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Sep 2023 12:02:49 +0200
Message-ID: <CAP8UFD043ut1h-3SW+YLoT1ZpSrRHBMi15w6rMmKqAp2UbV0Vw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] builtin/repack.c: extract `has_existing_non_kept_packs()`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 12:13=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> When there is:
>
>   - at least one pre-existing packfile (which is not marked as kept),
>   - repacking with the `-d` flag, and
>   - not doing a cruft repack
>
> , then we pass a handful of additional options to the inner

Nit (not worth a reroll): I think the comma at the beginning of the
above line would be better after "not doing a cruft repack".

> `pack-objects` process, like `--unpack-unreachable`,
> `--keep-unreachable`, and `--pack-loose-unreachable`, in addition to
> marking any packs we just wrote for promisor remotes as kept in-core
> (with `--keep-pack`, as opposed to the presence of a ".keep" file on
> disk).
