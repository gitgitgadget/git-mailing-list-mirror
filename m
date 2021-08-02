Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2759C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C066C60F55
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhHBSmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 14:42:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74BC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 11:42:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z11so3385876edb.11
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yUyzfA/y/SnWgPkWyZB1VqP/YR18QSOv5LobFX7cnhc=;
        b=L5FZe9MHtndsrKpvmuDuq3PxfxnFquYg4o1xVfnxva1fatV9VJNX8HQpj22b+9aNwA
         04XL1KdkGAz/iLrht/k97dZbjJ5cdWaXtVX3lOKKHTmQDDausi8KrTXytDjhRnt+a1c/
         dWC8gbPozwt83fNboM4whMuJQFEiR21kkoevzHWSfrkxy1+6IJqrpXArW+VneDGckrZ7
         57twaULnFGhwSMnh0XVrIorFzs6AH6gjKtu8a02+FRIZVu9mc3/dq7BpbgWK3ImTNze4
         Oqieqk5nqCkdSUnwqgD047CXY+QdZdf6R5jbII/5zsjS9YQiKIWFevY+qJ/U5i+hvi4Q
         lF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yUyzfA/y/SnWgPkWyZB1VqP/YR18QSOv5LobFX7cnhc=;
        b=aAVnjtvegtYcJSrUBabiWt1QSSQPnLxp8ARbXAcP8VttyhUgI/md5zM4UJTgrUcZW/
         ar2MsRhtgx3jB5NMmIUkBn/osdozf4TiMGZUTS6tK8Iue7g3Ki0dV0L7B/pg9uty47B+
         1rJt4AWVnbHvjKO0VNdZXP/se5Deg/LbASmLFRRYdPwt4L7WcS6UH3SsA5EahjEo8N/R
         RJJ7sLUgo8kJlJWg56vBPRf/HEfrhNukv6j4B6hCNd5lNd9RjOJVmpN/pFvVhN5plMdX
         KZNE6Efn7O7jIndx4HrapK7l5V7dwo00+9OYx1EIEsq6g1VnpLt1q/Ud9bZfwZ2wM12y
         6MTg==
X-Gm-Message-State: AOAM531AYKjJetlTgVqvVMMTcM05llvFUQ164+USKHZwth/NvV42DxVO
        4g6HFqWddbXTEZ4hS2sTieTjemAeTiKhGA==
X-Google-Smtp-Source: ABdhPJwflU5pyUzOslyxrWkwgo8LuAu2fv748CBzVT7FP5Kl20smIaz/vaEteC4F3UVG/mVwiKllNA==
X-Received: by 2002:a05:6402:206a:: with SMTP id bd10mr20803907edb.263.1627929746132;
        Mon, 02 Aug 2021 11:42:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c28sm4978469ejc.102.2021.08.02.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 11:42:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Emily Shaffer' <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
Date:   Mon, 02 Aug 2021 20:41:36 +0200
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-3-emilyshaffer@google.com>
 <87o8agp29o.fsf@evledraar.gmail.com>
 <00a501d787b8$f8347a80$e89d6f80$@nexbridge.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <00a501d787b8$f8347a80$e89d6f80$@nexbridge.com>
Message-ID: <87eebbofhq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, Randall S. Becker wrote:

> On August 2, 2021 6:22 AM: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wroteL
>>On Wed, Jul 21 2021, Emily Shaffer wrote:
>>
>>> Git for Windows also gathers information about more than one
>>> generation of parent. In Linux further ancestry info can be gathered
>>> with procfs, but it's unwieldy to do so.
>>
>>Having read the win32 get_processes() implementation and read proc(5) I d=
on't get how it's unweildy to do so on Linux? Perhaps I'm
>>missing some special-case but this rather simple patch-on-top seems to do=
 the job for me. This includes the unrelated enum/switch/case
>>change I suggested.
>>
>>I can submit it as a patch-on-top with SOB etc, but maybe there's some su=
btle reason it won't work properly. It works for me, I get e.g.:
>>
>>    {
>>      "event": "cmd_ancestry",
>>      "sid": "20210802T102731.879424Z-Hc2f5b994-P00001acc",
>>      "thread": "main",
>>      "time": "2021-08-02T10:27:31.879618Z",
>>      "file": "compat/linux/procinfo.c",
>>      "line": 66,
>>      "ancestry": [
>>        "bash",
>>        "screen",
>>        "systemd"
>>      ]
>>    }
>
> Should not the subfields of "ancestry" also have field names? I get that =
they are a list, but it seems a bit restrictive.
>
> My preference here would be:
>
>      "ancestry": [
>        "ancestor": [
> 	"program": "bash",
> 	"pid" : 1234 ],
>        "ancestor": [
>               "program": "screen"],
>        "ancestor": [
>        	"program" : "systemd"],
>      ]
>
> With more richness available in the ancestor.

That sounds sensible, but to be clear that's a relevant comment on
Emily's original patch, my "let's implement the same for Linux" is just
faithfully reproducing what we're already doing in the Windows
implementation.

But yes, I'd think that including the PID would be a sensible thing to
do...
