Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAFBC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhK2Wdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhK2WdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:33:02 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC64DC144FE5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:33:51 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id l7-20020a622507000000b00494608c84a4so11274563pfl.6
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ocqwidfzLeEvH+2tvT662UV4kToXlWud4gXvme9cHs4=;
        b=H5d5m8ADE2wZ4xwfGYA31Yj16u24QhKJ4YmI3KHp2E45+a6P2ZtTPFZzqnkAHmCHIU
         MqIS4XwCUmYNI7C4v/A8rRlbGtPiC862Lp971VxPDxthdI2IZT0umjBbDx7CjGAVsjsl
         W7Vp986I8IPqqDplC+A0X9jDQ/ot+Av9NuWV6jbVkJjZNodnaJsoEoCxf7ZhHMAfhLJH
         xm80vy4watg9NnANeHuLGjf2cyoFNNgzTeGdxJrCyNQSYO5lbSQ5cH30MG5ZEI+H7g1g
         hJGwelh0tEepRSjxqGu78QbFUmT62XVBVyBLMsYi7yQut2J0oPvxBz9bD83XrD5HEjyu
         Vhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ocqwidfzLeEvH+2tvT662UV4kToXlWud4gXvme9cHs4=;
        b=5ANBiIoLAVVDrAe/SaRhc4Z6nqWd2TdSo/h2CJ15wGcr8FAgjxtlJXDaVr8eMrGZkf
         UgY/6jrDYcxxlcp7GrSNI6cO38qFNa38zHZjQPeecY99mrcEQpK2/pIweGaI49RbTyTW
         NUWDc+IbvgC4Ad5fB/6SkJfkdZ6lcFLzn1W1ypJdZY1Jm35cUVwl9MUVo/IqUumAUNfD
         11JIqu+d0OLOdVCS/Vkjv7yVNu3oMx/c7dLwxnMrpxdnSvuY0R21rfGya33BC7KRDKlE
         LJ4l8WmuxG8N2jZ1U0re2uaE0HzR+YFRRLll9gfDJk+9GuIKyMpbYml4BMj/iXjjGWSD
         xrnw==
X-Gm-Message-State: AOAM530CH896uh0v1UO3X84zFKfAVK8aDa//+fumSAU1VSmHI6F7g7aS
        t3Plm4FRghasFCQtfNcvFb6Wte2Hde/XV6dCwunR
X-Google-Smtp-Source: ABdhPJwdWWgIsy77TkFDRBQc4E7NdmHwxUaLNWCnWyReM/Opzc+jcaAMg9q6bOyiFHyzgEnct+V/k6h+N9sUk/PXewON
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3850:: with SMTP id
 nl16mr10470pjb.10.1638210831500; Mon, 29 Nov 2021 10:33:51 -0800 (PST)
Date:   Mon, 29 Nov 2021 10:33:48 -0800
In-Reply-To: <211123.86pmqrwtf2.gmgdl@evledraar.gmail.com>
Message-Id: <20211129183348.384067-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <211123.86pmqrwtf2.gmgdl@evledraar.gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com, peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Nov 15 2021, Jonathan Tan wrote:
> 
> > +`hasremoteurl`::
> > +	The data that follows the keyword `hasremoteurl:` is taken to
> 
> Both here..
> 
> > +		die(_("remote URLs cannot be configured in file directly or indirectly included by includeIf.hasremoteurl"));
> 
> ..and here...
> 
> > +		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &url,
> 
> ...but not here (C code)..
> 
> > +	 * For internal use. Include all includeif.hasremoteurl paths without
> 
> ..but here..
> 
> > +test_expect_success 'includeIf.hasremoteurl' '
> 
> ..and also here etc., let's consistently camelCase config keys whenever
> we're not using them for lookups in the C
> code.
> 
> I.e. "includeIf.hasRemoteUrl" (possibly "includeIf.hasRemoteURL"?). It
> makes them a lot easier to read, and makes the end-user documentation &
> messaging more consistent.

The middle part is not case-insensitive, though - I tried changing it in
the test and the test now fails. (Unless you mean that we should also
change the code to make it case-insensitive - but I would think that
it's better for the URL to be case-sensitive, and by extension, the
"hasremoteurl:" part connected to it.)
