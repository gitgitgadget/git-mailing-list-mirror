Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B4C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9108B61A1E
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 02:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhCYCDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 22:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCYCCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 22:02:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221C1C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 19:02:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so635531eds.7
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 19:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rFW09pOE004T0lYSlFgeIeMaCm12TomG0weyEvPVA4s=;
        b=FXvqrb0GleWurP5VtHnrvMVZ7sEToTE7kTjmuMOVs3htjnxglJWHS0rbEySXl+wrU+
         4KmO6rgd4elGAhANELdiWp5yDMemtn/1gXtZZ8lWOGsCEOT62SReg9UYNbppHmhNQGYi
         q5a0JKFIBTZSL3yZjgh/Zaz0ApdUlOJmNnmw16XcaO8B0lknFynRIEx7/dy8SU3Ie+8F
         dXgAdRz5L4Mpg6cgxXzoXXgKmBz6vb6ZQNHghu5iDptjzEA/z2n7cNu2ZpGuQjQqLa9L
         0fhIFWq3KZs1GIJoJqp1Ipv4NoT5tKVHdE3Dfwg1Cc2/h4mHe42QtfBotw96bb4yVqbt
         rgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rFW09pOE004T0lYSlFgeIeMaCm12TomG0weyEvPVA4s=;
        b=MZ/JD6sHGEIQpkIIv6t9pC43kKv8aRAjeJXEnBcdOXDBrje8USlBFbC4/AHEslH4qN
         320v5EFnS7qEOhapC/wNwXfyXwTL7SPHt2YI/wZQpA3gjp1R955qjUb0rd+DGPT9+uDk
         xtmYEaYcHh0p+LVhClVmp7lAMYSzmGYtxsIYKqgS9iw9qVLD7FoRoSK6zSQPRWCPzdGW
         R1np59KhzRFuuk1gVkhJd7PluyU96e44s+JUzqBP/BJkgyn2tjJum8IB0scz3UJc2fHv
         WqfwhTfhrKAUDqxxW9+O3ZAhfBz67KD8JULuAwmuABOLmhyFrfiKfnYNREt/ZXkIZiPW
         kYAw==
X-Gm-Message-State: AOAM532H3ffBHKDiXB6Gzk+jxNtrBQbibUT900n1vZZ1YI59Z0y1SuBh
        mr/QdZ1sNVFvFLBSz3v28ek=
X-Google-Smtp-Source: ABdhPJwwXbCQJMuGipdwrKvGhA71saHVp1AiwwGfZe9wFklpdo72nj9wfwrZ2hevug+OE7F5LtmPzA==
X-Received: by 2002:a50:e702:: with SMTP id a2mr6580432edn.3.1616637769764;
        Wed, 24 Mar 2021 19:02:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm1962956edt.35.2021.03.24.19.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 19:02:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, jost.schulte@tutanota.com,
        Jeff King <peff@peff.net>
Subject: Re: Configure default merge message
References: <MW_aJot--3-2@tutanota.com> <xmqqk0pwxqvt.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqk0pwxqvt.fsf@gitster.g>
Date:   Thu, 25 Mar 2021 03:02:48 +0100
Message-ID: <87a6qsourb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 24 2021, Junio C Hamano wrote:

> jost.schulte@tutanota.com writes:
>
>> Hello all,
>>
>> I'm using git mainly with BitBucket repositories. When I pull from a rem=
ote, the default commit message will be "Merge branch 'source-branch-name' =
of https://bitbucket.org/ <https://bitbucket.org/jibbletech/jibble-2.0-clie=
nt-web>repository-name into destination-branch-name".
>>
>> I'd like to configure git to omit the "of https://bitbucket.org/reposito=
ry-name" part. How can I do that?
>>
>> Regards
>> Jost
>
> =C3=86var, is this something we recently made it impossible with 4e168333
> (shortlog: remove unused(?) "repo-abbrev" feature, 2021-01-12), or
> is there more to it than resurrecting that "feature" to do what Jost
> seems to want?

Perhaps I'm using it incorrectly, but I don't see how that repo-abbrev
feature ever resulted in the insertion of this munged content into the
actual commit object.

The shortlog examples of "..." in 4e168333 are of shortlog's output
being modified on the fly. Not of them being inserted into commits.

You can run "git merge" with "--log" which says it inserts "shortlog"
output. So I thought that maybe lines that were not the first "Merge
... into" line in the message could have gotten munged in this way
before my change.

But I don't think that happened either, and reverting 4e168333 and doing
a merge --log locally with e.g. "# repo-abbrev: branch" does not munge
the string "branch" in either the subject or the body, it's retained,
e.g.:
=20=20=20=20
    commit 02c864e58da (HEAD)
    Merge: 353c73510dc c6d63de00ff
    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    Date:   Thu Mar 25 03:00:21 2021 +0100
=20=20=20=20
        Merge branch 'to-merge' into HEAD
=20=20=20=20=20=20=20=20
        * to-merge:
          Merge this branch blah blah
=20=20=20=20

That's because "merge" never used the munging.

If you look at the code in 7595e2ee6ef (git-shortlog: make common
repository prefix configurable with .mailmap, 2006-11-25) when this
repo-abbrev feature was first added the "merge" would use
builtin-fmt-merge-msg.c to format the "shortlog", which implemented its
own function to do so, and didn't use the mailmap.

As to Jost's question. I think the way to do this is to use
fmt-merge-msg, see 2102440c17f (fmt-merge-msg -m to override merge
title, 2010-08-17) for an example.

That seems like it would also be simpler than Jeff King's suggestion in
the side-thread in <YFvAJU3Euxhjb+uw@coredump.intra.peff.net>.
