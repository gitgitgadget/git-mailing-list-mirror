Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30FC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiLLSSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiLLSRP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:17:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8901D167C2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:16:08 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id fc4so30174385ejc.12
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SRLyvGhv00JVhyDey9KVcr81k2xJ9olWJYrg/Tv+CoA=;
        b=AZa9cOwercRd8TDQfJClKPkFXptFsiV2qzABTgVey5cz9rzxWlzlgPsYdoGwRfCXQp
         nKKafQ1Z3RX2YBkOlyTlyb397ksT5GKGzaz8E+qRGIcaYn28oUFeYIoTfngau9kAVeYW
         59BNwQl878Ax8BBB3oW+FbyUd66wwRa2/wVDEqpmjUD0L9kaexkrB5fBTPNoFmO8+ijn
         rQ35xmb2J06FkK3iQU6zVSuHl50r7t0Z5NbzwWfIed/qhOQFsmdpculdBcQ2/1f3WUSN
         x7FJY4QzHuyZJiXrARtOwB0CHTFHgP5mhrT9K0hpLaqhYO3dQ1ABx+DSDwb145aCRZrF
         28qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRLyvGhv00JVhyDey9KVcr81k2xJ9olWJYrg/Tv+CoA=;
        b=tODkuq5f9fDv6S6mV5u3pn19Nt4m7VKR6vERhhpN9sr2CD8cFq7rUhqyw4S5oY8uE6
         vw3oOTDhST2XdZIyM/Ta+eWBqu9710c/5anJc8OtQaE/uJQdsC8Ii49xqhXUn4f6VcMk
         1467MLzLavX5+cBcvkyiWHYShgUya/I9QLWvDQ9Y5JR6TQR1cd6wWOFLMG3zgAn7cbn4
         Lv+NJFR0dUyTymMGazZQEr6aCcc1NbIioct1f+FPGqC8SrcsFI0B9OmEBPu9oIZDeHlS
         BJlxSrERL3+B4yEES3F0DeraKDdy3nuuJ0jVSLBfgCfFvrcBF1M5leL/hHIqb7OQSwT3
         uODg==
X-Gm-Message-State: ANoB5plzl3SV3LpGLsMsnFzo2rOEiawvcChpvnDGoNyXUMwrduN4OKx0
        A/8S/mkdmJCGsinSPJiK/WLzfHaeros=
X-Google-Smtp-Source: AA0mqf6ePmFI/E8RywLB6svX38WQZUIgUCNXhdKT/6sXbosznpXTNVelmN46KHBTBjnBhO5SIoTwTA==
X-Received: by 2002:a17:906:f741:b0:7b4:edca:739 with SMTP id jp1-20020a170906f74100b007b4edca0739mr14688403ejb.5.1670868967088;
        Mon, 12 Dec 2022 10:16:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hb14-20020a170906b88e00b007c10d47e748sm3614615ejb.36.2022.12.12.10.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:16:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4nLS-005Rda-0g;
        Mon, 12 Dec 2022 19:16:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 2/3] worktree add: add --orphan flag
Date:   Mon, 12 Dec 2022 19:14:11 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221212014003.20290-3-jacobabel@nullpo.dev>
 <221212.86tu2158bz.gmgdl@evledraar.gmail.com>
 <20221212145515.pohzoyllo3bgz7eb@phi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221212145515.pohzoyllo3bgz7eb@phi>
Message-ID: <221212.864ju05vyx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Jacob Abel wrote:

> On 22/12/12 09:11AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> > +	struct strbuf symref =3D STRBUF_INIT;
>> > +	struct child_process cp =3D CHILD_PROCESS_INIT;
>> > +	cp.git_cmd =3D 1;
>>
>> (aside: We usually split up variables & decls, I think this is better
>> right before the run_command() line).
>
> Sorry, I'm not quite clear what you mean.

I mean that we usually put two newlines between the last deceleration
and the start of any code.

And additionally, that the usual pattern for CHILD_PROCESS_INIT is to do
these "flag" assignments right before the run_command().

See e.g. the code in "check_clean_worktree()"

So following its example would resolve the decl style nit
