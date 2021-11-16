Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1431C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB83B60F6E
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhKPFWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:22:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64982 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhKPFWK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:22:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59501106B80;
        Tue, 16 Nov 2021 00:19:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=blbFkpF9ZI2qMiukBZfmHLmH8
        9DJz6G49oeI1/9AfoY=; b=QODc/lIDLUjR222Hn0B9bDP6o12BJWdmuqqJgmi33
        Onn97tImAjwqJ+QvyKNbvx0DXklwFvjqsY2Ht83SP/zMxT3xvChvUdavQTkNFJoU
        diAfyEMZKAe1klBYVXsbQEuJB0SfJWZUU5B6jO1q65enGY2hE/LGQVmNRzu+jdfK
        IY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FA0D106B7F;
        Tue, 16 Nov 2021 00:19:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE6BD106B7E;
        Tue, 16 Nov 2021 00:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/8] fetch: lowercase error messages
References: <20211113033358.2179376-1-andersk@mit.edu>
        <20211113033358.2179376-2-andersk@mit.edu>
Date:   Mon, 15 Nov 2021 21:19:08 -0800
Message-ID: <xmqqczn0d6er.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA696AE6-469C-11EC-829C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> Documentation/CodingGuidelines says =E2=80=9Cdo not end error messages =
with a
> full stop=E2=80=9D and =E2=80=9Cdo not capitalize the first word=E2=80=9D=
.  Reviewers requested
> updating the existing messages to comply with these guidelines prior to
> the following patches.

Thanks.  Whether reviewers requested or you thought of it on your
own, separating such a preliminary clean-up into its own patch would
be a good idea, especially if the later patches need to update (some
of) them.


> @@ -1062,13 +1062,13 @@ static void close_fetch_head(struct fetch_head =
*fetch_head)
>  }
> =20
>  static const char warn_show_forced_updates[] =3D
> -N_("Fetch normally indicates which branches had a forced update,\n"
> -   "but that check has been disabled. To re-enable, use '--show-forced=
-updates'\n"
> -   "flag or run 'git config fetch.showForcedUpdates true'.");
> +N_("fetch normally indicates which branches had a forced update,\n"
> +   "but that check has been disabled; to re-enable, use '--show-forced=
-updates'\n"
> +   "flag or run 'git config fetch.showForcedUpdates true'");
>  static const char warn_time_show_forced_updates[] =3D
> -N_("It took %.2f seconds to check forced updates. You can use\n"
> +N_("it took %.2f seconds to check forced updates; you can use\n"
>     "'--no-show-forced-updates' or run 'git config fetch.showForcedUpda=
tes false'\n"
> -   " to avoid this check.\n");
> +   " to avoid this check\n");

The two guidelines cited in the proposed log message are primarily
to prefer

    fatal: unrecognized argument: --no-such-option

over

    fatal: Unrecognized argument: --no-such-option.

and does not say much what to do to a multi-sentence message.  In
this part (and other parts) of the patch, I can see that you thought
this one through when preparing this patch.  I very much appreciate
it.

The approach chosen (consistently) in this patch is to

 (1) turn them into a (semi) single sentence, concatenated with ';'

 (2) as a side effect of not being a free-standing sentence anymore,
     the second and subsequent sentences in the original, that are
     now just pieces in a single sentence separated with ';', do not
     get capitalized, and

 (3) the sentence as a whole lacks the full-stop, just like a single
     sentence message.

I think we are fine with these rules, especially given that these
multi-sentence messages are not the main part of this topic touches
and are not the primary focus of this topic anyway. =20

I am highlighting this part of the change, just in case others think
of a better set of rules to follow.  Existing multi-sentence messages
follow different ad-hoc patterns, it seems (e.g. "git show 00000000").

Thanks.

