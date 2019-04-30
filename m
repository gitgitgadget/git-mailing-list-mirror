Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B7E1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 04:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfD3Ext (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 00:53:49 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51615 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfD3Exs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 00:53:48 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so2663887itk.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 21:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTF5JC3Kfk74ya2v3hN5B0iZTwi3uA4/YGJeBBu7y1w=;
        b=sOBDe3KQUTDpEYW1MnC1DVS8VhvPU/1sNBAgoP5jG0wX3/whaGYDoVV/D1OCoT0cB+
         XOaC2zVdxVp3lPeVcsdwoVz3+LrshXE5vhPDH7vxOKFMyUxtKseOObrAfwDm6UucoMHu
         VYCy2iEwnB/rmsWH+uNJhKKrPO91V9fHrzU2SNBCr3BFBbqbS7fmzN4DfJJ2xuE5DCSs
         Z8hvP3NVQ7I73K5ai6s8fvTs8mntu6FbCW4p4xmktz6lqZ0mxUxAlsocgM2LhVM0f56G
         3ZWbVMlbL59lEfXZyc8BmH/oB/la8LtgRE+GqME+TViF38blc0drLsV7LS62dAmWOWQb
         fTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTF5JC3Kfk74ya2v3hN5B0iZTwi3uA4/YGJeBBu7y1w=;
        b=RaXxu5IE/QeLqDMtQBDdxPnyoF+pO6JIZ0laHtG0AGtz6txfth3pzAIPwHc+CqxeAi
         Uyh9JE+eWwIQqjFK1RJJfobydAAmHO6TQcYOpXTJW4MiOZ27y/2JSjgs/bgmwizy0kgu
         9p4aUxkrC0VmwwqmyfIFj/CIJmRKXLfrcnVAtaodvnZtjZMKVKD4pA/ahnEYoRJImFm2
         Zn2bohtl36Bm9Wn0NzmaG5HXrCeyo+SgFLhCprD9EIwf9HdAD/7kFZWnoDq2jykFmR7J
         CAW2gpnZKd1t985efu7nQ8BMxEYjgCwGOxMGTaYmTSFC0dUxr5HJhAZGhHuD0hlwQLaU
         Anlw==
X-Gm-Message-State: APjAAAW2NpJEPIaXYV3zsAePpR0txz+U7id+2HN44X2IAqG6jmE6mm4P
        YGE7oOekZqip+fxoGD2DCt//b0ep4kF0ol9aDg4=
X-Google-Smtp-Source: APXvYqwuljILLmRrCF7kv+ZDRtoKZ7PlAGMAya+B5x06YFtdoL6Rl5lRevz/Mz7SOkKHG7H4t/hG5bO0VFlEm63v51g=
X-Received: by 2002:a24:5493:: with SMTP id t141mr1905265ita.10.1556600028084;
 Mon, 29 Apr 2019 21:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190320114703.18659-1-pclouds@gmail.com> <20190324082014.2041-1-pclouds@gmail.com>
 <20190324082014.2041-20-pclouds@gmail.com> <nycvar.QRO.7.76.6.1904292055300.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904292055300.45@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 30 Apr 2019 11:53:21 +0700
Message-ID: <CACsJy8CUNVWqWff05Lg2xjnOj3L2T7RvVbZh+RZPjvFokvT_-A@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] diff --no-index: use parse_options() instead of diff_opt_parse()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 8:02 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> On Sun, 24 Mar 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > While at there, move exit() back to the caller. It's easier to see the
> > flow that way than burying it in diff-no-index.c
>
> I just noticed that this commit message is missing more than just a
> trailing period. It does not explain the change of behavior: previously,
> `GIT_EXTERNAL_DIFF=3Dheya git diff --no-index a b` would silently ignore =
the
> external diff, it would have required an explicit `--ext-diff` to pick it
> up.

Because I was not aware of the behavior change.
--=20
Duy
