Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89AC433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 19:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C71208C3
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 19:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fDI4bsFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgGNTEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:04:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57406 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbgGNTEt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 15:04:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65DC6D5805;
        Tue, 14 Jul 2020 15:04:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D7dy2ksUf+Z/zGwj2fipH8ppObk=; b=fDI4bs
        Fg5pmkImgWuA2fiRNmy6/vAHMxgBnVRhvGTmLVj5vTJVmltepOh8WxfFfkEgV1oW
        pjPqL82EWwYUL2REy00wLCLquekyHr1CZKpfto6hDC63erAwNUp2yDJUVNahSuZh
        obvEJhq+BLrSqrlyZkogfUtzkCgzp1UEs5LNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XZc9IKY/c8/pcvLTtCYWLoIzCUxQPmen
        sUHb8Kp7IpVpr6cSF6WOu1zsuS62BNWwPm36qIV8ek2KXzZS3tEM6xYIIULQkZwk
        WEcG2eUlbT250Zl+4qMPycOl6Fxfe3c/zKNYOnF4VUXTeL7dkfJXPM0S3OxTGlm3
        xFUYmYeNBSo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DB6CD5804;
        Tue, 14 Jul 2020 15:04:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83B3CD5803;
        Tue, 14 Jul 2020 15:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Larry Martell <larry.martell@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Can't checkout branch
References: <CACwCsY7YSn_mbtFv3QjL5dY80G6e_r-gGC3SGo5rO5b8LGXxVA@mail.gmail.com>
        <CACwCsY7P5NiQL5ajHMOWo2EPiQZKUj_m_AVbtGy=z=twChimjw@mail.gmail.com>
        <CAPx1GvcOpmpuPseAQDYk9pg+hfdF9KJSSSiB0fEHQrnUuPS4CA@mail.gmail.com>
Date:   Tue, 14 Jul 2020 12:04:42 -0700
In-Reply-To: <CAPx1GvcOpmpuPseAQDYk9pg+hfdF9KJSSSiB0fEHQrnUuPS4CA@mail.gmail.com>
        (Chris Torek's message of "Tue, 14 Jul 2020 11:17:56 -0700")
Message-ID: <xmqqmu41lxyt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1044CF8-C604-11EA-A868-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

>  2. Treat this as `git checkout -b deploy origin/deploy`
>     or `git checkout -t origin/deploy`, i.e., create the
>     branch `deploy` from `origin/deploy`.
>
> If *both* of these alternatives work, pre-2.23 Git *assumes* you
> meant alternative number 1.  In 2.23 or later, `git checkout`
> tells you that this is ambiguous and makes you pick which one you
> want.
>
> To work around this in all versions of Git, you can just be
> more explicit.  For instance:
>
>     git checkout deploy --
>
> forces Git to treat it as a branch name.

I actually think "git checkout -t -b deploy origin/deploy" is a
better way to be explicit to avoid confusion.  You do not create a
branch every few seconds anyway---it is more important to instill in
user's head what really does go on by encouraging them to give these
command line arguments explicitly, instead of teaching new people to
rely on "git guesses most of the time in your favor so here is the
lazy command line"---that will prevent true understanding and if it
left unremedied long enough, will result in a confused user who is
no longer a newbie.

Having said that, yes "git checkout deploy --" is a way to still
rely on git guessing most of the time in your favor to stay lazy,
and it should work, but there may be unseen other factors to break
the DWIM, just like Larry didn't think of an existing file deploy
in the working tree to be interfering.

Thanks.
