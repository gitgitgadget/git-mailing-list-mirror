Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E24EC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA86C6135D
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhGEM0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhGEM0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:26:11 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9144C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:23:33 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id r24so4466607vsg.4
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1MpXj7sw/1ymifW1ze4CA7172PQNZxFF+0vd8e5p0yM=;
        b=LcKAU/V7wGNVeIFyVu0VUIV2dhW2whX25TWAdkKppLfFrt8ctqnEKXi+cuy8MKtd3D
         fjhbVa5GiDkIKJhJCNeycvIhJvOAODYyJ4AEZ9Dc6zLG1/3NYeCTwxszx9yvycCBEjta
         Bzypzb9hK7Hf0n1Zi2iulkFoqFxl/seI+nAZiXqkXP2mZzZJJ/cHzNlY/clTxQ0WCakI
         VleDJf6VNKuPtFFL6l51QcYiF7nETLRAXiKOmT3/TJ8rs6e2MXV0J0G1dowUGgkMnGRw
         2eKklL5Vwv2mg5jp7wP+KAFIXM8twVSqvqdaWB7rLyVs4gDg6LM0MOIcDpvZtoQBEJiB
         tNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1MpXj7sw/1ymifW1ze4CA7172PQNZxFF+0vd8e5p0yM=;
        b=RvtjKLT1i6lUnlp8G3HUDcAhGp/XzlQMpZRoPZplQp5GSi6IxKpq/I9XkmdubdTZPb
         7Tz2E8M5CqufCa8IVjnLFRckutXeRP4j1xdweXDl/DhfV2mvrYmRY1Rk0CSgnF7pL8up
         Iubuue9quMtYTi0jspU9PeIzW1zx5IKjk/mGR7lj/gZ17Zrq4j17jcon56ulzC1k1zfJ
         5EsWDIi4PIGWhmvQvJ9rXpkq0V4bpXkpoP1TsRyGL8JsRDjbZsHSlOiPbjK4v5EGkDO3
         zqTBF09xOe3f/yTW0Y7vo8TVDnf2n0ioK0z6ZIlVp51QICaVvIJ2CVwm/wgknohaurbo
         z2qg==
X-Gm-Message-State: AOAM53263b8GlQ/WUm9YZffzKDAm6BRAs3t2LAuT+ZzzSo/nCDbuuaNo
        6DEOdfWHZ29F96CjTS9TgdMIQH19MYlnYvW1n3NQ/A==
X-Google-Smtp-Source: ABdhPJzjHddsftkhwJBlaTzizOZ9RRlzEq3BA1FyVoRTkaBSlDK3nsME285ocAKKeowbJEvcW1E9bLntayHT4g6trC4=
X-Received: by 2002:a67:dc84:: with SMTP id g4mr3614325vsk.5.1625487812564;
 Mon, 05 Jul 2021 05:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
In-Reply-To: <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 5 Jul 2021 14:23:20 +0200
Message-ID: <CAFQ2z_Pbn2=0NuNNC9TnuLar91Nn2=CBZ7cs8ErM4guEi9BsEg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] serve: add support for a "startup" git_config() callback
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 9:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> So let's support this common pattern as a "startup_config" callback,
> making use of our recently added "call_{advertise,command}()"

I think this is an improvement over ensure_config_read(), but I don't
understand the whole picture. If you want to control configuration and
be sure it is set early, isn't it more natural to put this in struct
serve_options? With your patch, there are still two routes to
injecting configuration: 'struct serve_options' and the git config.

IMO the former is more principled, and the control flow (serve_options
is an argument to serve()) ensures that the options are read only
once.

> +       /*
> +        * A git_config() callback that'll be called only once for the
> +        * lifetime of the process, possibly over many different

Putting it in a struct supplied by the caller provides more
flexibility for testing: you could test multiple behaviors from a
single process, by calling serve multiple times supplying different
arguments.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
