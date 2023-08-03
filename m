Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8C4EB64DD
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjHCRuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHCRuD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 13:50:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A73C3C
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 10:49:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe55d70973so970964e87.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691084991; x=1691689791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLf9spnNUKudqq8lnuhplWCMfcDp+f1BTFwdnX1pUX0=;
        b=nrFPGH1/YEnaePUeEeIb8iCLWpEuRj5gJJKZJJcFmTpGjutLfI7ssSVVKhB4lB/sor
         z33SBcpoqAcn2f4bizvMYrUzhBwtiGPU4G0t9pZr5paxdBJQrOevcxak0OZ1kCdy5Uet
         6Yz07n/Louy/6VG2Fs2KJNTx5naz+HY2BVlpZFllBRdiKEo1A1xOsEAu5OBaLVgGNd9E
         pBwT8UKR7czSCJs/EFmClfQ5PxrlsnK4u9S5WpjhwtiayS7CJLKxertd7vCVDPuGm0KG
         eMb++KwPWyJ172F6w1QstWjK548dyxUEAgWevu5wgK/kyRP/NqfyrnOgafhrBI4O+XRk
         gKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691084991; x=1691689791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLf9spnNUKudqq8lnuhplWCMfcDp+f1BTFwdnX1pUX0=;
        b=gz843of3xhlKxtNc0+pMjuLlgcTABi6gROl+olnJx8zzVDH7vdVjhud/LO6BPDK7aU
         5eaTzGE99xvUbxrahTQYhzcu/zicktWg2haLaISCV+AXqcpaVbamp2rRW4UdpPxvib+3
         iAus1FLX7u97aYAp+yxjP0h3rvTOivBUhCT1lZ/VOPsEZJbFBht2i+atPPy5DCdawIk7
         1YA8xqGK77C602i26ljlfmBvbEvtAtSecsz6xZ04ue80voAR32+rVhrEpbJvBi02UmR9
         e3NlDiMDZ5p6QNX9es3QAqm5AJDUY5tSkDKA6/lzgT+dvtYdU0i74TwnavGctmlB8/hn
         os4g==
X-Gm-Message-State: ABy/qLag9aVVdXo+iGVr/V+YEAIuz2Hr8svk2oxm3ATUVsCR/hE4dWpU
        x4QIlakXp4k0X8XzgNbSO9V5d8dERdSKLY3dFUg=
X-Google-Smtp-Source: APBJJlET6TNplwZvgp9jqSN5Dt59mFNRp67TXwPJ77RRMfAVc7fO+2qoMhMjN8X/GSlV4onoBHoDDfJydf0bagA8cxw=
X-Received: by 2002:a05:6512:239f:b0:4fd:b7d4:70ec with SMTP id
 c31-20020a056512239f00b004fdb7d470ecmr3803073lfv.10.1691084990680; Thu, 03
 Aug 2023 10:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+sf2-+499Nfu00ciJeLwjRmBE7Bb-WZcZuCXY2-JXs88Pwz-w@mail.gmail.com>
 <CAE1pOi1Zt8i_rVi6dCGVsshhPxa_kV7qQ7SMu6R4nsSiadq7xw@mail.gmail.com> <c2fea20d-af37-8721-5bd8-14bbc3daf937@kdbg.org>
In-Reply-To: <c2fea20d-af37-8721-5bd8-14bbc3daf937@kdbg.org>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Thu, 3 Aug 2023 10:49:38 -0700
Message-ID: <CAE1pOi1xtaEo6LtF4VnXetmLYK5VbYU5uq7gGC=PpnVB3MWdag@mail.gmail.com>
Subject: Re: .gitignore is not enough
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Aleem Zaki <aleemzaki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The promise part, I was aware of. In that sense, my wording was too
strong. It's more like "just trust me".

So the "you will get what you deserve" makes sense. If the
original/default/skeleton changes for some reason, your local changes
will just get overwritten. Nothing surprising there.

But in what scenario would Git "commit them nevertheless"? That one is
a surprise to me and is a bit worrisome.

On Thu, Aug 3, 2023 at 10:17=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 03.08.23 um 07:35 schrieb Hilco Wijbenga:
> > I think you might be looking for "git update-index --assume-unchanged
> > <file>"? See https://www.git-scm.com/docs/git-update-index for more
> > details.
>
> Sorry to tell you that this is a myth that lives on because it is
> repeated over and over again.
>
> > This allows you to tell Git to ignore the changes you made to that
> > (tracked) file.
>
> No. --assume-unchanged allows you to make the *promise* to Git that you
> will not change the file, and consequently Git does not have to check
> whether the file was changed. If you break the promise (because you
> change it), you will get what you deserve. For example, you may find
> that Git overwrites your changes, or commits them nevertheless.
>
> Perhaps a better choice is --skip-worktree, but recent answers on
> Stackoverflow point out that even that is not a suitable solution for
> "please, Git, ignore these changes".
>
> -- Hannes
>
