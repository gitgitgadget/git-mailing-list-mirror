Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC97C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 19:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKATFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiKATFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 15:05:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4084955A1
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 12:05:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s196so14232630pgs.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk8oyq2bOkApfNNvTTOLvl1/KTVGwjtIJFXKQ6z/q+c=;
        b=JxP4EiGGsYNOmpy2wynMttq7LuXKnNrXTh47m+Bd12cq+WPNAjM91ID/L0YGTDKwSM
         osFqA7+DTw3F2e+7HmeyfIioRC3Dw+ePmco6Gi9X/+8twe4yZOPJhvxDrcu/YOs4Vrst
         UYdgQVLOUiVS6JHLMAVg7e/D3wNDdK8K/QkR8TsE3YDN8E2cMHGbblC9QoM63SDMgYOL
         0oZWSZOcbbzHleE4QKyrTQMo9ur2nOnCPPmrB2c1OQu1L0aFCOzh2OWcaAXxIRoMb74T
         2H4a5gOnrxnPtLdbtRQc6OdDotTz5g3ogZaefGj0JWKZXUYBwts2jcfTF7dECnBhxnmz
         yPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lk8oyq2bOkApfNNvTTOLvl1/KTVGwjtIJFXKQ6z/q+c=;
        b=k2DiRY3/8JqMBIAy4TCJrA/wb3S71G7HDDLV/dEzDqRzqEEl+I+l80153iAuExTPDH
         jZ2mFAhDqEYZkWVVwwYj4DExNN3axGE2s+QPrkYwMKM5GVIMiI9QbmqI1aYcz/E51BIe
         1z5iFh7HOCnyurPqOuaaGIGomGwjkd59j/QAOY7jxlOPjEHedZLsC09w2acwK3zsi0ZI
         0Y5dX2A0nb7dzK1mglza8kKd+138CbyGTed5QtI8la5MVp8BF+q3Viym6EqAGpKd4vsK
         Oyvw4P6JnisbjVRZGVDK1JSzzJJzu3CqfPyED5xOpwoFBvz+2U9H5X0ttL0pElCTUtr4
         cc/w==
X-Gm-Message-State: ACrzQf3e/yASpg0eKt3b8inwFG8VFX8Onz/vX42LWXDvq5Br/rM3oUY4
        vbCI5fqW0MFiclpvV4DU+gZeIBlOIjHy3Upw4uE=
X-Google-Smtp-Source: AMsMyM4AKQUgQ/ACyf5OUady089xTdJ6meNObYgWSnWnTffSmEk5kvF04tE8EXpCLG239U+i2NdnMQOoARILIOSEdZ0=
X-Received: by 2002:a63:4384:0:b0:43a:18ce:f98a with SMTP id
 q126-20020a634384000000b0043a18cef98amr18264420pga.273.1667329548661; Tue, 01
 Nov 2022 12:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org>
In-Reply-To: <f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 1 Nov 2022 20:05:36 +0100
Message-ID: <CAN0heSryxTbJXrRs7-aCNb6u9qXJnYjX7++Ji8jd=YeYTJfoaA@mail.gmail.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
To:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Cc:     git@vger.kernel.org, andreas.stieger@gmx.de,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sarah,

On Tue, 1 Nov 2022 at 19:38, Sarah Julia Kriesch
<sarah.kriesch@opensuse.org> wrote:
>
> I am one of the zsystems Maintainers (s390x architecture) at openSUSE
> and git can not be built any more since the update from 2.37.3 to
> 2.38.0, and with 2.38.1 afterwards. We have tried to debug it.
>
> There is no real test error output, but we can identify, that it is
> happening in the test part with check-chainlint.

> [  387s] make[1]: *** [Makefile:83: check-chainlint] Error 1
> [  387s] make[1]: Leaving directory
> '/home/abuild/rpmbuild/BUILD/git-2.38.1/t'
> [  387s] make[1]: *** Waiting for unfinished jobs....
> [  388s] make: *** [Makefile:3075: test] Error 2
> [  388s] error: Bad exit status from /var/tmp/rpm-tmp.ztqAAp (%check)

> How can we fix this issue?

You can disable this feature by setting the GIT_TEST_CHAIN_LINT
environment variable to "0". That should hopefully allow you to run the
tests successfully.

That shouldn't risk you anything, like reduce test coverage or similar.
That the tests are chainlint-ok (roughly speaking, that they are written
the way the Git project likes its tests) has already been established by
many others at this point.

I'm cc-ing the resident chainlint expert.

Martin
