Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83853C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 05:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B40020720
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 05:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uabDIx5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgGHFGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgGHFGe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 01:06:34 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B370C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 22:06:34 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id t187so1699055vke.5
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 22:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tLwjRam6wH0vCq+wPzuV1FQJudAguXwgIW66BXxNIaw=;
        b=uabDIx5JW6dY5TctSF0pEzk4lJ9Y2StBCqyxMdD4HZzJ4UHOwOM1Z5zTR9PsZuo0hR
         jS1mpf5rTXjK3T78NymcE807IundAuIhPoOYICGTrS/sfOtfMVutmnhnUS5/6Dvd6HsH
         vQ5Bmykgg/jh77JGkERBmiz8UMi39s94lJry+kmuBKwwMsTQjy4jfsl5BTVd6CzVjFXP
         xETo2ZlTk0D/dXJl9FgeDSrR7qlE8WKpOaLc6nVGiQBiHQGOnZ+dFAes4slK7A+B6n6y
         jHsyuzuNjP0JqZx4pJ/CRbTI57RBfj4Xa1CHfp/WmP31V50cv3kzikrGIEjsJx1/ufUr
         ZTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tLwjRam6wH0vCq+wPzuV1FQJudAguXwgIW66BXxNIaw=;
        b=t4K3g/PSRBlCANzSXgbVbYxEtcq4ud4l4LFS5JYDA9FQ46iwem0J+QSPs9/3dNM3tA
         ZiXcEKsJw1evJa2oUCqwZy/xTsmNcWgnF1Xnr8Zf7VvsBwxAlslWkYnDdVD62JpN/AW8
         nhW7TJQadWUysma17gI+KKg2KGdDqAymo8tRG/u1Q8w/oeko8kbHItDwS8SqHZAifq87
         V8G4MlkH4Qu1EJczhcVhIwYsglbp8TaJ5AU9/NoOmdXZrHb5xpPZlDw0Fjgd0ptJlwOs
         d0XiiEgmRe6rhVGn6GkQ2cMmFuFX2/o9B9A/uxD92Rphh5SO1l11D9z8wssNUcW+s8sy
         FJmA==
X-Gm-Message-State: AOAM530+a68OCUjCVdpjI/tZ2kg0E7615bmcRH6tilVdn2jwneNClO39
        uB3zYCjPwwAlCOL1zRtbuTzbVtMNV/STRrPKBTmwBg==
X-Google-Smtp-Source: ABdhPJwHEyOEhmc7KrfFRXTxakvoEqFjTfBrCb33zRMqWYe9Ouk13ZNBMiF7NYYnVf9yNLT5FAudysiIQov+RjAY5XU=
X-Received: by 2002:a1f:32cf:: with SMTP id y198mr4163555vky.64.1594184793569;
 Tue, 07 Jul 2020 22:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com> <xmqqfta33y0m.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqfta33y0m.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 8 Jul 2020 07:06:22 +0200
Message-ID: <CAFQ2z_PzBeubuhzPDJHG1VYbKhgLMaVdY1JMCfw1x8jOar10Wg@mail.gmail.com>
Subject: Re: [PATCH] Make some commit hashes in tests reproducible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 7, 2020 at 9:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Adds test_tick to t5801-remote-helpers.sh and t3203-branch-output.sh
>
> That can be read from the patch.  Also the subject tells us a half
> of what you want to achieve with this change (by the way, your
> subject is malformatted and lacks the <area>: prefix; perhaps
> "[PATCH] tests: make commit object names reproducible" or something),
> but the readers are left hanging without knowing what motivated the
> change.  Do any test pieces in these scripts change their behaviour
> based on what exact object names are assigned to them, making them
> flaky and hard to test, and if so which one and in what way?

You're right, I forgot to provide a piece of the puzzle. These tests
have been failing either legitimately or flakily with reftable.

I built a GIT_DEBUG_REFS functionality, which dumps ref backend
interactions onto stderr. This should be reworked to use the tracing
functionality, but you can look at the patch in my reftable series.

When a test fails with reftable, the easiest way to debug is running
it both with and without GIT_DEBUG_REFS=3D1, and running a diff on the
output.

This needs the commit SHA1s to be deterministic, or the SHA1s will
generate spurious diffs.

I agree with Jeff, that a more structural approach to making sha1s
deterministic would be preferable.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
