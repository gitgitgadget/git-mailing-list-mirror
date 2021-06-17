Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A10EC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22F3610A2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhFQVqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFQVqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 17:46:24 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA7C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:44:16 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c13so8103154oib.13
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mkTp+fFPVizWNrlkrUKuv0LONfmqBBl2zKm3IRO2lfI=;
        b=amDDXPN4/X3LYAx4WqytBg/6D9pecf7xCjVq4SAEhwjSNgNYKFzjHhMCWttkExXD+a
         6D3fqSjlnWDQwz+pHhBNGT7XV6JDyShF8W1FZkjZapybzzUUqQbOcGBfFMaY6dTQuw20
         WjqYZlLO/BarC1qzxB2IGQWREMJogSioMd6UM4FsuFChL/3UmdAMZZ40DRpSPUSSlFM3
         O9jXtvY7aKv4Kws26Nebsb/eLM8PfWlsxm2GxR/wUYD62cKf3GDEAtETRDEADPKjUqOp
         g303bwHJmVpiEt2EAMQpbzR8cyh/EWZklRtkL5ckv0XFJyQ0wOmpqCkVnnB3k1QcG4BA
         C9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mkTp+fFPVizWNrlkrUKuv0LONfmqBBl2zKm3IRO2lfI=;
        b=h2IHuNaQyW2tZPGy7aRsBW5atQmGGp/zTyhS6UItZbzGGKd5yEpVJ2nZ8T82OerJ7O
         QZA682HUeRWDF1T8fSrbHseZB0jwgFPZJ5NjcfCJy3kdHibacjUUV59OPNPyPgZhF7wx
         Ja3Vnfl/Ew9vEDiovZzembkhJ42uOwmLcuYGxhqouPi9tGbNGnVF/AX3mnu9g2E/MJcH
         tR7KlCgWN859/2UBzYiESOFMmxpd9J1esf/dmMi+ZiE1oPF3DcWJf3Mrxv2PqxsImH9f
         632pE2bY5hfRep9xdcyMrWdtEgJEcIvJipWMhpDny2tALIctUn0DkCUMPZwAXGgTVJKQ
         535w==
X-Gm-Message-State: AOAM533Vu9aLeQ/Ms+MkkmZcerNdbDjgxrg78z9a2Opr0d9XBgfEnP4E
        E8woJE+UN//dH/W/PYQWIic=
X-Google-Smtp-Source: ABdhPJxhuwM3g01QHJEVWDBCStaKoyTaJZeJP1vYoBz1RacZzw3XZHVHoJa0O5WR5AsHked16BBjUg==
X-Received: by 2002:aca:c18b:: with SMTP id r133mr4789529oif.143.1623966255939;
        Thu, 17 Jun 2021 14:44:15 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l24sm1340173oii.45.2021.06.17.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:44:15 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:44:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60cbc22e3db95_129920882@natae.notmuch>
In-Reply-To: <patch-4.4-dde0177235-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
 <patch-4.4-dde0177235-20210617T105245Z-avarab@gmail.com>
Subject: RE: [PATCH v2 4/4] show-branch tests: add missing tests
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Add missing tests for --remotes, --list and --merge-base. These are
> not exhaustive, but better than the nothing we have now.

Indeed, this is better.

> --- a/t/t3202-show-branch.sh
> +++ b/t/t3202-show-branch.sh
> @@ -85,4 +85,65 @@ test_expect_success 'show-branch --color output' '
>  	test_cmp expect actual
>  '
>  =

> +test_expect_success 'show branch --remotes' '
> +	cat >expect.err <<-\EOF &&
> +	No revs to be shown.
> +	EOF
> +	git show-branch -r 2>actual.err >actual.out &&
> +	test_cmp expect.err actual.err &&
> +	test_must_be_empty actual.out
> +'
> +
> +test_expect_success 'setup show branch --list' '
> +	sed "s/^> //" >expect <<-\EOF
> +	>   [branch1] branch1
> +	>   [branch2] branch2
> +	>   [branch3] branch3
> +	>   [branch4] branch4
> +	>   [branch5] branch5
> +	>   [branch6] branch6
> +	>   [branch7] branch7
> +	>   [branch8] branch8
> +	>   [branch9] branch9
> +	> * [branch10] branch10
> +	EOF
> +'
> +
> +test_expect_success 'show branch --list' '
> +	git show-branch --list $(cat branches.sorted) >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'show branch --list has no --color output' '
> +	git show-branch --color=3Dalways --list $(cat branches.sorted) >actua=
l &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'show branch --merge-base with one argument' '
> +	for branch in $(cat branches.sorted)
> +	do
> +		git rev-parse $branch >expect &&
> +		git show-branch --merge-base $branch >actual &&
> +		test_cmp expect actual
> +	done
> +'
> +
> +test_expect_success 'show branch --merge-base with two arguments' '
> +	for branch in $(cat branches.sorted)
> +	do
> +		git rev-parse initial >expect &&
> +		git show-branch --merge-base initial $branch >actual &&
> +		test_cmp expect actual
> +	done
> +'
> +
> +test_expect_success 'show branch --merge-base with N arguments' '
> +	git rev-parse initial >expect &&
> +	git show-branch --merge-base $(cat branches.sorted) >actual &&
> +	test_cmp expect actual &&
> +
> +	git merge-base $(cat branches.sorted) >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

All these look good to me.

Cheers.

-- =

Felipe Contreras=
