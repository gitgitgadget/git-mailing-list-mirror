Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56EDC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 19:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiKJTuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKJTue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 14:50:34 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672C47308
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:50:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f5so7815373ejc.5
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/J5MDivqnsPVBA2PCkhkRPCe7i21nYVXNiJzfPjMx0=;
        b=bgzjuJvHxGemhklJyEN+3yI2jfc8W9/fkAtUiI4t3bofER1lH+tsXulfEx+O964OYq
         KOIgqko/IgWyFR+beoPogEOAEn18GNcNfWoPbjW881t8SZcHqGy5GPliABxW3XCK+jea
         2ndB1Q1DQW4PFXpgP0p+h1t6hDB+f4muAED/16RUMd4pC15THaicpXO5yJNT1/QBZ3CC
         igTpPhIv4jUcrPgstFRqRjm9/rzctRGuo/GaMXnueSeqNpcifQzqrYCfE5Xo5ILEMbmg
         hxMxEL2KLLligK4PCjWNQVemEO7OK8hTLxdq/OSFO9Ag99x74k3LkSikl5uvDZVcFjJ3
         USpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/J5MDivqnsPVBA2PCkhkRPCe7i21nYVXNiJzfPjMx0=;
        b=AcPvp3kpucwNMG/JaAMu9LSYWkO+TMMK6mrzntiK+HliwIDCC4tEsDuoidW0S6Gdbd
         aSZ9YK5LK3vcmN4R1igmN4Zw/GXuCE70buONeWTmsCINbH3arFkYHFY0C9eVS+KICBJq
         N3s/mGMBcf4iKSvAG0Q9MAlGWefdwIMkCtOEMbkr9WF1e+EYrvzR+XwTp2Tt6f67gCoI
         DoIyZSU8yLYhjDoSZe4+VYbhpDkmRHxEC8AJG9Sr8BR3GVCMb0/aMSOep+Ko8HfFpz32
         d9Z7Gh7oA5iDpo7kb1DbRC/RuKUe2nTKJuv6ZYfKdVfEzy+nKiA4DFcPYDtKXPWtNWZ7
         a7oA==
X-Gm-Message-State: ACrzQf3Lt00qrQfn5yM+T4C/TKQtyDm0rvTX6f6M4bn0fA7WhmdMG5B9
        Y5qeMVplQONoQOwpoqb1zFY=
X-Google-Smtp-Source: AMsMyM7pQxKD5wH71aAV494nfDHNHdHCHOBIgTNCp42/2Ip7rpLyHZYzzSL7bqIky1bdI0LGXt8uag==
X-Received: by 2002:a17:906:c450:b0:7ad:d7f9:1f88 with SMTP id ck16-20020a170906c45000b007add7f91f88mr3487755ejb.217.1668109831853;
        Thu, 10 Nov 2022 11:50:31 -0800 (PST)
Received: from localhost (78-131-17-60.pool.digikabel.hu. [78.131.17.60])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b0078d46aa3b82sm84471ejf.21.2022.11.10.11.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:50:31 -0800 (PST)
Date:   Thu, 10 Nov 2022 20:50:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 0/5] Skip 'cache_tree_update()' when
 'prime_cache_tree()' is called immediate after
Message-ID: <20221110195029.GD1159673@szeder.dev>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
 <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 07:06:00PM +0000, Victoria Dye via GitGitGadget wrote:
> Changes since V2
> ================
> 
>  * Cleaned up option handling & provided more informative error messages in
>    'test-tool cache-tree'. The changes don't affect any behavior in the
>    added tests & 'test-tool cache-tree' won't be used outside of
>    development, but the improvements here will help future readers avoid
>    propagating error-prone implementations.
>    * Note that the suggestion to change the "unknown subcommand" error to a
>      'usage()' error was not taken, as it would be somewhat cumbersome to
>      use a formatted string with it.

I'm not sure I understand what's cumbersome.  It's as simple as:

   if (...) {
       error(_("unknown subcommand: `%s'"), argv[0]);
       usage_with_options(test_cache_tree_usage, options);
   }

>      This is in line with other custom
>      subcommand parsing in Git, such as in 'fsmonitor--daemon.c'.

The option parsing in 'fsmonitor--daemon.c' is broken, please don't
consider it as an example to follow.

