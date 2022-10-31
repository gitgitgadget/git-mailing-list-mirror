Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D37EFA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJaX4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJaX4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:56:52 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B9120A7
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:56:51 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 11so11163267iou.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tUD2kdovPbvl9KFrD/FIdbC8hCDX7smgumWVSdJqnkk=;
        b=mWNumf4yMj5312Z6DtLyGHGlnvkn8nOM/5ACDuKpbjfD9eXVD0PfUw9rSUuOi7wRwk
         p0tnS3BWeKdyNozODxqOr7R6V3yfvaCSj+KaY7JJ98Cd5gHoOgFvijVVW8ENIWnRWKxC
         aWgUGllfxLhUopcEscBqxz289079sorQt2Z8AdF8ySKx+p42D4O5fXxGQVefbIZP6MIi
         yFfFk4me+ycEf+8wHB7uam2rEMJ+1aKv/7gKParX85Sjj0R0go1a+ozdTOoPc3UpLFUT
         pNBCMs3zeRQ80HJFwifntuC/KMK4yFFYxP6j0jJVZz06Lwy1gYfg06cWRJx3GCgM30J3
         HA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUD2kdovPbvl9KFrD/FIdbC8hCDX7smgumWVSdJqnkk=;
        b=O8qwFjMk4g3CXQYjCTtxObTIROqdWhct+AG08TLR/g7mZ13hLTdvGEH/Q6+Zm1m8VX
         8T3K76eDrqB1VN+tWnHPt4rO9vtxMzFt7mQR38pmtxFHPZgD0RZZJnquNuFXGl4a63Ss
         +zYTbxfYPO9N0iI3St+r8gZGvpKS35Bp9/DuVruGhd+bt5Nt412PfOGNGyfZuke5hGH8
         db/wDVdmk2ipr2GQSUFpj8iKI0vEzcwOuP/nM4B7c9dLG2yBcfrQ+eWkN6wJC0lZJ9bs
         qbFaKWkejBOPaKZ5cuHRJt1C6oLaEQLiBCJo07jb8XQO76xp3U+ZESqUp+QeZt1lS2YR
         XhIQ==
X-Gm-Message-State: ACrzQf1mw+nA3X3dnbla0VSDabEnkhi8QGeTi3ybT0e0XdOBzK/UUdVC
        LXSI8g1Pd32lKmXlVa+G60BLRQ==
X-Google-Smtp-Source: AMsMyM7RPLKRj32Bfm3M7LBGtOW98fb74ZD7OnCdw0WXFKfHTmtO/Do7uMDGb+J/Rid6U13YNUIsEw==
X-Received: by 2002:a05:6602:1604:b0:6d2:b4de:9dea with SMTP id x4-20020a056602160400b006d2b4de9deamr1671608iow.64.1667260611227;
        Mon, 31 Oct 2022 16:56:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y4-20020a92d804000000b002f66aacb98asm3027811ilm.70.2022.10.31.16.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:56:50 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:56:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/3] hook tests: fix redirection logic error in
 96e7225b310
Message-ID: <Y2BgwZ45C+Oqs+W0@nand.local>
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
 <patch-1.3-1ba41a5842c-20221029T025520Z-avarab@gmail.com>
 <Y12I7zSohPu2cyJt@nand.local>
 <221031.86tu3k6u2d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221031.86tu3k6u2d.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 01:44:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Sat, Oct 29 2022, Taylor Blau wrote:
>
> > [+cc Emily]
> >
> > On Sat, Oct 29, 2022 at 04:59:45AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> >> index 43fcb7c0bfc..2ef3579fa7c 100755
> >> --- a/t/t1800-hook.sh
> >> +++ b/t/t1800-hook.sh
> >> @@ -95,7 +95,7 @@ test_expect_success 'git hook run -- out-of-repo runs excluded' '
> >>  test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
> >>  	mkdir my-hooks &&
> >>  	write_script my-hooks/test-hook <<-\EOF &&
> >> -	echo Hook ran $1 >>actual
> >> +	echo Hook ran $1
> >>  	EOF
> >
> > Looking reasonable to me. Though let's see what Emily thinks, too...
>
> FWIW Junio looked at it back in
> https://lore.kernel.org/git/xmqqczh84fpy.fsf@gitster.g/

Good, though I would like some feedback from Emily, too, seeing as most
of this code blames back to her.

Thanks,
Taylor
