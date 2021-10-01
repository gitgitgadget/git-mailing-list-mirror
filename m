Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC687C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9E61A56
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351428AbhJAB4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 21:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJAB4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 21:56:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E7C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:54:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l7so5265592edq.3
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nQRIWVm4kP5s1MAm17GJG3PWG5WWLXumVc+WyqEOfYc=;
        b=MS7Sjvl7ycDr63KOnL3n7EeEt0ol6ucyQ8sA507MQrSSKDPbrhAQx0MqgMN/kMYwsq
         WT3kz+d6Blk1CrWgHQz8HYl4UUcxleJE4gX98pbuMv8wj1aGBdQgIK7sxSgdMgmFq+D2
         qJgrcdfZ5nC748ZITM9AGcoSBEmFE72/FDrYf1jPAQKIvM6QmKVLpley9NKsoLyyxOn3
         4liq6MeO/M1N9NO58xhGiHds3DNdR8YPgh75h8igA8vDZj/PDN6WYZv20KfGTGKGWdzP
         MeX5O5EyJLCKqKEmsIIQUgu6q3OmwNPSQ3aEo0OtFVQOnTo8UrbWiamaB4crTP0h6wxm
         xBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nQRIWVm4kP5s1MAm17GJG3PWG5WWLXumVc+WyqEOfYc=;
        b=Akh5E8EhjOhfcElx0WezMxFt/hkufIYoEprIALX+z9qtDNaxVo+dU8ZwvwQZOYaGQQ
         dwf6QMjW02zdJZ5k210psatEOG9/9rnpw7VuMh1AzOLsMDzX1VOKhccMZNs4XsZf9xla
         +mmP8/Cytr+/ldtvVCoIp8P+pGynyJirxC4XaARhIMFbVHQjCTMk3af92pAvAqg3rz89
         3TTr5kFTJY/RJKfJTcbhO5c1q/FxdurlK1DbL49UuFd5RXRsDCSQYJ/GPH0Ijgqkl3O+
         lMA9OlB6lYROZ+60suBBMdiXLSH/OqIOmWhPCRvRQEetkvQLWtzuFemmH2lgPSWbfHgd
         ZWyw==
X-Gm-Message-State: AOAM531JHwGAnyO2WzBEu8EUUdzrq2f/x247ZAeao3gK6bJbprzrEVgL
        3Ee0e8pBNzpLmQ0tLvufspo1PzSjoF+KLN6maB6cDb1Gip4=
X-Google-Smtp-Source: ABdhPJxs+Nbsbec+4kLlFtAZAw9172JpVvKey+yqO7Ihm5vK9AvHbdJ0Dg3GSz15xV6TlQDQsMKQ7qdMoYb1opZ9W4o=
X-Received: by 2002:a17:906:6696:: with SMTP id z22mr3000128ejo.443.1633053262747;
 Thu, 30 Sep 2021 18:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ce95b82fc492d48fa6022df424f9a303a1c70ad4.1630376800.git.gitgitgadget@gmail.com>
 <87a6jut36p.fsf@evledraar.gmail.com>
In-Reply-To: <87a6jut36p.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 18:54:10 -0700
Message-ID: <CABPp-BFyh239+7FLuUuoRJJbcE8NxHZABPTXPmSQhvRSPCiGvQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] merge-ort: capture and print ll-merge warnings in our
 preferred fashion
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 9:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Aug 31 2021, Elijah Newren via GitGitGadget wrote:
>
> > @@ -108,8 +108,14 @@ test_expect_success 'refuse to merge binary files'=
 '
> >       printf "\0\0" >binary-file &&
> >       git add binary-file &&
> >       git commit -m binary2 &&
> > -     test_must_fail git merge F >merge.out 2>merge.err &&
> > -     grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.=
err
> > +     if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> > +     then
> > +             test_must_fail git merge F >merge.out &&
> > +             grep "Cannot merge binary files: binary-file (HEAD vs. F)=
" merge.out
> > +     else
> > +             test_must_fail git merge F >merge.out 2>merge.err &&
> > +             grep "Cannot merge binary files: binary-file (HEAD vs. F)=
" merge.err
> > +     fi
> >  '
>
> To save readers from eyeballing if a single character has changed here,
> which I don't think it has, just do:
>
> if ...
> then
>         cmd >actual
> else
>         other cmd >actual

Do you mean
   other cmd >/dev/null 2>actual
?


> fi &&
> grep [...]
>
> I.e. no need to duplicate the "grep" here just because of merge.out v.s. =
merge.err.
>
> [...]
>
> > -     test_must_fail git merge bin-main 2>stderr &&
> > -     grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
> > +     if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> > +     then
> > +             test_must_fail git merge bin-main >stdout &&
> > +             grep -i "warning.*cannot merge.*HEAD vs. bin-main" stdout
> > +     else
> > +             test_must_fail git merge bin-main 2>stderr &&
> > +             grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
> > +     fi
>
>
> ditto.
