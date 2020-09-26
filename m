Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2A3C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 12:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BAE2396D
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 12:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzQIlUZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgIZMjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZMjp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 08:39:45 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D6C0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 05:39:45 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id b4so417801vkh.9
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrWrPlUDS5IKNzE+gms+FvnoHUnhulB/JHEQryPFheE=;
        b=gzQIlUZ2T0xywfWFLvVBR4+/pNdXIRHITWWRhor3hRJcbXTWGi+rmltj1l/Ca732ZK
         mWs8DkFyMXI+EOWrw48GmEuEnRni4jyWLP53sPIWfjUr8MTV4A9GqoSX0rDi92lgaj/x
         lR5dLKy247nLvVC8LLLzHMNUlZVH4PPeKmgUPF8Sr8R77MbdpkL3naZKL1URR8DRS3GE
         mnxGT6+z/KOxmVR5gs/yFkQ2D0ZyLIq+dl6TnOwSAOCuaWzU0rDzh/ZBFIexA23dUF84
         lBeMwaiiBiLKcyoMGlJ3DAEsxMwBlrSMGLfDcW39571Os3RXTFHxqwpAZhr1LgzDuYM3
         iX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrWrPlUDS5IKNzE+gms+FvnoHUnhulB/JHEQryPFheE=;
        b=oZU0iWIUzfbklUC6fm2h929NWMvaL/XtGtL4QqhNsWXLA/lsAvKE+HaUe2rW4BcSvR
         N54/qwHxn83ABBIyNwanTnFL3McVKVSeSl9c19mCLcE48uPVbn9EjmOK4vpPfB8lxTD1
         UfxO3NcL2A0ZtFWYobCvbrmjJR/MjjOgiO7Q1SpQ0Jl6VjjJO6wKyhDTgnBPyLZkm5r2
         dXbucIG0jWQW+v19SshKHxoiAzfD9qP3nbokn4Jy+CxrWGKuqHj7CONF8aedWAhbQU7I
         np6yNLhjQGFTFpyHHmtIjGpOy2wAeHDC0xVWi/dMU2h4iobO+oQUgKSZxb4p+LMAIjWW
         dudQ==
X-Gm-Message-State: AOAM531Id12Qc1vvpA5fltMhUlyKdHDBBQ1ii/xETJiRZzLlcDTC6HFZ
        luz2CKSc8UNRHV+LEBW9HeC8dyjC0AKNpdmaK7UU5nMB7Is=
X-Google-Smtp-Source: ABdhPJxYmIrUdfSmCWPkotdx06w2uSa+bpydKLkDhDQIHK6INEpWPTKvSWauQc7k3HmMWTk6h9B5tcYk4vErknRfi2A=
X-Received: by 2002:a1f:2d0c:: with SMTP id t12mr1489947vkt.0.1601123984136;
 Sat, 26 Sep 2020 05:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200925070120.GA3669667@coredump.intra.peff.net> <20200925070249.GC62741@coredump.intra.peff.net>
In-Reply-To: <20200925070249.GC62741@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 26 Sep 2020 14:39:32 +0200
Message-ID: <CAN0heSrhmf9-Ep+SWe7Wy-7c3M9-1NFBybSA=6aJ1vDYGTdciA@mail.gmail.com>
Subject: Re: [PATCH 3/8] trailer: add interface for iterating over commit trailers
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 25 Sep 2020 at 09:04, Jeff King <peff@peff.net> wrote:
>
> The trailer code knows how to parse out the trailers and re-format them,
> but there's no easy way to iterate over the trailers (you can use
> trailer_info, but you have to then do a bunch of extra parsing).
>
> Let's add an iteration interface that makes this easy to do.

> +void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
> +{
> +       struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +       strbuf_init(&iter->key, 0);
> +       strbuf_init(&iter->val, 0);
> +       opts.no_divider = 1;
> +       trailer_info_get(&iter->info, msg, &opts);
> +       iter->cur = 0;
> +}

Ok, this does initialize everything...

> +void trailer_iterator_release(struct trailer_iterator *iter)
> +{
> +       trailer_info_release(&iter->info);
> +       strbuf_release(&iter->val);
> +       strbuf_release(&iter->key);
> +}

... and this side takes care of everything, too.

>  #define TRAILER_H
>
>  #include "list.h"
> -
> -struct strbuf;
> +#include "strbuf.h"

Spotting and removing the forward declaration, ok.

> +/*
> + * An interface for iterating over the trailers found in a particular commit
> + * message. Use like:
> + *
> + *   struct trailer_iterator iter;
> + *   trailer_iterator_init(&iter, msg);
> + *   while (trailer_iterator_advance(&iter))
> + *      ... do something with iter.key and iter.val ...
> + *   trailer_iterator_release(&iter);
> + */
> +struct trailer_iterator {
> +       struct strbuf key;
> +       struct strbuf val;
> +
> +       /* private */
> +       struct trailer_info info;
> +       size_t cur;
> +};

Ok.

> +/*
> + * Initialize "iter" in preparation for walking over the trailers in the commit
> + * message "msg". The "msg" pointer must remain valid until the iterator is
> + * released.
> + *
> + * After initializing, we are not yet pointing
> + */

Truncated sentence. "... not yet pointing at any trailer"?

Martin
