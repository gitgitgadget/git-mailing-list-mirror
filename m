Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC6FC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 11:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286A2223AB
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 11:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOF8Cbik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774567AbgJZL4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 07:56:24 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:34316 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391540AbgJZL4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 07:56:24 -0400
Received: by mail-ej1-f68.google.com with SMTP id gs25so13018861ejb.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3Nh4Np4KlVXwdur8dUZXNaSPSP9oK5jAFwrYRjCSRI=;
        b=cOF8CbikbgEnj4M4C5tZKBmIMSw2yVwLUoTgSYzTd3TlJTRXYLoyxQEGM51ald1vVS
         3zVd9LDj8Wg1Sdlz5RlK70HJXM/CtvbRAcUPnN0IoLQSxsFkCV1c4eHDv9Tz+krAz2lt
         5ZBir/PtaRNOFQk8RwkWbBxq0q1bExAolUs/VDPj6ClOWOPUndxOi7eEddjUs+64TFE5
         eYFYOx3kDw+eF5agNXyThDWDRn9tcG4G4kPg0mmIKHWLWw26r8F8P00H6NzrKknyRHmV
         x8mwehicZ22BA9JJ70whtuV4zj5dUPDt+aQp/POyvUrBk49gTeNEcFbWoobmScSvBupv
         qSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3Nh4Np4KlVXwdur8dUZXNaSPSP9oK5jAFwrYRjCSRI=;
        b=cb0uBEXM28uG+nQOqPOPbgOBjqEtP+r3z4RMmJtE8unpKmMyj8lscWVHQkt1axpk0D
         b7xnwFhdvISF0VD2LBAsJS3XLFZjI9JGneFrMI/45nDCWJ/vLSU2SobuWUV4RJbSCUH7
         jU+v/S45MgzvLEcPjUf6T6v5nKQruNqTq90QqH1uCARbmBCn04ZT1/pzdmFov0muvppc
         +I+O40P36isY+WEOehtiO7okF3YijM9J3t0FxyOeiCL8AFO/mgtwPi8OMZiR3lbp01t/
         LqM/dHECAtE2IhnmJ+0QP6BL6ZjcX2HcxtMsoAJ27aXbht8aUFKs1i77CdXsLbLbn8XN
         ZP6Q==
X-Gm-Message-State: AOAM531i6QFhTS5Jnpth2VfnE8fOvg0u037nmjIA5UT1D1Ym5S/6/fA2
        hIhvNdgMQU8ZdRWO9B2dYra4vKqdCzPOHgQLpvw/GQX8jCk=
X-Google-Smtp-Source: ABdhPJyFXIHImq17USYcQFMFgckds3TMHogwd3uwTdG4tTsplYFDrLA5ILAUjbjBxCTSEZPjFMIz5rHa1NNScZhZK7A=
X-Received: by 2002:a17:906:da1d:: with SMTP id fi29mr15323667ejb.160.1603713382033;
 Mon, 26 Oct 2020 04:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201025212652.3003036-2-anders@0x63.nu>
In-Reply-To: <20201025212652.3003036-2-anders@0x63.nu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Oct 2020 12:56:10 +0100
Message-ID: <CAP8UFD0J+hfARYWmaj51wzUT-Y-nD=9RyvyFqrzsUYMd48WKPg@mail.gmail.com>
Subject: Re: [PATCH 01/21] trailer: change token_{from,matches}_item into
 taking conf_info
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:27 PM Anders Waldenborg <anders@0x63.nu> wrote:
>
> ); SAEximRunCond expanded to false

Do you have a way to avoid the above line? It shouldn't be in the
commit message after applying this.

> These functions don't use anything from the arg_item except the conf,
> so make them take conf as argument instead. This will allow them to be
> used on other things that has a conf_info.

s/has/have/
