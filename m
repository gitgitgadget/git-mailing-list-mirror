Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1FC433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 13:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4C061421
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhDVNBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 09:01:49 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3142C06138B
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 06:01:13 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 66so22821893vsk.9
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 06:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CyTr5NCVufAwdkcihuNwcectBj9wfNTu/RNThBYh4w0=;
        b=T3uaDYL+g9psxxi+8M4gxZwRdUqg638P6mvdsKejGqo9U+MRifNluZuCs6iMQNoj+p
         PsO0mAwE1pj6l8WuWCwpzJ2c7XD+QFuINiYnRCQLKtBq6tLANzKelGcIGDsTp8DAQkj0
         es57wdrdKrOg+cEzhHPGTtyBDooKUb+Tx61N59EcN1I93xs8fyySaunyq5OjBkZoMhMB
         8BmNWIJJ8N1W36CeOC1H++4B4HLIqaLanXDwZhOSUvPXyM/E6DiDI/ndnyXwtVUoGIkZ
         4e0lIy7KQJsJxKbUoVXGdNTvc4OlINjqkM368WijfHS109jwCPrQmWhOwTguS2V8UUY2
         ErTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CyTr5NCVufAwdkcihuNwcectBj9wfNTu/RNThBYh4w0=;
        b=q4pUZX5GLZWHMY1CKj0Wek4abW8Mav057Fhd1oeaq+afq9WdyTaf5sVTQgIJpjmZi/
         GD+q9tjYxMNKLSI00HbGCLsYXJ/aoQnjrb08VcbmeTwuxLENxy8PKIF3j/xxjZTuSEMQ
         sYi0jpl49ABr5B2x55t+h3T3Y4iZ3QngI5MHLluc3MzZb3FQTgPDZzS6lOPfXH+CFgfV
         F5cdJ4w9sPmFSB2tXG+zp2JNb1gb26PnnI7keHh4e4yUresN6wP96B+Z7Yjlei4PbeDN
         j6Z1xTBMHni/e02om3dPJ2dftc+UGN5YJktxYPqRJYbw3YPyc6CXf8A8Ho4oyZv9Qd79
         fByA==
X-Gm-Message-State: AOAM531iW+DgGUJSHPubG1aglXSxQldw9XOH/UivnJXhGwAYlLHq+wo5
        1XI3AlP5yrx9suNQHp4GrxHJk1SHTnl1rz30JoOpvw==
X-Google-Smtp-Source: ABdhPJwFcQM8oPH36xUEqrrogWXrlnNMw1VhV10UFGPS9qIEXK7QNVc3xIHd2ax+4yB4EkwAQC6e4qKNRcMRYcmzjcU=
X-Received: by 2002:a67:eb45:: with SMTP id x5mr2559812vso.28.1619096472869;
 Thu, 22 Apr 2021 06:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <871rb45ftz.fsf@evledraar.gmail.com> <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
 <20210422045953.GC2947267@szeder.dev>
In-Reply-To: <20210422045953.GC2947267@szeder.dev>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 22 Apr 2021 15:01:01 +0200
Message-ID: <CAFQ2z_Md=LAkJzohf3E5ogWGQHzxN_ik=yHAGmxm7bg-yT6-Zw@mail.gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 22, 2021 at 6:59 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> > See the comment above the changed line: we don't want auto-detection
> > to clobber the surrounding git repo.
>
> Indeed, but then this is not a faithful conversion of the original.
> That 'echo' will write sane content to HEAD no matter what state the
> repository is in.  That 'symbolic-ref' command, however, won't,
> because 'git --git-dir .git' turns off only repository discovery, but
> not repository verification, and in case of a corrupt '.git/HEAD' it
> will bail out.
>
>   $ cd test
>   $ git init
>   Initialized empty Git repository in /home/szeder/src/git/test/.git/
>   $ git commit --allow-empty -m initial
>   [master (root-commit) ec0df0b] initial
>   $ echo "foo bar baz" >.git/HEAD
>   $ git --git-dir .git symbolic-ref HEAD refs/heads/master
>   fatal: not a git repository: '.git'

But then it's working as intended, no? It will not corrupt the
surrounding repository.

I see it as the test writer's job to clean up to the extent that
git-symbolic-ref can reset to a sane state.

We could reset back to a known state in a more drastic manner
(extracting .git from a tar archive), but that could interfere with
the test functions if they're not isolated from each other.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
