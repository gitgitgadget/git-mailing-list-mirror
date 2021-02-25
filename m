Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A9EC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CB164ECF
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhBYCsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:48:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56139 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhBYCsH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 21:48:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10B7611A865;
        Wed, 24 Feb 2021 21:47:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jTu+i+fF80J3
        rMbTsqblPn3P8ug=; b=TJgDNPjnyeCuevx9MkBT5cKHygLs6DPMU5PpkZv81x7f
        ECF0rChE1IOEnJg33kuVJuNKW3xv/+fMWBDZ91MHsK20SXMG8Y07PB1aS0qQY+Hy
        +DWFo2VivTmAot8sljGElg42panup2xyMfECDWxTOOxzhyIKM7bZdAPlNu82fp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UkKB2l
        ElJE39BQ3bI/jIwmCIxAeJP98kxhYTuVzNZ38DnXPM1N2I4BKe8wklnLCZ+H8B+S
        kNXzWEG+uoN2ltKOtw+bvMjdoglfZD46ru+1SSzikmHD4/8cItUUXUatcFWGbVmf
        EAzn4NcmUS6alIkGNYX16ibCeTCSlvDMzcaBU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB17C11A864;
        Wed, 24 Feb 2021 21:47:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0823811A863;
        Wed, 24 Feb 2021 21:47:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 11/35] userdiff tests: match full hunk headers
References: <20210215154427.32693-1-avarab@gmail.com>
        <20210224195129.4004-12-avarab@gmail.com>
Date:   Wed, 24 Feb 2021 18:47:18 -0800
In-Reply-To: <20210224195129.4004-12-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 24 Feb 2021 20:51:05 +0100")
Message-ID: <xmqqeeh4yibt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C786BE3A-7713-11EB-A468-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 9aec9f8e6de..15dcbe735ca 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -70,16 +70,20 @@ test_expect_success 'setup hunk header tests' '
>  		echo "$i-* diff=3D$i"
>  	done > .gitattributes &&
> =20
> -	# add all test files to the index
> -	(
> -		cd "$TEST_DIRECTORY"/t4018 &&
> -		git --git-dir=3D"$TRASH_DIRECTORY/.git" add .
> -	) &&
> -
> -	# place modified files in the worktree
> -	for i in $(git ls-files)
> +	cp -R "$TEST_DIRECTORY"/t4018 . &&

Is this because otherwise we'll mix leftover cruft in the source
directory?  I guess this is OK as it is just once per t4018 test
run.

> +	git init t4018 &&
> +	git -C t4018 add . &&
> +
> +	for i in $(git -C t4018 ls-files)
>  	do
> -		sed -e "s/ChangeMe/IWasChanged/" <"$TEST_DIRECTORY/t4018/$i" >"$i" |=
| return 1
> +		grep -v "^t4018" "t4018/$i" >"t4018/$i.content" &&
> +		sed -n -e "s/^t4018 header: //p" <"t4018/$i" >"t4018/$i.header" &&

For now this would do, but I am assuming that the "t4018" prefix
(which by the way is a way to make it harder to renumber these
tests) was invented so that we can add more magic than just
"header:" in the futhre (either in this series or later).  I am not
sure if we want to run one invocation of "sed" for each new magic we
invent---perhaps the plan is that we'd keep the framework simple for
now (while we have only one "magic") and then revamp it when we gain
the second one, in which case I am perfectly fine with it.

> +		cp "t4018/$i.content" "$i" &&
> +
> +		# add test file to the index
> +		git add "$i" &&
> +		# place modified file in the worktree
> +		sed -e "s/ChangeMe/IWasChanged/" <"t4018/$i.content" >"$i" || return=
 1

OK.

>  	done
>  '
> =20
> @@ -87,8 +91,9 @@ test_expect_success 'setup hunk header tests' '
>  for i in $(git ls-files)
>  do
>  	test_expect_success "hunk header: $i" "
> -		git diff -U1 $i >actual &&
> -		grep '@@ .* @@.*RIGHT' actual
> +		git diff -U1 $i >diff &&
> +		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&

The original was already loose but this makes it even looser.  Can
we tighten the pattern to strip the line number information from the
hunk header to something more like like this, please?

	/^@@[-+0-9, ]*@@/

Thanks.
