Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A0DC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347499AbiBBVWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347497AbiBBVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:22:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E575C06173B
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:22:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jx6so1450566ejb.0
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FZCb57K3dNoPILDBE49CZt0EZ/3L16QAZixSVV4LPXU=;
        b=ZUueOpwDY01kdHCXWWJrzGpduFyQGwOi+3qH8hIlOlfSuOqYgFUWOQ9NTZTQYWRMZc
         Na0dy60M4g+DfMc2UpCeNAXCJrsCRiZ9yPx8aeT8vjlPRote+EkRrhOUo4DZAcvT0TwQ
         FIem+SRci+E7Vkxy/zQ0n+ll1K+dD9JdK5XDko1xAdewuLGBvg49DZ3fgdBJMJHzGm7d
         1okm6NHSn/5R57JSMlKHZFZ4pUJ+FjalY1aOxChzRijE6OVzUq8rZSkJ5J/ZGDnYpUcV
         slEWllfySmaT2oKoSPB2dbGm8tTo/ejaGFi2xOz28gDJg33GY25ca32BWv2Yu4D2Xtl+
         SR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FZCb57K3dNoPILDBE49CZt0EZ/3L16QAZixSVV4LPXU=;
        b=zXe79C+XbDK4O2VZVOL5qyMJpsNaDc3nu/EA0IxNtOcnNT+CsWkEIc89ZPdgIk7pJq
         8LIwYZKWbIoa3ocPGPsw5nH/QNKCRMxucUyNHWlswKAskyvhndmAPyR33q8Ahja6qD4y
         gMBrWKoPz/E6xt48TFgX5CtEPO9XpocpCAJFO2dBL+qUpKp7gy5WugJjn6O5MR7yb1j8
         QSvYbwBXyWKHvwLdSKFKSivbg8F9YFjwSIa8mBAhc7Tuwm5QevoBxn80IaXSMqm64XXc
         3lenth4yBIMxUErcUS1x9SMfZ170luyb62XdUziUBtVx2NPPiiqFg81vj2bTXL0SjaLE
         v5/g==
X-Gm-Message-State: AOAM5328+3mK80LUWI/rbMEnE0nW1bGcXvJ7rHY4q0iLupeI0jnVjheF
        O8bV1ApccfKdaJTUQXby76yLqP2gkzwi1A==
X-Google-Smtp-Source: ABdhPJwqXm5pXG3zUWVOm8KwUWJts9TzMhe8q107RvcRPxX43zq7/yweM2I9o0dJjJ6f1OYD+se0ZQ==
X-Received: by 2002:a17:906:3903:: with SMTP id f3mr26392437eje.705.1643836950546;
        Wed, 02 Feb 2022 13:22:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v3sm20647591edy.21.2022.02.02.13.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:22:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFN5B-004hc1-El;
        Wed, 02 Feb 2022 22:22:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/5] date API: create a date.h, split from cache.h
Date:   Wed, 02 Feb 2022 22:19:17 +0100
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net>
 <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
 <patch-2.5-7de62956db4-20220202T195651Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <patch-2.5-7de62956db4-20220202T195651Z-avarab@gmail.com>
Message-ID: <220202.86v8xx6k16.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 02 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Move the declaration of the date.c functions from cache.h, and adjust
> the relevant users to include the new date.h header.
>
> The show_ident_date() function belonged in pretty.h (it's defined in
> pretty.c), its two users outside of pretty.c didn't strictly need to
> include pretty.h, as they get it indirectly, but let's add it to them
> anyway.
>
> Similarly, the change to "builtin/{fast-import,show-branch,tag}.c"
> isn't needed as far as the compiler is concerned, but since they all
> use the "DATE_MODE()" macro we now define in date.h, let's have them
> include it.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  archive-zip.c         |  1 +
>  builtin/am.c          |  1 +
>  builtin/commit.c      |  1 +
>  builtin/fast-import.c |  1 +
>  builtin/show-branch.c |  1 +
>  builtin/tag.c         |  1 +
>  cache.h               | 48 -------------------------------------------
>  config.c              |  1 +
>  date.c                |  1 +
>  date.h                | 43 ++++++++++++++++++++++++++++++++++++++
>  http-backend.c        |  1 +
>  ident.c               |  1 +
>  object-name.c         |  1 +
>  pretty.h              | 10 +++++++++
>  refs.c                |  1 +
>  strbuf.c              |  1 +
>  t/helper/test-date.c  |  1 +
>  17 files changed, 67 insertions(+), 48 deletions(-)
>  create mode 100644 date.h

I managed to notice just after hitting "send" that I'd forgotten to
"make hdr-check". This commit will need the below fix-up. I'll hold off
on a v2 for now for any further comments though:

diff --git a/reflog-walk.h b/reflog-walk.h
index f26408f6cc1..e9e00ffd479 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -5,6 +5,7 @@
=20
 struct commit;
 struct reflog_walk_info;
+struct date_mode;
=20
 void init_reflog_walk(struct reflog_walk_info **info);
 int add_reflog_for_walk(struct reflog_walk_info *info,
