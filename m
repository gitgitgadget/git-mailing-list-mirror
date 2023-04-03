Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB23FC761A6
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 07:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjDCHCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjDCHCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 03:02:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7ECEFBF
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 00:01:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so112997175edb.10
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680505254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tcFxrLBSTktPLu0FfPQFGYZ60D18C1GbxFW82WLt6kM=;
        b=OyDvHoJe4v25tYAlsC+0Xi6KqX48tc2adpVS6FAwgh2LpwZSjuT8zuG6L2idkUiDdi
         zXEBv7NU779Nrjih9U8oRo6M5Xayg4MUQdlDKIPl3CT5T3hxbFKhlvDP7u1mYSaqx1BC
         WXYChZNigNZ2luVmNhHLZ4hf8iMrVmMj5w6ifovqlS80W1utBLieoBjhTp8PEVb6O56d
         AgyGgeIaep3pAVlxV6jiTFiCrC9DMWm4bLhRvs9rbjH4MG8nwT0NpNTqpBFMEtU88K5J
         JQM/1Q6YzfyE9OQTYP05ox5dYqmXEuLh5OZdB+2fzPTcHpPTAFK2MZTg++tGk1qhjQgj
         vcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680505254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcFxrLBSTktPLu0FfPQFGYZ60D18C1GbxFW82WLt6kM=;
        b=dB8+0okE4ao2pi4hup+6Jghb7fP8kAJImxyiXkvVtTRuX8RwBYBhdAzKN7FYfrHb26
         nnEEt4hQIVy51J1l/1gmgulhSLHF4qcc7QD8CpSEuHUVhr/zfZkp9eR06FdRMDpLhhid
         6QyAsWGHhOI7yDnM9CID9KUJ0rGdSHLJCuJEQpbGa3meuU1MqR8171BeRJjwsz7FZrn5
         +2yZ7FESksAxvRSJl6RHRQVv8o3J39c7nQafFP5JCyNlCrQCPaT2Oe5U2ulByfBJnlaK
         SZgNLM716WQh1Y7UCO2iZtn7uuf14sAKUna08LYrxrSF9I3IqGtckPOhsxkGl8i3gl66
         p0GQ==
X-Gm-Message-State: AAQBX9fbjzC63xy/k0cimoY1olMbCWf/iFFH+djUEYVqgFrj8/RENLK2
        8haXDhltccvIgJv3vmbefnTuhBit88sQ4ZaHSoM=
X-Google-Smtp-Source: AKy350ajZSOjA/t2FEvGhI0cv/iox7MRJzrnpC2W4KrhIJXNRaG3y/+M+aIX4YW+aAMStOI2aeIB4x2JqUSJ1GrLZfQ=
X-Received: by 2002:a17:906:81da:b0:92f:b329:cb75 with SMTP id
 e26-20020a17090681da00b0092fb329cb75mr10376037ejx.5.1680505253864; Mon, 03
 Apr 2023 00:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
 <pull.1477.v2.git.git.1680200278780.gitgitgadget@gmail.com> <xmqqo7oahws8.fsf@gitster.g>
In-Reply-To: <xmqqo7oahws8.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Mon, 3 Apr 2023 08:00:00 +0100
Message-ID: <CAGJzqskDmiYwoe2tdgLbxCpRHzZZMon-SxjLqiJ8OYMk3f0hcg@mail.gmail.com>
Subject: Re: [PATCH v2] credential/wincred: store password_expiry_utc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
        "Johannes Sixt [ ]" <j6t@kdbg.org>,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        =?UTF-8?B?SmFrdWIgQmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>,
        Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Mar 2023 at 20:20, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > This attribute is important when storing OAuth credentials which may
> > expire after as little as one hour. See
> > https://github.com/git/git/commit/d208bfdfef97a1e8fb746763b5057e0ad91e283b
>
> Readers do not have to visit GitHub at all, and proposed log message
> shouldn't force them to.  Refer to an existing commit in this
> project like so instead:
>
>     ... as one hour.  d208bfdf (credential: new attribute
>     password_expiry_utc, 2023-02-18) added support for this
>     attribute in general so that individual credential backend like
>     wincred can use it.
>

Thanks Junio for the example. I'll update the commit message in patch v3.
