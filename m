Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6BDC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 10:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiAMKCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 05:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiAMKCr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 05:02:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF12C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 02:02:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b13so21288152edn.0
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 02:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=njCIoVwcn0AmPr3jnBos+XtiAVadbw6rfNPgkTZh5pg=;
        b=Ci7aNM8+a4l572edUTv84KAFTKoIF+z6eluEHmdx9lNJ2tLgzzA8zwShfAgF2ZfklM
         IXQw4RwI30cPXoUa+hb2Fklx9PngAchYl4iYTndHXiQ4LG1OmZsa4rzAxdtQFjw012vC
         +dF2h7nLyBPeJOnYjE5ag2UDQNU9s0DS7+A/0VtBffPJgYls283YBVtF8SF1LoO9bHZa
         04pmlDu7cQzEnV5pAwSovEC7iwdei0X8sQDrL7VTxVy08QvSiG5BwR0IXUVy60Zx4KcL
         JB7NsUEZ13IgFAPM3evqDjw9NI1TF3GjvWpozeGSWwSYnXdhrT0dgp6BcHqDqCli8xqL
         R/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=njCIoVwcn0AmPr3jnBos+XtiAVadbw6rfNPgkTZh5pg=;
        b=zdHZ1M8ZMTXpoiEqke9mHlED1F+D/N90Iegt8wo0m1sXDQ6V/IdYLQGeRhdsTSigZ3
         eqdCl/ku6s9VF3lRpJciD9yndXNYbUER7S8NMBtK1MPzu1QmVRwFoGenaSiPvKuP9b0q
         h1MwaAfHGFjuhIW8yBS1HsDga0g3/4Mq70Mv9We2QvGIwNk5GWyfHgae8WDZjRl7woLk
         smivgFLY+ByFoplPWp0FSVXH5xrdtakp6iZUVk/v47trGN70Gg3ZfP5JWV4zGh1AQd4f
         ibDchG1iCYuuI1annfPaEMbSyotCJEYy1yXjZMJsO399oYPLoWXXY3w2IH8seIp5b8ay
         AeyA==
X-Gm-Message-State: AOAM531+NlPzPwR04HwIljbGbDoYUGxdsC2nkGTURvL7zV4hmgtdzqkD
        nZu5gako2hubqupamc9vW4Q=
X-Google-Smtp-Source: ABdhPJycoEJ/fS5EsR6dNmaBajokPylSFNqqdl/JsS5+B7KVeA2LvVbkcrQ/jJZrDfyZD+pPYqY4kA==
X-Received: by 2002:a17:907:da1:: with SMTP id go33mr1392005ejc.60.1642068165839;
        Thu, 13 Jan 2022 02:02:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 12sm716861ejh.173.2022.01.13.02.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:02:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7wwO-000qs7-LQ;
        Thu, 13 Jan 2022 11:02:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 02/16] reftable: fix resource leak in block.c error path
Date:   Thu, 13 Jan 2022 10:55:54 +0100
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <9ab631a3b29addaa54415139e7f60a79a19a6edb.1640199396.git.gitgitgadget@gmail.com>
 <xmqqtuf0fe3r.fsf@gitster.g>
 <CAFQ2z_OLCzOYXgXCTXyLOwwk7EBkPzwH=KASDmuJbur=q7L1Jg@mail.gmail.com>
 <xmqq4k6y63j7.fsf@gitster.g>
 <CAFQ2z_OFK77TC605GqM2Lw1Lf21fyF2cVKkGVrXO6TP6zcp+mw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_OFK77TC605GqM2Lw1Lf21fyF2cVKkGVrXO6TP6zcp+mw@mail.gmail.com>
Message-ID: <220113.86bl0gvtq3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Han-Wen Nienhuys wrote:

> On Fri, Dec 24, 2021 at 5:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Once you
>> initialize at the declaration with "less meaningful" value (like
>> zero initialization), the tools won't be able to tell when the code
>> uses that variable "uninitialized" (because the assignment was
>> skipped by a bug), since it appears to always be initialied to them.
>
> Which tools are these? When I add
>
> static void test_memcpy(void)
> {
>  uint32_t dest;
>  char not_init[200];
>  int i;
>  memcpy(&dest, not_init, sizeof(dest));
>
>  for (i =3D 0 ; i < 10; i++)
>   not_init[i] =3D rand() % 255 + 1;
>  printf("%d", (int) strlen(not_init));
> }
>
> to the C code, it compiles cleanly if I do "make DEVELOPER=3D1".

Aside from what Ren=C3=A9 said in his follow-up, I think what Junio's
pointing out here has to do with the use of this pattern in general, not
the specific code being discussed here.

I.e. if you get into the habit of needless initialization it may not
matter right now, but once the function grows an if/else branch, or
someone copies the pattern to such a function it may hide a logic error.

So it's not about analyzing the control specific flow here, but that
your upthread patch is separating a variable and its actual
internalization by ~20 lines.

So in the general case, by initializing it when it's declared it's more
likely that we'll introduce a logic error where it won't be initialized
at all.
