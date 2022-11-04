Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAB3C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 17:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKDRKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiKDRKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 13:10:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457B631F8F
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 10:10:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 186-20020a6300c3000000b004702c90a4bdso2220627pga.9
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHrA2hDhW59ETeqvPwJARVW3xH6tFTfSmeu0aZhLHKI=;
        b=oLY2l9WovHlxMK5w9Yi6YFUV0zYulOFdBXyzMXPuqlNIriIX1PXF/Rly7mnaI0AXQN
         EFQhOxzgdfDRF2BwNYxjcLbNNF7S1k469kq9wt1cFhNNdktuyShSZxb5BJGfXZhcC7xP
         +vItVj8Wkot5sOH4dujCoNV+sNScYHeCTlvT2jEPxise3UFmPcxCMy+8VHcRWoNgWAFS
         SLg2R5AVR344Ew1Cx0NVPamacJa4gAfnztD73iay3AptxBCRFPwsa2REO6ElmHlu4wl2
         RGX6bibGwMZ2G+mK/xcozw0htKsnRz3fvetvsOQTISAVR33BWI4UtrXFVEfRtJghHnpF
         qnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kHrA2hDhW59ETeqvPwJARVW3xH6tFTfSmeu0aZhLHKI=;
        b=uiLSy+oLTtHYgKAwqnCo6gDTQcLFf/NrAsrvyJBW6B2ip1nOK506RlfqSuQk4PJI//
         WEMbyY0C465YX7vVbe3uhRknpnAWwEB11Di6vs/ApTgYxo3evKCCw9oXecgaEZogDDYj
         GKT8IwAPATs1m0xPGSqn6FEjjk0yJZSjxrZMDjMOMwMke/bWOU38hbHc7+anmM1YxkaK
         EbQmTQwhut4SbRJQgeeoF/oZy2Gi7oGm2lQT6QvccXKddMkvM18rOnzBE7vjL8cAOUV1
         JpHkBGvObe8gF80k9iBX56LhYMCMeF6IyqiRDvbzaQsFiLeyKahFKKgzgWqK6uwjpJ9b
         HnEQ==
X-Gm-Message-State: ACrzQf2b8LFYoDc54JvCQUwJdzzBkaugnwPoZTVdoq63E80pys9x9P+9
        lM+gmsI2MNSBMWe7AN2y1U3DUCiH6aGwZg==
X-Google-Smtp-Source: AMsMyM5NJhZ6T31cqA1+b5QoRPKffiyarqyJ1GVqpMhPi0UmIZyKfW7/5GMJPMIlX3Z84jmbUCZlNgZgGSIq3A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1687:b0:565:a932:f05a with SMTP
 id k7-20020a056a00168700b00565a932f05amr20126580pfc.21.1667581830802; Fri, 04
 Nov 2022 10:10:30 -0700 (PDT)
Date:   Fri, 04 Nov 2022 10:10:29 -0700
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
Message-ID: <kl6l35ayy7ay.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/8] submodule: tests, cleanup to prepare for built-in
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I have a topic on-list to remove git-submodule.sh and create a
> builtin/submodule.c, i.e. promoting "git submodule--helper" to the
> "real thing"[1].
>
> Glen gave me a bunch of good feedback on it, including (but not
> limited to) pointing out that we have outstanding dead code in
> [2][3].
>
> Once I started pulling at that thread things became a lot simpler for
> the re-roll of [1], e.g. the migration of git-submodule.sh's commands
> can squash in the "update" step, as it's no longer a special-case.
>
> But that also made the series larger, and it's conflicted with other
> outstanding patches. First Ren=C3=A9's strvec() cleanup in submodule.c, a=
nd
> currently with Glen's in-flight submodule topic.
>
> So here's "just the prep" part of that split-out. See also [4] and [5]
> for previous "prep" topics, we're getting closer...
>
> This only adds missing test coverage, and deletes dead code that we'd
> otherwise have to account for. Then 8/8 converts submodule--helper to
> use the OPT_SUBCOMMAND() API in 8/8.

Thanks for working at this so patiently :) I can't wait to see
git-submodule.sh gone.

The only issue I saw was the out-of-date test names in [1]. Otherwise, I
think this is ready to merge.

[1] https://lore.kernel.org/git/kl6lfsezofk9.fsf@chooglen-macbookpro.roam.c=
orp.google.com
