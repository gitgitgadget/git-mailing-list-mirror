Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B49C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B655260C3D
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhDLTkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:40:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56821 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbhDLTkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:40:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFD60AB92E;
        Mon, 12 Apr 2021 15:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3FDk3g+11WcZ
        JvnXRlMQD72dJTY=; b=dn/dIUDUA1QmwvtzQJUPfK5JWs1t/ywbg/Mm0SdquDDt
        izpC9C2jhukorEzmmwI/ERfWte78J227Tyk6NUASfjVGlqCOQ9icBWJuDL6i9RwV
        RLuhTEFqVFCNl3x055LTYNDNfCXz9I9a++C6K1rx06Rtnpy93e8ejIesALSjWWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AlIKi1
        D0cJM+br+mIcINa+agIV17nRCw4Eb9RxcEQ5FumSWR97WyhvbWm3Xc+8nv7XJkTK
        0NYTqxI0jpnjI87NA1InSAgeUvR254u9PkK0Da0mdPaeT37EPv/kJ8tyAiQZYJRY
        RDolN8IVGoQBnECF+Q8aIWdAxzKJJpN/IZGjc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0BDAAB92D;
        Mon, 12 Apr 2021 15:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36DBEAB92A;
        Mon, 12 Apr 2021 15:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/16] test-lib-functions: remove last two parameter
 count assertions
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-16.16-b4a018a63f3-20210412T110456Z-avarab@gmail.com>
Date:   Mon, 12 Apr 2021 12:40:16 -0700
In-Reply-To: <patch-16.16-b4a018a63f3-20210412T110456Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Apr
 2021 13:09:05
        +0200")
Message-ID: <xmqq5z0rcmvz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E88EF412-9BC6-11EB-AAF3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove a couple of parameter count assertions where we'll now silently
> do the wrong thing if given too many parameters, unlike the "$@" cases
> in the preceding commit where "test" etc. handle the check for usi.

What's "usi" (not a "cow", I presume)?

If test_line_count is given 2 or 4 parameters, we'd call BUG---does
that "silently do the wrong thing"?  Why?

> In the case of "test_file_size", the "test-tool" we're invoking is
> happy to accept N parameters (it'll print out all N sizes). Let's just
> use "$@" in that case anyway, there's only a few callers, and
> eventually those should probably be moved to use the test-tool
> directly.
>
> That only leaves test_line_count, I suppose I could leave that one
> alone, but since it's the only common function left that does this
> assertion let's remove it for the brevity of the -x output and
> consistency with other functions.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/test-lib-functions.sh | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 2cf72b56851..32d6b98b972 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -822,10 +822,7 @@ test_path_is_missing () {
>  # output through when the number of lines is wrong.
> =20
>  test_line_count () {
> -	if test $# !=3D 3
> -	then
> -		BUG "not 3 parameters to test_line_count"
> -	elif ! test $(wc -l <"$3") "$1" "$2"
> +	if ! test $(wc -l <"$3") "$1" "$2"
>  	then
>  		echo "test_line_count: line count for $3 !$1 $2"
>  		cat "$3"
> @@ -834,8 +831,7 @@ test_line_count () {
>  }
> =20
>  test_file_size () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	test-tool path-utils file-size "$1"
> +	test-tool path-utils file-size "$@"
>  }
> =20
>  # Returns success if a comma separated string of keywords ($1) contain=
s a
