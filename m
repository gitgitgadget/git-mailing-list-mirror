Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BFDC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLOPIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiLOPIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:08:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BB630F4B
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:08:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so3028853pjj.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iNfTo5yeNay0+UivJNJMq/rj2OhZVqOYNARAz1E5lsc=;
        b=NWMtI6m8Hyx/ZoR65q5xH7RlcUB8VTMbm0sJ//A8DWj2/vERSiNoT5mAGVddaPTslt
         OBH6eYCiCgX8V9QfgJTrVk+9Ubi//+1xq3Fv84f2f2oSTev/jQVWXEX/L7cNJy0BjKAE
         lW437ta/ycgCFNe67eC8RZ6jKzH+aR+S6vinU8Sdvd6ErLSlq/mv0DYzresBTZvJigc4
         1MQc1r/BNwlAu22uN5x0O5UXNiWK2YzriPLTlIScx4+l4hHd6fL5nF5PAyxeleKVSsYd
         Sg0pYfUkpG8f29ZhjJEPFvnpu9PYWQ7UonZN73VA0hITFwNJsstsm6+3o8cNHb9jNWrJ
         nShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNfTo5yeNay0+UivJNJMq/rj2OhZVqOYNARAz1E5lsc=;
        b=tYnRM+ojof2cqu226HVkLc7sPiYuwEPx2cAFf+mSJKTVhNhBEGBghYYuweqbzpHOJO
         Gyrvc728Bj2+qWDGwFxcB1hAQUFbDGIvGZnZyf1EHuraUhtlWIG3nFHXP1D4zFHCmnV4
         z3meOSMGwBZcOTqKmSN4PadT8tsWOxEDbIHQGz7HhhL+0Spg3H+AhypK07LNzSeOmVcS
         hZ4dHIAnapye0/UBW5AwrocmNfLTQjAeksFB2If1aL2Ed3EVb44+ZNYvDWFocU07zqPd
         2VfcYTutgst/gpcBwoa2//K3PneNSN8aowLOomXenzQVL33qBwCqg/DeRixf0PwTxOC+
         TICA==
X-Gm-Message-State: ANoB5pk4LTkKG5h7JvmbRb1O/C/k3EhSxJp45qtgPvkWJXBr+MDvN7JF
        OND+sRl29Fb32QF1OGGmbZtSHHYfhNw=
X-Google-Smtp-Source: AA0mqf7Wkub6q7G8N5jyQWBg/dItXwqfKo95HpiihtXDoT/xb6Vn1qvq6GyIXUGbjHhacC2xd7w3FQ==
X-Received: by 2002:a17:902:f351:b0:189:c1b6:d905 with SMTP id q17-20020a170902f35100b00189c1b6d905mr24311120ple.14.1671116907200;
        Thu, 15 Dec 2022 07:08:27 -0800 (PST)
Received: from localhost ([2001:ee0:50c6:3450:2c99:6e24:3d2f:3473])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b00189667acf15sm3949688plb.162.2022.12.15.07.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 07:08:26 -0800 (PST)
Date:   Thu, 15 Dec 2022 22:08:23 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/6] bisect run: fix the error message
Message-ID: <Y5s4Zy14TbGalfIl@danh.dev>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
 <patch-4.6-59a8a3085b1-20221215T094038Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.6-59a8a3085b1-20221215T094038Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-15 10:47:47+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
> in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
> the part that prints out an error message when the implicit `git bisect
> bad` or `git bisect good` failed.
> 
> However, the error message was supposed to print out whether the state
> was "good" or "bad", but used a bogus (because non-populated) `args`
> variable for it. This was fixed in 80c2e9657f2 (bisect--helper: report
> actual bisect_state() argument on error, 2022-01-18), but the error
> message still talks about `bisect--helper`, which is an implementation
> detail that should not concern end users.

I don't think the error still talks about `bisect--helper`.
The error is talking about some "bisect-state" which is not it Git's
glossary, though.

> Fix that, and add a regression test to ensure that the intended form of
> the error message.
> 
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/bisect.c            |  2 +-
>  t/t6030-bisect-porcelain.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 9fc8db06944..0786ebf4012 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -1292,7 +1292,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  			puts(_("bisect found first bad commit"));
>  			res = BISECT_OK;
>  		} else if (res) {
> -			error(_("bisect run failed: 'bisect-state %s'"
> +			error(_("bisect run failed: 'git bisect %s'"
>  				" exited with error code %d"), new_state, res);
>  		} else {
>  			continue;
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 9e56b42b5da..0a62ea2b3ce 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -1221,4 +1221,14 @@ test_expect_success 'bisect state output with bad commit' '
>  	grep -F "waiting for good commit(s), bad commit known" output
>  '
>  
> +test_expect_success 'verify correct error message' '
> +	git bisect reset &&
> +	git bisect start $HASH4 $HASH1 &&
> +	write_script test_script.sh <<-\EOF &&
> +	rm .git/BISECT*
> +	EOF
> +	test_must_fail git bisect run ./test_script.sh 2>error &&
> +	grep "git bisect good.*exited with error code" error
> +'
> +
>  test_done
> -- 
> 2.39.0.rc2.1048.g0e5493b8d5b
> 

-- 
Danh
