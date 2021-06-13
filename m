Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E3C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 14:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0617861040
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 14:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhFMOIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhFMOIo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 10:08:44 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1FC061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 07:06:43 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r16so11190303oiw.3
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=H8pVIbJ82BDdXKd+ykiTyQAjqKnLRfnSBf+3SbkWLV0=;
        b=UXV45TYx8fjAwu07D4t2OqNwSKvj5cHul1eJWCv0x67xHVi06cH3NuDrout/6rcgM0
         XyAjzczs9D8a+3rn3GfFb8P4lqMc9nq2dIEf9Xv1lvDr6M20KNi5sy19/XbzcFjtCaQz
         rEun9+uwpwSYSkETAyBm0cP5v0yFfQlf9T048O3bwRzl/LqVQrSnQFEsRKBgWASIJVcx
         bd6bvFNY/gU9H24qIM4T9ZTTLTIqmqIJSRvkXwh7ugHJaOQ1FIq4SmF5/Rz+JmjbXfi7
         Go81xyL0Mq+8YxQDY/woDDXE3KHLeYaG0b2DLP2Y+oJjJsg83Lo8/h/jJ4GqAMHA/6oi
         LtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=H8pVIbJ82BDdXKd+ykiTyQAjqKnLRfnSBf+3SbkWLV0=;
        b=WIzP96iMPF1R6Wx2PMrLLvbzQ7G6X2Y3ZBQvu3/okKHB62qmVwEYekfJFIlHiphvuE
         nvEoelLS5rZEJ6eSIzKo1kO5EsGR/vhGO1hwrCxgfLYqDtsBCji2AUvKHUmjU0SaTYnV
         OY+jM+T7JZYiWB5ZPj+Op55Ux4/ofjQjpBbO9sU79QMLIoKG+eX+7UpOiW8BfhFKfn4j
         sbFouxaT0A6l1PVTkDYSNEIuXj8ppw1uHd8527maD/Xe+IlC334trommimLIHFlIPwNz
         8+upv0bSZoNWziXI3BgB+FSNeDT5FOyDYYWGAvXGlPhtJH9o3h21jDstORwKVrKD2/pB
         VRVA==
X-Gm-Message-State: AOAM530pFuGtk3mSSyWhxL8R5qIFkY7xymDkOYTz+RqD8Np1JbJrRqRL
        2Lqv1e1PZbE79X0jJXrL65E=
X-Google-Smtp-Source: ABdhPJxFEkhd/4iX65IkulTqH+XUw51Rdps8tvh6v7PaRjoYnMLpSRDtGiSRTA9khdxR6F/O5iIkqQ==
X-Received: by 2002:aca:33d4:: with SMTP id z203mr19146546oiz.51.1623593202276;
        Sun, 13 Jun 2021 07:06:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 21sm2704484otd.21.2021.06.13.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 07:06:41 -0700 (PDT)
Date:   Sun, 13 Jun 2021 09:06:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Varun Varada <varuncvarada@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>, git@vger.kernel.org
Message-ID: <60c610f04b288_41f2b208ce@natae.notmuch>
In-Reply-To: <20210613114007.GF8544@kitsune.suse.cz>
References: <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
 <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
 <20210527114629.GD8544@kitsune.suse.cz>
 <60afa7d9d4ca_2056d208d9@natae.notmuch>
 <20210527143541.GH8544@kitsune.suse.cz>
 <CAD2i4DC0zH8WQvfZiHJA7f+DXubZjG6fKSuMbXdaztDC_PU4ZA@mail.gmail.com>
 <20210613114007.GF8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Sat, Jun 12, 2021 at 06:13:02PM -0500, Varun Varada wrote:
> > On Thu, 27 May 2021 at 09:35, Michal Such=C3=A1nek <msuchanek@suse.de=
> wrote:

> > > That's only opinion, not evidence.
> > =

> > Hence, the dictionary definitions, which are evidence. If people are
> =

> The dictionaries provide definition, not usage guidelines.

What do you think definitions are?

A definition is there because many people use the word that way.

> > Yes, there essentially is. It's called a dictionary. If you don't
> > respect the value of dictionaries, you're tacitly claiming that anyon=
e
> =

> I don't consider opinions tangentially related to dictionary content a
> proof of anything.
> =

> Also it has been pointed out that dictionaries don't agree on the
> precise definition - hence no final authority. The laguage use varies,
> and dictionaries also reflect that. Even the use of word 'impact'.

You need to understand what dictionaries do: they describe current
usage.

If some dictionaries say "impact" and "affect" are not 100% synonyms,
that means some people don't consider "impact" and "affect" to be
synonymns.

Period.

> > > This will bring in reviews that focus on hairsplitting when the
> > > formulation with 'impact' reads better than 'effect' and where the
> > > change does not make it read any better so it should not be changed=
.
> > >
> > > It also brings in reviews of the sort that simply say that use of
> > > 'impact' is OK, and there is no need to change.
> > =

> > That's an "if". This, however, is a situation where multiple people
> =

> We already received such reviews as response to your patch. It's not
> what-if.

In case you haven't been following this thread closely, you are the only
person that says the use of "impact" is OK. One person said "impact" was
OK for him, but he didn't say anything of anybody else. Another person
asked if they were synonyms. That's it.

I say Varun should resend the patch separate from all other patches,
explain why they aren't synonyms and mention for the record that one
person objects to the change.

It's OK to merge patches where one person objects.

-- =

Felipe Contreras=
