Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB41C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 18:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBASXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjBASXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 13:23:41 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833877CC92
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 10:23:40 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id w15so13718798qvs.11
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6ShE69klCwOGBSPGLiT3bceCrTwKXsc4QoqfVYS7cA=;
        b=WJCWDV5iorIe5y5t0Qnp4+jvhVfhe7VOfZO7bcAzC0Q51Ano1HLz+W2aOb/8VndYWz
         /eg16SlplllM3tHagGUMCS8dYlUVhmg6EgegUgp3reEPZfs78mr/PXlqo+kBN9Bh5QsJ
         gB47zm71H27S/e8ygfhspuAJGhffnkNHXudNhtYQSXANiFR0o18DvUguVL2jVNmYdB4v
         FaFgrL2iZhRVAC7GzTeDF+VDYIOXdG8MGMACRXNTZFd3gXtbK/yR5pL//EMsOLvlBWNa
         Aa/v49GvLd6pNHoU72RbS6xFhZ96TLPDBOBDC5NPMhO1hdE/X7RJYYNBAbGdqPVeBnny
         UMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6ShE69klCwOGBSPGLiT3bceCrTwKXsc4QoqfVYS7cA=;
        b=3KjkB0Igcb+Yc6hVQm/teXSa89zjhimcOdOi8zALdJAK+VWURdjQmBf0LNtjP8AmmF
         lHkWhkZi2mYYJEMvtrocztD4Mx+BxmAzLBolDVi/eA+SNDfVSapLku2zRgZRHP+PUOSt
         Pj9MOa/3O8II99LwzVLYg9HWKvpqPGkycL54qe9j2vSIP5KHOEutqJoJXmOfiqpETugG
         Z3LIAw3sQjl54pR/Pse0NtY2yCeYJmAk9f1QFkh+JIUiq6HOFOz2nFSq6GAYziFEmLgw
         KM5SRGKus+Nh3I1mmjtdWb11DzkdPvMJFPRkwo8nCklnYuciIp34ZJ0HYHkg7N6O+Wkg
         QXOg==
X-Gm-Message-State: AO0yUKXao7TbVPNm1eBtBWeDRUmoQYtpnf3Ptk7WFd+TNQCBWDgrnKts
        mcqPVBtal7tvv/EqhuD/57Ts+n+tky1tYixOrlnsLSsSR7qHgA==
X-Google-Smtp-Source: AK7set/BuI5n3e9RYabc6hC3Z24AcSuOiK4ppF8g1czxofy3ShwoM9tjL2x2lFS16mgqYR/GL1mazwk23dazmZGaoqY=
X-Received: by 2002:a0c:f1cb:0:b0:536:6a69:5edb with SMTP id
 u11-20020a0cf1cb000000b005366a695edbmr245031qvl.5.1675275819680; Wed, 01 Feb
 2023 10:23:39 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com> <CALnO6CDCkuN2XU_AyO66hQSm2ztfpe8Rs_baw_J4uTQZmekREw@mail.gmail.com>
In-Reply-To: <CALnO6CDCkuN2XU_AyO66hQSm2ztfpe8Rs_baw_J4uTQZmekREw@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 1 Feb 2023 19:23:28 +0100
Message-ID: <CANgJU+WZR56xG+KL3P053aD_qTh+rBhZ01mqNajg2qRt_+RNMA@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Feb 2023 at 17:22, D. Ben Knoble <ben.knoble@gmail.com> wrote:
>
> On Wed, Feb 1, 2023 at 11:09 AM demerphq <demerphq@gmail.com> wrote:
> > FWIW that looks pretty weird to me, like the escapes in the charclass
> > were interpolated before being fed to the regex engine. Are you sure
> > you tested the right thing?
>
> Quite sure. `git diff --word-diff` fails. This was just a smaller
> example based on the linked C code.
>
> Here's the output of `git diff --word-diff` (verbatim and dumped):
>
> ```
> fatal=C2=AC=E2=80=A0: invalid regular expression: \|([^\\]*)\||([^][)(}{[
> ])+|[^[:space:]]|[=C2=BF-=CB=87][=C3=84-=C3=B8]+
> 00000000: 6661 7461 6cc2 a03a 2069 6e76 616c 6964  fatal..: invalid
> 00000010: 2072 6567 756c 6172 2065 7870 7265 7373   regular express
> 00000020: 696f 6e3a 205c 7c28 5b5e 5c5c 5d2a 295c  ion: \|([^\\]*)\
> 00000030: 7c7c 285b 5e5d 5b29 287d 7b5b 2009 5d29  ||([^][)(}{[ .])
> 00000040: 2b7c 5b5e 5b3a 7370 6163 653a 5d5d 7c5b  +|[^[:space:]]|[
> 00000050: c02d ff5d 5b80 2dbf 5d2b 0a              .-.][.-.]+.
> ```

Interesting. The regex engine seems to be interpolating the \xC0 in
such a way you arent seeing the real pattern. In the Perl regex engine
I'd call that a bug (it used to do the same thing before we fixed it
years ago[1]). FWIW, this is a valid regex in Perl so i dont think the
pattern is at fault, its something else. I saw some discussion
recently that the mac regex engine doesn't play nicely in certain
ways, but i dont recollect the details.

Sorry i can't help more. Try searching for EXTENDED and regex and mac.
Maybe you can find the mail I mean.

cheers,
yves
[1] I am one of the maintainers of the perl regex engine.
--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
