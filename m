Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B79420188
	for <e@80x24.org>; Tue,  9 May 2017 10:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbdEIKRI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 06:17:08 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33016 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdEIKRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 06:17:07 -0400
Received: by mail-oi0-f50.google.com with SMTP id w10so81434064oif.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 03:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B0YZoT/yyUzIp/HdS1nD/8Rw/Og//CrcR4QUju2AFbg=;
        b=I3t+CSEFO3ccuvlgWVw59bgeKNAdHnI9JkQLY6ZWo95zppFqwA8drWQBwdeIfnfTsX
         8yMazghW6CphS/Na4zYuIbO6V5mSfnzgFjjHCVv1N5yl4bc+qXODxB7u0brEIOnk7Caa
         rlyWrGBnlt+5MaB2eLJc6zI2oK2wB5rWcsEwVdfQ3iYQDAjRaaEwZtYV3JP2lzuvLvEM
         bCcR0qagxOtn/bPftLBqh7+H1sloLXr0kaL6bpzQIUIpKffnvan+wCDEiHUDAwCl44SU
         RxWX0IL3xW8EgE5v1Dhi9H3VN7BHvfW4bLDoCuewU3GicyH8rQge8evd8pDl/Iy1O9b4
         tzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B0YZoT/yyUzIp/HdS1nD/8Rw/Og//CrcR4QUju2AFbg=;
        b=h/GjehkW7tLXe0KDdXWVMhUM5qnNcYgwOEWx/63db2cPwwqpoAfewO9OAgvW5VC2NR
         CuEHvfk6NDi8rCwGNZ9D8Ib5bTBWNm2QdU6PDTLY+rJaFolH3sjpWE5sKMfK0lKgvdyL
         lLYm0B09Lobha/ZC6juqNTbIze/KVyOacOV90CaKJuXoaZ/Kmpe58XTtMTtjwnPXsy6/
         IUwCOZzxx2M5O4SME4qe5t+1KR0jOoNWKWoUbgdcrYLcjtjhHMwIOFtjfRSdfuamUlm4
         25ifW2ghhxQLEnL02S1MaoRsGPmHPgigiTZ4GBBGSF3Edr92gQn0q6SXfWkTSP8Syf5h
         PGuw==
X-Gm-Message-State: AN3rC/51ZCz05sgJmk5ARbtNCJDqgWf7bb+hza7D7AO0m7lyfl1VQXsL
        x6JmivjSvhBHhPLghf7BRiKly3Uybg==
X-Received: by 10.157.11.34 with SMTP id a31mr24008781ota.114.1494325025928;
 Tue, 09 May 2017 03:17:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.140 with HTTP; Tue, 9 May 2017 03:16:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1705031720000.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com>
 <20170503101706.9223-14-pclouds@gmail.com> <alpine.DEB.2.20.1705031720000.3480@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 9 May 2017 17:16:35 +0700
Message-ID: <CACsJy8BHMk4Xe+vjDke8tVUwMYsu5HCoLHVF9tArhE6L0Hu3TQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] remote.c: report error on failure to fopen()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for super late reply. I'm slowly catching up.

On Wed, May 3, 2017 at 10:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
>
> On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> There's plenty of error() in this code to safely assume --quiet is not a
>> concern.
>>
>> t5512 needs update because if we check the path 'refs*master' (i.e. the
>> asterisk is part of the path) then we'll get an EINVAL error.
>
> So the first change in this patch unmasks a bug that is fixed by the
> second patch?

The change in read_branches_file() in this patch causes the failure.
See the original report [1],

[1] http://public-inbox.org/git/3a2686c2-6766-1235-001f-1b5283b5f408@kdbg.o=
rg/
--=20
Duy
