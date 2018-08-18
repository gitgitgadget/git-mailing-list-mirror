Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB2F1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 22:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeHSBKs (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 21:10:48 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34808 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHSBKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 21:10:48 -0400
Received: by mail-ua1-f67.google.com with SMTP id r15-v6so7748655uao.1
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G0kJrEJAW3i7AmwQaJ7tcmYl/3D8rUR6hbmXuuhXeJI=;
        b=nKEKGYc0j5WoAaepM1d/tNMqlYLP75r6dfoxQpVwCYzEZagSw/dqTM/HlNB7nCr1lW
         kGF0dm+Cr86dysCdsyBcVOOzDsqXhRx0ilCyZwUIq+mn+f8iepPQV3UPT0iih/3Xl7WR
         qJ+YwSmtSvsup4aR/XBWTGDMDUAaRYS1CYpL2npNmu/96N/ujwtcADU4eyld3HNbqdcv
         DAnGijlRvYYw0mxPpISOTt45s2mVGiLSaNXSjuS5tKCVr5HFHeSDSrNOxmVrjLd+mHuG
         APhiopQpwaeLJvqjJnu4D1QzF2q/dErZYd+r0TCdKvnCS/IU1MLpHyGYiCe6q6yKpZRS
         ybZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G0kJrEJAW3i7AmwQaJ7tcmYl/3D8rUR6hbmXuuhXeJI=;
        b=O3gVXu2adxfpA0UeT3wSU28qFqCCC+cmJQ4l9TYuFZIPyJUYGBhehTKDMZucEmxEXy
         QAoe1V+v8h/RHDdXuhht97WC1XcSNrRIYs19psc1fgA78zaZY8a54i1fgPR0aZx65qsF
         efEbCPOqCqsgMoHla42I3JRfd/ja4jNJnWmAiNAPPk7iNVJ6ThwRpLoMBo2FHJcaxf/W
         IYSeG/H/aXr/VUqk0dHMaYHLzvxGjAJNyVoyJawjI5kAxMPkoj74J1AhFTKDhu54O3nb
         HSNsuctEvUVjs0XpdxBLfE+LHJ1Lsl3cNvAqO2GqxbOTgslrHjydTyCLRf61HZWRIYo5
         o7iA==
X-Gm-Message-State: AOUpUlEW/mLwZtQDPN3/7/6+pDVditQLGyfvcIgV9cL98JuexfyPXbo4
        wMJYxe+OVL151nDUdiXODioHg2CdfNGwrBDrzmk=
X-Google-Smtp-Source: AA+uWPxaSdfrsE3MrQgZyAAZJVXmZpfaNI8Kbik+HF9Sbs0LJGfJpyFEO5iTWXyr+54gkjB9v23OsPp1qWfwPGKhEOc=
X-Received: by 2002:ab0:5507:: with SMTP id t7-v6mr26268581uaa.100.1534629697984;
 Sat, 18 Aug 2018 15:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180812081551.27927-1-pclouds@gmail.com> <20180818144128.19361-1-pclouds@gmail.com>
In-Reply-To: <20180818144128.19361-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Aug 2018 15:01:27 -0700
Message-ID: <CABPp-BEK-oFWBbjgZBCDaixtmnxrTYtvHnPeT5enHBr9XJ8fGg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Speed up unpack_trees()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 7:41 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> v5 fixes some minor comments from round 4 and a big mistake in 5/5.
> Junio's scary feeling turns out true. There is a missing invalidation
> in keep_entry() which is not added in 6/7. 7/7 makes sure that similar

I'm having trouble parsing this.  Did you mean "...which is now
added..."?  Also, if 6/7 represents a fix to the "big mistake in 5/5",
why is 6/7 separate from 5/7 instead of squashed in?

> problems will not slip through.
>
> I had to rebase this series on top of 'master' because 7/7 caught a
> bad cache-tree situation that has been fixed by Elijah in ad3762042a

Cool, glad that helped.

...
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
>   trace.h: support nested performance tracing
>   unpack-trees: add performance tracing
>   unpack-trees: optimize walking same trees with cache-tree
>   unpack-trees: reduce malloc in cache-tree walk
>   unpack-trees: reuse (still valid) cache-tree from src_index
>   unpack-trees: add missing cache invalidation
>   cache-tree: verify valid cache-tree in the test suite

I read through the new series and only had one small comment.  I'm not
up to speed on cache-tree stuff, still, so don't feel qualified to
give an Ack on it.
