Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A81C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4646145B
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhENMT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhENMT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:19:56 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A262EC06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:18:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s19so2201963oic.7
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mW/3D7chLvKoTFzG6DUKWradBN1RNxcqD2ViXLvhE3c=;
        b=SBQjS163cOCrL+5Pet9itwAMlSBIVUKYcRwmhkT9l0Q1zU+YIL9iRCVtxw4TyGFQ7+
         rVMaQdQD1kz0QaFMuuYMzh/oOEjxsoXsACGLnLpoLzT8W+1a0by41uQP3ixBUUS8t5Gm
         HK57aQoDgmek9hHj0zlRR9igIkFLTFfOIbu+v/152p/vMWLZbU9QeD2CylQeU9SMqJPo
         Sq+Urb/PrfvA2X0obKfxaAqFuiedO8b5HlmYvWJdA8Xb4ZzM8ueANT8j/Cbkp48AeL9m
         QVZND6UOzIhuoyEj1kZ+EUtx40quiq38H+w2AN0GXWgk4/BEygMrKQgOKA9dscObLPvy
         RgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mW/3D7chLvKoTFzG6DUKWradBN1RNxcqD2ViXLvhE3c=;
        b=fBuZz71ybsvxVgjla+lyI6Wle975qvwsDZm7q+Hv5bGg/uSY9T2Ny1TIfxELgwLpMB
         OOmif/c5KWarHJF0gzz0C2iad6Ru1vFyaOYjQoikiZRoQaZdwGeuNL6VnDlCU8UfUlsI
         BmWxFbYYnYK/5zQeAiTR7HIIvCBpjarQYjipLUE3Cfpvi5kV/1iuUgXVtFh+7+HDz2bd
         ddCI+dbGWsz202xXfSbqdYYpEq6KLpvi4behiHPm7hk29x/85YS7d/526aFp245ONUjH
         XPfhxuMKEpJSNRKGqWSypx2HBNScbJWUiIRJjfDR7ENZxnh6AvGwyWm5UdZ6j++WBW0F
         bDPw==
X-Gm-Message-State: AOAM532vxMZ7ndTF5JdZJ9pKAOLrlNTxig+bhiAMr2LkRo3Q0Vqn6hfZ
        KyT1nMqOlQ30EVtml7lgDjo=
X-Google-Smtp-Source: ABdhPJxYjuueQ66GUEbKxmp31nPVbeUVK0rUzE4q7banlXrLIsS4qxXvC8w9cp2ZKfHbsatTlVb7+Q==
X-Received: by 2002:a05:6808:484:: with SMTP id z4mr21095306oid.64.1620994724108;
        Fri, 14 May 2021 05:18:44 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m189sm1130018oif.45.2021.05.14.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:18:43 -0700 (PDT)
Date:   Fri, 14 May 2021 07:18:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <609e6aa287cc9_4312720893@natae.notmuch>
In-Reply-To: <CAN0heSrzkexY9K=VD=y0h9D0pVh59BjaLLg0pEo-WxsP+s0juA@mail.gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
 <xmqqsg2q9xts.fsf@gitster.g>
 <CAN0heSrzkexY9K=VD=y0h9D0pVh59BjaLLg0pEo-WxsP+s0juA@mail.gmail.com>
Subject: Re: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Thu, 13 May 2021 at 22:35, Junio C Hamano <gitster@pobox.com> wrote:=

> >
> > Martin =C3=85gren <martin.agren@gmail.com> writes:
> >
> > > Some of these rephrase wording such as "other peoples' commits" to =
avoid
> > > that apostrophe at the end of a word. I'm hoping those rephrasings =
don't
> > > regress the quality of the text -- if they do, I'll be happy to try=

> > > something else.
> >
> > It is sad, but we really should try "something else", unfortunately.
> >
> > I do agree with the "motive" very much---even though condensing it
> > down to plain text before running comparison already loses too much
> > information, doc-diff is the only tool we currently have to
> > effectively review regressions in rendered document, and the
> > proposed transition cannot be done safely with confidence without
> > being able to vet the differences.  I am happy to hear about 17%
> > reduction already, but the requirement to rewrite things like "other
> > peoples' commits" is a dealbreaker.
> =

> OK, calling it a dealbreaker is fair. Thanks.

If I understood correctly the deal-breaker is as a long-term solution.

These particular patches may be welcome right now to reduce the
doc-diff, but eventually these issues should be fixed in asciidoctor.

> > A typesettig rule like "instead of double-dashes --, use {litdd}" is
> > an acceptable way out.  At least that wouldn't constrain what the
> > final product that gets delivered to the end-users can say.
> =

> I've done some experimenting now with a new attribute "apos" which
> expands to a lone SQ. It seems to work fine across the different tools.=

> The rule could be that all ' should be {apos}. That's a quite
> aggressive rule in a sense. It could be narrowed down to something like=

> "... if the paragraph contains other quotation, such as backticks or
> single quotes", but that's probably just overly complicating things.

I would rather fix it in asciidoctor (the ones that are actually
asciidoctor issues)

-- =

Felipe Contreras=
