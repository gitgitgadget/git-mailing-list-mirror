Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413D1C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 21:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiGKVET (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 17:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 17:04:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3919E15A19
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:04:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2253712BC0F;
        Mon, 11 Jul 2022 17:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YsS6B7JwGQWJ
        mBQzaGtAc8WKtFwP+fv/RKriehpMC0c=; b=Ehf9vRsEB7RPQZk26sv33ZgpkYaW
        Ln3WsGivx3wY6oTNXMjkQV8Hpfsg0K53d97x71VFEoYeu9khKuaf18iT8HiyU11u
        0hT/jU2ETYpAzeZM9StER9S0DKiwAhLXZqH9Ch+3bBhZ4/oZaUkD/dGKWG1pfruU
        mRb8JZJIep0NKQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1978F12BC0E;
        Mon, 11 Jul 2022 17:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C70812BC0D;
        Mon, 11 Jul 2022 17:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 4/4] .clang-format: don't indent "goto" labels
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
        <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
        <RFC-patch-4.4-e3a95c62bda-20220711T110019Z-avarab@gmail.com>
Date:   Mon, 11 Jul 2022 14:04:15 -0700
In-Reply-To: <RFC-patch-4.4-e3a95c62bda-20220711T110019Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 11 Jul
 2022 13:37:28
        +0200")
Message-ID: <xmqq35f7nyy8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0628CBD6-015D-11ED-B097-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This change is a slightly mixed bag, we have a lot of "goto" labels
> that are indented by exactly one space.
>
> Before & after this change running "make style-all-diff-apply" will
> yield:
>
> 	509 files changed, 13042 insertions(+), 12745 deletions(-)
> 	510 files changed, 13039 insertions(+), 12742 deletions(-)

More files changed with fewer changes, or the above is not
copy-and-paste but typed in?

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  .clang-format | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.clang-format b/.clang-format
> index 5a106d959be..56d7e8f9def 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -148,6 +148,9 @@ SpacesInSquareBrackets: false
>  # clang-format 12.
>  BitFieldColonSpacing: None
> =20
> +# Do not indent "goto" labels, they should be flushed left.
> +IndentGotoLabels: false
> +
>  # Insert a space after '{' and before '}' in struct initializers
>  Cpp11BracedListStyle: false
