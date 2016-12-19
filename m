Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5EA1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758207AbcLSU51 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 15:57:27 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36542 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754419AbcLSU50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 15:57:26 -0500
Received: by mail-qk0-f169.google.com with SMTP id n21so23143199qka.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 12:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fAetDFATI0CdhJb4h5y+hlLTr7VH4QdFwhw5Vmc9WGc=;
        b=vrhzhCXiYOBWQyHfSZIkAYcL+c1J5wOg9yX7LgMzSdneU7YE+qIvPsVzM3JBP63VKD
         Q+GJkBYe7f5uuknnU6bTAz8tl/Tge6QlKy/PKxV3x77l89wT7UZ6E4tucdFaq0wI+mVc
         0AQmFgMBzamxlvO2t0rPsK8NSozmjv2ReXNM1MnYIKQ+HkdCM4iiodnU7BEb/Z2N5bX9
         cSmKtO+slFPZo/nwU6z33ZQpIhRSPLazq7F12VVF2QzU3wTTHJ061GxlYR+V4dv5P5MY
         QHXnZ7LfjeHeMtuJRf+A/M9JDuNRhDn39yPTeD4v02FQz7eefBBL05Z9nDaWzGBLVSPi
         94LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fAetDFATI0CdhJb4h5y+hlLTr7VH4QdFwhw5Vmc9WGc=;
        b=fdnNxlWgXufOmGhsyGH40K5QM5c/PMFOo0gvNC1ca/UO15eBiRDKRZCkkfTltvHhZW
         268p+hd2PI98ER0d2K5VG+y0Sa/VGUmimH2phyjrIvTUXLwQpD05Bid4AZLaEGOom2W2
         r7LSM5GEnz90wS4E/u/3/BgQZ9ny54IyMbSmAc8OF+37EQS4tddprBpgHy8pDNOWlg5P
         lIEZo0kdNgg6kgOa9M8CnjHfoj+nem6EVe4G3alq0jf+hdGyGDcsNqL1GE5WssToiyKD
         j/CPKKN4y4KNKlNZC6lafs2NGE8Nk2LKtFI9z4BS7E4qSuiD5cp78780Vz2niN7VLpA/
         6pEQ==
X-Gm-Message-State: AIkVDXJSXvjS7odC5Axra/Jsd4CwZyIAuXmukohgoD+jVJSqrbpdevghYD9BeVH1guY84eN+VA7YggJoPE+cLcEE
X-Received: by 10.55.53.147 with SMTP id c141mr2106659qka.255.1482181045017;
 Mon, 19 Dec 2016 12:57:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 12:57:24 -0800 (PST)
In-Reply-To: <20161128094319.16176-11-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com> <20161128094319.16176-1-pclouds@gmail.com>
 <20161128094319.16176-11-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 12:57:24 -0800
Message-ID: <CAGZ79kbgJ=1j9V1QxmdzoKx60ZnqsJet2VwDH72Kz5PrDArOnA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] worktree move: refuse to move worktrees with submodules
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 1:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> +
> +                       if (S_ISGITLINK(ce->ce_mode)) {
> +                               found_submodules =3D 1;
> +                               break;
> +                       }

While I applaud being careful with submodules, I think this may be a bit
overeager, because empty (both not initialized as well as not populated)
submodules are fine.

In origin/bw/grep-recurse-submodules^6 you find
    int is_submodule_populated(const char *path)

that could be useful here, i.e. I'd imagine you'd change the condition to

    if (S_ISGITLINK(ce->ce_mode)
        && !is_submodule_populated(ce->name)) {
        ...

I guess that can come as a fixup later though.
