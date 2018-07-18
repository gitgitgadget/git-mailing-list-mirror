Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A21A1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 21:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeGRVmL (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:42:11 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37268 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeGRVmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:42:11 -0400
Received: by mail-yb0-f193.google.com with SMTP id r3-v6so2415042ybo.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t6mSIWRjVjZWUm1tkEg+y7Q1sLTz9OWNaBty4N2dq70=;
        b=V45Pzk9OljGwW/SB69f7U3B4nFa7AnZiwPmfrPUpyEwaluW0FwWT9tdVopR6k5t56O
         fIZYcbMOx4XNUbaPikBptbxukOzYkDVspb71M+hOYofTvO0DXwCWPSaCBOFDqJ7CSOkN
         C/DE5cXrog6otreuoKmIea2FombG6fwYlKNC08yX8GbM1dBXKwSdMmBOqnZEF0pMT67Y
         otJvaHp+j+pqT+pmURALZEdC0YS10GgdportHdWEQYR/YqjLoQFXkrWRgDxtRJ2QeXW6
         V93OAJroLV8RqIinVDI2Z+vtVLYMfyj7SiPghEleUAqNFi++VxkahdkkD7MioDEahNAy
         UDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t6mSIWRjVjZWUm1tkEg+y7Q1sLTz9OWNaBty4N2dq70=;
        b=Qmhy8uZXtmeMoYosJTBrXflKgiSTjOI6kfUt1xAPpO1XxyFlAfyST08WZS6praJyCe
         EfTuLy4ovoonDsy3xG5d4Sm0yHrzWTzb8N9QnZ4qBcCkJEAXmn5uCWxkm0iBJx8h3oKl
         BQ2XRmnPqjG2LRkxizYDj7ZCyyg/uK4iYJGgK1PXAbLtjvlgTjYvGsWINpRJr8ilWdvl
         BSMNFFHliz4pjP5DpHf48PQUVx9gOecNcpPsURvr/KTwGWgx5VhNFYMwA5L2qqsYwLHf
         KAqMRxLg3RERMQTJjiKDmRotHlQ8mE1XiAsJF0ARXp8/hChfVkT2CiPL2naVrz816clh
         q4gA==
X-Gm-Message-State: AOUpUlGN8KHSKc7r4ahqLbRbm3g0LRLy57tD5M6NykmGNcIjUuSyD3sk
        myYkPiadlOLwIf5jAQOUjl8fUliC4j5KIvIVOQCQy/WPWQI=
X-Google-Smtp-Source: AAOMgpd4ZXyFCNo5nBQK7w0p3diT05EWywN7mMmonAXyJ014ZZD4RE4tFySeKBlP9RZH8fXtZFxTljnVNt8IrtP34YY=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr4108983ybp.352.1531947750179;
 Wed, 18 Jul 2018 14:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180718204458.20936-1-benpeart@microsoft.com>
In-Reply-To: <20180718204458.20936-1-benpeart@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 14:02:19 -0700
Message-ID: <CAGZ79kYkoK6R83fQXeXMunzxXYLxFiO8z9+cDY8Ku4fsR+9-TQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> don=EF=BF=BDt

The encoding seems to be broken somehow (also on)
https://public-inbox.org/git/20180718204458.20936-1-benpeart@microsoft.com/


> When I brought up this idea with some other git contributors they mention=
ed
> that multi threading unpack_trees() had been discussed a few years ago on

https://public-inbox.org/git/CACsJy8A0KUyxK_2NAMh+da9yithZM5d68rhqEVZe3NcMx=
inAjA@mail.gmail.com/
https://public-inbox.org/git/20160415095139.GA3985@lanh/


> the list but that the idea was discarded.  They couldn=EF=BF=BDt remember=
 exactly
> why it was discarded and none of us have been able to find the email thre=
ads
> from that earlier discussion. As a result, I decided to write up this RFC
> and see if the greater git community has ideas, suggestions, or more
> background/history on whether this is a reasonable path to pursue or if
> there are other/better ideas on how to speed up checkout especially on la=
rge
> repos.

If you want more than a bare bones threaded queue, see
https://public-inbox.org/git/1440724495-708-5-git-send-email-sbeller@google=
.com/
for inspiration.

Stefan
