Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747011F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbcIIKn5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:43:57 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36685 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbcIIKn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:43:56 -0400
Received: by mail-oi0-f50.google.com with SMTP id q188so17823571oia.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y4PO60LBwVYeS++cs85wa/aNu1Br3F7BjnXERfyfJJo=;
        b=rV+5JM8nuClh6AsqFb/pTvWKffTDnlwoZIk70Is4D/NjVEERIajHtQkFeL1NIBzLDr
         c1GejrVlm7u2mfCZiZDKcvLzDgTjIXuFf255Ba25YH7m8qnXuWqPlbyQVDyt7J9Bm/4P
         2WTY/5SMc90gCr21ZoxQLBh+GQBctfTbzwUQt8NtuRwwpJLqDBs8n4OKnAgabRuigEG7
         fpKrcWoDlKl7dQ1NU84rDXWJ8ikGZolo87oMJTocgsSbWl0m1FmwLhoomnSJF7rof2ia
         JraheHNeACX/SmQBTDcYRqzFcCiNQm4rs53C7BiKa0EBEtKQPszO2AhJ766lAY2ZB26i
         eMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y4PO60LBwVYeS++cs85wa/aNu1Br3F7BjnXERfyfJJo=;
        b=X2xSpSlaG476EaUPKAIqK2m8UTX/f2F3dXHob7AOt2E/h9nac8Bg4zILv0Dsm7UT0S
         owUHcjXK4oGUkblfqQxiU9ZJy760Gu8GNUynmB7Xh2mh+1ZYrxlmAtDYYNZ6G4hCuwn0
         5N+BlJUz/J40X4t9cSugplgHd5hl0hLPtQ2E0be+vC+TUxeGt5qACY5Ahv+wesQy6zBd
         T792bz2wBvh7gXQcjyJioXXJ/HphxWwQT4Kaj04ud8akvayMuDGuGXOx+IhFS/7xv977
         GryDI2UCz9JL1tQTnlfq87B589zD520qkO0out7eZMXqDlMVhd/M9GPz6WDZx4G0icKl
         oFIw==
X-Gm-Message-State: AE9vXwOQg7BS33a/Hcp0tsbfju4xiFkmvN6HyRQKcMVFQtDjKwFuqfTSWNh0u7EZxQMkVGnimh3q/BMuMLczMA==
X-Received: by 10.157.29.131 with SMTP id y3mr3726503otd.62.1473417835943;
 Fri, 09 Sep 2016 03:43:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Fri, 9 Sep 2016 03:43:25 -0700 (PDT)
In-Reply-To: <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de> <20160907151251.30978-6-szeder@ira.uka.de>
 <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Sep 2016 17:43:25 +0700
Message-ID: <CACsJy8DZtAOL9OA_6eqKN7bfS2up+LLEYOWDg=Nh0Quy3coAVQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Leho Kraav <leho@conversionready.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2016 at 10:48 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> wrot=
e:
> Now, while I believe this is the right thing to do to fix this bug,
> there is a corner case, where multiple configured prerelease suffixes
> might match the same tagname:
>
>   $ git config --get-all versionsort.prereleaseSuffix
>   -bar
>   -baz
>   -foo-bar
>   $ ~/src/git/git tag -l --sort=3Dversion:refname
>   v1.0-foo-bar
>   v1.0-foo-baz
>
> I.e. when comparing these two tags, both "-bar" and "-foo-bar" would
> match "v1.0-foo-bar", and as "-bar" comes first in the config file,
> it wins, and "v1.0-foo-bar" is ordered first.  An argument could be
> made to prefer longer matches, in which case "v1.0-foo-bar" would be
> ordered according to "-foo-bar", i.e. as second.  However, I don't
> know what that argument could be, to me neither behavior is better
> than the other, but the implementation of the "longest match counts"
> would certainly be more complicated.
>
> The argument I would make is that this is a pathological corner case
> that doesn't worth worrying about.

Maybe we should keep a note about this in config.txt? If it's not
worth bothering/scaring the users about, I suggest you keep this in
the commit message.
--=20
Duy
