Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CD5C11F66
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6343D61260
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 23:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhF3XaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 19:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbhF3XaX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 19:30:23 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F1DC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 16:27:52 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p22so7803025yba.7
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XLN/PQcvZWrKchVjfskeKojOgef66oQZtRjA8FNLESo=;
        b=JbtIzQtmjC+HHJAph4x3hzKvrpZgz/vG6TOV/SjehSljMHby50sPGeNtihLiX8tAJr
         cQ5kK/Vg8gaza9MsAhlkyVurp9FShY/WSkqBdWjLQ1PXUG6B7/6TUde/7tP3yUYi4uJI
         snaQLEM9s7QkxHWrO2jeKAK02MTsbQz1Mwrg6qQ574ft9zvKpEozaGrepv6sodLkhLg0
         2Wvgz0LVT38E4IdGesdY0q1WUMdhCJV6muddrunUkF2SoO2KuBQJzuH2ZZFoDzIzRoTK
         ffqTMu5hhJKbf3O5XZCUAvSZcDJ86WvNJWOMH3y+tj2lXH1uanHMtahk4BRIM7210r+e
         HyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XLN/PQcvZWrKchVjfskeKojOgef66oQZtRjA8FNLESo=;
        b=rh7w2CD1kMyJfzkv8t+5irW+x1yn2zrH1PIMYxD6uQ1q39z9devxwCc1NkrtMVQ9M6
         5YG5qlQTCbV0kNNVU8IvZyFarKThVn6QasFlsoJdJJoSpYczZz9m9pbC6fqUe9xDy6lc
         4tWXj8ZYVStr9mujjD1TizhxziMSQNlim7nfNPzlR1BqdknkeiHGqytBgJlxya3xVQCi
         FF4xovgBVszM9LtH1CyVUNgRY7e5VHvsQfyraN3crt1SZF66qHBrRMxovgL4rKklzSmX
         59RYeHHBx6dzWNuXNVoAKsMIHsPWSZJlZF5l4i/0lMS6eCrHdYIYXRlO/6EdYrL3Fx43
         dSlg==
X-Gm-Message-State: AOAM531k4OEgdIrvww3S4ZIY2rEHu4i1o3yDGTrR4OoJt0tcJLBFlJOS
        4p4d6P/TXEnXGb2RCi2thBItJi3sXwG2aBbt+1x5StuU7eo=
X-Google-Smtp-Source: ABdhPJwv316ajNyJd0PWSno29urvSRKlTP8ompzJ0UWExAkd2goY9KrsuV1Q+Hkry21y5mnZuCRwel76wO7a54oQAlw=
X-Received: by 2002:a25:34d1:: with SMTP id b200mr22244825yba.492.1625095671452;
 Wed, 30 Jun 2021 16:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
 <YNyxD4qAHmbluNRe@coredump.intra.peff.net> <YNzR5ZZDTfcN2Q+s@camp.crustytoothpaste.net>
In-Reply-To: <YNzR5ZZDTfcN2Q+s@camp.crustytoothpaste.net>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 30 Jun 2021 19:27:40 -0400
Message-ID: <CACPiFCLAm+e_JRc=eAt_rqwCWASqr19nXdk0zWqLbTEgELL81w@mail.gmail.com>
Subject: Re: Structured (ie: json) output for query commands?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 4:20 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I'm personally fine with the ad-hoc approach we use now, which is
> actually very convenient to script and, in my view, not to terrible to
> parse in other tools and languages.  Your mileage may vary, though.

It's of one piece with the Unix tradition that gave us Perl. That's
both a blessing and a curse.

Outputting fields, escapes, etc and the ability to use xpath to
extract, manipulate and query specific data is... very useful. There's
a hard tradeoff with utf-8, and any attempt at papering over that -
iconv conversions, etc =E2=80=93 will inevitably munge data in some cases.

hmmm,


m
--=20
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
