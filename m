Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B392AC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70362613C1
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhEMHzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhEMHzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:55:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5FC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:54:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n25so29990583edr.5
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WC4c+jlA+mbEdRwAVK2aniJl7zxG42qBAKCFhxuTSO8=;
        b=Mfy6Y/GXDMuzd0G6LZRNdr3BCkczk4w/d2tATSGs3i+fTEEfhGLyT41nwFepP+lpXv
         eODjarSa2dKQo48t6xvHUdZjTubt3PoP/M6oPPMKDUS/A2NoxZw/yZG4AhHWcD68CfZe
         DTOfpDgOOhU180adu7zme2L7ZvSAUetufYBbfBwQ3FhvP7MqDwbU3xKm7zOaeP0zBszc
         Jc2MusZOHC1WxSBQCaFM67WecF86kyTeni/FLyq/CpMh4mS3enQLu9kEoR6yemIUD7Vv
         gq2OOzoW2rivlr6Qb0bhcpPpARx8eKDqVyYCx4ZjazSXN9iennimzGsAAkUHmtP2VdWX
         0BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WC4c+jlA+mbEdRwAVK2aniJl7zxG42qBAKCFhxuTSO8=;
        b=LtFNOYsfKp+CH2s3AOa1PABi1KAXSk/lh/v4dt4eP1vaCdGng8AKkjFjXizIliESBx
         RwNJa7e2UWW1UuZ7Lxrd4wvKXq661RBjaQuOyB9XEl2AaNj8YwX2XQ4aNcVn6Td1r/JY
         r5N9+eLFrJRVoaqLZRbFsu7nDLV7bHI5rDAY9BbbFIYSs2i7RFSldwSlVAwvTigwENCv
         d2xrKADlrifgYxkWe8uP57fkkzOvLMHW65togsPslaw3x9mU5JhLd/CpnGXklEro1wkW
         t2v174DfU/IMsp/rtL212bot3SmzmgN5BUTT2H0/flKCklzt65M6RxENo7a6W/FNQ2Qv
         mHFg==
X-Gm-Message-State: AOAM533RIdhezq5c3uN7G2pvVeNYg7YLJVAslE0zAr74qPZmYZEgQEyZ
        LFFzxTg1l+45Jq674fiWpY8=
X-Google-Smtp-Source: ABdhPJxUA8EtKaIse0pPEcmChq601K5vij+AytT6ySWwtuf/7jL9xsXALYcrQVlEqIJ/JSSp9xyo3A==
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr49528785eds.291.1620892482537;
        Thu, 13 May 2021 00:54:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w6sm1730337edc.25.2021.05.13.00.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 00:54:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/3] SubmittingPatches: remove pine-specific hints from
 MUA hints
Date:   Thu, 13 May 2021 09:50:21 +0200
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
 <20210512235136.GB10785@localhost>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210512235136.GB10785@localhost>
Message-ID: <87mtszrrum.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 12 2021, Dave Huseby wrote:

> On 12.05.2021 10:45, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>There hasn't been a release of Pine since late 2005, in Alpine the
>>no-strip-whitespace-before-send switch is already the default.
>>
>>This documentation was initially added in 9740d289ee7 (Update
>>SubmittingPatches to add MUA specific notes., 2005-08-26), at this
>>point it's safe to say that it's not useful to anyone anymore, let's
>>remove it.
>
> What is wrong with keeping it in there? My latest version of the
> etiquette patch moves my Mutt MUA config notes to this section on MUAs.
> It could eventually become a somewhat exhaustive reference of MUA
> tweaks. Old tools may not be popular but they sometime have niche uses
> and/or userbases. My recent switch to Mutt has been mixed at best and I
> went back to take a look at mh/nmh to see if I liked it better and I may
> give it a go for a while to kick the tires, likely making me the only
> developer that uses nmh.
>
> Keeping these notes on old tools--at the bottom of documentation no
> less--seems to have little to no "cruft cost" with the potential of
> helping somebody someday, even if nostalgia is the only reason.

I think there's an inherent value in keeping guides like these short and
to the point, and only including those things relevant to most readers.

So I do think that if we're including such a niche guide we're better
off splitting it into another file and linking to it, same with the
whole guide in SubmittingPatches now teaching people to manually craft a
patch without using git-format-patch, another obscure edge case we give
too much space / causes distraction.

In this case though I think saying anything about pine crosses the line
from niche to obscure archaeology. We're inlining a patch for abandoned
software that has a replacement. If we're going to say anything about
Pine in such a list I think it should be:

    Pine: abandoned and has known flowed text bugs, use its successor
    alpine or another MUA instead.
