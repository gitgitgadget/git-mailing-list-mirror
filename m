Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC1BC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 07:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhLKHLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 02:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHLi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 02:11:38 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4ACC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:11:37 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id t13so20548870uad.9
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p+T1N3cUgFdsMP3lWCOldz8i1nVsFZfGXBi30Ci123I=;
        b=HCEXo82fvc8B7uahSyMyw19WG0tkXBnNIdtEnhQ++/XMwm/jTDGU8eiX4LAgHjCL5p
         +8cU9/41K9VSgBliugu4ie629x8e4e5J55kUkb+NU4weFWsHbUSD+hFi/Ln092x7bvG7
         jREdpw/6mwtyUq1RKdkYOO3W7+N8hPfOwfHDBtfNBxTeNretRdyPozUlJHpj2NxeSySV
         YAhYHB393JZrfVshW2hOm6qRs0ojSXzfm3bHWaTNbx9RihbPntiUu1oBMRF4gVks/h8g
         voAXJ0/xHL7rVWHK1ThI0eK0iWQHWomdQUogOV+iMtHRx4OyXf9/VkEFhJ7ws/QG6PL4
         bhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p+T1N3cUgFdsMP3lWCOldz8i1nVsFZfGXBi30Ci123I=;
        b=FYpIHLlt7lgLAOjQpUUQjTelP4o5RtXKG7NJbtTgFgTFntZYnPl/Mp/uaxhVWk4Ktu
         NHncPaDH1ae6nzmtXsUPIE5hhLGt6JB38yC2WmOFB0OyUDeY/blYBQ5aAkRVUKs0DZ9F
         YNDyJ3vBiQ8URiv2YBjomRlA7Nj6q8hD4OoTF2cUeGj5ZQRvrnKoPhH+VZmXeFtaPr5a
         YD/YUEcTVaLAbNC3RB45UVxgEk2FKqVFTP+30z0kYtLgsOjfVEm/mmgk0NaddI7DsxRy
         h5cpQ4MD+lZ74zokeahPfGKNPN/8RAz+qEJvQzVOoghhRz2gYPyfdN0HqqUUz4hMGfar
         HwzA==
X-Gm-Message-State: AOAM532rvSIi8F6YzMNt36mgF+06Jn55ShfEL+m/7ANT7MxBzpVBRTOg
        gG1cjp+uiT0WCFi9F0c77EEnyhGGDorzNgPHOMM=
X-Google-Smtp-Source: ABdhPJzVJ/7jMdTtF4I4d9f8B+BFK5XOOebC5nFm6pgs2vJhUvd07TP9M3Y2OwoQ+hYMwa9SJpiAGwuWTHkCRtFxstQ=
X-Received: by 2002:a05:6102:a4a:: with SMTP id i10mr20576219vss.47.1639206697040;
 Fri, 10 Dec 2021 23:11:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
 <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
 <211210.86y24sdd7k.gmgdl@evledraar.gmail.com>
In-Reply-To: <211210.86y24sdd7k.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 11 Dec 2021 15:11:24 +0800
Message-ID: <CAOLTT8Qt57C41fiq0C+8szj9OMwUexJq_pV2QNwy8AsgoZscDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B412=E6=9C=8810=E6=97=A5=E5=91=A8=E4=BA=94 17:24=E5=86=99=E9=81=93=EF=
=BC=9A
> > +-w::
> > +--to-branch::
> > +     Rather than checking out a commit to work on it, checkout out
> > +     to the unique branch on it. If there are multiple branches on
> > +     the commit, the checkout will fail.
> > +
>
> So basically what this option implements is something that could be done
> as a shellscript of:
>
>         git_checkout_branch_from_oid () {
>                 rev=3D$1
>                 git for-each-ref --format=3D'%(refname:strip=3D2)' --poin=
ts-at $rev >/tmp/found
>                 if test $(wc -l </tmp/found) -ne 1
>                 then
>                         echo "Goldilocks error in finding $rev: $(cat /tm=
p/found)"
>                         return 1
>                 fi
>                 git checkout $found
>         }
>

Yes, this is the effect I expect, and it can indeed be done through
the shellscript.

> Which is not to say that it isn't useful, but that I think adding this
> to "git checkout" specifically is adding this to the wrong level. Isn't
> this useful to most things that parse revisions? I.e. wouldn't a better
> interface be via the peel syntax?
>
>     oid=3D$(git rev-parse HEAD)
>     git checkout $oid^{tobranch}
>
> Doing it that way would allow any arbitrary command that takes revisions
> now access to that, and we could have e.g. "^{tobranches}" too, so you
> could do:
>
>     git for-each-ref --format=3D'%(refname:strip=3D2)' $oid^{tobranches}
>
> Or:
>
>     git log $oid^{tobranches}
>

Very good inspiration, putting "oid -> branches" in peel will be more elega=
nt
and useful.

> I think implementing that is a bit harder. It's peel_onion() in
> object-name.c. I think parse_branchname_arg() via get_oid_mb() is now
> only capable of filling in an OID for a given name, and then checking
> out that name comes as a separate step, and you can't just return
> e.g. "master".
>
> But I don't think anything stops us from adjusting those functions a bit
> so that get_oid_with_context(() and friends could pass down say an
> optional "struct string_list *", and the "peel" could then be expanded
> to that.
>

I agree.

> Similar to how we have "git chekout -", and the "-" is understood by
> some commands, but not all (via some opt-in whose location I forget...).

"-" is parsed as "@{-1}".

Thanks.
--
ZheNing Hu
