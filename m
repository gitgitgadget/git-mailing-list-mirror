Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE96C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B32E613C9
	for <git@archiver.kernel.org>; Thu, 27 May 2021 21:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhE0VTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 17:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhE0VTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 17:19:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65169C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 14:17:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 27so927453pgy.3
        for <git@vger.kernel.org>; Thu, 27 May 2021 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5azSmnkE38Lm0mOEXXXtUxh+oCrhmGgYzHlExYCUy4M=;
        b=EZbmJOzPENk9LfbG0LkZepIQIAabu1NSBb79GoOvwettMn+wkLYb6m9Wbbi0d/5D/z
         X9pVrtI8MVMsd3XPDl1VXxv39hILs9GYbpfK1Y6IN9R8N2eJdNvcl3BGi7Y6BG1cmDLO
         5TAzX5oxEaGNYWnPDjv+HrD4VX9gOoQgQvKq4uy3ba82CxXqK7uTi6w9TErOB7Xorhd+
         dmth6Av0f5zRDcWbIQEbWPWf+2ekzn1c+iK1FFdMmi1lpJYlh33WzIOdKwaKbnxeRo9c
         F6KkTEI1WRCveJmopNCUf2cH4/MKGAHmdjY4omzHzpBMwxitm5WoL2bd6Bv42mjg6Nvq
         Z9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5azSmnkE38Lm0mOEXXXtUxh+oCrhmGgYzHlExYCUy4M=;
        b=IiuSx3voi6a9rfLWjYz27ykDlMdZgPBSgM0D7XC8o/VRQOTZpoZnMvHfbzOGtTJd+Q
         Q625fdYfCgF9HDgC5etIaAj4TBOk1ecWoyo3cbB0b0lzIUYcfKiY1XuFDm/6AvuBrYh7
         8LOiVMAmDwEhfxhueGTaZscqLjfK/7w2Ha1maTWPAyCrWNd7C6zP0gc6nCf7z8tK0Hmg
         urImRyHkZPAeeHdjsAa0oim+tGBZ36+FwDgNHEJv6q0nOLvYENcDflmHmfy04iAf4VsT
         hKFTe+APkTCN8dDWJK3vbOnT8RZwuQycsMA2pOJPE6LON9AokvrLq0+EsTez9dZrUcfW
         j0GA==
X-Gm-Message-State: AOAM533P+xkA70X659XUr4zJyzfg+VQhHQ1FGqmnISoLDfuUA/kce/9C
        x25P6pxYDGRXV3e19bKpSYL4IUVl3u4=
X-Google-Smtp-Source: ABdhPJzYCjifHGlG2rm3i4bhmnbnizp0AzXKj2J6OYbrgcyPTdIg7n2UIcXLW4xnFlcYMTBAC2K0kw==
X-Received: by 2002:a05:6a00:1c43:b029:2e4:d188:fe38 with SMTP id s3-20020a056a001c43b02902e4d188fe38mr510011pfw.20.1622150264951;
        Thu, 27 May 2021 14:17:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:d939:f7c8:3cd8:2351])
        by smtp.gmail.com with ESMTPSA id 85sm2583595pge.92.2021.05.27.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:17:44 -0700 (PDT)
Date:   Thu, 27 May 2021 14:17:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/17] cat-file tests: test that --allow-unknown-type
 isn't on by default
Message-ID: <YLAMdYtd77l2g6SP@google.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
 <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
 <patch-04.17-871b820003-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-04.17-871b820003-20210520T111610Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Fix a blindspot in the tests added in the tests for the
> --allow-unknown-type feature, added in 39e4ae38804 (cat-file: teach
> cat-file a '--allow-unknown-type' option, 2015-05-03).
>
> Before this change all the tests would succeed if --allow-unknown-type
> was on by default, let's fix that by asserting that -t and -s die on a
> "garbage" type without --allow-unknown-type.

nit: "tests added in the tests" seems oddly repetitive.

More importantly, I'm curious about the desired behavior here.  The
idea behind cat-file --allow-unknown-type is that I can use it to
inspect an invalid object, for example after it has been reported by
git fsck.  The commit that introduced it (39e4ae3880, "cat-file: teach
cat-file a '--allow-unknown-type' option", 2015-05-03) gives the hint
"query broken/corrupt objects" in the documentation, so I figure
that's what it's for, and I'm sympathetic.

But: why is that an option instead of something that we always do?

In other words, is there some situation where I would not want the
more permissive behavior from cat-file against a bad object?

Thanks,
Jonathan
