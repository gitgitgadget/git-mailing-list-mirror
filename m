Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA97C4361B
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 02:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3050A22482
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 02:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgLWCaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:30:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56190 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbgLWC3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 21:29:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2377112F95;
        Tue, 22 Dec 2020 21:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=I9bBJzfi9IJN
        rEBpEUqc+SKt0u0=; b=IqYkycMSXgvip578O0ZtbffdciWEB1yUgmAjqGw96LdZ
        fR2z7QuulBKChzf9lhjNQVX5oOc2Fuz1pyXjUtChjp3r0TJQWS+dqA6cn5bDTTIE
        ynXxnwEXP/uCJlFq1lzQ3Rzv6VBREGsGczo5ZN2aRApM8JCXE5bH5kNO3giXuvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rOrUD0
        rCPFeVLJBX3P9O1Y0uxxHcy0Zy9ygVRpK0ujwR1zzF4VOkc2U6hOBGF6G6BdhGk0
        FYADDfjQtVjIflaid4qk8N+BlD55SauncTiK1VnAeqj0oaTTo/zt3lheUuEuqbew
        vRytgWg5XNb3qqH+Ep0Ac8Nx0XeAf3+9Kw2B0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C85E3112F94;
        Tue, 22 Dec 2020 21:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DE36112F93;
        Tue, 22 Dec 2020 21:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 10/20] mktag tests: test "hash-object" compatibility
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-11-avarab@gmail.com>
Date:   Tue, 22 Dec 2020 18:29:08 -0800
In-Reply-To: <20201223013606.7972-11-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Dec 2020 02:35:55 +0100")
Message-ID: <xmqqczz1dzm3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A3691B44-44C6-11EB-9184-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change all the successful "mktag" tests to test that "hash-object"
> produces the same hash for the input, and that fsck passes for
> both.
>
> This tests e.g. that "mktag" doesn't trim its input or otherwise munge
> it in a way that "hash-object" doesn't.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t3800-mktag.sh | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index f339321be8..c6826762d9 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -19,6 +19,16 @@ check_verify_failure () {
>  	'
>  }
> =20
> +test_expect_mktag_success() {
> +	test_expect_success "$1" '
> +		git hash-object -t tag -w --stdin <tag.sig >expected &&
> +		git fsck --strict &&
> +		git mktag <tag.sig >hash &&
> +		git fsck --strict &&
> +		test_cmp expected hash
> +	'
> +}

;-)  Nice.

I'll stop here for tonight.  Thanks for working on this.
