Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE0DC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 07:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiAMHCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiAMHCm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 02:02:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF99C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 23:02:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q25so19556322edb.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 23:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UCg5ZcT0wf4qG7UL0MwmVV9OeWz+eFOwBuM4J69Sb/M=;
        b=bj6+hpfNAspDKYXr94IqnsJaZa7bJdl/fuTLzi4jMltS9ruE9pgAdGGfzVsQ8/gztH
         9GYVo3DA8WsXAPh/DAAyJGBEKf5i5+vC+H6/JQbLaJMM8BhajiAxkgjLlAuAGAtKu/1G
         3TxXaXmw7JoxPBXIusr8UaOuS1lw+tGilKXvEtaYqF0GlpZrbp+aOIWujUA3LjjNtsIS
         fZfGIbMfOWIuFSR3zqbSswbKVWh33cq3wwXc5iHoj0uWAzEfu938DfxJxmL9XfJxeNu2
         /0jC/uIexuk/O9yKbRwboaWIF9sVxNqouP+UyBVcGL8+JeYy24+IjyA6yil9vkBBYh+v
         rN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UCg5ZcT0wf4qG7UL0MwmVV9OeWz+eFOwBuM4J69Sb/M=;
        b=52CqOambt03FfP6a7qrpe0MCDyS0xrLogdUqu6LTdhUmWxoRavqenDgFwIzsKtGplC
         atOHV/cr/AuKDm8CFSEGB5l6Xmq5cp3qI1QVrzn4DLe2h2ljsLvYtqbflvUGAD4Zmapb
         If2H5zOu8bWsnFvUkEqZa+cd0k/V0ddCse8whIBnJtl4TdmteGt+i2ix1Wr0sQiXaOFB
         wsXhAP0sVhiMqFqkM8Ekmt6g2vJMnQRFbkNLwS5hh8+u36bfq6f9j6pT5JdG47waYz4t
         I8Pnm6aX6zB0Vxks6D7nwdC/2ZNPw9m6XLSEb5D72CIyVYEFYitAoNakQRZtjG2+IL19
         AqFg==
X-Gm-Message-State: AOAM532wvf7UUlMSSyLud64KOo49hp+ThzaKfkvUyf9iycBUYVLDdyL8
        CTvkzKYN1LvMZJirEbvdjLU=
X-Google-Smtp-Source: ABdhPJyqnXOcjZc0CiY2xGq8NP8I8Abwqf0haWyTyok5r5IZp+b2YQQtO1q8Y635MHU3Ao8v2slDRg==
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr3043150edb.177.1642057360421;
        Wed, 12 Jan 2022 23:02:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 19sm549886ejv.207.2022.01.12.23.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 23:02:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7u87-000mIR-C9;
        Thu, 13 Jan 2022 08:02:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: Re: [PATCH v10 6/9] ls-tree.c: support --object-only option for
 "git-ls-tree"
Date:   Thu, 13 Jan 2022 07:59:35 +0100
References: <cover.1641978175.git.dyroneteng@gmail.com>
 <bcfbc935b80b889273e3e54fec2a896e44acd2b5.1641978175.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <bcfbc935b80b889273e3e54fec2a896e44acd2b5.1641978175.git.dyroneteng@gmail.com>
Message-ID: <220113.86wnj4w228.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Teng Long wrote:

> We usually pipe the output from `git ls-trees` to tools like
> `sed` or `cut` when we only want to extract some fields.
>
> When we want only the pathname component, we can pass
> `--name-only` option to omit such a pipeline, but there are no
> options for extracting other fields.
>
> Teach the "--object-only" option to the command to only show the
> object name. This option cannot be used together with
> "--name-only" or "--long" , they are mutually exclusive (actually
> "--name-only" and "--long" can be combined together before, this
> commit by the way fix this bug).

In the RFC series I sent this was first implemented in terms of the
--format option, and I skipped the custom implementation you're adding
here:
https://lore.kernel.org/git/RFC-patch-7.7-5e34df4f8dd-20211217T131635Z-avarab@gmail.com/

I think in terms of patch series structure it would make sense to do
that, and then have this custom --object-only implementation in terms of
not-"--format " follow from that, and thus with the tests for the two
(we'd add the tests you're adding here first, just for a
--format="%(objectname)" or whatever) we'd see that the two are 1=1
equivalent in terms of functionality, but that this one is <X>% more
optimized.
