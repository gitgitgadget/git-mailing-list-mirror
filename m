Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30C2C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 16:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBFQXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBFQXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 11:23:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D96EAF
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 08:23:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-50fe0b4495cso120305207b3.14
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3MYV0zAUJYU1pjFILPYcAEWc8UUdsIehq1h1klxwv8=;
        b=HmhpvlRJofFtwiv/JS0SaWhlMUVsqFM2/JaOplunOGKgF4aAw+vCRfkM2RKUp50BG8
         eujYWGM17fPbndceAChBr/CpPEgO0iaYFEKbhi+idHZEyO9YKTv2cdo1+mx49BbRpSJk
         mkbMpTyv4xf8GIUXSqbO2a/d5HrZPaZk7MDSOfp8Qqso5wVymiM3RrNh4zGprNsoVWP0
         WmELNkp+lLsCg1nsuxA5nIclLzfVa9RoAcJ8bZUCFA8Wo3Ex5xaUnrovUpmKjF2tFZSG
         qVO8cUxhIuNnZJGzvJemqpgvQkZ98bTiHsBbJH1DbuJGEMGyGrtfadHExrIsEEZ/yVAK
         AhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3MYV0zAUJYU1pjFILPYcAEWc8UUdsIehq1h1klxwv8=;
        b=y1+B8Et4TlyZVnwbQEubPFbljSavFOgSfulgJ07rbiXweHL1/YFinxcrUiexIfqY6R
         Ez4lxhluZLN3Exryxx4Xlo98f3XzBq4E+pDD8ZG1sybXllz/KHh/QW2msvHy0qppJnWw
         VQ58OsnnsFN+9SJVw1fodVnIybQnmElGeeWT1NJi71gVuzrwlyNpZqEKRpgneMUAHnZQ
         XIZ7sKfdB4c579SHrTqq1G5yzUhJ3A4qqSRvroW5pGw/zdzj8rdQ4ySq14RdjxUrqTIc
         NWYJJWzUyC94belS0pu0Yic0ZiXWc8Am2AtIQfo+u5uPFqPzPzYqxuu4fW0pCfj57fyV
         WGNg==
X-Gm-Message-State: AO0yUKV4T6dOBYtWaGnML5uH1x3g61G97xRdz5musZ6s2Q2AAY2xJrea
        52IUYHeogul9eziNCh/MHHOhf74Vg5w2XA==
X-Google-Smtp-Source: AK7set/DyYqulbwMkNgd+y+oxiirh+A/q9ab/rJrtf6QJA7zmL4Rkxk48ExJISDm7oxwVTT9sKc2+BBi3iN3KQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:fe0c:0:b0:80b:69f5:3966 with SMTP id
 k12-20020a25fe0c000000b0080b69f53966mr14176ybe.519.1675700630525; Mon, 06 Feb
 2023 08:23:50 -0800 (PST)
Date:   Tue, 07 Feb 2023 00:23:42 +0800
In-Reply-To: <230206.86edr36ki2.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <patch-v4-2.9-1f0f8bdcde9-20230202T131155Z-avarab@gmail.com>
 <kl6lzg9rgjqv.fsf@chooglen-macbookpro.roam.corp.google.com> <230206.86edr36ki2.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lk00uhiep.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 2/9] config tests: add "NULL" tests for *_get_value_multi()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Feb 06 2023, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> +test_NULL_in_multi () {
>>> +	local op=3D"$1" &&
>>> +	local file=3D"$2" &&
>>> +
>>> +	test_expect_success "$op: NULL value in config${file:+ in $file}" '
>>> +		config=3D"$file" &&
>>> +		if test -z "$config"
>>> +		then
>>> +			config=3D.git/config &&
>>> +			test_when_finished "mv $config.old $config" &&
>>> +			mv "$config" "$config".old
>>> +		fi &&
>>> +
>>> +		cat >"$config" <<-\EOF &&
>>> +		[a]key=3Dx
>>> +		[a]key
>>> +		[a]key=3Dy
>>> +		EOF
>>> +		case "$op" in
>>> +		*_multi)
>>> +			cat >expect <<-\EOF
>>> +			x
>>> +			(NULL)
>>> +			y
>>> +			EOF
>>> +			;;
>>> +		*)
>>> +			cat >expect <<-\EOF
>>> +			y
>>> +			EOF
>>> +			;;
>>> +		esac &&
>>> +		test-tool config "$op" a.key $file >actual &&
>>> +		test_cmp expect actual
>>> +	'
>>> +}
>>> +
>>> +test_NULL_in_multi "get_value_multi"
>>> +test_NULL_in_multi "configset_get_value" "my.config"
>>> +test_NULL_in_multi "configset_get_value_multi" "my.config"
>>
>> I frankly preferred v3's tests over this version. v3 is slightly
>> verbose, but at least the lack of logic made it easy to read and
>> understand. I'd be okay with it if we get a big DRY-ness benefit, but 2
>> conditionals for 3 cases seems quite un-DRY to me.
>
> Note that the v3 version didn't test the get_value_multi(), adjusting
> the v3 version with copy/paste to test that as well is why I made this a
> function. From the CL's range-diff:
>
>     -    When the "t/t1308-config-set.sh" tests were added in [1] only on=
e of
>     -    the three "(NULL)" lines in "t/helper/test-config.c" had any tes=
t
>     -    coverage. This change adds tests that stress the remaining two.
>     +    When parts of the config_set API were tested for in [1] they did=
n't
>     +    add coverage for 3/4 of the "(NULL)" cases handled in
>     +    "t/helper/test-config.c". We'd test that case for "get_value", b=
ut not
>     +    "get_value_multi", "configset_get_value" and
>     +    "configset_get_value_multi".
>     +
>     +    We now cover all of those cases, which in turn expose the detail=
s of
>     +    how this part of the config API works.
>
> Of course that wouldn't address an outstanding point that we should just
> copy/paste these anyway, but maybe that addresses your feedback...

Ah, yes I noticed that (thanks for confirming), and I meant that I think
it would be better to just copy/paste anyway.
