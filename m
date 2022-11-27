Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B2C43217
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 00:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiK0AYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 19:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiK0AYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 19:24:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AD9178A6
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:24:32 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 140so7238620pfz.6
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX0ut8MdMXEDMuw+T5Vra7x8yIwsoe8i0hDueMFdRzA=;
        b=JxXO4l5lGic9YlsoH5fvP0pl0gd2whFrC3qmo1kR4cT7EW9cZuShdH504UL+j/ju+9
         Uy7+8tjnwbOPPqlo0TRMBMC5dmsxdceSEUOQJTsI+69X8IHqdyB/6e1gS1zTb4ekaVOS
         y4Cf5CGS5q7ozebw0lk0OntkWHklnNec2S8JpbawsKl/+DKtIdWPkWMCS9YNyUfqefpP
         ix/5nciVqB61xOcWFsW3O7wTkTeXdretTG3M2cVbUSqipS1WzmhYCvyfJdmVuhQRaes1
         q7D37JsU6Gr2oyBB/o4maBkr5t3rx7X3Hr0dCJ0s9WDwC7RlXLe2zj4JenSGRWEG4GlV
         4Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX0ut8MdMXEDMuw+T5Vra7x8yIwsoe8i0hDueMFdRzA=;
        b=S2eUr0Rnt3y/wp4kYmHAYVjWzG7dEMsPLxBKIHoQd/4dpj6/hpB7uSUFXdJkWNkceH
         GZBgtMZasJuBSom97FqwQ+mcWMCn9zVjNPC9gVMaoU0RTwDiKslzDGukSsj7OQPPR41o
         oORlvADdvqbVtB1DdBtbyitmEWSxMGT6w5ceLXCVYp6ufqymYAI7+B+ppePQAjRiR94j
         xk+kuMzpQNEy5hZ0/SxqOQ/UTxW7tEcWCuuioiK9HUVZOimn+CLdqCQsDxySUgT7K0g6
         NX+htse4GNJ0+lh/rMmw8iknS29/7Y0qSepxubpHhxR+rl5i65iPCEb5VAevkGJNui60
         SyxA==
X-Gm-Message-State: ANoB5pmvPavPOJ/B/ZKOzKiFKaXphRJQtlnZ9oBVQlCKIwlSIU5ihKfg
        YnpBY1GtIiUwgcijjfyU110=
X-Google-Smtp-Source: AA0mqf4CoqaE630g/fR13huIHoj65ul2mWr6+we+Yvej4pT6h72yjZ/F8n7B1EVlxjo3+Bm8QkjZzg==
X-Received: by 2002:a63:5719:0:b0:476:ea7d:3ff6 with SMTP id l25-20020a635719000000b00476ea7d3ff6mr23298236pgb.73.1669508671496;
        Sat, 26 Nov 2022 16:24:31 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b0056e8eb09d58sm5379380pfh.170.2022.11.26.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 16:24:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 1/4] github-actions: run gcc-8 on ubuntu-20.04 image
References: <20221124153934.12470-1-worldhello.net@gmail.com>
        <20221125095954.4826-2-worldhello.net@gmail.com>
Date:   Sun, 27 Nov 2022 09:24:30 +0900
Message-ID: <xmqqedtpb5xd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> GitHub starts to upgrade its runner image "ubuntu-latest" from version
> "ubuntu-20.04" to version "ubuntu-22.04". It will fail to find and
> install "gcc-8" package on the new runner image.
>
> Change some of the runner images from "ubuntu-latest" to "ubuntu-20.04"
> in order to install "gcc-8" as a dependency.
>
> The first revision of this patch tried to replace "$runs_on_pool" in
> "ci/*.sh" with a new "$runs_on_os" environment variable based on the
> "os" filed in the matrix strategy. But these "os" fields in matrix

"filed" -> "field".

> strategies are obsolete legacies from commit [1] and commit [2], and
> are no longer useful. So remove these unused "os" fields.
>
> [1]: c08bb26010 (CI: rename the "Linux32" job to lower-case "linux32",
>                  2021-11-23)
> [2]: 25715419bf (CI: don't run "make test" twice in one job, 2021-11-23)
>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---

Very well explained.  With the patch text alone, readers would have
been puzzled about the removal of "os" and the description certainly
helps.

I also like the changes to ci/*.sh to match any future versions of
"ubuntu-*" used in the pool name.  It is a sensible way to future
proofing.

Will queue.  Thanks, all.
