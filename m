Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557BE20281
	for <e@80x24.org>; Wed, 24 May 2017 02:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937933AbdEXCox (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 22:44:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36605 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937917AbdEXCos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 22:44:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so31207590pfb.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 19:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3evBBZqapkA/1Lw4gjGi+yxsLOQnJJ1BdUxy8u0TaUM=;
        b=gyvaV7VsGjvCowW1EOxgngNLpuPp1ziKpP2Hxc1n5hf5tXedqP6gjl5v5maoV2nbB7
         67D+ASj59BnmLuoDyFd7qdjodlIEuYKLDdNQRKG/ukowGRw4+jYgW38ONsugFj8/Gece
         g0+97d4clsNTRBbuU2dDWIhYyrjK28gf8xk3LPVLDjPHxX2oTcHWqBle2eR6G78i32gp
         rbhU1zyg0dgYANTbcmZwtXNwvCbTn7//mZH7Cn3v3TUMn8dhNIKoOJ29bUFT91IueMS2
         MZBLt6IRiChRo9dOnE8c4yFdskmAKSs/Uq8Tz5HWu5SFvGsfSkDMHz0Z6g4QtKdAVpW3
         2M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3evBBZqapkA/1Lw4gjGi+yxsLOQnJJ1BdUxy8u0TaUM=;
        b=bnfxvQMF+1waYn5aU7UnFFPOCMsEmjuLYjjSd2proKa+3TwBR07rq5MrQuPRFDDT01
         akfatye8ypVn3v2n2+z4K4kTP0+9FbfjZdqvVzys1RXNVH1DSL/w06NS7FknfaBeEPbS
         bViQRKPtJqrPvJjCPPDIz8uVmVEnngnHRy6ZwhWO0hAVPZ361e4EK8G+3msZy77Mq2Sr
         uGChORDiWmh1ixHppFB0qLLzSuXBTSlpvusj1S7/MLcHY65jiHduSVmMxd/yqGiXn9rS
         CuPgYe58jpMBfRVmwY68QNXUPqV0XR3I32LYbYK5UjZRKmJvCNoJcQy4knoWwZt/HV6M
         cNqA==
X-Gm-Message-State: AODbwcCNFxlqsjEsVX9tqmpQZU0UJrK3fm0wbgMGyHVeEVpsJYVsBMxa
        jFwTd9W0uLwr5A==
X-Received: by 10.98.55.198 with SMTP id e189mr36151141pfa.38.1495593887644;
        Tue, 23 May 2017 19:44:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id s18sm4145587pfi.16.2017.05.23.19.44.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 19:44:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/15] retain blob info for git diff HEAD:foo HEAD:bar
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
        <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
        <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net>
        <xmqqshk4z2hv.fsf@gitster.mtv.corp.google.com>
        <20170517020535.qqmw2yncfomd3hfb@sigill.intra.peff.net>
        <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Date:   Wed, 24 May 2017 11:44:46 +0900
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 19 May 2017 08:46:51 -0400")
Message-ID: <xmqqefvfht29.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches around [PATCH 06-08/15] made some unexpected (at least to
me) turns but the series told a coherent story, building on top of
what has been achieved in the previous steps.

Thanks for a pleasant read.  
