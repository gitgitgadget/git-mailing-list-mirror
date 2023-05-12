Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CDCC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 15:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbjELPHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 11:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjELPHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 11:07:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E70A5B90
        for <git@vger.kernel.org>; Fri, 12 May 2023 08:07:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-306f2b42a86so6700827f8f.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683904030; x=1686496030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qL7Bp9pGjlkUPswVcmwl9k+IT2qYPa30N7DBetxXazk=;
        b=Z1RUOa1aziDPfDbSgdQeF9aMD81Mbo+K4QCVotjjq7Kej9YXk3vH49MRmNtETRdDKJ
         oJ2BEeNbaLNV0vmnkECG/gB9Roj1WLE2h1jEaXJ/qIMgGa7zItpCxNPsxNbwfDmMl6zs
         XjheG7XLcHwsoGXZ/3wgn0on4QyXgfpb7+EkqIVSufKwvsNL6JTlDjF1IkwkpELfK69u
         vWJ/GaXdEePFIputiWbI2xNqn//n67NQBakhms1NasHt3/caoclEWmpioZVAurvN21XE
         C5HH+ADsz2OkoF2Cd2igbOhnNS/n/mAT38B4GujgsCOEav/LQfZcjlRThkA7/gnkgMNa
         I9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904030; x=1686496030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL7Bp9pGjlkUPswVcmwl9k+IT2qYPa30N7DBetxXazk=;
        b=WLWlFEWToFoaVik4MoUEYPNKy3uOdYfC9HeA+IO4Hl0cP/uzo8BjOlWawH9NvxvGrU
         GKQZPFAg/d9LZpZ7ymgYrkCsCUsnB34wNPdwjPT/7EVSO2dUxotmzcIZKTj2ZyV690ga
         CkJ/BLpkV/ItaCu4Rs1XYys2xexTMn4bynsqLnvqQF2MTp8rP4EXAz15DO7DrX4/7wYD
         rP+dlgb9SVRoiC3ML7FI07odHhKGI8mmhjp2g4BEWdwKfUkxuny2q2ZP8+Oqx6Q566oN
         5hne1eAqllLoOwNOdzsnC162Nq1OnHWUp7zJWaISc53qJFFQr3r99cAVf8T0v3YDOeuD
         +HPA==
X-Gm-Message-State: AC+VfDxGBHTcG4bQA8/M3RfM1FAKTDuIKx+6TGivZzWyKH6YRVlGfV56
        7eph+ECOW88yxCKXz8aocsYSyP04yIQ=
X-Google-Smtp-Source: ACHHUZ6NSD5rToWeBVUYMOcnahXAbigcvIWmJDFz6t6TY3JzV1WOcqOY5Nv10TBOiRt+qrL7h7XCow==
X-Received: by 2002:adf:ce84:0:b0:309:2b6:5c83 with SMTP id r4-20020adfce84000000b0030902b65c83mr1140780wrn.1.1683904029783;
        Fri, 12 May 2023 08:07:09 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003f4b6bcbd8bsm7623644wmi.31.2023.05.12.08.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:07:09 -0700 (PDT)
Message-ID: <20d1d7a2-049e-cb53-e276-101995b7c9bb@gmail.com>
Date:   Fri, 12 May 2023 16:07:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug in unused.cocci?
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <5720a23e-6ac0-9a6d-3d05-4e0f34bc0589@gmail.com>
 <ZF0B2Prhc7jsqa3p@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZF0B2Prhc7jsqa3p@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 11/05/2023 15:55, Taylor Blau wrote:
> On Thu, May 11, 2023 at 10:16:21AM +0100, Phillip Wood wrote:
>> I think this is due to a bug in unused.cocci. I'm not sure what is going
>> wrong and admittedly we're unlikely to see code where an strbuf is
>> initialized and then used it without calling any of the strbuf_* functions
>> within our main codebase but it would be nice if the rule could handle this.
> 
> I don't think that this is a bug in unused.cocci, but rather a bug in
> spatch not being able to read t/unit-tests/test-lib.h.
> 
>      $ spatch --verbose-parsing --debug --all-includes \
>          --sp-file contrib/coccinelle/unused.old.cocci \
>          t/unit-tests/t-strbuf.c | grep '^bad'
>      init_defs_builtins: /usr/lib/coccinelle/standard.h
>      -----------------------------------------------------------------------
>      processing semantic patch file: contrib/coccinelle/unused.old.cocci
>      with isos from: /usr/lib/coccinelle/standard.iso
>      -----------------------------------------------------------------------
> 
>      HANDLING: t/unit-tests/t-strbuf.c
>      parse error
>       = error in t/unit-tests/test-lib.h; set verbose_parsing for more info
>      badcount: 3
>      bad: int test_done(void);
>      bad:
>      bad: /* Skip the current test. */
>      BAD:!!!!! __attribute__((format (printf, 1, 2)))
> 
>  From my understanding, spatch happily ignores macros that it doesn't
> understand (like check_uint() and check_char()), so to it this code
> looks like:
> 
>      struct strbuf buf;
> 
>      strbuf_init(&buf, 1024);
>      strbuf_release(&buf);
> 
> which it marks as unused and applies the patch. Strangely, if you force
> it to pre-process with the appropriate macro file by passing it
> explicitly, it works as expected:
> 
>      $ spatch --macro-file t/unit-tests/test-lib.h \
>          --sp-file contrib/coccinelle/unused.old.cocci \
>          t/unit-tests/t-strbuf.c
>      init_defs_builtins: /usr/lib/coccinelle/standard.h
>      init_defs: t/unit-tests/test-lib.h
>      HANDLING: t/unit-tests/t-strbuf.c
> 
> I am puzzled by spatch's behavior here.

Thanks for looking at this. It's good that unused.cocci is not buggy but 
I agree spatch's behavior is confusing.  There is a similar test for 
STRBUF_INIT which looks like

	static void t_static_init(void)
	{
		struct strbuf buf = STRBUF_INIT;

		check_uint(buf.len, ==, 0);
		check_uint(buf.alloc, ==, 0);
		if (check(buf.buf == strbuf_slopbuf))
			return; /* avoid de-referencing buf.buf */
		check_char(buf.buf[0], ==, '\0');
	}

Which does not trigger this issue. Presumably the "if" statement is 
stopping it from ignoring the check() macro even though it does not 
understand it. If I change t_dynamic_init() to do

	if (!check(buf.buf != NULL))
		check_char(buf.buf[0], ==, '\0');

Then the static analysis job passes but I don't think that is really 
fixing the problem.

Thanks

Phillip
