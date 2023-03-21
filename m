Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F160FC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 22:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCUWSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 18:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCUWSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 18:18:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58867683
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:18:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x198so9335693ybe.9
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679437087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un3Zm5ERI+YxM/55dgwYcUDXLBkwTy2K40fHMfeyspc=;
        b=SZl5tSuHD+qxLcjSp/VUQgn+S/JTTWMPCEY4yM3APE/yu6xmTVYS0sT3+gwG7rKKmm
         JGSytNc6skZb1WbD5OOwJgXyYamMiRclggqoVfeV/j3ufrqtEg2svLX9P5IVhH5zPJMM
         Lz9DSLlxxAhwGRjQI4fdOdI3yqT4m9zxQhX3xJD7kTMxJN4C4s/dKbxRnhhOaSJt+98p
         WIJAiYAWp9QRuJ6BX76zdsG0JX/9fyqmXnWTp8860K0ajyafPZFUTTV+d4WHZQXZ2jjm
         9DK8dCqvND6VgtTzomJtmmvypy2puHXSOZcyNJWRbf57M0pxF60Pbmd2hZ9GocxN+Xhe
         lHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679437087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=un3Zm5ERI+YxM/55dgwYcUDXLBkwTy2K40fHMfeyspc=;
        b=Jc4KXIezksGayEBE8HhtlyHMLjEAFbaqylRrLIyNupr8+2stT2nzDk8Eir7YSsjS+0
         9tS/Og3iYMmCHWYHNx0Nx3rjr6GB2QAboN+IGqAGKR8ubruGcb+22qxEHbkKVAt3f56u
         zcU86WGrkV54ZUZeZOenbt1tfh/FSg2tWTLgd+BnmHaqY50DtZ9HDq18AAvwPkm+5Ttq
         tScVvW6f5qoBWfXPw+gSMYJwVS/f5mJs3zr4QFiCd0J7/70aqEp4MIpmxn5aKHImf1DU
         uXR4QgFkfDMU2YeGqs3/h9/jkwwd/98mAmjx1S6Egv1Sxqfmd8X6AjQRSLA1C1nyremj
         6b/g==
X-Gm-Message-State: AAQBX9c/ghzN6hziRAdFoscr1TH7cQtQg4RFojRps8E8jWE2/Qi0rCIb
        +BVPyeDJQuerkldZ5MvwvlH2WEKN3BdyC2i9l+8=
X-Google-Smtp-Source: AKy350bDlmopzthIi/GGRy/5bwYIgsvWtuX6pCc3mtxEJJxVn+c6Zxx84+nXvRvnpLTJPjX7MBNXRh4XD5vrzUQqrKk=
X-Received: by 2002:a05:6902:92:b0:b69:fab9:de60 with SMTP id
 h18-20020a056902009200b00b69fab9de60mr2700019ybs.0.1679437086879; Tue, 21 Mar
 2023 15:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230320190047.79836-1-felipe.contreras@gmail.com>
 <20230321173206.GC3119834@coredump.intra.peff.net> <xmqqcz52hu7n.fsf@gitster.g>
 <20230321181702.GI3119834@coredump.intra.peff.net> <ZBoqpba+z+/lsTZC@pobox.com>
In-Reply-To: <ZBoqpba+z+/lsTZC@pobox.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 21 Mar 2023 16:17:55 -0600
Message-ID: <CAMP44s38Hnhb-FjAYBQtHVRBcW7wDhd6ah3veemGSw+XdeamaA@mail.gmail.com>
Subject: Re: [PATCH] doc: remove GNU troff workaround
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 4:07=E2=80=AFPM Todd Zullinger <tmz@pobox.com> wrot=
e:
>
> Jeff King wrote:
> > I could believe that some people are still stuck on 2016-era versions o=
f
> > dependencies, but yeah, I agree we can be a little more cavalier with
> > documentation. Anyway, I think the right date really is 2010, as above.
>
> I tested this on with CentOS 7 ( docbook-style-xsl-1.78.1).
>
> I didn't notice any bogus curly quotes in the output.  So
> even one of the older OS releases we tend to support
> shouldn't be affected by this change.
>
> Happy to see the cruft removed. :)

For the record, you can check that the fix is there by opening any of
the manpages:

    .\" http://bugs.debian.org/507673
    .\" http://lists.gnu.org/archive/html/groff/2009-02/msg00013.html
    .\" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    .ie \n(.g .ds Aq \(aq
    .el       .ds Aq '

--=20
Felipe Contreras
