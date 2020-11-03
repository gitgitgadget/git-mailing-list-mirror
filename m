Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF7C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 11:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0ABD208B6
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 11:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDBDLS6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgKCLV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgKCLV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 06:21:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E6C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 03:21:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id p93so17839689edd.7
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GfVDSUoaRTPt0cunS3Sq8p41Y9mxriEJf9AE/qgNcJo=;
        b=vDBDLS6Gm5n9UI++gwvK6YXAawGvhUtsGww+LKZbx8hFnLYiOa2M3OE6Frl7PrOT41
         ft7ZSWIwrl9l5PoOrCawRlfRZTpda/0NA6LDyZ4xqAO0aH8vwiw4ZRiibw4x3BcD4VcD
         STKvEE4DAMcGjn16pm5RTY3xavZ4I+Vu5hqCptXsezBPTh+w1KFXxCki60d7fONM+5lx
         E7GZ8b9PjMSGgwCGSKPlXSmpHs1vFk+tGFX2ph5V36t9OuOmJUAGqRgx7fqFYuPkcJJT
         m51mfaCNifzx43Qbla0MZTm+hXtZQAcdB76JwkD2efI9YclkiuAUJ7uq873ziTZ57crX
         uj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GfVDSUoaRTPt0cunS3Sq8p41Y9mxriEJf9AE/qgNcJo=;
        b=PY9UOU5JtwfbKNmndl9vfrcrUI9WwFG7ltNEQRALhFUA2CmhZJEFYsQsDwxk5iI8F6
         zgLSNfXrt+4ltgHgCtdZe1k2IRfgZjmb4krbhqCxShffdrusLvwLdgKBFfD7GWrqX66C
         xseY0YNupLtTZg6CCXfcdy5Vdqj932P0sO5oWzMWeO6HWTtX36+QQw0vw2BdPgl9pVj4
         alcFijsgCSyGfXo6rSxcCe+zUF90Gz1ASkB1lF6V42NybjUxbJE9012XkBquMnU5hbO8
         PyB8ZiDfDDNSsutKCKqy5iEduyGXnh06XwaGEtbxMRpdXa5XnwarNur7bbia5LSXpb6Z
         a8AA==
X-Gm-Message-State: AOAM532ifMMbMbeVOXdpyReTnwJCpfnE73TQ6O2jIXVbzNvLZtzhd6qO
        wvIPcvrJX30ZzEFjEQ6f+l571NV95qvXK4aoMa3BhL7s4qjhsg==
X-Google-Smtp-Source: ABdhPJyb7kYjD9xNxP0XYo8EJC26WbUjQGYGmwl2ywxFeAXs62b6/NTx34b240TKaFddUci3NMw1IQczkTUCri02lN8=
X-Received: by 2002:a05:6402:4cd:: with SMTP id n13mr16279300edw.127.1604402515541;
 Tue, 03 Nov 2020 03:21:55 -0800 (PST)
MIME-Version: 1.0
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <20201102144321.GA3962443@coredump.intra.peff.net> <20201103101553.GH24813@szeder.dev>
In-Reply-To: <20201103101553.GH24813@szeder.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 3 Nov 2020 12:21:44 +0100
Message-ID: <CAP8UFD3SMCBdE8TOP7OKabYyOW4344nNAa=G2hCzxWnN-XjQrA@mail.gmail.com>
Subject: Re: Segfault in git when using git logs
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Sathyajith Bhat <sathya@sathyasays.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Sangeeta Jain <sangunb09@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 11:19 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Nov 02, 2020 at 09:43:21AM -0500, Jeff King wrote:

> > but I'm not clear on how "--follow" and "-L" are supposed to interact.
>
> They shouldn't, I would say.  Though it would be great if their
> rename-following logic would be unified.  In particular, line-level
> log does a better job at rename following in some ways, notably it can
> track multiple files at once, while '--follow' can only handle a
> single file.  So I think the rename following logic should be
> extracted from 'line-log.c' and made more generic, and it should be
> used to implement '--follow', removing some restrictions of the
> latter, not to mention removing the duplicated logic.
>
> (This might be a good GSoC project, though some of Linus' remarks in
> 750f7b668f (Finally implement "git log --follow", 2007-06-19) like
> "you did have to know and understand the internal git diff generation
> machinery pretty well, and had to really be able to follow how commit
> generation interacts with generating patches and generating the log"
> and "this patch does seem to be firmly in the core "Linus or Junio"
> territory" are worrying...)

Thanks for the suggestion!

For the Outreachy round starting next December, we have proposed a
project to accelerate rename detection and range-diff based on:

https://github.com/gitgitgadget/git/issues/519

I am not sure how much it is related to this though.
