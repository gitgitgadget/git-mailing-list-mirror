Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690CCC433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 14:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbiEKOET (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 10:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbiEKOER (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 10:04:17 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E821C62232
        for <git@vger.kernel.org>; Wed, 11 May 2022 07:04:15 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id v3so840873uau.4
        for <git@vger.kernel.org>; Wed, 11 May 2022 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wB6EVmo10EM9YOOZ7zyn4h5eflYMA6lOUNVj2z5S320=;
        b=P9Vu9MyK23skmLKZc/CPTMesNyW+A0hSFhMkLnBGuyliXCHZP7KNyvxzhhXlrJAuIe
         hF7JRdUuMc306wvvzZCZSEhFZ6cDeN39LZHrJtY3GKCRLDa/iNEXdsgnJw9L1ctsg6Xk
         ytotyIvWHaIbjjBpQKDMsw6FJ3lblf4f9w9JDVJpAhHYdlpT1V7pmW8BtGZD2rvTWAJP
         60uMQxXb8zIMDHRKXPv8FJBC2pdAq1rJNrapI9ibHPKrD/qujgihC3CQY37zCJDv9jx6
         NvwAgjm5s/IjYAhpA2WONm4DqS/ElB1CItcsJhaphOCHJ8eK7hdu872JSejYTHjMeNl/
         weGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wB6EVmo10EM9YOOZ7zyn4h5eflYMA6lOUNVj2z5S320=;
        b=H75N/lXo7cSdTVuA/aYbB6bI8aYZTgE3wqzow82ogmVY0bBfXcuGgV/mZJxRr26y15
         A5Q4VB3cqysX2LJYu+eWAA9pIfVDdrc0V3WclJUgeBTPzYIVp2iyUn8SdCJhQof1Wked
         Yb7p8WxQ/2kZuTIX7z8lZvdLyajaKGqjkrNAqigJwfx6uVSUcJ8twe3YOSxLETdMeS2F
         TiiOCrhdnbLz2SKX4neXeqXNuMaVhubagMoFVJlYI7jrj7G3VBO4KyUoCkcgvSfwx/NR
         Dew81zAydajTLawoCADvTwIGXSF2yvd3L/NIR8cN/eJM9Iv4cHLtKrzlc/CfoV9DHXaK
         gesg==
X-Gm-Message-State: AOAM5320+QbkIgBZsej6VhApbUMLy9gDknmxIVlV0k6G0EU4VahFod2D
        EPJ6xexpSpR8eEG2BTje+u6pXGT2X9a4amGucpQ=
X-Google-Smtp-Source: ABdhPJzQnXKrxGRNmvUGaG89SzF9fbvp8OKXmdneRDye2hq7qtizTwui1r7yfX59Li7EdoVHK+mnF4ZHLeauO0Resdc=
X-Received: by 2002:ab0:654e:0:b0:360:303f:46c7 with SMTP id
 x14-20020ab0654e000000b00360303f46c7mr13934740uap.6.1652277855017; Wed, 11
 May 2022 07:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220507163508.78459-1-carenas@gmail.com> <20220510174616.18629-1-carenas@gmail.com>
 <20220510174616.18629-4-carenas@gmail.com> <xmqqczgl56fi.fsf@gitster.g>
In-Reply-To: <xmqqczgl56fi.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 11 May 2022 07:04:00 -0700
Message-ID: <CAPUEspiJSn5onUDpGQOtP7-51F87SfKRkcW+RC693EOboymnPQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t0034: add negative tests and allow git init to
 mostly work under sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 4:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > Note that the specific test that documents that after the previous
> > changes, it is no longer possible for root (if obtained through sudo)
> > to NOT add an exception or NOT need a "workaround" to be able to run gi=
t
> > commands in a repository owned by thyself, is marked as a regression
> > and is expected to be fixed with a future change, which hasn't been
> > provided yet and that is not part of this series.
>
> Do you mean "you can easily unset SUDO_UID to access root-owned
> repositories as root"?  Ahh, no, "after tentatively becoming root,
> you can access your own (via SUDO_UID) and root-owned repositories"
> is what you meant, I think.  I think that is reasonable to stop the
> current round before adding the support for it.

I thought so too, but now I am not sure anymore; it would seem this is
a "regression" worth fixing by some (especially since there is little
appetite for behaviour changes since the last CVE that had a "fixup"
on top) and the code is available to do so, so will add it as an
"optional" patch on top and then we can decide.

> > --- /dev/null
> > +++ b/t/lib-sudo.sh
> > @@ -0,0 +1,12 @@
> > +# Helpers for running git commands under sudo.
> > +
> > +# Runs a scriplet passed through stdin under sudo.
> > +run_with_sudo () {
> > +     local ret
> > +     local RUN=3D"$TEST_DIRECTORY/$$.sh"
> > +     write_script "$RUN" "$TEST_SHELL_PATH"
> > +     sudo "$TEST_SHELL_PATH" -c "\"$RUN\""
>
> This is not wrong per-se, but I think
>
>         sudo "$RUN"
>
> would be sufficient, wouldn't it?

only because currently we rely in a sudo that defaults to "-s" and
SHELL should be TEST_SHELL_PATH, but that wasn't explicitly tested by
the prerequisite, and so this just makes sure we ALWAYS use the right
shell, even if sudo might not want to normally.

BTW, sudo IS very opinionated, and just like it can ignore PATH when
it thinks that is the most secure option, can also ignore the #! line
in a shell script and use a more secure SHELL for the same reason, or
even not run ANY shell script, so by doing it this convoluted and
ackward way (as explained in the commit message) we ensure it works,
and works the right way, and is indeed how I was planning to "fix" the
'can we use it also when sudo doesn't default to "-s"', which is
obviously not part of this series, but a future one that should also
improve coverage for this test both in CI and for people brave enough
to try to run it locally.

I guess I will remove it in v5 and which seems better again as an RFC
to make sure we can iron out all remaining controversial things, but
thanks again for your thorough review.

Carlo
