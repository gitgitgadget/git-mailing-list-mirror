Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB05C2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530B62255F
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgLORzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLORz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:55:28 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E96C0617A6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:54:48 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id x20so22107389lfe.12
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fxH1Oc7Gfh0q995JfXng5AbDuxxbh2GAgs5mkqHI8Iw=;
        b=VWXSJwx7OqoLplJpTrmrW5KnpTv8rz5AZOX8VOiVZBK0WzTdQ7N2lyH+HLmmP720OC
         9kAPjyxq95WERSa2dXg8MrtDRVGbiRCxEmE20qHGG4y4t2kBOGQ8wGr8BF+gTTYJBtiS
         jlQMAk2Y79muTZicLjlvUBCVv1m+N7b9cjeT5Gc8kYrCkFpUfPNT537n3Zw0ByJRX/1s
         ISUdxH7GaqVEOK4V/VOzKJXGqfabRorHRM53htn8V5pPwj++GkPLg7APaNGndy+RPzSb
         z43/XFVFfrm2vyW4aqLHOkZE0LOQSzLCrFgT5UqQ2xx/nZq5Csa3ZpOrN7+USDJR7Pro
         FksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fxH1Oc7Gfh0q995JfXng5AbDuxxbh2GAgs5mkqHI8Iw=;
        b=XDFcGU+pggZdOaSzf2Isv+MxP53kjdAd5taNaWglYKQkgDI9GW9oHgy/dt98NtBseC
         7k8872MnJsZHcGhH9iO3MKqOb12DNaV/WyAtfjJzyyhZpg3eNlLz8lm0HbnIChvTBS1w
         5lRzEM1nOp76Io6aw58ZeVQ9vMuyQYVSFbCwzznI/HW6E7L46KLnvH/vTs7IsTZqiUE2
         ibCmwgVuT2EoA3q9NgO18210W1y5h5sy6JDT9JY3NdGNS9eULOZAEr+nGC8dnxXBkVvj
         ph/nNZuEXejKkt/25HEHScU/l+ogMv0VDuW9IIGqnsRJGzxi5e/luxy4yzup1juMKGPe
         gxNg==
X-Gm-Message-State: AOAM532RSkV8d7PNldJ2HsJU94xavveGjVQiy4u5lqPjkSvMIYhAFNMM
        JwHaKfCmwREBfWp4FCg2+G21Sg+bykKRZWFiieyQBg==
X-Google-Smtp-Source: ABdhPJzvcmwmDaFObsVDW9FYS/vug0CwKnpnms5fSGJf8GWFE2IfyMKhxCetCv5v3vOij5zCsXYZfMNpsJRhOqekwuM=
X-Received: by 2002:a19:cc05:: with SMTP id c5mr11523385lfg.393.1608054886835;
 Tue, 15 Dec 2020 09:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20201210143017.24615-1-congdanhqx@gmail.com> <xmqq4kkoat8v.fsf@gitster.c.googlers.com>
 <X9j0pf1lQQHZifvw@danh.dev>
In-Reply-To: <X9j0pf1lQQHZifvw@danh.dev>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Tue, 15 Dec 2020 09:54:36 -0800
Message-ID: <CABvFv3JjipUqchLAhyvMax=s4z3VhPyKvSAPqtbj3W4pNOmzvg@mail.gmail.com>
Subject: Re: [PATCH] doc: mention Python 3.x supports
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 9:38 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writ=
es:
> >
> > > Commit 0b4396f068, (git-p4: make python2.7 the oldest supported versi=
on,
> > > 2019-12-13) pointed out that git-p4 uses Python 2.7-or-later features
> > > in the code.
> > >
> > > In addition, git-p4 gained enough support for Python 3 from
> > > 6cec21a82f, (git-p4: encode/decode communication with p4 for
> > > python3, 2019-12-13).
> >
> > I am not a Perforce user, so with that in mind, please help me make
> > sure I understand the situation well.  The statement "not 3.x, which
> > is not supported by Perforce" is from early 2013, and 6cec21a82f
> > talks about the format of marshalled dict object that comes out of
> > p4 (Perforce) tool that needs to be read in a certain way to be
> > compatible with Python3.  Does that mean sometime in these 6 years,
> > Perforce started supporting 3.x?
>
> AFAIK, p4 is an executable binary (in the sense of ELF binaries) from
> forever. And its {in,out}put is in arbitrary encoding, while Python 3
> expects UCS-2 or UCS-4 encoding. 6cec21a82f adds code to decode to
> Python 3 string to overcome this limitation.

Caveat: I am relying on memory here. I haven't looked at this code
since my last round of PRs...

Yes, git-p4 use the p4 executable, and not an integration library. p4
has a "serialize for Python" mode which outputs in a python2.7 pickled
format, which is still supported by python3, and this is what is used
to receive data from the app.


> Not related, but Perforce's official Python bindings supports Python 3
> from at least 2013 [p4r13]. And they still maintain in [PyPI].
> That binding requires compiling with Python Development files, though.

Compilation from source is only required on the latest version of
python3. p4python has wheels on PyPI, but it's consistently a minor
version behind. At the moment wheels for 3.8 exist for all major
platforms, but not 3.9.

> > The change to INSTALL just drops the mention of 3.x; do we want to
> > specifically say that any version of 3.x is OK, or is it generally
> > accepted that Python 3.x is "later" than "Python 2.7"?

Any 3.x is OK, as long as we are staying with interfacing with the p4
executable directly.

--=20
Yang
