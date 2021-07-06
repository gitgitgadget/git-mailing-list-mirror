Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A71C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2006199C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhGFW2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFW2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 18:28:15 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB094C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 15:25:35 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q23so1050581oiw.11
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 15:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XcypSehQ9ts8THxAa+1CK91zRWJ0b43V/S7wlPQCQjI=;
        b=YYwsaIaFB9/2FNxqmJ0tLrh5G5vANJb/fqKrBTTRavdzn29VTDK6RJEstOJbDYwX0K
         YA7yL+mZ0uZ7HB/RxYnmxXxY2COZEFp/PNQOzrjtKsmSMQ7E/r3mDiuWg4a2rPSML5CA
         ophWFrN0a7X06G9EEUSax3Epn7KM4OTwtvQDAat8bIzXTuujh0zA5sQYANBa4XSb7Jow
         AhVcffROOSuiSlCT8MUqPHmt8azddSXDEDhxYcp355NDVgfWGaHehSIb3l5CnGEvv86L
         xh/sXiOqzjV9jj6u6MLjujPeZx6nKAfHQcpZNAET2fXz4GjAlnVi5CwBZtpoZE6w58NV
         4t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XcypSehQ9ts8THxAa+1CK91zRWJ0b43V/S7wlPQCQjI=;
        b=Et3miiRckVcOtu1yufD6Z88+3R87BvZtMTS5lyU0FkThezYtVgsdd2KvJlnX/Wyj50
         aiJ+Vva09dr7LOvrWE0TueU+mkoDsbMMiZK08Xu/9DKkhgCb+vMcNdn7KU/RgT8nwtle
         fYbnRLd7mZTRmsIlSFrmMq3Rx4+ZvfRK3WydPfzlyRhoEbfjPn2oWXu4Cju0kxqkqdfE
         WNbOxJTozKpSEKYCuedaEcGdi9fHS0t0Q5WMDIPqpH1mHYrL5rKdvm78ir2iWbvK2byO
         qzH3G7acTTMs2bqyZEikHVgNTGrt7YMPN/SBb5a/SfrzIktrYZtN3rg+ooJNFhil/HQx
         NhIw==
X-Gm-Message-State: AOAM533SMUkMvgKoYCRwaYe6kwUMS4SnIaBWvhSPCacb0Y/3wPpwk0Ch
        rCIrmFcXkrTSKv5EEnK1gFI=
X-Google-Smtp-Source: ABdhPJzeT4RLg+bIUWvSSIOT5HMd51lXyfhXXkvdyD/UBKBDLz9BGiA61qO5dGq/VCujxaMT7/RfGg==
X-Received: by 2002:aca:b682:: with SMTP id g124mr16040706oif.138.1625610335292;
        Tue, 06 Jul 2021 15:25:35 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id j194sm1478393oih.43.2021.07.06.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 15:25:34 -0700 (PDT)
Date:   Tue, 06 Jul 2021 17:25:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w5h5c3RlaW4gV2FsbGU=?= <oystwa@gmail.com>
Message-ID: <60e4d85d94e80_1c42812084a@natae.notmuch>
In-Reply-To: <xmqqh7h8mtzh.fsf@gitster.g>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
 <60dfb7d11cac3_3dd220811@natae.notmuch>
 <87mtr38tvd.fsf@evledraar.gmail.com>
 <xmqqh7h8mtzh.fsf@gitster.g>
Subject: Re: [PATCH] Documentation/Makefile: don't re-build on 'git version'
 changes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I am OK with the approach you hinted to have an option to _hide_ the
> version string in the generated documentation (hence they lose their
> dependency on GIT-VERSION-FILE), while keeping the dependency of
> version.o on GIT-VERSION-FILE, so that something goes wrong in a
> built binary, the developer can still ask "git version" to identify
> where the binary came from.

But it would be even better if the build system knew what was the intent
of the build.

There's a difference when building a revision just to run `make test` on
it, and building it to do `make install`. In the former there's no need
for a real version in version.o, only in the latter.

Maybe RELASE=3D1. Not a release from the point of view of a maintainer,
but a release in the sense that the binaries will escape our in-tree
build.

-- =

Felipe Contreras=
