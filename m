Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E8BC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E7120829
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhf+q5Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgHMFRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHMFRs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 01:17:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3BC061757
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 22:17:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t10so4760626ejs.8
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6zdQ0xZIUGSdkcDHprxPPyHUI9UfdAeSkcRQI2rSAxo=;
        b=Hhf+q5OiRGS9TCiB3QN6QpRq9RP8EOLK65YgTSUje4JElAU2IUZUOuPpY8YXTrh5Bp
         L5A1NNODr0AKmUt8/lgTmrLN77xVkEGbuT7nyzltzzuL6cgYyMOeKkaL12pivEhDNg11
         MxyrFjTBHizx93MKL5JAau+b0L550r0YMJfAmpr6wciZOsoVPrELtRW69T2xiXqcdIFn
         Qpf9aMIFoVBNqVes12QuaXRhJCeSSwycIEwQ1EXF0jSEqMJGW3FIZEXze+7lhp4viQ9O
         Y9tuBkozr9nsIeGhGjbuzz3h7DfWmqWrCb121wpqk0LkmM0eIR391qkK3d/a22s+tJcf
         nXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6zdQ0xZIUGSdkcDHprxPPyHUI9UfdAeSkcRQI2rSAxo=;
        b=p/NeBuqkgM7vCLri6FDQ0IDqmolr1PUUOIZF5rsx31AugX/jJqlP7Gq6UDUd5/taZO
         kaKyB20tSqw0Ak4iKQI8yfS/fjLjoJ8hxAHpGAHd4B58NXUybgdRh0b5DMDbmVBwKEZK
         4TIsMJf0ZK7Kvdrl807snZvVO7ryAmZ7rpCT9rpj3pbcJj+i4/2fLSxyTkIYGD3THuve
         h3K7BLwws3Op1uLa4X8u+MYehNqaOoGw/zkHUFibfYs4e74/UVwv3ytdwxr4loEQK6zJ
         ss+W0mfI09QFZa+pSfx1zvpZnvrp0YHbS33PYFnNQvFM7BDJQ1eCzfOUTdOgTiZMMSym
         JN3g==
X-Gm-Message-State: AOAM530r7wmAQpPya7f5BZVIqdUqt9Mx5BhXCBaFpv+VmqY3tZPqgRTx
        7zEDFuICzpJoH1Bfn2TodbBwCG1AoOhHiHg5P0E=
X-Google-Smtp-Source: ABdhPJwvWR7HVsk1+XYNOwmE1rKfIpWwMotYzk80gsDZ1Y0bHlp5NZdEeq+skeGcMnVK9nKyyuilBZ57rLJ7vvKm/ec=
X-Received: by 2002:a17:906:6146:: with SMTP id p6mr3246478ejl.211.1597295866499;
 Wed, 12 Aug 2020 22:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de> <cf395005-af63-f698-fe19-6c4b6f1a8a4b@web.de>
In-Reply-To: <cf395005-af63-f698-fe19-6c4b6f1a8a4b@web.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Aug 2020 07:17:35 +0200
Message-ID: <CAP8UFD1rDZOQSDWhc+xdEQVX+Umq-nE-sd-orgKZ3UWTWFHJhw@mail.gmail.com>
Subject: Re: [PATCH v2] upload-pack: use buffered I/O to talk to rev-list
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 6:54 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

> -       close(cmd->in);
> +       if (ferror(cmd_in) || fflush(cmd_in))
> +               goto error;
> +       fclose(cmd_in);
>         cmd->in =3D -1;

I wonder if setting cmd->in to -1 is still useful...

>         sigchain_pop(SIGPIPE);
>
> @@ -660,8 +658,8 @@ static int do_reachable_revlist(struct child_process =
*cmd,
>  error:
>         sigchain_pop(SIGPIPE);
>
> -       if (cmd->in >=3D 0)
> -               close(cmd->in);
> +       if (cmd_in)
> +               fclose(cmd_in);

...as we don't check cmd->in anymore at the end of the function, but
we now check cmd_in instead. So should cmd_in have been set to -1
instead of cmd->in?
