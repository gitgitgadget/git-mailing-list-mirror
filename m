Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1718C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjDFIQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbjDFIQW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:16:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A02119
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:16:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-4fa3c48480fso1069809a12.2
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680768979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEy6I69lkM81crQqd4dqASeg7AOw4CrsImEAYHEqGhc=;
        b=jwF7Vwxs+SRor1yn6DvCSuuKDEioNj2OEI8jVjAGvcGhxXY2MmPLVb909rV0pI37Cq
         B03kvPnQ2y+JB0ZPXW2oykmTmrrVcwaRXm5tiafvyJxp2lDLbdZA0ksUnGhan5bIQbzq
         y53pkWNblDEsoYJWVJEFEiklH2NulHD7DJ/ykkmtoRkgFIMcQDMtZAW+eTNNptKzU4+b
         7ctWhkf7L45pLh+6jnbK6I80Ng05b7ENY043UwX+wRurieKlQBWMPPWUOWB+wXhQZtya
         FnyMFKHjPi6+IoJdJm/lvdi2FyFA0WBeK/Qz7QpMTI6yrbd/S1t9vVIm4BjutaTsJsgT
         efYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEy6I69lkM81crQqd4dqASeg7AOw4CrsImEAYHEqGhc=;
        b=hdeIk536+IPQimROhbkMxSN3WvSkQxUyrMZ9jkbChsr8AF/TMwjJazzHrwqhUBzjc8
         PsOyf84BPY1DuKAojbSYAUCscEoS9rC/ibavKCfrezFtHJ3TSV6SGTBY1V7EcGpmH3q4
         13Cd3vhZcFv11wS5XzKAIFwKqOo3VbUrY/8ox1/HKPRU9iCUGOxsjXdnOOLytwcLKyzE
         AM9zTfySC4KhXv76stygpcO5JDn8gMe3PcDx3kQaEdAGZW5rwU2atVZHKLxBqstS4XG6
         wCosIKL7OK2kidsQ+pzkCEVn6k9SqdiYYvGayidrjvK6DIO6WCeNzgAq5yzFZT3EvqfG
         KAhw==
X-Gm-Message-State: AAQBX9eqHVzAXBlPXSewU4VgBtav6OvRIw82X7B0M6KV9dwmpfPRjxcZ
        LQrrK6legJ+77j4exz6fVlXwpTpaO0rWeSn7B6mX5Iklc3w=
X-Google-Smtp-Source: AKy350ayagXF2/uifyPsjFKxFvpBunZaXpRdPgyyvkS/oUbfNkron5wP1cmmRJyDrgabSzcuUHCPsTups10jlwqqUVA=
X-Received: by 2002:a50:9f8e:0:b0:4fc:6494:81c3 with SMTP id
 c14-20020a509f8e000000b004fc649481c3mr2633800edf.1.1680768979160; Thu, 06 Apr
 2023 01:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230401212858.266508-1-rybak.a.v@gmail.com> <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-6-rybak.a.v@gmail.com>
In-Reply-To: <20230403223338.468025-6-rybak.a.v@gmail.com>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Thu, 6 Apr 2023 10:15:40 +0200
Message-ID: <CAFaJEqug4bghEMnEQzGDN10EqM8e8iSf5i12AvOm+NZzDCQKOw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] t1502: don't create unused files
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei

On Tue, 4 Apr 2023 at 00:33, Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
>  test_expect_success 'test --parseopt invalid opt-spec' '
>         test_write_lines x -- "=3D, x" >spec &&
>         echo "fatal: missing opt-spec before option flags" >expect &&
> -       test_must_fail git rev-parse --parseopt -- >out <spec 2>err &&
> +       test_must_fail git rev-parse --parseopt -- <spec 2>err &&
>         test_cmp expect err
>  '

This is the one that was touched by me. At the time I just cargo-culted oth=
er
tests. This looks obviously correct to me

For what it's worth:

Acked-by: =C3=98ystein Walle <oystwa@gmail.com>

=C3=98sse
