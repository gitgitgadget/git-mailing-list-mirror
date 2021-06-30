Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDFC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 21:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A572661425
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 21:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhF3VQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 17:16:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61857 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhF3VQX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 17:16:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CF58DC7EB;
        Wed, 30 Jun 2021 17:13:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0NShmekJHmN/
        UgIzA5Bi6IC0YsPun2GeLrhz/eD2RVI=; b=EpQT3nqDfXEXq3cAYip+Ancus8bN
        dv0aAh/B9TpScEBM+fVlgn34z1ZTJkr0hQCfKqFQhBBa7LaiutIhlI9rXOLLzUxZ
        lLHm4BYYhWXVZ2wO6vf+KskiVI+VUo+i984BZafdpAg4d8CIlSUPrGqroIMoH1HS
        6pbG3YPYSyhgocE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34113DC7EA;
        Wed, 30 Jun 2021 17:13:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B028FDC7E9;
        Wed, 30 Jun 2021 17:13:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/3] bundle doc: split out open v.s. closed
 discussion from <rev-arg>
References: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
        <patch-2.3-fe61f20f19f-20210630T091548Z-avarab@gmail.com>
Date:   Wed, 30 Jun 2021 14:13:52 -0700
In-Reply-To: <patch-2.3-fe61f20f19f-20210630T091548Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 30 Jun
 2021 11:16:27 +0200")
Message-ID: <xmqqk0mbt5rj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 124A2682-D9E8-11EB-8427-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Split out the discussion of why you should or should not create "open
> bundles" into a new section, away from the discussion of our handling
> of the rev-args syntax.

I changed my mind about this part.

 * There is no option to create a bundle with one or more
   prerequisite commits with a non-thin packfile as its payload
   part.  So "THIN BUNDLE" is an unnecessary new jargon and concept
   that does not help readers at all, because there is no "thick
   bundle" that has prerequisite commits.  Let's not introduce such
   a new word.

 * We do not call DAG in our history with bottom end (i.e. a range
   with one or more uninteresting commits) an "open history".  Let's
   not invent the words, "open" vs "close", to describe the history
   recorded in a bundle, either.

We do already have an appropriate phrase we can use to explain what
you wrote in open/close section: "the prerequisite commits" (find it
in the description of "verify" subcommand) and that has been a
concept well understood for a long time, ever since 2e0afafe (Add
git-bundle: move objects and references by archive, 2007-02-22)
introduced the bundle format.  Let's use that phrase, instead of
inventing a new word.

In short, there are two kinds of bundles.

 - A bundle with one or more prerequisite commits can only be
   extracted in a repository that already has all these prerequisite
   commits and the history behind them, and "git bundle verify" is
   an easy way to check if your recipient repository has the
   prerequisites.  The payload in such a bundle is always a thin
   packfile, but such a technical detail does not concern readers.

 - A bundle without any prerequisites can be extracted into
   anywhere, even into an empty repository, or cloned from it.

And that should be sufficient to base your new paragraph(s).

Sorry for having made a potentially confusing comment earlier.  What
I said about open vs thin was technically correct (i.e. there wasn't
fundamental reason why a bundle with prerequisites MUST use a thin
pack as its payload---we designed it that way because such a bundle
MUST be extracted in a repository with these prerequisites present,
hence it was OK to assume that a --fix-thin would work while
extracting such a bundle), but it is irrelevant in practice because
you cannot ask for a thick packfile to be created when creating such
a bundle anyway.

Thanks.
