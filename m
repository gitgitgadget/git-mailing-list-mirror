Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0D01F424
	for <e@80x24.org>; Sat,  7 Apr 2018 06:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeDGGyg (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 02:54:36 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:44082 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeDGGyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 02:54:35 -0400
Received: by mail-qt0-f177.google.com with SMTP id j26so3571465qtl.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 23:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ABZev6jBke/yL40lltDvxw8T1gsxOUR1DMoMcvPkBxw=;
        b=BdJEZdPZ4YW1SKo+NShGuCiUSSTvKJFYwo3kB4qxhuKiGT5jBtonwSKDuyJ54QgaHr
         lThaB2XgUGKt5/Bt/tu/p/5JBPrBWUKLe9VsXSd0/gUK3O5sQEeJTX8yXsTRYNTVBNAk
         wQ+/zZsT3iCPIbrN95/2zwiv8BrxgtFiSMGcgnXuIfMbSPwtoGs7nRLzLqEwPqibRFHv
         14oKC07Z4VwQOckKS7h+04X+3jkNEykiw57YpwOewchD6OtjwbLt+5WOsL4n0mEDzKU8
         pg/H/7lRFy4pnsoY6KQ0/MoC+trqyUGf6C5ayxTjsduJuqbsZw7QzFHfi6SsO8vxKhvk
         LMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ABZev6jBke/yL40lltDvxw8T1gsxOUR1DMoMcvPkBxw=;
        b=LnT2fjpiC1bRNC2z5SAtrL2JdRlVxkBlLSl3mp0JacqKIcnX95UgX2SbtnPbkz6qlN
         jpXcYBQJy8/8+rNzzGZVmmGbwT+e/+rnfs0TrrhMiXiEemnOh0llcrv/nP4MZFFPaRah
         7NzDrjy2j7olAb5DCPwhpctanso7sQIsI/Uafz3Il24ZsdGRziM5c3uN9axCiyyb67rO
         kCdxHGqJiQ09v8SDUgRJIRXuzOJoMKo0+0WLgSo+YQANq4tumLz1TwnxO6mPRTNDaJn7
         BAf4dhweJauPpT4PWJaYAl9MnvEbHKM2LfhKPtm787shpMTFcymnDjSLlBeKnW4cEQ+V
         cX4A==
X-Gm-Message-State: ALQs6tBmYi5m2RMJCoPNsSGHDoUFjHk3Ep14+/URRUuAFtPFTbsrLjlN
        sySBtrBrjRZi+Idd4yLF4wynZ4uiUuVRSxRO2K0=
X-Google-Smtp-Source: AIpwx4/iDX6iSjxHdQKKPZpz67oqB7pa1KOkBlK/BF5/miGqqeFNNI9aHy/O0xyFPcOk3EYztvc8zNuUUjL+M/PEs6g=
X-Received: by 10.237.49.195 with SMTP id 61mr41608590qth.77.1523084075079;
 Fri, 06 Apr 2018 23:54:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 6 Apr 2018 23:54:34 -0700 (PDT)
In-Reply-To: <20180406232136.253950-14-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com> <20180406232136.253950-14-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 02:54:34 -0400
X-Google-Sender-Auth: QPXAmodiYJaiDpFr9Z0ds1f62BQ
Message-ID: <CAPig+cQp2dH2bY=sfNZoCwt-S3tTMDgJ_2td6JkDqwz=zqm3_A@mail.gmail.com>
Subject: Re: [PATCH 13/19] refs: store the main ref store inside the
 repository struct
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/repository.h b/repository.h
> @@ -26,6 +26,11 @@ struct repository {
> +       /*
> +        * The store in which the refs are hold.
> +        */

s/hold/held/

Also, this comment is short enough to fit on one line: /* ... */

> +       struct ref_store *main_ref_store;
