Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7ECC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 09:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573EC20724
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 09:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5LXRR9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgDXJ2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726582AbgDXJ2Y (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 05:28:24 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5BC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 02:28:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i27so11264666ota.7
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Rl9aoolykVaehD7geATMUL3w0nqetNegq6VLqq4dB/M=;
        b=K5LXRR9X+N1em+a6UYIxfXpCV3A1Sr80Aahcr3As/Xys8XLy9O6VHybYgVmH90gYdn
         cS4mRctbQxkmuzGqeUbteG0Lvc3lRy2ogE4+ZTWGa+GX0ofq/E/7USWHHL+IcvzVM9RH
         ttsfMQS87ktuWTkC0Lz+fUFwgfB2rwdcFnf2mUrBAVzBzfIQNvCkZ3r+SadmJMSCIdee
         8clTcbgFqMPcPseasLbdz3tkL/s2I8FX4eMD8v07g2Pe/TIypqagHmK6QPpXCdKjiFKx
         +jT2CJyJDV4nYOWLKqj6ypNUtHZgi2nkigtDQiXLtC+raQNPpSukcaH996JNLFQsjkdt
         1xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Rl9aoolykVaehD7geATMUL3w0nqetNegq6VLqq4dB/M=;
        b=qdM1tz52wm7gsQ8wqIUEtMmYKugPaf/kPkggZCuyo9ew0nCuHfcKmajq2ic0LF8OUO
         sKe8J3hBFXSeMUrIctFPLTWEwMdPe/FE86/2xCTd5wK4KfwuUlOel4QizjMq5FbO6pm4
         a7mOWeOyThhUtBc/EJvs/DUn5iNu3zo/8nEFDax6qxtLRlLusm2aXzUY849myiNvJQZs
         7nCwDnCpbhGlaPv1G6UnRvraHRCU+UF7dQel5SeHS95heLvri6190TNexrlK0WE1A0N0
         xsBEY9KepFwkdcnIsgsTpr6ocFs6Gtx3FhLOqO/PeTwvaCYxXJTNnfWstyB1+61SrKi2
         FgFA==
X-Gm-Message-State: AGi0PuYfr4nUSeTOI4dm7lPctVDAi7AeyJNCKv+OKNvBHsGvBhaJa1La
        QEaFTq3nn18CTUzSgGtUJ0T4FQlWedxE2rfaKoLLNZt+
X-Google-Smtp-Source: APiQypIy+SQpkJORhuOZUTpU8eV64ZZnM+lICStTpoRokagNrhn/h6gcebC8lsNqn0P3oUch+RYcfD205Fwle+SGNlU=
X-Received: by 2002:aca:c311:: with SMTP id t17mr6024277oif.169.1587720503187;
 Fri, 24 Apr 2020 02:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
 <20200424064805.GB44448@Carlos-MBP> <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
 <20200424072049.GC44448@Carlos-MBP> <CANYt6aF1o9fmK2rwAA-LPSbd3TeW+x+6LdUj99sg_ANy3Q0kJg@mail.gmail.com>
In-Reply-To: <CANYt6aF1o9fmK2rwAA-LPSbd3TeW+x+6LdUj99sg_ANy3Q0kJg@mail.gmail.com>
Reply-To: lars.fricke@googlemail.com
From:   Lars Fricke <lars.fricke@gmail.com>
Date:   Fri, 24 Apr 2020 11:28:13 +0200
Message-ID: <CANYt6aFN0eAKEhRvNhoiOTu7jO54Kau_ayQMhrdy+7_GPAOCyw@mail.gmail.com>
Subject: Re: p4merge no longer working after upgrade to 2.26.0
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to help anyone who runs into the same problem.

For whatever reason (maybe broken package on SLES) the wrapper p4merge
was missing from $(git --exec_path)/mergetools.

I just put the version from the official repo there and everything works.

Thanks again for your help

Kind regards
Lars

On Fri, Apr 24, 2020 at 9:25 AM Lars Fricke <lars.fricke@gmail.com> wrote:
>
> Setting path explicitly does not help either. Some other colleagues
> are having the same problem.
> So it might be related to our OS (SLES 12 SP4)
>
> Thanks for your help so far. As you said - the issue seems to be on our e=
nd.
> I am currently digging through git-mergetool--lib.sh to find out why
> it thinks that p4merge is not a valid tool.
>
> Thanks again for your help
> Lars
>
> On Fri, Apr 24, 2020 at 9:20 AM Carlo Marcelo Arenas Bel=C3=B3n
> <carenas@gmail.com> wrote:
> >
> > On Fri, Apr 24, 2020 at 08:57:27AM +0200, Lars Fricke wrote:
> > >
> > > git mergetool --tool-help indeed does NOT list p4merge.
> >
> > but does show if you run :
> >
> >   $ PATH=3D$PATH:/opt/perforce/bin
> >
> > > So support was discontinued?
> >
> > no; something else might be broken (hopefully only in your setup)
> > it seems to work at least on mine :
> >
> >   $ git version
> >   git version 2.26.2.266.ge870325ee8
> >   $ git config --list | grep p4
> >   merge.tool=3Dp4merge
> >
> > Carlo
