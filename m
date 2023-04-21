Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061BC77B73
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 01:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjDUBLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 21:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDUBLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 21:11:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D8170F
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 18:11:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f833bda191so725572f8f.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682039461; x=1684631461;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0qh37PCNDirYkiEBtfslJMP0KbziflWPFGDnRh+PQc=;
        b=GzHoC57abgZQFzFb6r+eRIP67uOe1umRUejd75JnuAljq/2qwxh/IaCJnlnpgp0I+c
         2TMQCM/N5bRLNXwjQ1p1dCefO3p2BjhUR3xx3MKw0UuvYZU9ttd/mR1Ot3DpDmg1a3Nw
         i3tGe8z7zkXNuSWKPJcXwOkotnkqZSC/EB60IuBqOsky3huNhy8dvSK/8lbHg3sSO/sT
         tlUSJiIFoBwvo6QiybLXLprL+c4eBG80AGkl8V3DhF4dzfQw0XtiiogrVwEUBsqL5Zg6
         +DkXMDqCb4orgjFs7NViZECZYNOGjieHNFo6Bu9wRhXTFzNQum55Gio5ldSQjXPbNGqy
         lAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682039461; x=1684631461;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0qh37PCNDirYkiEBtfslJMP0KbziflWPFGDnRh+PQc=;
        b=jhWHq9mSWDIAdfVJomPa/iR9m6PrJDZGfIUU2nejCmCw7Lz4vsGqD+2ZseNUj1EnU/
         p6FSlGNvobQFoKMPQVp6BrxYto/AUA1lwZhBvd01gSkHGKzKclfT9YAMVL+GIv8aGnJO
         CyxT8w5kFWQJ/Dv3AYMuxJF0qlVdfI4PrOfqBxv7D4Ixqp+cxSf1mZ+zujj03ND+Mh5v
         hJQ1+Ras22SE4hsVt+cZnRu80QLopWJ+HRjTIzPz9lHjstYzzdhcIFHVvebjz9l+P6xL
         Etqnoo4Ub4MN0aZiovZ06wFOordL6FWZTB92Ciu7vWF6zGiCZQJd1s4kEj6ADA8ow7lr
         +usQ==
X-Gm-Message-State: AAQBX9eP+KjlBQIPBKuwQ0Gyal4jAC2Z7BcZD5xrAilln1B8F3VILtRW
        0Um/5pgRe13b7f89a5dQOk2l02zh/sXM1ojII9M=
X-Google-Smtp-Source: AKy350ZJDB0Ux8+4KTHxitGJ4NiokJ5N7fhjnZHNcHcIHlOLuFzI4qEVV6OAp144p5fUqJRQDhpreEH2CqO2RbcaAxU=
X-Received: by 2002:a5d:428f:0:b0:2f5:ac53:c04f with SMTP id
 k15-20020a5d428f000000b002f5ac53c04fmr2597798wrq.28.1682039460910; Thu, 20
 Apr 2023 18:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205241.105476-1-cheskaqiqi@gmail.com> <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-3-cheskaqiqi@gmail.com> <c382017a-8c65-24ba-5092-6b46428d8b9b@github.com>
 <CAMO4yUF1P1Sv1aVJ1aw9US-QeNYD-GfaS7ndr=bwp-dgvOyexA@mail.gmail.com> <069a53ef-63b8-c1e3-7502-6728bda50665@github.com>
In-Reply-To: <069a53ef-63b8-c1e3-7502-6728bda50665@github.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Thu, 20 Apr 2023 21:10:49 -0400
Message-ID: <CAMO4yUESBZw2Jr8y4NW_2N7640o2o2mpq58+nnC+3qffG3Y8=Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] diff-files: integrate with sparse index
To:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

> If a user manually modifies a SKIP_WORKTREE file, SKIP_WORKTREE will be
> removed from the file and the index expanded automatically [1]. If that
> mechanism is working properly, there would be no need to manually check the
> pathspec and expand the index.
>
> Have you tried removing the 'pathspec_needs_expanded_index()' and running
> the tests? If so, is 'diff-files' producing incorrect results?
>
> [1] https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/

As per your suggestion, I tried removing pathspec_needs_expanded_index()
from the code, and 'diff-files pathspec expands index when necessary'
test failed.

So, I'm thinking about keeping it to ensure everything works properly.
I'd like to know your thoughts on this. Should we keep it or explore
other options?

Thanks,
Shuqi
