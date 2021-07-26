Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235AEC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F012D60F46
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhGZLyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhGZLyj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 07:54:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D39C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:35:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id go31so2413284ejc.6
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zrUG/G+luRtMJtGd4ZAkfl9t0Rfk7nSPep/0EZ0eCN8=;
        b=OKm591FwM2bT9CxCrpBcpT+57BTLnb8C0bnsl03U1n0CWia8UuVwwzSrwvjbICT4CQ
         n5d6Qwmv97CSQUHcaDe/vF9h9MdyuT/YxvsYlKYSz6NqsslnOHbI7Jyh7d61g7xv35xQ
         Yr1NDSGpFcn6XG1N8n1+ogezacjynrn28AvFxurBw0iUv5pY2gNTNmvG51HwLPry+VBY
         T+eXG2pPsEUenX7YfjQu9jBE0b2k0wpfQVhiF/WX82S6W8ZXJFZcu0hdgNCwN4l/L1Cz
         jSvMLbzauyD7VeG5svHfy5ekC4vFuAZu9p4RNu2muomEMZJd1/NEVJbZ63ZoG0w2pm4I
         qXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zrUG/G+luRtMJtGd4ZAkfl9t0Rfk7nSPep/0EZ0eCN8=;
        b=e2rcQt6TJVA4a6Spr2bhS3rAvXQQwKU6ADAprcJ5CmDGpj5o+aedFg4dft/Tlu1+WG
         SaCU079sHzm50xF4py7DWOT4G7GZdlvb7fwMtgXZ+6BSyCRLj3K/jAddaXB0aCSoPkEM
         wn+TfhRpKWFlFxBW0jxds9JdyEtn4/1VhPp5SzU8CJHfZAiAafJ+bRc3v6S2IaSSXcrk
         /fPlVaKOQ3niE8V3H6P3JknLC+p2kvn7i1YZNP3V9pQ+boJ30rez53kiYQhHvuHRBCsF
         SoA16IDocHI/ctoX7WpPL4t0Ev7HraNxusyx/QZk33EjA6oGDcLO26YlSWW1qdcTm7yD
         GkLw==
X-Gm-Message-State: AOAM531vlsdMksvfhfaPx4Fvgaa636ddSwOSYRSD7ozNBqa7BV8i52Ye
        K2xBCbR5vpYQe2A7COK1mWQ=
X-Google-Smtp-Source: ABdhPJxlaxKRgkbBlJ/z9RuHTei2yVNcWei8HwyW4rfZ3ZW5CEuk140gFfDMcr+kIsKUsm6exO+eug==
X-Received: by 2002:a17:906:4a59:: with SMTP id a25mr3247296ejv.483.1627302905434;
        Mon, 26 Jul 2021 05:35:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f22sm18635098edr.16.2021.07.26.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 05:35:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v3 0/3] packfile-uris: commit objects exclusio
Date:   Mon, 26 Jul 2021 14:34:49 +0200
References: <cover.1621327467.git.dyroneteng@gmail.com>
 <cover.1627292424.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <cover.1627292424.git.dyroneteng@gmail.com>
Message-ID: <87czr5s162.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 26 2021, Teng Long wrote:

> Range-diff against v2:
> -:  ---------- > 1:  91dce385f6 packfile-uris: support for excluding commit objects
> -:  ---------- > 2:  92def8c72b t5702: support for excluding commit objects
> -:  ---------- > 3:  01ab2cbb34 packfile-uri.txt: support for excluding commit objects

It looks like you provided the wrong base for the --range-diff (likely
master?), so it's not a diff against v2, just whatever you used as a
base.
