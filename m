Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8936E1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 15:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbdJXPeq (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 11:34:46 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:53581 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbdJXPeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 11:34:44 -0400
Received: by mail-qt0-f182.google.com with SMTP id n61so30912666qte.10
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UjszrrmV6ZCPj7uBYB85foGBId1QHt+cngQ/LyWxodQ=;
        b=YnMGVoTFhRUWx8lvkzvLiRytZxz4gC+dv1TjsJP3avNEEIGRlATsXJhIBpMjqoR5uR
         b5mYsaIGF61vgrQwCZ90W4Dd9aktysuxmZawmyg5RpgMWyVHoiT8ObJRCcXUhtVfv3Xl
         VPtDVFGWqhYN7EF8dwUrVNwt6u+Fdf2PnjneWncXQ8Qa+Ud9wVNpQwgxQHjKxFeFq0B2
         6cAaHIBLSrLXA+vMmCWzUVUoSKFNz7AA7ofhRXh+z3s96kfjwh1ZWsrjNDXzB+c51TX/
         gbA4/A9fLC+E+dXX1OA8wx78nUPohP4ZrK4e/vWGchERUOfj+X/6HyG2ac3xTxQ+w6kN
         PODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UjszrrmV6ZCPj7uBYB85foGBId1QHt+cngQ/LyWxodQ=;
        b=fWC2fXXtWuT4yo42y4VGKAi6AM0q1VYp+7ibY7t51GsTXb0X+3o3Jsm1EpBDjGhJnt
         K2s8p2zRpNVjDYmk3IMoPrPzH798c/TslYRoSXuuki9qZRb4+TqkRR5hnd36/x/TskFU
         qo/V3kiz1ntYDrhvJh1BBgALOhld8OmjjwO7NxLSDO2Q8cBN/6tlEOWFmLwIRQoZVTbn
         21cL4MZrMLeFUIWleTQKC0c5juHm+Zj5O+dCoAdyrlbQirs0rqGGKaVvO2eGsAWpEwMP
         WaR0M+uRih5iRTrWQk5LvkW0p3rzHiRL/hhXXYfHv2F197edW8ysMsp4/TjbHNVPu66S
         CGPw==
X-Gm-Message-State: AMCzsaV1RswthCARqGvmUC6stLOSsvFAgHv8H00aZx+FIJSK/N9aonRi
        NoJ8/pR/4GVyRcsSrxzIILxEAyHmG/FGCAIZ7S+ciA==
X-Google-Smtp-Source: ABhQp+SZCBeE+HUFNO0FD47NOOsm9tPGkyCEYPvintDMjnG8mhXhM0Vc/hXau0EmNzBbNbkcNqFFj2rnTpf/nxlFWhA=
X-Received: by 10.200.8.53 with SMTP id u50mr26889204qth.260.1508859283274;
 Tue, 24 Oct 2017 08:34:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 24 Oct 2017 08:34:42 -0700 (PDT)
In-Reply-To: <20171024121536.GA88363@book.hvoigt.net>
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
 <xmqqo9oxkts6.fsf@gitster.mtv.corp.google.com> <20171024121536.GA88363@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Oct 2017 08:34:42 -0700
Message-ID: <CAGZ79kZk+4_Vzb8=ksa6iYLsYW=gopAuTEupbqintcV3bTxR9A@mail.gmail.com>
Subject: Re: [PATCH] status: do not get confused by submodules in excluded directories
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 5:15 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> Looks good to me.

Same here,

Thanks,
Stefan
