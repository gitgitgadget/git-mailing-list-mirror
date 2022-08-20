Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0769AC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 11:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbiHTLO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbiHTLO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 07:14:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4573ECC3
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 04:14:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y13so13021571ejp.13
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=qxDOXvoKzDrYk5HkwQ8i/UyDyTmA9BweRl8zGmB6q0U=;
        b=B3wci6Y/bQx8fvaJynK68vnAIZ0cIUugmBbEGfqcz473Hii74jhrbzA198H8QXi2Fp
         ezT0FVmcmd9tiCkvn/DjgkBIUi0f+F4YNCxmADQxw3J7BPdFIb8Ei3bJoMpTvwmQM337
         lM5YWUICb7HfyVtaepeaLn3Q/3api3a9axkLb7+teIChvA33AhmKHPwZ9E74jiugftL9
         Jc902lSk+w7oVli7/69LxgOnPGPWBSLrs2rXASHaS3G4rM+Tkd6HIcgRBZH+uGULQ3Jm
         X86CZgHWQjTrhjh+XkEBXa85IyYfQGkCY/4VtxuZJy089g4+tAtaGFijN5tPk34uQUdP
         iXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=qxDOXvoKzDrYk5HkwQ8i/UyDyTmA9BweRl8zGmB6q0U=;
        b=TIeBhJn7FKnhxEjnxfwY0x5sS3i9J3+2TJuF9GXKAvDhVBy5ICarEU4DUJcjCZlfAv
         pJJX2Op6Nw13cMfWZqA2DawW9u8Ahz/yn/hBN6F3NW0jKqZAphzgrqGc659zg0948k40
         YpdwdmO7GIwD1E8WKRJWAxcoLdm0GdZZCkb/2aOe641suAFVDuHliApCtDel/FKD0apO
         U54QATDvTg7KZ0Gz3IZjnbmz7amJHdRvyeAzSUgCnAWtChB5/Qmgm0SevIivvB/QmRjy
         PaVeEUG6WHiYDRRLgGn0OSOP5YJgz39AkxpK//5QBh6uEjWExb+a0pKvumDHw2CUDsaU
         S+mw==
X-Gm-Message-State: ACgBeo3YmOM5iDjSSjKaoLvPk3t5PP0IGVHCrTw8875MPD8za0Yf00MW
        eAZVKjA1xifKLqcRUzacJgo=
X-Google-Smtp-Source: AA6agR4f99aNtJhZLK4ljvignzw5AXGmKPoJhkSkS7nk6vj2idW34qZkWjx8rl8ZRdI4nkaTBhHEPg==
X-Received: by 2002:a17:906:93f0:b0:730:6b07:102d with SMTP id yl16-20020a17090693f000b007306b07102dmr7478916ejb.237.1660994064693;
        Sat, 20 Aug 2022 04:14:24 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id la7-20020a170907780700b0073d6d760daesm99974ejc.60.2022.08.20.04.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 04:14:23 -0700 (PDT)
Date:   Sat, 20 Aug 2022 13:14:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/20] t0040-parse-options: test parse_options() with
 various 'parse_opt_flags'
Message-ID: <20220820111422.GE3373722@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-5-szeder.dev@gmail.com>
 <220819.86k0746t7v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220819.86k0746t7v.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 07:23:44PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > +		error("'cmd' is mandatory");
> > +		usage_with_options(usage, test_flag_options);
> 
> I think you want usage_msg_opt() instead.

As I responded to a similar remark in the previous round,
parse-options uses the "error:" prefix in its error messages:

  $ ./t/helper/test-tool parse-options -U
  error: unknown switch `U'
  $ ./t/helper/test-tool parse-options --unknown
  error: unknown option `unknown'
  $ ./t/helper/test-tool parse-options -i
  error: switch `i' requires a value
  $ ./t/helper/test-tool parse-options --int
  error: option `integer' requires a value
  $ ./t/helper/test-tool parse-options -i foo
  error: switch `i' expects a numerical value
  $ ./t/helper/test-tool parse-options --int foo
  error: option `integer' expects a numerical value
  $ ./t/helper/test-tool parse-options --quiet=42
  error: option `quiet' takes no value
  $ ./t/helper/test-tool parse-options --mode1 --mode2
  error: option `mode2' is incompatible with --mode1

Subcommand-related error messages should be consistent with these, and
use the "error:" prefix as well.  Unfortunately, both usage_msg_opt()
and usage_msg_optf() use the "fatal:" prefix instead, so I will not
use those functions anywhere in this patch series.


> > +test_expect_success 'NO_INTERNAL_HELP works for -h' '
> > +	test_expect_code 129 test-tool parse-options-flags --no-internal-help cmd -h 2>err &&
> > +	cat err &&
> 
> Stray "cat", presumably in error..

Leftover debugging :(

