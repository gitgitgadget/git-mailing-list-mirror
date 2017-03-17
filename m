Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC07E20951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdCQX67 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:58:59 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35212 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdCQX65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:58:57 -0400
Received: by mail-pf0-f182.google.com with SMTP id x63so38278392pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=96sEAT9hBhnEkqS9+Dt47Ic6g8E2nFC8MSELh/YH0dA=;
        b=ixlPTrb0Iug9V+UfoDNRIX765nUH6oRE+J5OpCmQIGBBfOgFJzqAt5EqrAWkKUVCmd
         wftdNgdsp4vOEyapm7s4kNADXuMY9bdyxQGR07TwJn+uvHdS+nlJwWOFx+hLLKzTx2nY
         rNGs0JAAWuVhSVXImxzpLIRKs+GtcST5jk4TfPMHp9Jdc0FkhJuB4U0vr5pIjtqvumVS
         Z5cmQu2loKrPWGiNEtgXDUPB6pnPCJa2NvdIYZq8DcM2VATDigkmrHcQII2IJiZhG6jj
         GHLwvtUyfVtSnK76Ojacq1CzeFikGI1nzciWuCS7vVtNtgEsfwIfbuKYxv/SwfPiw4wX
         yWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=96sEAT9hBhnEkqS9+Dt47Ic6g8E2nFC8MSELh/YH0dA=;
        b=f8uoXiGU3Ey943RSLdxqLaI8FLcapzDFBBQO8uJSidqx59d6XO+coldunF28wihoGH
         5tTTukaOMkeAWkB87rKBKmD+CCmu6hVl4MJkrLZxQtt309rF4QJJsx/2C2n0uwwDnPd2
         yUISSRB7QCenMavqtPrN2mj/U7vZk+yNncjZ0l8wahXMIJhlBOEkhZjq2dgQ1JAUUOPf
         f3AQzo1acnX7V5EL72B1h55orF1IrZ+WeZFbS/16xvF69SLOtuwjuRv33S4Shuv+QVIK
         Y7wI6T+GDicsWlEklWscGynB1d0oFqNYJwUhmCaLg/lwoS9lZbvUXDMeweIK8TvADGYd
         /ZYA==
X-Gm-Message-State: AFeK/H023ISHhCOkAWFNcEcwew5wNN87XHlDyrdQPnRjBUg06I5tlmSARzl+IOyzooompg==
X-Received: by 10.84.128.65 with SMTP id 59mr23292316pla.167.1489791042790;
        Fri, 17 Mar 2017 15:50:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:cc9f:ca23:5f26:6394])
        by smtp.gmail.com with ESMTPSA id o24sm18718351pfj.126.2017.03.17.15.50.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:50:42 -0700 (PDT)
Date:   Fri, 17 Mar 2017 15:50:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] receive-pack: simplify run_update_post_hook()
Message-ID: <20170317225040.GQ26789@aiede.mtv.corp.google.com>
References: <ac1c0cfc-b1de-37be-23b3-98ef1081ec4a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac1c0cfc-b1de-37be-23b3-98ef1081ec4a@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe wrote:

> Instead of counting the arguments to see if there are any and then
> building the full command use a single loop and add the hook command
> just before the first argument.  This reduces duplication and overall
> code size.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/receive-pack.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
