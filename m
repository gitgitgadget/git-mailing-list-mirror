Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9889C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbiCBV3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiCBV3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:29:03 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF4847071
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:28:19 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c14so3421640ioa.12
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=osoCjvukOvEe+yKRmaLgPgx87mLWNonWfG24M+yKh2k=;
        b=fkXYtCHMQhWv/44ALBcIM3XmZRcUCmkJMe6HrHdRwdm8UvpdDlI7JBzu3RjYCYlJp1
         dQ9WVHhDx7GfnuyOTpjqSwodJQqLrz6/VwDhTqgot0DQNVgvdxITEoQMGBV6wg2Dq8jm
         ZocCDmtabJUj8hmgb3pSWLzBVZR2c4Uv+O3zIaPeSzN6b7fk4oSL9kwCx3FV0Vk160xU
         IBKj2P9XvBxV2hHyAuCIlu9Q2a/uE4rHjmLHmgufYp1gTT4bbGoaUjnzfZmJyoQlOfCn
         CTl2yMYEcjsSamoVqTQwropUrQrDMnK+1XdVOHq/i86ItMpmOfSLtznDaM/J8AXQo6Zb
         CHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=osoCjvukOvEe+yKRmaLgPgx87mLWNonWfG24M+yKh2k=;
        b=SLIiroY153rITGFpi/apDA1CoQsMvP3QCe5NxEgr2PB2Goct/LtzOEk51y9Kho5kRq
         ERLLMNRBvp8acyOfJ1i9WL1NS7iq17WuVxMedMHEKZZaU5xWcmiQoW3nfVJcZvAkmGsi
         I7IBCS4a22/ckrLq977t8w2Y3swnJKr7bYmDd3aU6sgxSh+1uNgzpC2wVbTORM+eYrLJ
         D3xe0gEtwZ2dLWzepYFgJiVOhvL4x6DwVUrqkyDz6VbHfHa/wSQHbeMl9gtLj4/TWAY5
         7udiN9SA522yGDwrEMU/l7xDnD9LJcwJTQ4IgudbXgI6437M5uqo4yH/QFotUkYZqmDD
         2bVg==
X-Gm-Message-State: AOAM531teyZYfiPUVzWureL/zLBOXUx0lTiJW2pbsfvCsYKPuMCSOgLr
        TBJDfrJk1TBc60ePakHULhPXJg==
X-Google-Smtp-Source: ABdhPJwXZL29SAVvK+PkzLky4WAHMEjiThN0qPEd0imZkU5WU9oJg9vqt35Bmy+SFP5mTFGAGXilRw==
X-Received: by 2002:a05:6638:2688:b0:314:e214:d996 with SMTP id o8-20020a056638268800b00314e214d996mr26089081jat.167.1646256499065;
        Wed, 02 Mar 2022 13:28:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j22-20020a0566022cd600b0060c10684623sm123115iow.6.2022.03.02.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:28:18 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:28:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v2 09/17] reachable: add options to
 add_unseen_recent_objects_to_traversal
Message-ID: <Yh/hctKsg1gzmo3o@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
 <6f0e84273f78797c728058521969e73f8817b49c.1646182671.git.me@ttaylorr.com>
 <245e34c3-ba85-2bb3-d17a-e48ee5b142bd@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <245e34c3-ba85-2bb3-d17a-e48ee5b142bd@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 02, 2022 at 03:19:57PM -0500, Derrick Stolee wrote:
> Nit: just realized this include could be replaced by a struct
> declaration:
>
> >  struct progress;
> >  struct rev_info;
>
> Like these. 'struct object;' should be enough for the typedef.

Good catch. We would need one for the packed_git struct, too. I don't
have a strong opinion about including object.h or not, though needing
two stubs pushes me slightly in the direction of leaving the include
alone.

Thanks,
Taylor
