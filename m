Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860FC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4F220735
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCBNEicW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgEKLm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgEKLm7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:42:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA20C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:42:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y16so3355953wrs.3
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=++qMSqxO65LxnPCJbXxktsV2L7Kk9Vu0P6oEmB0RMBU=;
        b=uCBNEicWWZTomFCVNq1ErASFVO4pzyAfJU/dR1/wrAvrN7CkZ4MCknilHE8s+dDG0Q
         Ze2mYNcBY4kOgGdMUIRyG3dKPCXQdtCvxaMpVT0hOpDWZ0xliNGMoxsI8MXKFf6ctEkm
         ZJhxJ14+qBZUkLgX7XUAwgPq4mq87cuLnOvojgsFqnBjKQVaN6Vv/KTYn+3cy18gwdJO
         JcG3G2pHofPei7fsAS5ow5bAHsAWx2wNukt20iz/0gDpnSKRV6pxXSWUMKuFJ33giqQJ
         +Wk1aQ4535cKAiyUTH6awShjKVl4njqB07qNdhg7TTvelTy7nAxsSMWRmveZMqJf5Bee
         MESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=++qMSqxO65LxnPCJbXxktsV2L7Kk9Vu0P6oEmB0RMBU=;
        b=NrwIBIX4HlkVBFMPHIyf/AvIhhteqxLNQ4/j8jo8Lal16r6ylpRp/9oK6BG4mm53eX
         xBQhWBOnSkL0KTAj4jqEhqbr4fyNEo+LuGdCoFGWTn2ULtVNDlUnS3bHtTjzdX2EtXLu
         g8pcrYCPwqGi1GvK9ffLFuDkJmETJfMm53/A9C/0r1sh9bzykySCbH9YHnCWaKWP+EvX
         mQEC33TJFjflknsBdFBg1ZYb4/xuo+5R/eBTiS5XU9TN7856osInTjUjzlAevO/Wejhb
         22yqbvNGrLeExBlZMHX0i3SGOgico5xmdIBIJCCU5FcUVkfenM30OnYgY+NIDKes4oF0
         XDXA==
X-Gm-Message-State: AGi0PuYXK3F0U5A8gygY19pO28S2O74JJNOBeXufcxxRoSu0YDbSHm+D
        qvcnm12xXQBCGFjTPsB4iJpFvFcGeSp9UTHHQ2FCJg==
X-Google-Smtp-Source: APiQypL/kaAxuYgAL6y8yyOeFAy1y79saTHGYWjCR4NzowdJLoNU+dgCpEn21BZNFp5iAGxxsEHxGk5LFWK8YgEQkUE=
X-Received: by 2002:a5d:5404:: with SMTP id g4mr18251425wrv.310.1589197377475;
 Mon, 11 May 2020 04:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
 <pull.539.v12.git.1588845585.gitgitgadget@gmail.com> <6553285043b2f004cca646aefd59c509324d4da3.1588845586.git.gitgitgadget@gmail.com>
 <xmqqd07exnhs.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd07exnhs.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 11 May 2020 13:42:46 +0200
Message-ID: <CAFQ2z_NQuSpCwqZM25KZL7AshZZD01Cn9tfWgEjT6A2N3bk3yA@mail.gmail.com>
Subject: Re: [PATCH v12 03/12] refs: document how ref_iterator_advance_fn
 should handle symrefs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 8, 2020 at 8:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> Makes sense.
>
> I wonder if I should take 1-3/12 as a separate "clean-up" series and
> merge it before everything else down to 'master'?  That would reduce
> the churn somewhat.

That would be great. Do I need to send them separately, or do can you
cherry-pick the changes out of this series?


> I also wonder if there are similar "clean-up" buried later in the
> series. For example, would it make sense to also move 11/12 and have
> it graduate early together with 1-3/12?

yes, I'll reorder my patches to reflect this.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
