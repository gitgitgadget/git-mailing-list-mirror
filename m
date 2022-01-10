Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FADC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiAJS3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbiAJS3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:29:50 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C1C061748
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:29:50 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 19so988886vkl.2
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=guSilXg8l7fH+N2sksaoyv1LM5yHTdz2czmh12aPEps=;
        b=N4kEZl/oeHJnhQEwPA5Wahztd9lT9OmrqVLI5yNPhONnEpHRV/sxJGG0wdAIEjqXfs
         M6SvWkb810YgmDotLqlwAodS3bk1uZBZ61fRvDbKdEQOvK1lpW1i1olraoGO4G4/dxyx
         ok3ucy4ImtHDXnMu7i/dkCRxrjUxtShJLJnl6u0Tr9143SivfXcrgEo5O46zuMIIjpol
         zleQ7MCY950XtfZGM5BGuAzhkZvaMhxylMzRpo4fLpNMRSZMF2WPTGaRs8uxcRMlUl1p
         wJ4Fw+UP3Xh8tupu2QoDX10Wu5GBK+fH+Qf5pd93CxqYgzYwbnzbWrc0CcVOdX11z4XR
         IDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=guSilXg8l7fH+N2sksaoyv1LM5yHTdz2czmh12aPEps=;
        b=QW/wzvEkxQ1zwcDtTd86Q+Onj8+LgGU8YEeQ/1lAECGFk4Q5TeYRh8/ccwdqwgZglH
         LF9qh+o6LVAPwBkCGcTaXL0fTEdP6+GGrwDF5FBrgdNSsxNgN/N/2yc3sXkIRANxnOf3
         HsfHfGZssILkRxqphV6czv/6JxbrLxPLLkd2O7o8Ci+tEtadDXORpqQ7EFVWNuCEUaqO
         hN0xr8UPHY6ogwSB2vlHBpqiMLjIKy7C4o83zQ52zSELQArslJMvlRvpDo7ZspzU4BF+
         pOfD6QDeoVeqSQrY1JXsb/aSuHmiOTRB4CwLDIaYFEmxR/Mf+fjufv4gp4yweZrG6kCu
         if0A==
X-Gm-Message-State: AOAM532cfiNQ1R7WhcN37eMtpFPkYLhk8y9fNdtV659sMSzR/YUYWewV
        B814oYo/TSpOwQ9HhKOqxRWLLaCL28XzJE2dvMQ0FQ==
X-Google-Smtp-Source: ABdhPJwvS/qOG4fb7jUIsLBXHtQJ0Niim+VlA3dXVQlIe05hSil+LOGLvYEBTttuPYqee9pVpHxUlQK7b21Q8RULDq8=
X-Received: by 2002:a05:6122:1821:: with SMTP id ay33mr568853vkb.37.1641839389791;
 Mon, 10 Jan 2022 10:29:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
 <e0d7dbf8b552381a9b7854f2bb9eff41508aac04.1640170784.git.gitgitgadget@gmail.com>
 <42bde83d-65fb-d326-ec3d-4ef4121c35dc@gmail.com>
In-Reply-To: <42bde83d-65fb-d326-ec3d-4ef4121c35dc@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 10 Jan 2022 19:29:38 +0100
Message-ID: <CAFQ2z_MccXoZqxCJJ1Fi093mQWrt1T5FyWfG2KznO0PoxVOQFw@mail.gmail.com>
Subject: Re: [PATCH 1/4] t5540: require REFFILES
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 24, 2021 at 6:14 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 22/12/21 17.59, Han-Wen Nienhuys via GitGitGadget wrote:
> > +if test_have_prereq !REFFILES
> > +then
> > +     skip_all=3D'skipping test; dumb HTTP protocol not supported with =
reftable.'
> > +     test_done
> > +fi
> > +
>
> Did you mean reftable doesn't support dumb HTTP protocol or vice versa?

AFAIK, the 'dumb protocol' isn't really a protocol, but is simply
exposing the file system over HTTP.

I suppose we could expose the reftable files over HTTP, but that means
we have to rewrite the client to understand reftable files if they are
served. However, I get the impression that nobody really uses the dumb
protocol anymore, so is it worth trying to make this work for
reftable?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
