Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DEAC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiKCJu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKCJu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:50:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59263ED
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:50:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t25so3690560ejb.8
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8gO4lQEckpOBV60u7yrQDolsXIPVqe8lszXzHyadKU=;
        b=nFNKZT4loft7Pnm3wYyRaFZjMA1lHn4V6rl0KaS+jcpHlrv3dkyX93WTQv6H1nb17P
         Fj3Nt7BUwb2mk08ioeTSUrGMvx5R0oiGG5v83ICFNgD6y6uoToyXikYUMunTo54hvSVC
         e3R1HTseqJcaEcpEXz9/vnra26/rtnN1WvXgFna9PG6qwoPLiv7sQ06LVkxBeB2Eqssx
         Gl4VHAoc4o76qUSBr1T+/jJ70JwqPGyadeBibBLyOJIULLg8GPkH752nwQFugqsY6NZa
         YgWaSHNnKwLT89YWkhJsEC7z7Yt755CwAGW2yNJ9QCgZIq3zjwL1F7i2LwK7Kz1Mud5f
         Zmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8gO4lQEckpOBV60u7yrQDolsXIPVqe8lszXzHyadKU=;
        b=sHRgdE7cETo/cwaS3C1ZCP7VTYXLwwqrBRtTGww8e/UZzEaz7jXcPeX+gAD6zKbkGK
         c4NGfdw+gsO6Gr/lJQHEGIzqACgEnZ8Zbn+gTDlW88naqo7ffUSYGjI/Ngx0Lr9LlBZC
         d9foqL65h/mHwDUclIrppZIWVoOka9/4uEZsWP7U7vBHxxEdDHBRSzLXddvQa8mcVm6g
         meuTmvT34q7X3hXgzLGiVhRzwVJzS0oQXA+EVtqQzJtB0j9/ngChjii+YQr+Bz6injR7
         pDwlJ+ueXhHXIHFIcH2AmWJp84bEWyIgywRd0fsjc803hMoDH+TWsqNrO+Qmv6Mmz33x
         wTGw==
X-Gm-Message-State: ACrzQf1QOvxDHnarfSUdMdYMhj1y5XzfOosXIXTThAKhls0g2MNNxTlQ
        ouk3DYLWqflRyoAAz8680thpb4uKkC8=
X-Google-Smtp-Source: AMsMyM7Z19qLRRMQ74w9CCuiWWrp+ozKRioBQGJND2ArtW6qscOpwt9i5ZX8ymNfucqG+tvkHJONPg==
X-Received: by 2002:a17:907:75f2:b0:7ad:e51e:837f with SMTP id jz18-20020a17090775f200b007ade51e837fmr16216477ejc.0.1667469024251;
        Thu, 03 Nov 2022 02:50:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n28-20020a5099dc000000b004619f024864sm273979edb.81.2022.11.03.02.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:50:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqWre-00CMcO-2r;
        Thu, 03 Nov 2022 10:50:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 6/9] strbuf: reintroduce strbuf_parent_directory()
Date:   Thu, 03 Nov 2022 10:49:02 +0100
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <2200a70d279adcc6460dcb7bef7b0e681d19a414.1667264854.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2200a70d279adcc6460dcb7bef7b0e681d19a414.1667264854.git.gitgitgadget@gmail.com>
Message-ID: <221103.86iljw1i5d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>

> +/*

Please use a "/**" opening comment in strbuf.h, i.e. an API-doc comment.

I see just above what you're adding we got it wrong :(, but most docs
for functions in that file correctly use that.

Some recent background at:
https://lore.kernel.org/git/220928.86pmffwmft.gmgdl@evledraar.gmail.com/
