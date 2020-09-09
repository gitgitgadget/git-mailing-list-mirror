Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD17C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B1A21D7A
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzs4O6tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIIJfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgIIJfs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 05:35:48 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB368C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 02:35:48 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id s62so959979vsc.7
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wHJK/HA8irhDOOhyjpkFmniXORsOPvOfzG30W8RJ/Ds=;
        b=gzs4O6tEWbeuLIiPwJOHNe2XLQVGInSh48jIcoBQmj/CVrGsJa7u91y08PfhlWUYB/
         YyubR3wiOWCn7sy9H5EPNg6B3EnEuYnnPGr6BksngWwc/wuhBWdq4zNczNM5AzSK3g4a
         FoBjzoqMJKXSnyBnzGObQzNqobS2eeRPRo/zl2DbodD8ZQhpI8lWkAwcq64n3RdyzXT7
         Rvf2jpL6oOXbKAotm6l9ZDGK4i3l491lgtUjxlKvNDA2SOBFsAP370Pk0eU81aEcEXjR
         mty/nsWk3xZUPV2/iS2uXxM5Ek0LILHQx70aZwLrmM4b19fxApGHmdXbYUR+MccujWtq
         mFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wHJK/HA8irhDOOhyjpkFmniXORsOPvOfzG30W8RJ/Ds=;
        b=n2BTST5G6EwKjJsekNyfZ6qgkcXqtgt+DygLCZrwlOrIPF5f9OZ4AZxozBts8SQYSm
         /xu6l27MBlL9ky3PdfdcA/PRoH8co4lkwQn0clXyrwTg8ojEt6iNbAzialKR9oMKLuYb
         u22yQC7uJ3GRif3h99FZEtP24U3bkUaxkfjU1amXiBoGZvOUwOy9E8av2kWIGuwMdakW
         XvUGCkmJZOEo1c9m+WBmxhKCjZcdpcLdzzV6yhI2z+T0jA1SJnnk6mVkGNAOKbrHZAvu
         Ixtf26gNu3TeGJI9DX0PCFOUEwW5q2zEIG4mAAuzgZxNmZKC2ll7mxxqnHE+tOAFnfz5
         hFkw==
X-Gm-Message-State: AOAM533qN+gFqGcGD4I+Fz2NMauqq3NY9Wp37ELZU89p+UuG9ya7jxKl
        N+5C1i96w5g1sf8Dz1TZAFwhK1jzJrvQjT3dRsPaxg==
X-Google-Smtp-Source: ABdhPJz34UGFcjcPPYs2uFDyZNxDWYrBDDX2LM0U84ZdzgGBa3EeDl/Ggz0BYIVBroOYm2YjQ+KF7yG9xMbvtxjTejk=
X-Received: by 2002:a67:5d07:: with SMTP id r7mr1952686vsb.69.1599644145880;
 Wed, 09 Sep 2020 02:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.712.git.1598628333959.gitgitgadget@gmail.com> <xmqqo8mfx4qd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8mfx4qd.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 9 Sep 2020 11:35:34 +0200
Message-ID: <CAFQ2z_OYn6cC5SCgv-49pa9VQ2ZEhbeZ9aGn4e-C7tsnQ=qWow@mail.gmail.com>
Subject: Re: [PATCH] refs: move REF_LOG_ONLY to refs-internal.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 9, 2020 at 12:50 AM Junio C Hamano <gitster@pobox.com> wrote:
> Hmph, I am not necessarily sure about "need to duplicate" [*1*], but
> I do agree with the patch text---the bit should not belong to a
> single "files-backend" backend.
>
> [Footnote]
>
> *1* obviously, a better alternative, if possible, would be to let
>     the more generic layer do so without forcing the backends to
>     duplicate.  But even if such a change were possible and we
>     decide to avoid duplication, it does not make sense to have this
>     bit specifically defined for the files-backend and nobody else.

I'm not sure if it is possible. REFS_LOG_ONLY is used in the
split_head_update() which is called from the middle of the
files_transaction_prepare(). In particular, it can happen after a
number of locks have already been taken. If this moves into the
generic layer, the head split happens before the locks are taken,
which could alter behavior.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
