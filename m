Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5A4207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 03:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980418AbdDYD4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 23:56:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35080 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977289AbdDYD42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 23:56:28 -0400
Received: by mail-it0-f66.google.com with SMTP id 70so1459559ita.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 20:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6raFdunoHUqXLNtq6fsurmEmrM1H8x7e5KYgdGfanrs=;
        b=KwPD9lnpjjoiHeNAunvC++Kw4NrD5HWJSx6Vf8LjZXyIqvqfZftX6qR30D9wqOEduI
         vxF0oUP/K+OikBOdVQedVD43oYZNl+7p07UzphdVydluCWaLbW6oFb9h+DTPBPvF9n/w
         u19I4S0OBZj0GizROpOeElSYPC645BO/cOOo9MBBCHGaEiaSu1be6UDgC8yvqYqgyXc4
         JiK9UYY+7JcX+XliFKdQFzckNe+OsTfbq1U0d5OdvumKAdSpUuPHgm18jSmoiKFxetIl
         2OOc2S73ylZTSIc+hii5GjLAm3lAxzwftg600Wi13pf+R+hu3g/eG8dr5n7eAsjmOgGG
         QcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6raFdunoHUqXLNtq6fsurmEmrM1H8x7e5KYgdGfanrs=;
        b=NiHFiRBq+BwqCrUpKx1GBVg8bueYbDnR5Ui06hvdvj0tCAh9SLOIhCAk7oEid2YwwL
         O+0xUPPpxhQMl8u1QJK8SgoOIwNGnD3Q2k2EJuhJIp0GbhrzAtq+F13kTcbWH/z3ucO9
         VCL9JJSVxMawMWmVmvSjgEczUCVdjqIiCdVroFcpJlykS0Hgg2liLrOsVSIce7Bys9oT
         iS2QuXaasC6Kg8WScDjzqYoSRm/W5oZeDYebjZxyyraiw61aMVe4bZmyFegOC+6Ju5U8
         OsIaSZxQ7cIhU+q/aCoDFr+GxTRs2LCkoRpkpCj5XrW5D97YLu/BJSAD0xKgomEJVntF
         MTxw==
X-Gm-Message-State: AN3rC/6F2mK1iQqvrM/ifByYPcjvVbhsLt8qkawn4fWguxB4UteGkgVK
        CSjM1MZwyBOreA==
X-Received: by 10.36.0.200 with SMTP id 191mr18646910ita.87.1493092588070;
        Mon, 24 Apr 2017 20:56:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id o64sm1808161ioe.19.2017.04.24.20.56.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 20:56:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 7/9] Abort if the system time cannot handle one of our timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
        <2b7f90c003a1f60ede39813530617edbbdf29607.1492771484.git.johannes.schindelin@gmx.de>
        <xmqqr30i1omp.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704241228510.3480@virtualbox>
Date:   Mon, 24 Apr 2017 20:56:26 -0700
In-Reply-To: <alpine.DEB.2.20.1704241228510.3480@virtualbox> (Johannes
        Schindelin's message of "Mon, 24 Apr 2017 15:57:28 +0200 (CEST)")
Message-ID: <xmqqvaptw36d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The code would also be incorrect, as the `minutes` variable can be
> negative, which the `unsigned_add_overflows()` macro cannot handle (it
> would report very, very false positives, and it would hurt you more than
> me because I live East of Greenwich).

Yes and no.  If we were to care about integer wraparound to do this
check, we'd still have to worry about negative offset applied to a
time very close to the epoch that turns into a timestamp far far in
the future (unsigned_sub_underflows, that is).

