Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3E61F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeBEUAL (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:00:11 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33096 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBEUAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:00:10 -0500
Received: by mail-yw0-f182.google.com with SMTP id x24so19270203ywj.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6i2vo5abIJft3jMR+b53Q4De+5LzU+a8IwQUYk7hzAg=;
        b=h9b8cZ2NhKJ4PBtmotYmVWDW/DvhRFAPQ08UdoAqkEf52QsM39LP7DJo69Ri/Py30u
         h+ppWC+7SdnTi1qGHjvdAzw6/DQrMGBlgOj6FV/+VYZBFuUo0y/HF+EAR1McRVROmDhw
         znpWoAByqidK+AuQDL3mUT+4Hvn/JQMiuMNMoFINB8aSx7OKfQniPAu0rBtaceDWfYpW
         R1Fey1qytBIg7BMih7u/34V9thE1Opuu8kcwJ1kjd6z/WlpwRhpw7lDbCKnruvHXODgR
         fJx0w6UdYe6/3BFl0eX/XCoyD8Xg9vUrNiClBW5zTA0xqXKokh+dziolfh5Z7S/gTCbW
         4xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6i2vo5abIJft3jMR+b53Q4De+5LzU+a8IwQUYk7hzAg=;
        b=OSkJt7ws3iBEF1DRLf6BqPWGLd/T2JatNvxRakhPcHoXe/7tUFuX1+NY7Vlo/zSZp1
         PxMYmmL/J3cL8HQJb2WeMjmRVGFbOePXqcKxp3k+TYnpZMRJ7DX9+eGozna+3+QPZlYh
         Rt4ehEZCbKeC4Cyfb2vXo60a7fZng6L8Hbwc336n2yG6zRw2TeB2w5ruTiAcuY6xJcyY
         rm4oQifKd4GXEh5QwgX9bZ2Kgg1DuGXNNznNzJM37IlKKqGOcrKpx+Nq2UpsmZ+kSslm
         9p8rGtlbK26SEtKyBILpyi58s1rs6QKibTYbhG9jEKBq99RiipzSh9B9fmUdoKyiWkIQ
         dd3Q==
X-Gm-Message-State: AKwxytfabJALJvN/horx90jozyqVD3emdBQpgdC8xFfpxZ7h6DczLK2R
        C/GHoPOwVA9wprFMlmcSRDzm8S8XhQkJLPj0GCxicg==
X-Google-Smtp-Source: AH8x226X7+SOaMi3iXfkA0Jvvk9uk6oCepDmTLcW6H9sB5WsPDPSR7hUXvKkaiv8jc8v5nqYmEPfwEJdu8O65fdCnE4=
X-Received: by 10.129.108.149 with SMTP id h143mr32157402ywc.373.1517860809109;
 Mon, 05 Feb 2018 12:00:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 12:00:08 -0800 (PST)
In-Reply-To: <20180130232533.25846-21-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-21-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 12:00:08 -0800
Message-ID: <CAGZ79ka+Dd8Hr_CZwnkpYLnc38CiHPLe18OAbzjHBGUFv+Da5g@mail.gmail.com>
Subject: Re: [PATCH v7 20/31] merge-recursive: check for directory level conflicts
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> Before trying to apply directory renames to paths within the given
> directories, we want to make sure that there aren't conflicts at the
> directory level.  There will be additional checks at the individual
> file level too, which will be added later.


> +static int tree_has_path(struct tree *tree, const char *path)
> +{
> +       unsigned char hashy[20];

What is 20? ;)
I think you want to use GIT_MAX_RAWSZ instead.
