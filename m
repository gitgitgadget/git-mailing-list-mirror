Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A092C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CA460F9D
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 15:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhG1Pgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhG1Pgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 11:36:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA04C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 08:36:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y12so3814096edo.6
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XwCjaXWPYMwgW9JiB3ZKJF8TA/U37NCaKe5sT1PrGcg=;
        b=K3IAdCQd32SeCyn5pXk2cHCV9i9BWcAcE+AUH1kw2b8IiCHlhWMVbcpPL0hom5LE67
         VuLah73MV35xRxe1/E/uNMM2tBg44irS+T2PjqD+8U+ho65WjSoVY+LSvZnKpWF6AgaK
         QF10Bm8k+YIDIYgn8uUwlK3d/AaGrmyPjKcGxSY/ShsiD8/RSsL9tCQtqdNZmoP0PEY/
         EFJnYAHRk8v73+XD99d+JgtE+RORu2TLTILUcJBhkeDb/WlCm9Hqa+bafbd4FS+D1YZN
         9C1QsO0vmyEECitxcdjhro45yuN8iF1N3aSxKMnf++IUN/FrdfKO0f/ScBHA4oJX3fmk
         az1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XwCjaXWPYMwgW9JiB3ZKJF8TA/U37NCaKe5sT1PrGcg=;
        b=JpjSnwK563cgWNVFexSZYWDbaRF/di2YbSAbBRKw3exEwM+cRAsD+68MNKfPxP15VQ
         98+TuA2NYxOapCWK54UTRQMcZ/22SU2tLtVYkagJeoD2A3HMr/5mgpzJlbwnao/k6ydi
         yEtOYNjhQBxd51lo14Wup1CuuKLLXF5ZpRIi050vRc0CS71pkgUSL5dIrtd/qtXter/k
         u9EJ/ApHpz+rdgsukqkA5iqKcG1dEPwF4yDQ9SraYr8qfCN8euLue0zhazZdKCsKPkqr
         F8/rOIOO9nupwoa6BJr6Bl9lSfclMSZTrKE1MWVjpc9EjA2KXukwJZvUDdsfBRA6cm+U
         Y4AA==
X-Gm-Message-State: AOAM530x/9I/82d6NBkcA/cNUtRhU/QRJuRMvAUZO5YSBKCVScenjF1B
        8IGuoRy/F48YeY1PpcDm53WjdiXUQBJUrcHJk28=
X-Google-Smtp-Source: ABdhPJxTdjJgjZX4Bm8Hut2UA74+GhLAgYaTwzquDk/TYK2p44DM1qOtndyO4qtXqPIuYHjQwka6JDDxtBDsEZTDK/I=
X-Received: by 2002:a05:6402:1289:: with SMTP id w9mr489651edv.127.1627486604859;
 Wed, 28 Jul 2021 08:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
 <87im0zs8wn.fsf@evledraar.gmail.com> <CAOLTT8Sbusr8=iJbG1qXcSerivZqP5xm-GS8R7TqDMh7QXSZaA@mail.gmail.com>
 <CAP8UFD1szPO-qmusSqiLRWxynV0gcy8UsnZORNn0USYAmRUGVw@mail.gmail.com>
 <CAOLTT8TdL7UhfVSOzbpmo-WFNrcKwmy=E720tNt4KM9o_p=keg@mail.gmail.com>
 <CAP8UFD1WtSX59AqfG=d0Ge2BcK+8LdyZk0mQuftpu=FKX-877Q@mail.gmail.com> <CAOLTT8QvtJ70X8mQx4K4gD0T=7i-ryd0QL81-QeSTqSWyHuWLQ@mail.gmail.com>
In-Reply-To: <CAOLTT8QvtJ70X8mQx4K4gD0T=7i-ryd0QL81-QeSTqSWyHuWLQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Jul 2021 17:36:33 +0200
Message-ID: <CAP8UFD1tS++xEMob7p5UeDQ_enoyy1aOQTG=28r-ge2k4n3ECw@mail.gmail.com>
Subject: Re: [GSOC] How to improve the performance of git cat-file --batch
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 3:38 PM ZheNing Hu <adlternative@gmail.com> wrote:

> Ok, therefore we need an accurate number of call times about lookup_object(),
> although the conclusion is obvious: 0 (upstream/master) and a big
> number (with my patch).

[...]

> This is the only 1 time left is printed by git.c, which show that after using
> my patch, we additionally call  lookup_object() when we use --batch option.
> According to the results of the previous gprof test: lookup_object()
> occupies 8.72%
> of the total time. (Though below you seem to think that the effect of
> gprof is not
> reliable enough.) This may be a place worthy of optimization.

First, yeah, I hadn't seen the "calls" columns in your gprof reports.
Sorry! It's nice to see that your manual check with a trace_printf()
function gives the same result as gprof about this though.

Anyway if you agree that it might be a place worthy of optimization,
then it might be a good idea to explain the reason for the numerous
lookup_object() calls when using the ref-filter code.

[...]

> > It would be nice if you could add a bit more details about how
> > lookup_object() is called (both before and after the changes that
> > degrade performance).
>
> After we letting git cat-file --batch reuse the logic of ref-filter,
> we will use get_object()
> to grab the object's data. Since we used atom %(raw), it will require
> us to grab the raw data
> of the object, oi->info.contentp will be set, parse_object_buffer() in
> get_object() will be
> called, parse_object_buffer() calls lookup_commit(), lookup_blob(),
> lookup_tree(),
> and lookup_tag(), they call lookup_object(). As we have seen,
> lookup_object() seems to
> take a lot of time.

Not sure why you are talking about %(raw). Is the root of the issue
that we now use atom %(raw), or how we implemented it?

> So let us think, can we skip this parse_object_buffer() in some scenarios?
> parse_object_buffer() parses the data of the object into a "struct
> object *obj", and then we use this
> obj feed to grab_values(), and then grab_values() feed obj to
> grab_tag_values() or grab_commit_values()
> to handle some logic about %(tag), %(type), %(object), %(tree),
> %(parent), %(numparent).
>
> But git cat-file --batch can avaid handle there atoms with default format.
>
> Therefore, maybe we can skip parsing object buffer if we really don't
> care about these atoms.

Yeah, maybe oi->info.contentp should be set only if the user specified
one of the atoms that really needs the content provided by
parse_object_buffer().

Thanks!
