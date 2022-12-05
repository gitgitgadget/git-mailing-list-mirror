Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EDDC3A5A7
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 00:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLEAYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 19:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLEAYi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 19:24:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C110059
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 16:24:36 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cm20so9722570pjb.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 16:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tYf1tBroTHeOKAl2lRCs4Wobo+kYM/fROYwInWWoJk=;
        b=iXP4Mx90Ymmz1TV4DJkFAcv57rTAy1k3HvHUsZLNvs25ztk+xreKdR/4mzMuFMiQbL
         DGkir20pIZ5PfWQ2+LDjsklqhm+Ieq6veYGLSgfmvEtdx43KGvxTbBH4uoFk3WnvoNvg
         uo+S/JnjAia/i9SUTAfpcSesd3qxhGWyJWzqQeLwq4D+jbESsEXBkDWKyUtLJQ+plbqF
         oRnew4Xbsk6/JPbQ1STcUgb06A7uoxAOuOt4YOggUwcgsNe7GHFjWFIgdHQwuzFWo2ee
         rLeNfrMfQgme+W1wmHexfU7t4U2Bm+aj9D4sIK8GEaiFaS5nF1rrluMbnqZUGNn5ZVQe
         AiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tYf1tBroTHeOKAl2lRCs4Wobo+kYM/fROYwInWWoJk=;
        b=RUdRCmDA2rLOpXotn2QcGIh1I4qq6IdsaauYFa+48ZV7GDjGxUqj+P65DI3dInUAEe
         kMsJOlTUlYLxzwNPW5sr/cuGghpqjyJ6MVkBls6URdFqLtAUQPAwVkEa9oC5NZ1Irwdm
         x4AkyPR4HU6VFLTSvRTvfjhnt+bCp1g6nFWOs8gpZ8+/Zoy/G/YQfw3BIGlBzf2x+vPr
         +VSWLNUu7Q/vpBQJ9mh+rtrx3XvJqXOyaPftHbsdwkVHfWqOOHm4bQgIdKt4knYJVG5R
         4NJXFKF5ySaP6RUYUMO+GGJ0jDjD0bsp0OoimoFgkD3pmqmo4aP1c6OkDXa2K3g7gLmw
         FaFw==
X-Gm-Message-State: ANoB5plvvS7CC0n+7GF0+aEkjR5YuMNTuu9jvlwS8eo+JgkCFhzdVNzm
        /9XZA3ziT+CM98x18XkPqBk=
X-Google-Smtp-Source: AA0mqf7tJcUJMko6Mw5FXcXmTZQsMuGx1tgJCC5aHV6/49s8kyYjfLnZJnDQV0NMTJ+n6ZP/4lJcRA==
X-Received: by 2002:a17:90a:7484:b0:219:828e:ba8 with SMTP id p4-20020a17090a748400b00219828e0ba8mr17075997pjk.118.1670199876168;
        Sun, 04 Dec 2022 16:24:36 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b00174c1855cd9sm9162777pll.267.2022.12.04.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:24:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 1/8] merge tests: don't ignore "rev-parse" exit code
 in helper
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <patch-v3-1.8-64dfec31fb3-20221202T114733Z-avarab@gmail.com>
Date:   Mon, 05 Dec 2022 09:24:35 +0900
In-Reply-To: <patch-v3-1.8-64dfec31fb3-20221202T114733Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Dec
 2022 12:52:34
        +0100")
Message-ID: <xmqqpmcyu27w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH v3 1/8] merge tests: don't ignore "rev-parse" exit code in helper

Just one is inclded here, so I'll retitle (and I am tempted to
disassemble the "series" into separate individual topics, as that
will help to use good bits early without getting distracted by the
rest) this to something like "s/^[^:]*:/t7600:/"

> Change the verify_mergeheads() helper the check the exit code of "git
> rev-parse".
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t7600-merge.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.

>
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 7c3f6ed9943..060e145957f 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -105,7 +105,7 @@ verify_mergeheads () {
>  	test_write_lines "$@" >mergehead.expected &&
>  	while read sha1 rest
>  	do
> -		git rev-parse $sha1
> +		git rev-parse $sha1 || return 1
>  	done <.git/MERGE_HEAD >mergehead.actual &&
>  	test_cmp mergehead.expected mergehead.actual
>  }
