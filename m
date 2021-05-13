Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF88C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF54861354
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhEMWia (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 18:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhEMWi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 18:38:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86EC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 15:37:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s19so707744oic.7
        for <git@vger.kernel.org>; Thu, 13 May 2021 15:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fKKy/jdf7f/UIMbjKYvEQXJySK8Q6a9SiGEuS15qRNs=;
        b=EsryxyOAvHIBC9xQK0xktA//sUC+Hf7yMNv4/l6ric/Q4novfk7IbseweKktH41VmA
         Iu5rwKxLvEPUZE4WvZaJ+B6SHFn8PlUetCRfpCVsF/drnYHd/Od94Ep9NVW/qb9mZ2oj
         DfCDuO32l0hTN9zg6ufi/MldJN3AtkXBg4ufIGYFvUEtGtses0pbr9HxrHYyXya7jRiM
         woY1V05o5wZ4xYQj3yZI96c8wh4nFaQZLShzcjc6wr6JCHrTOtGqotDCQID/8NC1UZYb
         334qQFBj8ZHkVmSsmEomjMCtJPyn2xAw4rvigvlfnHFxiEYZ8wh3dBZMHH38fTADqPNK
         WLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fKKy/jdf7f/UIMbjKYvEQXJySK8Q6a9SiGEuS15qRNs=;
        b=mjkkzwXThqsM+xZnGWVgOhvLe5LGS8E4ycQbmURGKsLB53G9pL0/xYQk2F9EnP6MHO
         sq33tVwqBfSyAwuf0tLNO5PJRS0+up3jcPP3pSXuKIx6jo+WPzel4aB6Wd6j5raP/FK0
         46BnBARbJgrfADzE+RcmycvPRfUysrnih853oq3TMO0rQmEZhmiShDur5fc27+NQcug5
         kUwazkV9AJw/BcKJGsJo5VUTHURUPs7XSFhVal9JGzFPst6v7U+cjg0Bc33xMFDu6O0b
         ivawbtP4lO1CPaLP3DNR0pZ6c0a3QrUuYaxoaCh5OUHOqIOT7+c/le5i2ibAoEcBC5/h
         pVww==
X-Gm-Message-State: AOAM530i2BYyLRdJW9IZk3NuGIDvm87k4YLQdTH1KKRjxxZ/B7cp6VNO
        xkjm6FyyjtiDAw5b+c2awy4=
X-Google-Smtp-Source: ABdhPJzGKM6mXuksaRW5kEniHs0Ouec2WnXGVYIVT+lAFwoEBBz68323CSgIGft0YJnUp6hSLhj8pQ==
X-Received: by 2002:aca:ac09:: with SMTP id v9mr4568330oie.88.1620945436899;
        Thu, 13 May 2021 15:37:16 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x141sm871907oif.13.2021.05.13.15.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 15:37:16 -0700 (PDT)
Date:   Thu, 13 May 2021 17:37:15 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <609daa1b108f3_42a0208de@natae.notmuch>
In-Reply-To: <CAN0heSqxFdiwF=--DaBFMqmvjMDY__hvs+u0vfc=GG1jcqZwoQ@mail.gmail.com>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net>
 <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
 <YJt81neO7zsGz2ah@coredump.intra.peff.net>
 <CAN0heSqxFdiwF=--DaBFMqmvjMDY__hvs+u0vfc=GG1jcqZwoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Wed, 12 May 2021 at 08:59, Jeff King <peff@peff.net> wrote:
> =

> > We seem to have a problem with some escape codes. E.g.:
> >
> >   -           of nothing). The other file, git-add--interactive.perl,=
 has 403
> >   -           lines added and 35 lines deleted if you commit what is =
in the
> >   -           index, but working tree file has further modifications =
(one
> >   +           of nothing). The other file, git-add&#x2d;&#x2d;interac=
tive.perl,
> >   +           has 403 lines added and 35 lines deleted if you commit =
what is in
> >   +           the index, but working tree file has further modificati=
ons (one
> >
> > and:
> >
> >   -           Added content is represented by lines beginning with "+=
". You can
> >   -           prevent staging any addition lines by deleting them.
> >   +           Added content is represented by lines beginning with "&=
#43;". You
> >   +           can prevent staging any addition lines by deleting them=
.
> >
> > which is a pretty bad regression.
> =

> ASCIIDOC_EXTRA +=3D -aplus=3D'+'
> ASCIIDOC_EXTRA +=3D -alitdd=3D'\--'
> =

> seems to have done the trick for me at one point, but Todd had some
> concerns [1] that it interacted badly with the html build, so we might
> need to use a less aggressive choice of makefile variable to only affec=
t
> the direct manpage generation.

I don't see a point of complicating the Makefile more if we are already
passing `-r ourstuff.rb`.

One advantage of Ruby is that everything can be overriden, so we can
override the initialization of the Document object:

  module Asciidoctor
    class Document
      alias old_initialize initialize
      def initialize(data =3D nil, options =3D {})
        attributes =3D options[:attributes]
        case attributes['backend']
        when 'manpage'
          attributes['litdd'] =3D '\--'
          attributes['plus'] =3D '+'
        when 'xhtml5'
          attributes['litdd'] =3D '&#x2d;&#x2d;'
        end
        old_initialize(data, options)
      end
    end
  end

This does the trick for me for both backends, and it simplifies the
Makefile.

However, it's a hack for what seems to be a bug in asciidoctor. I'll
report the issue.

Cheers.

-- =

Felipe Contreras=
