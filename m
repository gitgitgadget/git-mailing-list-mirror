Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588B7C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 10:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBFKkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 05:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBFKkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 05:40:41 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A46126D0
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 02:40:20 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h11-20020a056a00230b00b00593b9e6ee79so6210893pfh.8
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 02:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqB+mnu1T4gsiItSu21hbhHl1q8bbaktoQa+6nJjR1U=;
        b=NB7OzTuhdE0riw9H2YUf+vEo33V9Wc4MJlFkaNbmiTjCFqXuBfBEsR3CeKEArFV3xQ
         BW0o0xnTX6RzZ0gVEj2gUL6inBONHVMNcnPaO/DomR1zAmJJRk97Z/gyqp9l8MeasDLx
         uwWbAPCvNHPI7MFCpjHBwy2EqmIR9Atbj98BTxoQmROasVPeUI0thjp415JRPUGCOzfr
         r7ZgZc3NMl2IokON523dMLz5CL1JQUKu0IqYzxEaQRs0hA3CyyM+VjeLnc2AcacF6DDb
         EQO9xneQvc38eekJ3uH/bXjrwMF0hGwAuBTsI+WP9lLcIOpkYEH9n1CEMng4fd1BSxab
         epew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JqB+mnu1T4gsiItSu21hbhHl1q8bbaktoQa+6nJjR1U=;
        b=CRRBkzFYyqUOwT7l7KCCLABZkpXHufpnREASzrtPSkQrntAuTUGKHVFEsaXmIHSCpo
         W+BQzaY033uRgsKEtWoeyXyndQGy/RIECAJhvEhk4KAmSmzdGNRKcOYNibceiXLDpY5d
         ltlhL5UJO5ZDj8+jlJrgI4XaHPWp51lDLnZ3ILzRiIqzjykSbkdMDQXkakZxsKL9uihy
         p9Ro38RgxHpfGO/M9eNviySvwa51BAioqnX+tzBGb996c15twDzInyjGVc0LyQNShnh9
         Xab4DucA3/1Elgv016XCFKDK4Zvk+2L1dcwb/d2EnWVM4bse/qScXiBpuZReXulb5utr
         lRhw==
X-Gm-Message-State: AO0yUKUbUrtXljNfLHk5rev03hb03jxk3l5ktpZE0DIXDAtIF9IiOnq0
        37OVwsdsFtLtjflAcYC2icmOUEthCJInmw==
X-Google-Smtp-Source: AK7set8g/VpvKhy3uGOlPRkT0ZXCXxssXKF6d6bAqtmxamxlNf5rE47nDlqhu35ItGbVs4nkm+xj/BSAb8Wz0w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1895:b0:592:d9e4:1b8b with SMTP
 id x21-20020a056a00189500b00592d9e41b8bmr3801866pfh.18.1675680016633; Mon, 06
 Feb 2023 02:40:16 -0800 (PST)
Date:   Mon, 06 Feb 2023 18:40:08 +0800
In-Reply-To: <patch-v4-2.9-1f0f8bdcde9-20230202T131155Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <patch-v4-2.9-1f0f8bdcde9-20230202T131155Z-avarab@gmail.com>
Message-ID: <kl6lzg9rgjqv.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 2/9] config tests: add "NULL" tests for *_get_value_multi()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> +test_NULL_in_multi () {
> +	local op=3D"$1" &&
> +	local file=3D"$2" &&
> +
> +	test_expect_success "$op: NULL value in config${file:+ in $file}" '
> +		config=3D"$file" &&
> +		if test -z "$config"
> +		then
> +			config=3D.git/config &&
> +			test_when_finished "mv $config.old $config" &&
> +			mv "$config" "$config".old
> +		fi &&
> +
> +		cat >"$config" <<-\EOF &&
> +		[a]key=3Dx
> +		[a]key
> +		[a]key=3Dy
> +		EOF
> +		case "$op" in
> +		*_multi)
> +			cat >expect <<-\EOF
> +			x
> +			(NULL)
> +			y
> +			EOF
> +			;;
> +		*)
> +			cat >expect <<-\EOF
> +			y
> +			EOF
> +			;;
> +		esac &&
> +		test-tool config "$op" a.key $file >actual &&
> +		test_cmp expect actual
> +	'
> +}
> +
> +test_NULL_in_multi "get_value_multi"
> +test_NULL_in_multi "configset_get_value" "my.config"
> +test_NULL_in_multi "configset_get_value_multi" "my.config"

I frankly preferred v3's tests over this version. v3 is slightly
verbose, but at least the lack of logic made it easy to read and
understand. I'd be okay with it if we get a big DRY-ness benefit, but 2
conditionals for 3 cases seems quite un-DRY to me.
