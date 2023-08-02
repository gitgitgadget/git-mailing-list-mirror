Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C826FC001DF
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 13:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjHBNDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjHBNDi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 09:03:38 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3068268E
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 06:03:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d3d729a08e4so342517276.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690981417; x=1691586217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEa0BhYMZkaU50iLhr4kdL/aU33iLHuJsERzAwHlTZk=;
        b=sOUKqPrNoU6b66xlzsCTZ1cgL1GeIV2hYCpk+2Oh+caZvLP7pNQAzz+B/l+AzW2d5i
         /JNOTXPkoHbIJwdtrJPVcqBOunJwargSyL/zd16UGOo3yDdcGrtLmFn3sTfqMC75gmwU
         LCCv3icZuLkUcooso1tMwv/9m4Xqu/bvTBQC7vRPaES5ZFyJvAyqNSJbrqGv7W9ymIuT
         rQXflVytG0J0dWWPZu0UDyteK45eIsl5NoqKQV99AUtpC/udhuY8Ntos8ovrI80qBdtG
         Kq6iHhIKs51EM+GnJHaLpqw7VtMENT+tts9Ys+riiKmjlTGTh+VcJags0NptPiWcWtaj
         W1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690981417; x=1691586217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEa0BhYMZkaU50iLhr4kdL/aU33iLHuJsERzAwHlTZk=;
        b=LFXz2uOVaEjMniDGlTUahdmngS9Y+6+M9ERqFGMNnoxzBtqmbF5PJow3OEyBPtrtVr
         /D6oRKWEjym1LJxtVAghmeAOAIMxcWDVGhuFYDdYBNmEaoOUqTWsCqmtnkxM/N6ZO417
         i39WmjDbvuT6KdOQZwRuijYaoy17YQuy7VzRPn60qXOzmtWR6283qCa8binfPZJ52tOm
         c/5ChoSo6iCT75i5iEBFYv7KURv/t0BtqSNiPwZX4tQJlTqxgZ66yTZL1YgBlJtXssRL
         pJ6Ry4X7IJ/wiSW/JYeV+YXHIHPeIM+9heCFI+kbzfPd2m0kK1DWrvHlx8wqgb0o0VxV
         Vkqw==
X-Gm-Message-State: ABy/qLYK0JCYcJjml/dCmJ5UBdzr/45orp4iMRUTiJTVd2TMrRkfcba5
        3OS8lP1BATLsRZmpkQBdKp4sSFDJzDvgC8+HyhOjFhlnSBzL99gP
X-Google-Smtp-Source: APBJJlHV7dsoST8O2gDDOHFtkpGqys4aPRMcZzHYQUv2Vp8ydjfFWt1CHZPl6A491Hz8XapNGgp0s5Qitzn6WfxAzRI=
X-Received: by 2002:a25:918d:0:b0:c12:29ac:1d36 with SMTP id
 w13-20020a25918d000000b00c1229ac1d36mr14494613ybl.7.1690981416436; Wed, 02
 Aug 2023 06:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RvAbmS1SwFja8_+NSBBoL0gTH1RgpSN5CYtDWZscMYZA@mail.gmail.com>
 <CAP8UFD02tYrz+bxoR_GQfYuxxrmv5=BXjcZuiqXbX3m7N2dPaQ@mail.gmail.com>
In-Reply-To: <CAP8UFD02tYrz+bxoR_GQfYuxxrmv5=BXjcZuiqXbX3m7N2dPaQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 2 Aug 2023 21:03:25 +0800
Message-ID: <CAOLTT8TXYpyadp=Z6K44G59iSar5ieyLwmSph4ypwxGo9doHYA@mail.gmail.com>
Subject: Re: [Question] git rev-parse verify for non-existent object
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=
=882=E6=97=A5=E5=91=A8=E4=B8=89 18:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 2, 2023 at 9:50=E2=80=AFAM ZheNing Hu <adlternative@gmail.com=
> wrote:
> >
> > In my case, I often need to use "git rev-parse --verify" to verify
> > if a revision exists in the repository, and this usually works:
> >
> > git rev-parse --verify HEAD
> > afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3
> >
> > git rev-parse --verify afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3
> > afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3
> >
> > git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> > fatal: Needed a single revision
> >
> > However, when I started checking for a non-existent OID that happened
> > to be exactly 40 characters long, something unexpected happened.
> >  "git rev-parse --verify" did not produce any error messages.
> > I consider this to be a BUG.
> >
> > git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> > aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
>
> The doc says:
>
> "
>       --verify
>           Verify that exactly one parameter is provided, and that it
> can be turned into a raw 20-byte SHA-1 that can be used to access the
> object database. If so, emit it to the standard output;
>           otherwise, error out.
>

So why doesn't "git rev-list --verify" check if 20-byte SHA-1 can
 "access the object database"?

>           If you want to make sure that the output actually names an
> object in your object database and/or can be used as a specific type
> of object you require, you can add the ^{type} peeling
>           operator to the parameter. For example, git rev-parse
> "$VAR^{commit}" will make sure $VAR names an existing object that is a
> commit-ish (i.e. a commit, or an annotated tag that points
>           at a commit). To make sure that $VAR names an existing
> object of any type, git rev-parse "$VAR^{object}" can be used.
> "
>
> So "--verify <argument>" only checks that the <argument> provided to
> it can be turned into a raw 20-byte SHA-1 (or perhaps a raw 32-byte
> SHA256 in case the repo is using SHA256). "^{object}" should be added
> at the end of the <argument> if you want to verify that the raw
> 20-byte SHA-1 (or the raw 32-byte SHA256) also corresponds to an
> actual object in the repo.
>
> $ git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa^{object=
}
> fatal: Needed a single revision
>
> Hope this helps.

Thank you, your method is effective for me.
