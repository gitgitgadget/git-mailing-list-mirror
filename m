Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7AC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D9461279
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhIPUcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:32:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60594 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhIPUcN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 16:32:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEA78EFC58;
        Thu, 16 Sep 2021 16:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V3+tQX3Lbbnd
        PjnmkdUxBVVse9FPi71ZM70HAhuKRGE=; b=ZLXaXtgCfLlQMxpyrqhVJiL5YNj9
        VzhZy53WcujYsUnGUhQsyQzPfTmXNlYGQ5/UI3YX22mt21qcIrIGOOgIZ8XasMsS
        u4gAZiQp6Ehogbldk4rhTco23qPBk8TQldQkmb7ImXqN0EqzcFfL/KOjWDbKPinE
        Qa3XiAqZHHjwuvE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B53A3EFC57;
        Thu, 16 Sep 2021 16:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3350EEFC54;
        Thu, 16 Sep 2021 16:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Ryan Anderson <ryan@michonline.com>, vmiklos@frugalware.org,
        bedhanger@gmx.de
Subject: Re: [PATCH 2/2] request-pull: mark translatable strings
References: <20210916113516.76445-1-bagasdotme@gmail.com>
        <20210916113516.76445-3-bagasdotme@gmail.com>
        <YUNKIj44AlW0tkXk@danh.dev>
Date:   Thu, 16 Sep 2021 13:30:50 -0700
In-Reply-To: <YUNKIj44AlW0tkXk@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Thu, 16 Sep 2021 20:44:18 +0700")
Message-ID: <xmqqbl4stg91.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FBCF5CBA-172C-11EC-BBBC-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> I would argue request-pull message shouldn't be translated.
>
> The person who creates the request may prefer to use a different
> language, let's say French, for day-to-day work.
>
> However, the recipients may not understand French, and prefer to
> receive English message.
>
> And this change break their workflow badly.

[jc: devil's advocate hat on]

While that may be true, it would be a nice-to-have if we had an
option to help developers who usually work in $French when they
contribute to a project where $French is the official tongue (assign
any value other than English to variable $French).

[jc: devil's advocate hat off]

I haven't done or seen any official survey, but I would not be
surprised if English were used as the official project language by
the majority of projects that accept pull request messages.

In that sense, the output that gets translated for the user's usual
locale by default, like the patch in question does, is misdesigned.
The consequence of the design is that among those who do not usually
run in C or en_XX locale, the number of people who will be forced to
say

	LANG=3DC LC_ALL=3DC git request-pull ...

to override their usual local in order to send the untranslated
message to their project that do not want translated requests would
be far greater than those who can just say

	git request-pull ...

to send a message in local language to a local project.

So a good middle ground may be

 - allow translation, like these patches attempt

 - introduce the command line option "--l10n=3D<value>" and
   the requestpull.l10n configuration variable that gives the
   default for the option:

   - when it is set to 'true', end-user's local taken from the
     environment is used as the target for translation.

   - when it is set to 'false', translation is turned off.

   - when it is set to any other value, the locale is set to the
     value of that variable (imagine a Japanese developer
     contributing to a German project).

perhaps?   I dunno.
