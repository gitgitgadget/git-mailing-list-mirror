Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E7C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 10:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26446619A7
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 10:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhGFKKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhGFKKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 06:10:13 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C9C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 03:07:35 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id n61so8064487uan.2
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7lplYG1o4Xy+DMm2sSe9e0FtdRR6gw/y4+voUfp0x0A=;
        b=H96AoeSK0KkPdIIXu6cheAv30BA4pUCmIO1xAKeC5iHwcWrP7iKGEt3hrRIu4FUaor
         2cqCePW3NtV1l584N2XCKD/w/BKgsOyJ7AYdnjk8sOgmou5C1zfwxLD3iD4f9txhWg3T
         X2BwumeIypOA3XbO6aS+wePCdxGC2XqnaLt5OVe6gyJ8YY78C9c6rC5a4EcUV4ozE4fI
         gfw8DNes7t3S0M41IAYldc71EkUH7tW0NXxOKuMCAtuQzz5gPh5JBGj2sKHYeMlOz8GA
         Ygzeo2qhb8tNwDfwxImEaK64WYYtUFhyis8CTZzm8bL9BuLMkNdOB/R6ngJ7pUNeind5
         kFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7lplYG1o4Xy+DMm2sSe9e0FtdRR6gw/y4+voUfp0x0A=;
        b=kI0rWxt5TRETFV8e/Ty58kfo/LftBjSaq8t3YoFu4FyGmbHynsi2R0j1cTz+DValFa
         2kw2vz70EEEbS5B6a0zjfgZxfQjDCPkMfCOxpliPBigXorT+pGyOPDytNpr4K8giGS5I
         vr5H35wav401EP4Y2dTsRYQqK4uiKPe0zS7jsUQgus4P/+N3NOs3c8bE7Ixpeyg5FF4S
         1UP7omieoPWFvgWT9ulDKdN7uS9pMy4ACCfa2K5/AnqDQMeg+YN5vdZUDY5l32wJwM9Z
         kFZKqQl2yd+VBiSGjovCFb5ZTzbQuv+BON5NW7Gpi6pbfqofkm0GouH+/npTkUnLvABW
         vYtg==
X-Gm-Message-State: AOAM531/uqtbr0Red0V3ILv8Ypx6zZJauQtTwq0skCA3VfW5d7KRmR5s
        rmAM9ZBYRqwB31oIhr0pAcQG1agRNvnXrTAeBMI7EA==
X-Google-Smtp-Source: ABdhPJyGM8Z+mDITx3UpErk0bFvGe/kK03ycnZlUFi415UCD3JSUtghTl1OlG7yHnmMhoWnJIHJVAd3FSKDNKONdokA=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr6011601uaq.15.1625566054166;
 Tue, 06 Jul 2021 03:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 6 Jul 2021 12:07:23 +0200
Message-ID: <CAFQ2z_O8fQ4eaCL30jpe8-_q5Cez4jH_E3v5WbgZ0ZgVZYZcyQ@mail.gmail.com>
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys using ssh-keygen
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 6, 2021 at 10:20 AM Fabian Stelzer via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Fabian Stelzer <fs@gigacodes.de>
>
> set gpg.format =3D ssh and user.signingkey to a ssh public key string (li=
ke from an
> authorized_keys file) and commits/tags can be signed using the private
> key from your ssh-agent.
>
> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
> A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
> verification.
>
...
>     In our corporate environemnt we use PIV x509 Certs on Yubikeys for em=
ail
>     signing/encryption and ssh keys which i think is quite common (at lea=
st
>     for the email part). This way we can establish the correct trust for =
the
>     SSH Keys without setting up a separate GPG Infrastructure (which is
>     still quite painful for users) or implementing x509 signing support f=
or
>     git (which lacks good forwarding mechanisms). Using ssh agent forward=
ing
>     makes this feature easily usable in todays development environments
>     where code is often checked out in remote VMs / containers.

Thanks for working on this, and I support this initiative. I
coincidentally have started proselytizing something similar just weeks
ago.

My interest is in signing pushes rather than commits/tags, as that (in
combination with SSH U2F support) provides a simple mechanism to
require (forwardable!) 2-factor authentication on pushes over HTTP. I
haven't looked at the signing code in detail, but I had the impression
that adding SSH signatures would automatically also add support for
signed pushes? (aka. push-certs) Do you know?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
