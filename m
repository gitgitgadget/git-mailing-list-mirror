Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548FFC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2740E20722
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="0OyotRij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCXXBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:01:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44440 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgCXXBr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 19:01:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id j188so201293lfj.11
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/PxZhozAW7JtXzW71x0Ds2FxgOQy1co/acqGZogXqg=;
        b=0OyotRij0cAd7BfNpiOglq5jMyTJSs4SADErl4COUeMtCRssTDL61tYTJwS4WKWAYx
         /AU1nxw65xzY8U14qimtFKGkvvEBuZ51JQjE7Q8RGgK/tS4BqIqk48fzc6YHcfm0PqI9
         8kwVguFBIwYN3imUi3gNN4hSUIfSmaXGYKrJ0cXYS6VULXp74k0zkA2DWfGxKYOx9iC/
         Folpezszx8TeEZeY9z8aAOSqaZb38TMYj6Vn/arweDiB1gdEKnD/BfzftWPo4KffzgqI
         +5ct7Ain2r7Z5g0Vg3saACYalLhRKxAeaMh3H3Sh1Uh8HL4hpNyv815AucvQfpxL7pDa
         IazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/PxZhozAW7JtXzW71x0Ds2FxgOQy1co/acqGZogXqg=;
        b=An45mfz6Pr6y5rIPaGjH6F1YVHcN2vGICsyCRubGhxfJUUoQM80NGKrHpZht3g4TZl
         65giUmX3r3Um5Dk+2gimQZSb3DbG7DFjXL2yCGH8c0Z053j2FG+F1HtJiYuhESQXNrIk
         9j1vaALSzOJiC3F9df7JtFmjlby+ctuPwIIz9jrCBQEuerPncDvnYIHtAMspqdk0bz5x
         Jpvp0QN1PoXSpvGQjKyvH/dIb00Za2Zs4P5pJYOxm9yPsGfWn9zfTu0F4srF8aSv2H9f
         yG9WTINWtD/UUlM2gwgtEs+vALN9hlzGXivbHMeyzvESnlptJ1KbXVe/QzlBRiyzZk0O
         enbw==
X-Gm-Message-State: ANhLgQ3j4/r6w+n1oOiovJhK16tUJTHYGFbAzhMx61G55Su46nGphSZK
        CkcyJ+8l+KPEK6iYZZlbT6jEroWo+Gg1iuv9ulm8yQ==
X-Google-Smtp-Source: ADFU+vun51WB8SZU1Wu74DzUiMXWgaeMttHoet80KCQRDmweX2ufObIpTkxiqAtPFOmtx30PNhFRXgmqHZAeF7zTs2E=
X-Received: by 2002:a19:ccd3:: with SMTP id c202mr235947lfg.103.1585090904653;
 Tue, 24 Mar 2020 16:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com> <59c04216-8dd9-cbbf-a869-a65ed8ca6e0a@gmail.com>
In-Reply-To: <59c04216-8dd9-cbbf-a869-a65ed8ca6e0a@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 24 Mar 2020 20:01:33 -0300
Message-ID: <CAHd-oW603gAPcVhJG8+wirFy1uOEc6vjWYaph+dRPk63up=DMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 12:12 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/24/2020 3:15 AM, Elijah Newren wrote:
> >
> > On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> >>
> >> Also, if I understand correctly, the index doesn't hold paths to dirs,
> >> right? So even if a complete dir is excluded from sparse checkout, we
> >> still have to check all its subentries, only to discover that they
> >> should all be skipped from the search. However, if we were to check
> >> against the sparsity patterns directly (e.g. with the function above),
> >> we could skip such directories together with all their entries.
>
> When in cone mode, we can check if a directory is one of these three
> modes:
>
> 1. Completely contained in the cone (recursive match)
> 2. Completely outside the cone
> 3. Neither. Keep matching subdirectories. (parent match)
>
> The clear_ce_flags() code in dir.c includes the matching algorithms
> for this. Hopefully you can re-use a lot of it. You may need to extract
> some methods to use them from the grep code.

Thanks for the pointer! I will take a look at the code in dir.c.

> >> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> >> new file mode 100755
> >> index 0000000000..fccf44e829
...
> >> +       cat >.git/info/sparse-checkout <<-EOF &&
> >> +       /*
> >> +       !/b
> >> +       !/dir
> >> +       EOF
> >> +       git sparse-checkout init &&
> >
> > Using `git sparse-checkout init` but then manually writing to
> > .git/info/sparse-checkout?  Seems like it'd make more sense to use
> > `git sparse-checkout set` than writing the patterns directly yourself.
> > Also, would prefer to have the examples use cone mode (even if you
> > have to add subdirectories), as it makes the testcase a bit easier to
> > read and more performant, though neither is a big deal.
>
> I agree that we should use the builtin so your test script is less
> brittle to potential back-end changes to sparse-checkout (none planned).

Makes sense!

> I do recommend having at least one test with non-cone mode patterns,
> especially if you are checking the pattern-matching yourself instead of
> relying on the index.

OK, I will leave at least one test with non-cone patterns then. Thanks
for the comments!
