Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89310C77B7D
	for <git@archiver.kernel.org>; Tue, 16 May 2023 03:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjEPDHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 23:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEPDHb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 23:07:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687F66198
        for <git@vger.kernel.org>; Mon, 15 May 2023 20:07:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f38bea8be8so712284e87.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 20:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684206434; x=1686798434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTpOCY+0yr0HlKBz/1pABsvgobGVAVn3U8u7BxT81a0=;
        b=ktiFoiVaANiAuwSYe5WiOGYe7w4B4GxeAoVzk/zc8LrnKgAjGLH+QAxQ8EyygbDxv7
         KcLPAaGfWSOjYJr/t7uxeMkCuN7iywIWoNV33OrN3HMMWCYaSOXll3W1uhAMiaOPUoMa
         sHzcxwwjUdn6mrRc+GG6Kxw6TlMIebxGI+pfjXro/a+6UAFtbUoWe8bRr/cxI1+XM6Zo
         sP/o8C/6N/lrZjzvIgGRJC93SFuii6Mf8kSnzU2fSIaJtx5jSNZIk7z/Yvyv6rmq4X0b
         80ehc1fEahfuX9k3olqmApmHi+L5/VQJv/Yz/Vyd6pidYBk7O7X0oci2lXrNJUjVnKv2
         eXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684206434; x=1686798434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTpOCY+0yr0HlKBz/1pABsvgobGVAVn3U8u7BxT81a0=;
        b=j6X871/gOkiF1j11z2QimDqFOjWYaECe0z/o4Ndd1eX4uYcRwl3MR8LKduB2yAHPxM
         HbPGfvLz1SpVVrVssQBcX7N2i/lH5GGo8U9+QpAMp3VxDXZVDpF/pch86KsZ05gtmj0V
         uwixljNH6u8L6OzdmeI08psjio3LILtFNReAf2uNedukDkAAYW+hk3ysgPdN3XAEKQaz
         WaamN1PPe6sNHaqBQRbCFWJ/4Btqb2thV1rgJ7f2Eg+QBma43QZFNPvGQk0IFsy9fPxp
         yrUeXbdA7PdyMP152zHbuXhLUcGvWX10+FWZpfdt50ENpot2WLwLXhdpHk7O9wtrmSVv
         T5vA==
X-Gm-Message-State: AC+VfDyBmtpBUCalIPqALfMi4FuSWDxY58c1Ix6AtW38EAEVeIvQicfv
        DlqospIusdsvXTOyuQcp2MCbCClUYQvBfywJGgbwtUf6z0E=
X-Google-Smtp-Source: ACHHUZ6kSpqaHszox5694b+FEHayv+UAGWQWdYdJPLSXFQo7/ccK2Dc0DPPs1Ik+o+nKkmu3DenXTnRb7kxpEXRFkms=
X-Received: by 2002:a05:6512:e97:b0:4f2:7952:d883 with SMTP id
 bi23-20020a0565120e9700b004f27952d883mr3669602lfb.34.1684206434507; Mon, 15
 May 2023 20:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <bbe64fccd5289aa6fc65d1301110812d71bb6f63.1683875073.git.gitgitgadget@gmail.com>
 <20230516001707.1460816-1-jonathantanmy@google.com>
In-Reply-To: <20230516001707.1460816-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 20:07:00 -0700
Message-ID: <CABPp-BHFA4LhY0pxv2jqc5tcUD-jF=_aLx8oFD-2+sa8hxsg7A@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] fsmonitor-ll.h: split this header out of fsmonitor.h
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2023 at 5:17=E2=80=AFPM Jonathan Tan <jonathantanmy@google.=
com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This creates a new fsmonitor-ll.h with most of the functions from
> > fsmonitor.h, though it leaves three inline functions where they were.
> > Two-thirds of the files that previously included fsmonitor.h did not
> > need those three inline functions or the six extra includes those inlin=
e
> > functions required, so this allows them to only include the lower level
> > header.
> >
> > Diff best viewed with `--color-moved`.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Looks good. Thanks for this significant effort.

Thanks for the review!
