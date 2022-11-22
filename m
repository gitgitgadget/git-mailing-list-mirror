Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A35CC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiKVW3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiKVW3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:29:48 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4FD8E29F
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:29:46 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z19-20020a056a001d9300b0056df4b6f421so9997844pfw.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6OWBwbXzy0Uw2OEIHpiUKbDEaRtBv55ITCKYLNRSCQ=;
        b=nGrmpuPFo5OCxPpmD8QoSo4MUWEbSkSGkYDW6tILoysF7Wjh5EkkPzV4Ax3ZoXx5cr
         ckQ84OflKZBgADFw1VBth2gvaSmXdu4Qrg/64xkcyv783MOY427p0e3aefM2r62kP05Z
         GPuvG1g6kkS5AvKsfnxNaCmWn9or9gQ7Lsn++z3DKyKmh7oIe6VtIOmgEBQDA48GUd/0
         SoXmqK8ZCpdLI88AO32ygs1JM7cylNiMkDDBWvxlJ3+q0xQST8ttdC5fFxmLMhHZ1sO2
         hCyrLjFdCL8mmAubsm3D/ZLKVELerytQEjqj8jU3AHKBWGnSRW4qI8A5NI5EPQ7cCXbW
         BK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6OWBwbXzy0Uw2OEIHpiUKbDEaRtBv55ITCKYLNRSCQ=;
        b=z9zSmIlZWErAg+WpW+pv5X8zdORMlo1l95SjeoVDZkQ2FUcwbMVKjUtIidrWTfIng9
         ztl2yDjvk6LCkTAOV5xZBBeYShZnURiLDAVQ+P9XRQNd/UnXhwUoUaqHrjs25ORnqu7X
         nFeYKxqlt9qCuAbBGwSz3QZWOVt6lrcWrNqXnK5S+wYbTbe9Haiuef62A5BiFxv++pPU
         8Ek+4aXVAkbu0I7rZqNzd4TRdu1bYINmr1P6Yrlq/WAGbAXorBSTb30F1cMbPiV4Wvke
         27qiHpD/yL+EnUHKaxE2Jvg1FpvWfyYoj+KjGsTNqPPFPIhn1J6zxX90yW3z0iYRDGe2
         X4WQ==
X-Gm-Message-State: ANoB5pmsIghivf7x/OcZAdr8yL334Hsc2BVRKqona/nWTcVW7sd+5AzJ
        Z0dW7CI4hTKEqvKuXh/da5IkfmllWgx7yA==
X-Google-Smtp-Source: AA0mqf53dW+DtnrHo98a7AwnjNb1PIXasIPyR0lOkGs30tAL39Z1/W4QMJ1F7UQogoASzB7ailso0zS5cWnY0g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:902:0:b0:46e:9bb2:f0f7 with SMTP id
 2-20020a630902000000b0046e9bb2f0f7mr7064818pgj.203.1669156186171; Tue, 22 Nov
 2022 14:29:46 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:29:35 -0800
In-Reply-To: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
Message-ID: <kl6la64iei7k.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 0/9] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks! I think we're close to getting this merged :)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> =3D Changes since v2:
>
> * Fixes for test_when_finished() in test setup, and got rid of
>   redundant test_config_global.
>
> * There's a new 2/9, which passes along get_super_prefix() as a
>   parameter. This allows us to gradually replace it, and drop the
>   *_sp() variants of functions that the previous version introduced,
>   and it adds "super_prefix" to the absorb_git_dir_into_superproject()
>   call in submodule_move_head(), which as Glen noticed I'd missed
>
> * Squashed the "deinit" change into that 2/9.
>
> * Explain why we keep the "fsmonitor" test bits that we do.
>
> * Dropped the new "git branch" output tests, turns out I was just
>   wrong, and was conflating it with the subsequent read-tree
>   invocation...
>
> So, this should address all outstanding feedbakc, unless I've missed
> something.

As noted in [1], I think we might have missed some sites where we should
pass super_prefix.

[1] https://lore.kernel.org/git/kl6lcz9eep9k.fsf@chooglen-macbookpro.roam.c=
orp.google.com,

> The one loose end here is that I still have no idea if you can invoke
> get "read-tree" to invoke that submodule_move_head() in such a way as
> to have the "super_prefix" used, I've failed to come up with a test
> case for that.
>
> But for the purposes of this topic it doesn't really matter. In 8/10
> we'll start passing the new "--super-prefix" that "read-tree" gets
> down to that function. At worst we're handing it to it redundantly,
> but that was the case before too.
>
> So we can leave potentially turning that into a "NULL" for some other
> time, for now providing the "super_prefix" is harmless, and guarantees
> that we avoid any regression in that area from not providing it, in
> case I've missed a way to have it matter in that case.

Yeah, I tried to do the same too, and it turned out to be harder than
expected. The "absorbgitdir during read-tree" code is definitely in use
(e.g. by t1013), so it's certainly possible, but as you noted, I don't
really think it matters as long as we avoid a regression for the time
being.

