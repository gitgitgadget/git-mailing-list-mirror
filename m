Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23875C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DFD60D07
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhFQVbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFQVbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 17:31:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E5BC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:29:04 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m137so8103542oig.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KKLeJSW3gW1N9iuqVWwnS68YGR/Cy349JfhDBz0rYog=;
        b=H61je6HrssdiisU6CxdE4c3EhLHpyRDXbv7NfYEsLUg2QYq6t4YKNd7FjnKhQ1wcNr
         GjzVsA7rJDdqrevj8rTB9nPTjdMtB62IHom2hWudMv/ZktaFBmHSnuzoXKYIKVRo2yvq
         RR4FT9byfNb016GylBZZIYAXNNtovYf7E/Fni17vUNSbKha3R9MoNHqEg8UmeegJRZQg
         6qILrRT2dxLLqugN0CWGDsO10FUEoL+4PvlHQrXRNCo31+hFDylrS+2l1bg99w6Bv8sc
         aljsJk28P3+dtcT4beQrVNn7oJP78m+/hcs7udm4Cen5dK66CiY1BNUZW5DyBgMGN/rF
         RMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KKLeJSW3gW1N9iuqVWwnS68YGR/Cy349JfhDBz0rYog=;
        b=FtShV0S5OEW2LX04wO2+MlltZWEdWoHiCb2AFgX2uadsKphekpJpSksB4qlwCrXQG9
         SCdT+iRS9JOT6+dXfE+PIFUpsc5Ddsn566IQ1J76A+eNf0UVv8PGA5qjtFE26QRRXZQP
         yxygsJybIGTQRk7KKhzGSLA6ZFdMpzzT73F6jpS4s2gFEcTLPlcu198wKwDdDCAsvsFO
         PC7gBZTRGije7r6Y+iEWVu75p32ykRUfmTnD979UCtHIMPDQaoXK102o3xtADWkEGkx/
         44xedo/Ppmspa5S9g1GXY1/8kpGHzy/Z9eApMaNY0R/3lIc+GOOiGukXvv8m/wl3wSt2
         AxLQ==
X-Gm-Message-State: AOAM530KUd+y4s97tMAisf6FVQExR7UyKvHJu2M11v65ZSIryPzBKOR2
        uIAZ2PboNcUWyJzX30D7r+E=
X-Google-Smtp-Source: ABdhPJwQtyPZXwInYLIalrHQ1p8XKPUpS3iMFMvPBSgWB9mg1G+gYZUQ6YJ2tkwCFpQzxqelnb4njg==
X-Received: by 2002:a05:6808:484:: with SMTP id z4mr4797750oid.89.1623965343352;
        Thu, 17 Jun 2021 14:29:03 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q11sm1400867ooc.27.2021.06.17.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:29:02 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:29:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60cbbe9d89cbd_1299208fa@natae.notmuch>
In-Reply-To: <patch-2.4-27f94abaed-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
 <patch-2.4-27f94abaed-20210617T105245Z-avarab@gmail.com>
Subject: RE: [PATCH v2 2/4] show-branch tests: modernize test code
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Modernize test code added in ce567d1867a (Add test to show that
> show-branch misses out the 8th column, 2008-07-23) and
> 11ee57bc4c4 (sort_in_topological_order(): avoid setting a commit flag,
> 2008-07-23) to use test helpers.
> =

> I'm renaming "out" to "actual" for consistency with other tests, and
> introducing a "branches.sorted" file in the setup, to make it clear
> that it's important that the list be sorted in this particular way.

That is better.

> The "show-branch" output is indented with spaces, which would cause
> complaints under "git show --check" with an indented here-doc
> block. Let's prefix the lines with "> " to work around that, and to
> make it clear that the leading whitespace is important.

I'm not sure this is an improvement. To me the original code is just
fine. Also, I don't think writing an 'expect' file belong in a setup
step.

Additionally I would do this change in a separate patch.

> We can also get rid of the hardcoding of "main" added here in
> 334afbc76fb (tests: mark tests relying on the current default for
> `init.defaultBranch`, 2020-11-18). For this test we're setting up an
> "initial" commit anyway, and now that we've moved over to test_commit
> we can reference that instead.

That's also good.

All the changes in this patch look good to me, however, they are smashed
together in a way that makes the review harder, I see:

 1. Use test_commit
 2. Rename out to actual
 3. Use >actual instead of > actual
 4. Use test_seq instead of $numbers
 5. Use branches.sorted instead of branch$i
 6. Use test_config instead of git config
 7. Use internal sed 's/^ //' instead of outside cat

I'm on-board with 6 out of 7, but if these were done it at least 2
patches, they would be clearer. I in fact would prefer one patch per
change (although maybe squash 3 with 2).

Cheers.

-- =

Felipe Contreras=
