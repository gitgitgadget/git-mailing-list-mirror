Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4497BC33CA9
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 01:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DA121556
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 01:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC/sdi0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgANBiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:38:08 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:40429 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgANBiI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 20:38:08 -0500
Received: by mail-il1-f182.google.com with SMTP id c4so10000164ilo.7
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 17:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kYWkHXG/ZOAvlL8ldVreNFXiahmVYggY42mvh+QE3hc=;
        b=NC/sdi0k1PGgpkrPwIcLecmvdfHB0+yuAds7lW8XjiQD4b3ZZ+7gG5nkA9wnt58W4J
         uYHo/Vf2NuNMaoIQ5xfpS7S1Qffk595LVkGzGV0WXTvTE/6h2pd6DpyKR++PR208hXzq
         /ls6DwgoAZLDQ3dAN5A/7fZMPagFniOb6Dvehmv8HKN+Nh1Sgh10+mQNPGPZqNX9J+c0
         hkVMuFA6IQa4hxKjMRLECUYkDHK7Cnmj8AYL/pebdH4L+TlueHwrg+82W+PQ1IM+8o7F
         9wqCC42osJFiDMp5rrBSO84JaryhrRVgL0WFLhUIc0FJIAIFDX7fjxM+YQiyOM8mbwCB
         tI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kYWkHXG/ZOAvlL8ldVreNFXiahmVYggY42mvh+QE3hc=;
        b=mvLHmHWTNQAS9B+l+gsCH1A97UB3Akudor0ajFd4kLbLPr/wQfi+Niyiw53CrY+pZf
         BFwT1uG4mI+CIDLH9dP1/HUWRJ74JCcXke+FtCCsxm0HXn2jFbCfmTcd6albWO1EFsMk
         7rbtov16hBtfY/7TLpCRO4ktU3A8IgeGYoz1JOqxqgx8Q2LswIlMmF5oIbRWbXmnplij
         qhSuIq1T6hbKQ2lWso+X/qt5SdSHC4mkYm0S1pdIkuVBPbS3g5h6JC3V0k5uX9WTk5MD
         TV9b5j4202bGiLSMfEJsxRb72EzBJd4YPds8nOLYjcUm5iuEUndXy+QhzZ+iTDiyRjJO
         j9wg==
X-Gm-Message-State: APjAAAUTvOtneHv5iNoxV+xXUlkhqBNR+nMLt9tZBX4OUinLmRPVNw+w
        KigavdWKfyHyBt4DhJja7MofMyWfUvn62j1fXr+1LSVlGf4=
X-Google-Smtp-Source: APXvYqxJLMrbHc5Cq4gjU17nR1DxPJrjQyRVkLv8mr3S9E9jDgeEuCSI64X30Q4+dNIvOgfGa/3fy+HZRTpCNamSVds=
X-Received: by 2002:a92:8dc3:: with SMTP id w64mr1182765ill.68.1578965887443;
 Mon, 13 Jan 2020 17:38:07 -0800 (PST)
MIME-Version: 1.0
References: <CAA07yUgTW9-ba_Hynoj16sX4892FUhLxSy_fPwyc6p4aHb4fzA@mail.gmail.com>
 <CAA07yUhYMM8MkC0rdE5OGStjycgQbp8bnk1VTBhZEgRLFHz2ew@mail.gmail.com> <CAA07yUiCvVc_GhyWwXpvOmSuJroSHTspAqVNgHPCNpv=4+=SyQ@mail.gmail.com>
In-Reply-To: <CAA07yUiCvVc_GhyWwXpvOmSuJroSHTspAqVNgHPCNpv=4+=SyQ@mail.gmail.com>
From:   =?UTF-8?B?Q3Jpc3RpYW4gVMOicsWfb2FnxIM=?= 
        <cristian.tarsoaga@gmail.com>
Date:   Tue, 14 Jan 2020 02:37:56 +0100
Message-ID: <CAA07yUjg0q0r7PvALU4h4ZMicHySnhXL+ryXQAy_GYYZhvac2A@mail.gmail.com>
Subject: Re: no documentation for - git subtree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just noticed that https://git-scm.com/doc
shows no documentation for the git subtree command.

1. Is this the right place to report this problem?
2. Is it missing or am I wrong?
3. How can that be fixed?

Thanks
Chris
