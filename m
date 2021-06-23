Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33691C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 20:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C3A611AD
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 20:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWUfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWUfK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 16:35:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CDEC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 13:32:51 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so3282802otl.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZX6lnZ3XMDVRogDLkfgGGdcBEX6yfR9opFGLU1//I2s=;
        b=VuNzJXDjx1UmPX5Q0lSJadB5oGLOP0CaCymA1Yv1f2f7DfvfUMVR4tDFSne7wTIobo
         +YPIrBXZNaU3e0iZhJsBVmZwkDlSS297LxWoQDMODRa9YYSBO6TF7PUCZEOVkb53LCwq
         B/XbbtfKCkDQSS5dxUde85k3TLD8y81ME3pVrf7t2pWbwt+xWdbIqOwQQux00eZwEShe
         cN1dW2DdCYQYnUSbFBEPuJNI1ClaEEmOLXgwF7wPx6IotEJv1kUQjsg/Trb0ZOVA7T/a
         YNtanUw3TgTrxNoBAdGdOpe+gWZmx2ebfCmGYUKRRvvfNta4fPymJC2f+xgLuD6j96QE
         Z1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZX6lnZ3XMDVRogDLkfgGGdcBEX6yfR9opFGLU1//I2s=;
        b=ZUkRRLEJdjVHP0i9niNj5e7CU948IqwjeLbSQGpgTXaGAfAZnmV8aJ27iwKuKJvQ52
         MAkWN56OavXdYlVTXvJ7js1uF8oTIzGZKZcVaPN+5GHsNmqkxSYhaDehH/43E3274TaV
         79yhWUWvo35sRedkKrv9LHRPemF06X3YJtiyRjipv+ECZLdo23m/36B9wVbSdk4Co1cn
         bWl0WTmqyytsvnU9snXXD4apUi8A/JOlpt+eTLwEfZGPkKMXZMuZQDUyVgv7AqThY94g
         s2jl2O77a25Sa9omRQ2OPfpMIonxzH00/okp0nEbE+UJbogy0BiAWtXPXa50mk7wXUKw
         JiyQ==
X-Gm-Message-State: AOAM532iPuYZZESU4Dr7sKUOBcRD25w7FrU8giycCRmQOapPlSsNlCkF
        9JJQt2aVon5Abt6p+RsLSPg=
X-Google-Smtp-Source: ABdhPJxalaqQcv2tzR54aR8mcblm0uie7yuslXLkun0HN4J9XM1QV7UnTXOVDre9Wnj4nzNdVR2ofg==
X-Received: by 2002:a9d:2202:: with SMTP id o2mr1550386ota.24.1624480370921;
        Wed, 23 Jun 2021 13:32:50 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w200sm194535oie.10.2021.06.23.13.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:32:50 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:32:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Message-ID: <60d39a71299ef_429020815@natae.notmuch>
In-Reply-To: <87tulo1hs4.fsf@evledraar.gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <60d384ecd5ad3_4290208c@natae.notmuch>
 <87tulo1hs4.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Wed, Jun 23 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> As in db10fc6c09f this allows us to remove patterns of removing
> >> leftover $@ files at the start of rules, since previous failing runs=

> >> of the Makefile won't have left those littered around anymore.
> >> =

> >> I'm not as confident that we should be replacing the "mv $@+ $@"
> >> pattern entirely, since that means that external programs or one of
> >> our other Makefiles might race and get partial content.
> >
> > The reason I did it in db10fc6c09 is because both asciidoctor and
> > asciidoc should deal with temporary files by themselves (like gcc). I=
f
> > you interrupt the build nothing gets generated.
> =

> If you interrupt the build default make behavior without
> .DELETE_ON_ERROR kicks in.

Generally yes, but it's possible the program traps the interrupt signal,
in which case make never receives it.

> My gcc 8.3.0 just does an unlink()/openat(..., O_RDWR|O_CREAT|O_TRUNC)
> dance followed by chmod() when I do e.g.:
> =

>     gcc -o main main.c
> =

> So no in-place atomic renaming, does yours do something different?

It doesn't rename the file, but if interrupted the file is unlinked.

> > However, other scripts like build-docdep.perl would indeed generate
> > partial output.
> >
> > In my opinion it's the scripts themselves that should be fixed, and n=
ot
> > the Makefile, *if* we care about this at all.
> =

> I don't think default tool/make/*nix semantics are broken, I just think=

> it's neat to do that rename dance yourself, it's a cheap way to
> guarantee that we always have working tools for use by other concurrent=

> scripts.

It is cheap in the sense that it doesn't cost the computer much, but it
makes the code less maintenable and harder to read.

To me it's a layering violation. If the tool is already dealing with
interrupted builds, and on top of that make is doing the same, not only
for interrupted builds but also failures, then it makes little sense to
add even more safeties on top of that in the Makefile.

If this was really an important feature, it should be part of make
itself, or ninja, or whatever.

IMO the whole point of DELETE_ON_ERROR is to avoid everyone doing the
exact same dance in their Makefiles.

Cheers.

-- =

Felipe Contreras=
