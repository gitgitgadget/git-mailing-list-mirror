Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39F5C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 18:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiGRSBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiGRSBm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 14:01:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EA22E9FA
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 11:01:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05C08144993;
        Mon, 18 Jul 2022 14:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NH69usjkrR+o
        OXbGVtP+t2Z1I42zadbX1fth0KGLFfo=; b=NUlKAA/pybR/tQkfpvVLYfl6z5Mi
        gUV0t9d2iJGtgOF3nW8+CFOvCPVkiJvMw2m9K7rrgodSPWj9O1TN+3P/HnyK1MgB
        ao3vyM+hnxHhef6VBjSwzhXsAWkO3teJGB/g/kDR2YQBPLSR/5ZaquT68Fu7zlKQ
        7lWn+oypUipoGVw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF9AD144992;
        Mon, 18 Jul 2022 14:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17E76144991;
        Mon, 18 Jul 2022 14:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4200: drop irrelevant code
References: <20220718154322.2177166-1-martin.agren@gmail.com>
Date:   Mon, 18 Jul 2022 11:01:37 -0700
In-Reply-To: <20220718154322.2177166-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 18 Jul 2022 17:43:22 +0200")
Message-ID: <xmqq4jzeqozi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABED7AD8-06C3-11ED-BDDC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> While setting up an unresolved merge for `git rerere`, we run `git
> rev-parse` and `git fmt-merge-msg` to create a variable `$fifth` and a
> commit-message file `msg`, which we then never actually use. This has
> been like that since these tests were added in 672d1b789b ("rerere:
> migrate to parse-options API", 2010-08-05). This does exercise `git
> rev-parse` and `git fmt-merge-msg`, but doesn't contribute to testing
> `git rerere`. Drop these lines.

Very well reasoned.

Will queue, thanks.=20

> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  This is quite late fallout from Eric's review [1] of some commits that
>  have already gone in.
>
>  [1] https://lore.kernel.org/git/CAPig+cSjHg2-WYqdkZAS0ye1goj_=3D5RN3md=
jt0-4kSBqNm6WLg@mail.gmail.com/
>
>  t/t4200-rerere.sh | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 9f8c76dffb..7025cfdae5 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -358,23 +358,20 @@ test_expect_success 'set up an unresolved merge' =
'
>  	headblob=3D$(git rev-parse version2:file3) &&
>  	mergeblob=3D$(git rev-parse fifth:file3) &&
>  	cat >expected.unresolved <<-EOF &&
>  	100644 $headblob 2	file3
>  	100644 $mergeblob 3	file3
>  	EOF
> =20
>  	test_might_fail git config --unset rerere.autoupdate &&
>  	git reset --hard &&
>  	git checkout version2 &&
> -	fifth=3D$(git rev-parse fifth) &&
> -	echo "$fifth		branch fifth of ." |
> -	git fmt-merge-msg >msg &&
>  	ancestor=3D$(git merge-base version2 fifth) &&
>  	test_must_fail git merge-recursive "$ancestor" -- HEAD fifth &&
> =20
>  	git ls-files --stage >failedmerge &&
>  	cp file3 file3.conflict &&
> =20
>  	git ls-files -u >actual &&
>  	test_cmp expected.unresolved actual
>  '
