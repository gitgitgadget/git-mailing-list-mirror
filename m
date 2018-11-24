Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389C81F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 04:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeKXPBk (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 10:01:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54782 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbeKXPBk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 10:01:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A61C123A5D;
        Fri, 23 Nov 2018 23:14:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ks2c2pq9P5xT
        Tdt7wUeTMcLr9gs=; b=wzPJaN6BLqSxY8N4QB7x5rfBGjlUpk0jh/UidCyreHGF
        yMm2FuQImZ+xZruZ2Bs/rSdX+R8D/S+v7RCdpl16GDl8jSXba8SKKxUhAuUxZyLw
        3Bv6XhrsxuS7DfyxSMvosnJ+QZEtQBZzmdm/Y0c9kWI4NMX861Zzmhpt9RT2tKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=esiiQq
        L2wc+A+lJxNry+3nuDITLmJNOSdXll7GE/c5i5drshDH/90az2S+TrN3FcUfLwOy
        r/4UeeKhHqbwDxbT8FSWDi67kA+2UkHbZ0hykAONBYAkUIbFtEp0QRg01MxlEWl0
        QM2dnaHYx68+ipBXvqMah5cmWvozo+2O3H0RU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F2CC23A5C;
        Fri, 23 Nov 2018 23:14:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B312C23A5A;
        Fri, 23 Nov 2018 23:14:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] format-patch: add a more exhaustive --range-diff test
References: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
        <20181122211248.24546-2-avarab@gmail.com>
Date:   Sat, 24 Nov 2018 13:14:37 +0900
In-Reply-To: <20181122211248.24546-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 22 Nov 2018 21:12:47 +0000")
Message-ID: <xmqqo9af2jte.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 763EC55C-EF9F-11E8-8D0D-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the narrow test added in 31e2617a5f ("format-patch: add
> --range-diff option to embed diff in cover letter", 2018-07-22) to
> test the full output. This test would have spotted a regression in the
> output if it wasn't beating around the bush and tested the full
> output, let's do that.

This looks wrong, given that we are declaring that showing the
broken --stat in the output is wrong.  It makes us to expect a
known-wrong output from the command.

If the theme of the topic were "what we are giving by default is a
sensible output when --stat is asked for, but it is rather too noisy
and our default should be quieter---let's tone it down", then this
patch in 1/2 and then a behaviour-change patch with updated
expectation would make sense, but I do not think that is what you
are aiming for with this series.

Perhaps squash this into the real "fix" to show what the desired
output should look like with the same patch?

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t3206-range-diff.sh | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index e497c1358f..0235c038be 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -249,11 +249,28 @@ for prev in topic master..topic
>  do
>  	test_expect_success "format-patch --range-diff=3D$prev" '
>  		git format-patch --stdout --cover-letter --range-diff=3D$prev \
> -			master..unmodified >actual &&
> -		grep "=3D 1: .* s/5/A" actual &&
> -		grep "=3D 2: .* s/4/A" actual &&
> -		grep "=3D 3: .* s/11/B" actual &&
> -		grep "=3D 4: .* s/12/B" actual
> +			master..unmodified >actual.raw &&
> +		sed -e "s|^:||" -e "s|:$||" >expect <<-\EOF &&
> +		:1:  4de457d =3D 1:  35b9b25 s/5/A/
> +		:     a =3D> b | 0
> +		:     1 file changed, 0 insertions(+), 0 deletions(-)
> +		:    :
> +		:2:  fccce22 =3D 2:  de345ab s/4/A/
> +		:     a =3D> b | 0
> +		:     1 file changed, 0 insertions(+), 0 deletions(-)
> +		:    :
> +		:3:  147e64e =3D 3:  9af6654 s/11/B/
> +		:     a =3D> b | 0
> +		:     1 file changed, 0 insertions(+), 0 deletions(-)
> +		:    :
> +		:4:  a63e992 =3D 4:  2901f77 s/12/B/
> +		:     a =3D> b | 0
> +		:     1 file changed, 0 insertions(+), 0 deletions(-)
> +		:    :
> +		:-- :
> +		EOF
> +		sed -ne "/^1:/,/^--/p" <actual.raw >actual &&
> +		test_cmp expect actual
>  	'
>  done
