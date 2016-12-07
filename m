Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E8E1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbcLGUxg (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:53:36 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33433 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbcLGUxg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:53:36 -0500
Received: by mail-qk0-f194.google.com with SMTP id x190so50253790qkb.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 12:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XS/I/+VnDo9ApyF1QBCtSg0JwOq2JKpWphwxDIjjcBg=;
        b=nyO2KQ3dSWBMOhMp0mYh3C4+9wBCTrrjAXrapl5bFMO5rsGOjdqemiWyp6nmgM9G4t
         ME7FiOmbiVbxGsiuC69uGZhv6OH5Y7UxtLT2/xqetwI3s57MxHmzUjbQnJ/ANdKoS7Tu
         trrRPNaRwCbRiFcSjZJQ1Ez0Zbv5RCLE4uhLcUAtXJaM2P/5XpsrENhURAV6YA4Y7Fo5
         lRo8qzr6NnGshsOtte9Jr+rWQRdT0FdZpHafQLqd/TqUu4BuQsiI1C95TmSLB2w6Hwe4
         IbLJS1M/etOekeHKGIE8g1SLh56WQ8LyKw6sKZcTKN+d+7Fch6Xw44VvzgvY2c41JwFw
         MTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XS/I/+VnDo9ApyF1QBCtSg0JwOq2JKpWphwxDIjjcBg=;
        b=TKl/b0eUwYKPdeyEzBbrJ5nMG7/oMv9Cu6uRY63b2t2/+zNjec98NYXRMmqF0hOkSY
         6en5oVe4QCmuyQpvUVoqYbjJbugd+ELYTQhOLHAP0knvFadnDuPLYkoyl0g2U9rD6ekR
         Z+YiVeE8n5AyuexgftPUiVgsVtZUUkhJkW7Jffd9bsFuyKF5D6OryIm+gipwK9DyI5fS
         r1XuKkAg3wkJPkLgkF/q3yQLySKQQuzLzUqXbdlT3+QA4uA6Qw/obbqa2ojX9rME9KiO
         LGyAXFceelF4cMMm/Ei0HPFl1jzij2MF1dsoCCtY3awQhxPSWOUTs18vsgE0lz8UoWsS
         1tJw==
X-Gm-Message-State: AKaTC03bWyjgHHXS/kPH3N2/VdOJ4aZwQDu3lWexluCzAknRAsGKBWW8pzo8xB03Az2zoCu/0rYcgQgzJDfh6w==
X-Received: by 10.233.221.130 with SMTP id r124mr60640703qkf.183.1481144015121;
 Wed, 07 Dec 2016 12:53:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.36 with HTTP; Wed, 7 Dec 2016 12:53:14 -0800 (PST)
In-Reply-To: <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com> <20161207194105.25780-1-gitster@pobox.com>
 <20161207194105.25780-2-gitster@pobox.com> <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 7 Dec 2016 12:53:14 -0800
X-Google-Sender-Auth: MwTjtOBLvZrVNkdt-e2DRTk6ZCY
Message-ID: <CAPc5daX2CZ0=UBMuz70KwFPBDTUgAdi8WoVUJ7gNTq+QEXKxbg@mail.gmail.com>
Subject: Re: [PATCH 1/3] wt-status: implement opportunisitc index update correctly
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 12:48 PM, Stefan Beller <sbeller@google.com> wrote:
>
> So I would expect that we'd rather fix the update_index_if_able instead by
> checking for the lockfile to be in the correct state?

I actually don't expect that, after looking at other call sites of
that function.
