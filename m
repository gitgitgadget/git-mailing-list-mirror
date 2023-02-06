Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED908C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 12:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBFMeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 07:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBFMeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 07:34:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF220042
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 04:34:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qw12so33772447ejc.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 04:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0QdyBajSSdXZ/Dd6XtAMdjrvqTlHdEYsxfXTwMHtO1A=;
        b=aW+ZqLnURfXo5MoWzSO3TVUqtGwOO9TaEiVlJLf9nDnm4gpVdc91Zw3lfWRWkxKLOs
         eU5m75TTTsY3sV5agRPlDWTU5NJ7VKuWFBnlRwKd0PG6YM4yg1h/aIjA+LW0h4lGhVbh
         bYfP3pVEl4E72jsmbgXRybmd9RAwmvUezy6MUQhGXWLibz7CjwZx0lQGanznax35ChKU
         s5PqODoVvVPCzZj7BxsHzb2gY/Ojwql+qFi49KJWmvspjsByKHOE1hrifnvpXSajGC3C
         3Hx2x5DkPIyx77MXmOktcRIgD9RTQ3ABfTp33xKa0Oo5BPB2DI1NNzJ7TIlAoMJS2FyJ
         RAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QdyBajSSdXZ/Dd6XtAMdjrvqTlHdEYsxfXTwMHtO1A=;
        b=RrpMt2+TcEUZjM7+PFoLMw72POmA1pdB19pAhHXuWTY91JSqzJ8ZCupTWw485GaoFD
         43hSqShkSSaU+t1/SyIcfPErCz2kLyNHLvdRGxrAqR3dTA/kARd1b/Q5IjT2ANG/BSg2
         YHwMITyovxHRyrpsaLNJis03htb5HcPLYP4kS5dxay3G42wP+kBqRvalKcJcTffxX3d6
         kQ6ndQUtsPIv9lvAaDVZ0Q7bgfJ/cGNo5xzxmI5yBOBO1AgvoB209RzCFwgpNKkf0Eig
         GLb8fHY7UizB1B4VM9gplo+oq8h297HVElNIwrn6h4I9kK/b7jp1Scqd/WkjiSfvKWS0
         rEtg==
X-Gm-Message-State: AO0yUKUnOwG1Yrglw+5wzzIUqxBXChAoYGD+vCmdbTBDwRTy6cDsbiBq
        R5uf7jq61gZPO7EB++XbKGnQTq5vEn1GVX74
X-Google-Smtp-Source: AK7set8zthQoyXV5eDjr3GuzBs2JLEuT1ziXgm2ncnTWzceK5Fp/0jwtKwhxNwCxodaO1U7SfQR1vg==
X-Received: by 2002:a17:906:8586:b0:889:1eb1:7517 with SMTP id v6-20020a170906858600b008891eb17517mr20326177ejx.30.1675686839263;
        Mon, 06 Feb 2023 04:33:59 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b008847d7ed37bsm5429334ejc.100.2023.02.06.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:33:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP0h3-000H27-2M;
        Mon, 06 Feb 2023 13:33:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v4 2/9] config tests: add "NULL" tests for
 *_get_value_multi()
Date:   Mon, 06 Feb 2023 13:31:36 +0100
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <patch-v4-2.9-1f0f8bdcde9-20230202T131155Z-avarab@gmail.com>
 <kl6lzg9rgjqv.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6lzg9rgjqv.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230206.86edr36ki2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> +test_NULL_in_multi () {
>> +	local op=3D"$1" &&
>> +	local file=3D"$2" &&
>> +
>> +	test_expect_success "$op: NULL value in config${file:+ in $file}" '
>> +		config=3D"$file" &&
>> +		if test -z "$config"
>> +		then
>> +			config=3D.git/config &&
>> +			test_when_finished "mv $config.old $config" &&
>> +			mv "$config" "$config".old
>> +		fi &&
>> +
>> +		cat >"$config" <<-\EOF &&
>> +		[a]key=3Dx
>> +		[a]key
>> +		[a]key=3Dy
>> +		EOF
>> +		case "$op" in
>> +		*_multi)
>> +			cat >expect <<-\EOF
>> +			x
>> +			(NULL)
>> +			y
>> +			EOF
>> +			;;
>> +		*)
>> +			cat >expect <<-\EOF
>> +			y
>> +			EOF
>> +			;;
>> +		esac &&
>> +		test-tool config "$op" a.key $file >actual &&
>> +		test_cmp expect actual
>> +	'
>> +}
>> +
>> +test_NULL_in_multi "get_value_multi"
>> +test_NULL_in_multi "configset_get_value" "my.config"
>> +test_NULL_in_multi "configset_get_value_multi" "my.config"
>
> I frankly preferred v3's tests over this version. v3 is slightly
> verbose, but at least the lack of logic made it easy to read and
> understand. I'd be okay with it if we get a big DRY-ness benefit, but 2
> conditionals for 3 cases seems quite un-DRY to me.

Note that the v3 version didn't test the get_value_multi(), adjusting
the v3 version with copy/paste to test that as well is why I made this a
function. From the CL's range-diff:

    -    When the "t/t1308-config-set.sh" tests were added in [1] only one =
of
    -    the three "(NULL)" lines in "t/helper/test-config.c" had any test
    -    coverage. This change adds tests that stress the remaining two.
    +    When parts of the config_set API were tested for in [1] they didn't
    +    add coverage for 3/4 of the "(NULL)" cases handled in
    +    "t/helper/test-config.c". We'd test that case for "get_value", but=
 not
    +    "get_value_multi", "configset_get_value" and
    +    "configset_get_value_multi".
    +
    +    We now cover all of those cases, which in turn expose the details =
of
    +    how this part of the config API works.

Of course that wouldn't address an outstanding point that we should just
copy/paste these anyway, but maybe that addresses your feedback...
