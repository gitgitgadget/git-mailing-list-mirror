Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C15DCDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjJKWgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjJKWgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:36:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71638A4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:36:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso51475866b.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google; t=1697063779; x=1697668579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WBw5qDA+4euK5IGXfpFaaS/SZDl0wuQfcF2mj2WqmT8=;
        b=U57GMWFCNYe9K7eF+lnwnEtP+s/0oEo973PWSuUDn+mq4Aa1xnjzru0F1s4MGBk4IH
         WPfXCK7dpnjt4biV7WV4c66WC8Gj6MiYmzZlnGgiYpiMaXxYjal6IsAFMqHH0WnK5wJ+
         acjzLeiXlxy7qh88Ehm4MIbJU2tbxhovBiLz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697063779; x=1697668579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBw5qDA+4euK5IGXfpFaaS/SZDl0wuQfcF2mj2WqmT8=;
        b=J2BCSv9CeT6G4tJNSDAJ5vi5TSt3KkFxN52N2RjWalHq1vrzTEn+O4uYpw4cZbfPfn
         t918qQcdrN6ZHA3ATrwyBDDL2ejfQViA97GXhwTqZzfQ9RJ5JAifD42Odv+Nmy3jYXLt
         /irhYv1JLiD1fS3h6ugU5WI5BjljiXgqZlso9LYK3MXKeuF5HXlkrjrNUE/TapOMauWX
         fG6h6B3FvdfpQJGFiY/lW80t9nI7ahOzriABOgoy1hutkVZH9EtuuV5NllaUfNdaaQh9
         IMG+DOGtQL+ZUMw3PTpSpviZxPgHZHJv2E0P0BdCjvMi4gIv5Q8Ygxey2Cjqmscw0iFp
         ZnhA==
X-Gm-Message-State: AOJu0Yy0vami+tDYA4y1u1jwhgiUNjuTgHGlqzm2SaLmyYeFm5CxSr8S
        GiRX0N6GHjcR3zVgdmQXfR4YdKkocNoDymzj82WTEg==
X-Google-Smtp-Source: AGHT+IGT9YLtbPLfc7woMzuwnWdOujZXBfudwjkEQRwEAUCfHT4coZwMeoJ/PirMulw0WLpDQlmkCucfz3va2lYLSk0=
X-Received: by 2002:a17:906:3052:b0:9ae:696c:2c38 with SMTP id
 d18-20020a170906305200b009ae696c2c38mr19063396ejd.1.1697063778898; Wed, 11
 Oct 2023 15:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com> <20231011222728.GC518221@coredump.intra.peff.net>
In-Reply-To: <20231011222728.GC518221@coredump.intra.peff.net>
From:   Robert Coup <robert@coup.net.nz>
Date:   Wed, 11 Oct 2023 23:36:07 +0100
Message-ID: <CACf-nVeNV7NHaFKp976=Ln29CBbCFHcZ3kdQ4AorEcMMZDL4pQ@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: add tracing for fetches
To:     Jeff King <peff@peff.net>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Wed, 11 Oct 2023 at 23:27, Jeff King <peff@peff.net> wrote:
> I think this is a reasonable thing to have.

Thanks for taking a look

> Generating the json output isn't entirely trivial (and certainly
> involves allocations), but we throw it away unused if tracing isn't
> enabled. Maybe we'd want something like:
>
>   if (!trace2_is_enabled())
>           return;
>
> at the top of the function? It looks like other callers of
> jw_object_begin() have a similar issue, and this is probably premature
> optimization to some degree. It just feels like it should be easy for
> tracing to be zero-cost (beyond a single conditional) when it's
> disabled.

This definitely makes sense to me. Will add to a v2.

Thanks, Rob :)
