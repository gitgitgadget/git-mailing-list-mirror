Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAB0C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiKGVZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiKGVZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:25:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEE8D2DE
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:25:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b2so33627916eja.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xO6Fi+9nbEQCMdXhyV0gy5IdaZgig6pvl23olctzS3I=;
        b=CPWCx3RfTR3k4qolNEnlLXvBTu2LnPIW2FpjUGzGy7ROfdSB4rqu1RARiMRoG8nsB6
         IXKl3RB0prPO33trX25kS3kK6oLnqbqsEvn+7fg/lj1+o1EXXndCkr+HtoNyTd5meyxh
         afKU0tElUuGQmQIigCzCg8FfAa3I1jKBgYnmP9j4pqB6iuJhnw2ZJwnXvL+2wKnvJPQO
         JzL7mgjHj8iUTiEufXa8bScqcIYhoffiQ+bHI9TZNyCRdj+iyOKujqWclr4Q9ZcmfcFK
         6aE8FC+f8EPfV8MrDYg69dflwqWbzHs+57ziU0iA1Jx3Ho6UhLFxtqJzcBPYG0Hdlpor
         iUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO6Fi+9nbEQCMdXhyV0gy5IdaZgig6pvl23olctzS3I=;
        b=YZQ+UytM7tokbs3CtDhaRPLS/Io4TXuNUbHCcmzuYJHVIxDRRoKqNC4BP4NBv5FVJ3
         M2qdwYU30ZyVDnRbfGXLOizfq1YC8iV1ViEL3phGS4OndpOAGic0ajYMi0XolD85gVfL
         ZUEXgS++0YCbSkGT2Xibq8nEjvgLN0tLYQ984cUZkTT1fo8rNeeLKbdCQ2jHqARvIwYR
         lqbMTlp0tbM3VDjWaikWhmi2zdvzIjo0a8ed9/HwyfvMPTrLKK8ru/+VQM5cThaeRj7k
         Mcvlq3IPapwy9WOODm4OgEgRT9WCnqr6aPFqIbFZnJUA4OgU1l+cZwWW8nd1bDklZD0U
         wz/w==
X-Gm-Message-State: ACrzQf1jCiSFXu72siENfoSiMkd4WNQt1f6PDKFmrxB/fI7fPszENqg1
        DC5UmVdjila5214Obe8Ub7R6zD2RMVIIcA==
X-Google-Smtp-Source: AMsMyM6g7DiUuycy23kER/J8fuQGwvF5uH6Wcra98VMFm06ksokPtkKA4heq5K0q/38CaXRGTz3Elw==
X-Received: by 2002:a17:906:58c9:b0:7a7:dcba:a987 with SMTP id e9-20020a17090658c900b007a7dcbaa987mr49420176ejs.88.1667856330464;
        Mon, 07 Nov 2022 13:25:30 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hg11-20020a1709072ccb00b007a8de84ce36sm3810161ejc.206.2022.11.07.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:25:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os9cX-000Lkp-0g;
        Mon, 07 Nov 2022 22:25:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: ab/sha-makefile-doc (was: What's cooking in git.git (Nov 2022, #01;
 Thu, 3))
Date:   Mon, 07 Nov 2022 22:24:04 +0100
References: <Y2RldUHTwNzmez73@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2RldUHTwNzmez73@nand.local>
Message-ID: <221107.86wn86tq2e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Taylor Blau wrote:

> * ab/sha-makefile-doc (2022-10-26) 9 commits
>  - Makefile: discuss SHAttered in *_SHA{1,256} discussion
>  - Makefile: document default SHA-1 backend on OSX
>  - Makefile: document SHA-1 and SHA-256 default and selection order
>  - Makefile: document default SHA-256 backend
>  - Makefile: rephrase the discussion of *_SHA1 knobs
>  - Makefile: create and use sections for "define" flag listing
>  - Makefile: correct DC_SHA1 documentation
>  - INSTALL: remove discussion of SHA-1 backends
>  - Makefile: always (re)set DC_SHA1 on fallback
>
>  Makefile comments updates and reordering to clarify knobs used to
>  choose SHA implementations.
>
>  Will merge to 'next'?
>  source: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>

There was one outstanding issue from Junio noted in the v4, I just sent
a v5 in that should address that & more:
https://lore.kernel.org/git/cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com/

So hopefully with that it's ready for 'next'. I have a trivial patch
queued after it to flip the default on OSX to use
sha1collisiondetection.
