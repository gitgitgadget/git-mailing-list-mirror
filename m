Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDEEC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiLTNpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiLTNpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:45:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDFB1A07B
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:45:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id tz12so29285013ejc.9
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0PCFSGIYsmiLDXciMTv05fxXRo2UvzLC0v8QGQS1ow=;
        b=WSOFRR/zPdirEPdUT6nvTatjYcoJZ04kHB6/2Yo+nEjkhRprx6dCrpveqOI5xwZzu5
         eVjo5VNcwO+J/9Ngy/bCcLIo8jPob4/XKawh8wKP5JskPpPkqsCAx1IAWJpS/uc9STGZ
         TiT9Jr97/8WfwKOtm8Kr2CO7pFZELrUTXQ+k0TBwV4GgD1p2ZPi+jsUsRc3H2kirR6qO
         uzqD35ARsarho+cWr61BIs0PrU6ISQiaUO9fyQEmFlZmOBcFFpzUXloJNISyzxD2j0rw
         Cj+KbrrJzdzfygDiIfiCcSgjfyeOVkT46xAYdw5W1XDJYCuyW+muS3feQS6q2Tlrbxm6
         Hmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0PCFSGIYsmiLDXciMTv05fxXRo2UvzLC0v8QGQS1ow=;
        b=W6314XuMRJ2BVz9svghQjhN0AXqJa0DCXOJ4ppju8YpMsCmb6aInre9e1YrSCFLbVK
         sFZ3gP1HpRbfF+6vWh73VuB9q0T3pTaIepiIHO0xqHJNXZqleC/EPt03WmhykLhgRIbe
         3sbhv1Xjyb0n1gplizy5/NjNbhBD6p86jRFSMGOyfrQHUlKifevr8JSZq34MnXm8ADv2
         ZUROYdiW+/ZPSQQ+6MFhCaY7hcvvaNvfvneGZ0EPNS0lD2nwHDaAF4RTGowIzUgiPMlc
         3+AuydP3sNO5CJOi1BFThNUygEvctzG9K7dLNJPNQHUH8HS5Tp4tDO4hkQTjaCDRJ/kb
         RwKg==
X-Gm-Message-State: ANoB5pmgnelANcj+NbQllS9DSumj511f3k7jILLe2GxdCX9q0tJFgQKM
        O4qZCTFfv4pzwsDCZIbImFY=
X-Google-Smtp-Source: AA0mqf6wepeIhSmnnnJV53q5wQREKFN0w6t+PJWr/HQJHUQLA0hUQClLXfQQrWI/ndenSCoeJg9wBw==
X-Received: by 2002:a17:906:2209:b0:7c1:1b89:1fe0 with SMTP id s9-20020a170906220900b007c11b891fe0mr39419598ejs.65.1671543931048;
        Tue, 20 Dec 2022 05:45:31 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id lf24-20020a170906ae5800b0078de26f66b9sm5733918ejb.114.2022.12.20.05.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 05:45:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7cvy-007KDZ-0E;
        Tue, 20 Dec 2022 14:45:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Hubert Jasudowicz <hubertj@stmcyber.pl>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] Revert "builtin/bundle.c: let parse-options parse
 subcommands"
Date:   Tue, 20 Dec 2022 14:42:46 +0100
References: <20221220123142.812965-1-hubertj@stmcyber.pl>
 <0609575c-68ad-5392-0631-3563c179f177@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <0609575c-68ad-5392-0631-3563c179f177@github.com>
Message-ID: <221220.861qouxk79.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Derrick Stolee wrote:

> On 12/20/22 7:31 AM, Hubert Jasudowicz wrote:
>> This reverts commit aef7d75e5809eda765bbe407c7f8e0f8617f0fd0.
>> 
>> The change breaks git bundle command. Running any subcommand
>> results with:
>> 
>> $ git bundle create
>> Segmentation fault (core dumped)
>
> Could you be more specific?

I don't think the report can get more specific than (quoting it):

	$ git bundle create
	Segmentation fault (core dumped)

:) Did you try running it?

> We have tests that verify that
> these commands work without a segfault. There must be something
> different about your environment that makes the segfault occur.

We don't have those tests, I submitted an alternate smaller fix in
https://lore.kernel.org/git/patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@gmail.com/
that adds some.

I think what you're misrecalling here is probably that we have general
tests for running "git <cmd> -h" for all built-in <cmd>, but we don't
have any such tests for running sub-commands.

And even then, that wouldn't catch this, as it's a bespoke segfault in
the bundle code, as it can't handle not getting at least one non-option
argument.
