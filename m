Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5599BC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhKVRzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhKVRzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:55:38 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A19C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:52:31 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id n6so38330547uak.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uCr3QaEIWR1dmgIhCZtzKgWK3J1jwbW7NTLafdWtl0=;
        b=Oqca/XWd3NdPjqoqo6Sz0u+Oul2tnO8F1bHz6FFNco/5NMV+VzuDqFoGO0J2WF0R6j
         LBA5c5vnMn/PQD9jcLfzphNBWlowZnlkDAqjTrkojoI0byLLKvcQhXW7ciX0F2TFDE/W
         Tun0VtyaBp1W6P3kbrxTWdEBlE2xVPGrFHs4wgfPPgy4y0FCP79vcVarG+mKEJFH+mgK
         auQTzXLYPFyeHN3yviQEGfnW5QYDjgKl5EYJPicJOuh5vm9Um7oJ1DxoVilJupscJlz1
         S44ubOA3OdTQ1NvKtNJaRIW872SM+eExxTmDcQqosqRjt2ZeOZe7WZkjzhC+dlbsctL2
         x4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uCr3QaEIWR1dmgIhCZtzKgWK3J1jwbW7NTLafdWtl0=;
        b=TomLRwvgUTVc9UQYVA6R1I0zyYlmWiK+M7zE8Eblw1pQxTvEbFDRZzEag4mgO4tYqK
         XblIDHUy/Lh3Laa6A0sv7UYoYzjQBFnG/0h3NW0Cdm1PUndK5vDs6UH2+nvyJOBGaqSZ
         9t1lC+CuMERZrlPqS3aPG92LaRthIgSOc3mvEGdMUFlul2uURKdKQ7iRotiTbKJlVW8M
         MFbGwPej4U87dZK+FIsOxtTXUGf+t51PBrCRAMFcP6JTGyTvyjcMxKYFBxRYXXkz6Bbb
         Uia4PY6T5ryX0qPfqMNPKz8SUtmTNtUFCNhWX/Vu9tBr2kXxn4Q4YYjPLVFybm+rwCfS
         OnQQ==
X-Gm-Message-State: AOAM532k7TXYNUz2G3Mi/Fjwb0EfwKx4qxFZZ/5OavooMIBSuUJSfZ0L
        /F+9I40167f7ooMCC3dqNQpJWh562nmqdcs93DHzwMVT
X-Google-Smtp-Source: ABdhPJxvLu+muQLN15dxJw+3Zq+VIrUNqa/DcVB5L4S5zd45dWKTU/keCaCq5H+kaoccZr5hFKgrEfeDOOnX3GcsXkU=
X-Received: by 2002:a05:6102:512b:: with SMTP id bm43mr134226454vsb.14.1637603550460;
 Mon, 22 Nov 2021 09:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net>
 <20211114211622.1465981-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
 <xmqqk0h7423v.fsf@gitster.g> <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
 <xmqq1r38hzi9.fsf@gitster.g>
In-Reply-To: <xmqq1r38hzi9.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 22 Nov 2021 09:52:16 -0800
Message-ID: <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 9:27 AM Junio C Hamano <gitster@pobox.com> wrote:

> I had an impression that it was claimed that without this, the other
> weatherbaloon for "for (type var=..." would not fly in some of the
> jobs we have at CI?

It wouldn't if we have a CI job that tests with gcc < 5 but the last
version of that job died with travis-ci.org

Carlo
