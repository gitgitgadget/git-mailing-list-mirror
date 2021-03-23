Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31801C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2599619C3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhCWQrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:47:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57539 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbhCWQrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 12:47:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CDDBBA0D6;
        Tue, 23 Mar 2021 12:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=o5g3ymvUgHej
        JTGhAISjRU/H/84=; b=q5LF8PAtJXxMO3+O/UMPHiUNRGJgd27o8crrwcilqP3z
        uxyh2JnffsQe6JRfd1ZerjKz7UmQL/VIpp4yZF8eDM+lLE4Ajef+nhXZRQZ8kHeN
        FL7nkclhDjjWdq8r1y1H/Vz9WczoVlPsqQraWTbqEo+oq4eRCgFxO1n9W9HA33A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=J2pH7X
        2a8mvdaA54g7MHdHaOOjAfk6J0gfn/gL1JqdilAa2TLtQnmuoUCcBJsB4e1Tw1Db
        w45OffehA6Lq5mQh81nDE5VFkIioROwIDamEY1gHuXYas3kGj48aIP7g+vcaaxfd
        IE8KURM5iuxPuKB3eoc5EIlxk6LBwlwGP0dOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25922BA0D5;
        Tue, 23 Mar 2021 12:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7768BA0D4;
        Tue, 23 Mar 2021 12:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/2] diff --no-index: fix test blind spots
References: <cover.1616366036.git.avarab@gmail.com>
        <cover-0.3-00000000000-20210323T163917Z-avarab@gmail.com>
Date:   Tue, 23 Mar 2021 09:47:09 -0700
In-Reply-To: <cover-0.3-00000000000-20210323T163917Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 23 Mar
 2021 17:40:12 +0100")
Message-ID: <xmqqim5h4y2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 696F3DF6-8BF7-11EB-A1CA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since v2[1]: s/echo -n/printf/ (and I re-adjusted my test setup to run
> the linting..)
>
> 1. https://lore.kernel.org/git/cover.1616366036.git.avarab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   diff --no-index tests: add test for --exit-code
>   diff --no-index tests: test mode normalization
>
>  t/t4053-diff-no-index.sh | 60 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> Range-diff:
> 1:  2dbc6c253e2 =3D 1:  7dd5c309a70 diff --no-index tests: add test for=
 --exit-code
> 2:  a1ab6a323f2 ! 2:  e5bb094b783 diff --no-index tests: test mode norm=
alization
>     @@ t/t4053-diff-no-index.sh: test_expect_success 'diff --no-index a=
llows external d
>      +test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalize=
s: mode not like git mode (symlink)' '
>      +	ln -s y z &&
>      +	X_OID=3D$(git hash-object --stdin <x) &&
>     -+	Z_OID=3D$(echo -n y | git hash-object --stdin) &&
>     ++	Z_OID=3D$(printf "y" | git hash-object --stdin) &&
>      +	cat >expected <<-EOF &&
>      +	diff --git a/x b/x
>      +	deleted file mode 100644

Thanks for a quick turnaround, and sorry for forgetting to say
"locally munged, no need to resend".
