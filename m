Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D1C71156
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F959217A0
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o7VvF0Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389068AbgLAUZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:25:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55146 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbgLAUZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:25:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DE611149C4;
        Tue,  1 Dec 2020 15:24:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AZnKTp0Uic45
        +/fC91xgK3rf2Q4=; b=o7VvF0TnXTHk9FlrXMvxmiplGcDXkHA6sX8fJWU8y/WK
        F9MMj2a1eX5OmJ9MhSGJISsUZ9b8F2l/LCl8CTr6JN3Ff+AmZlbC/F3q7pvB+K1R
        ovBDNpJmJePFukl4VYjNZLLUp3/v2itkGnutSyGAz1Kt26l46xWPwNQXNp/P6QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=N8vc1e
        FZ75FXGwKN5/esZP7rPuhZk04h5lcOcHlyD5i9OdXwjQxmZgF34PM2IMLs7J5raT
        204rfB3/OmJsBlF+DabtJwflT5VSRcXiN0hqUdY4NgelktLyWT6DBCiA/vSBvbAu
        v7RTXzwVIPurfrKQ/6D0pnG4OKH1pBXlvmhCo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 559041149C3;
        Tue,  1 Dec 2020 15:24:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 811071149C2;
        Tue,  1 Dec 2020 15:24:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 06/10] mktag tests: remove needless SHA-1 hardcoding
In-Reply-To: <20201126222257.5629-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 Nov 2020 23:22:53 +0100")
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-7-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 01 Dec 2020 12:24:42 -0800
Message-ID: <xmqqv9dlnuk5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3FDDC098-3413-11EB-A6BD-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the tests amended in acb49d1cc8b (t3800: make hash-size
> independent, 2019-08-18) even more to make them independent of either
> SHA-1 or SHA-256.
>
> Some of these tests were failing for the wrong reasons. The first one
> being modified here would fail because the line starts with "xxxxxx"
> instead of "object", the rest of the line doesn't matter.
>
> Let's just put a valid hash on the rest of the line anyway to narrow
> the test down for just the s/object/xxxxxx/ case.
>
> The second one being modified here would fail under
> GIT_TEST_DEFAULT_HASH=3Dsha256 because <some sha-1 length garbage> is a=
n
> invalid SHA-256, but we should really be testing <some sha-256 length
> garbage> when under SHA-256.
>
> This doesn't really matter since we should be able to trust other
> parts of the code to validate things in the 0-9a-f range, but let's
> keep it for good measure.
>
> There's a later test which tests an invalid SHA which looks like a
> valid one, to stress the "We refuse to tag something we can't
> verify[...]" logic in mktag.c.
>
> But here we're testing for a SHA-length string which contains
> characters outside of the /[0-9a-f]/i set.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t3800-mktag.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 0e411e3c45..e9d7799537 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -43,7 +43,7 @@ check_verify_failure 'Tag object length check' \
>  #  2. object line label check
> =20
>  cat >tag.sig <<EOF
> -xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
> +xxxxxx $head
>  type tag
>  tag mytag
>  tagger . <> 0 +0000

These steps to prepare the input and the expected output outside the
test_expect_* block look too old-fashioned but they are consistently
so, so let's let them pass, at least inside this series.

> @@ -53,10 +53,10 @@ EOF
>  check_verify_failure '"object" line label check' '^error: char0: .*"ob=
ject "$'
> =20
>  ############################################################
> -#  3. object line SHA1 check
> +#  3. object line SHA check

Shouldn't we say hash instead of SHA for consistency?

> =20
>  cat >tag.sig <<EOF
> -object zz9e9b33986b1c2670fff52c5067603117b3e895
> +object $(echo $head | tr 0-9a-f z)
>  type tag
>  tag mytag
>  tagger . <> 0 +0000
