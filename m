Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825452095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbdCUSrV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:47:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55064 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933304AbdCUSps (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:45:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DD30656E2;
        Tue, 21 Mar 2017 14:45:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HCI1ZXsEnfjg
        2JFA1BL+QWPFetg=; b=GO3pcPsyXoVg91f0BE0akvnLX4YxduMhoOEiqCU+6fXz
        ILVMxl6ve3MEW1AWd3KM96Z6P9+YddyABwSbJ9gavPHunPOk2F+GI4XinsSz+P0P
        VIkGedtBuCsMz10eRIDQ0QZt2q9t2wFt3ZuO95NoXSkun6gQqZNJxdL08y/RYWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WNsSgB
        JuYfOaRSTSyCavg1U8EycwlupeJTapcslChVkkaWaaJyUcG4UEFccFuRbSP9Lyi7
        +25+X7vsjwyi2Bc6BFGmfv755Ah3pRIwoN14ATMSiBAqZLx21O4wUaKa8GyWBE9z
        F1571608M9ajxjhExcJCXPNsuMz3FJ4ik94ZA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D71F656E1;
        Tue, 21 Mar 2017 14:45:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B39FE656E0;
        Tue, 21 Mar 2017 14:45:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/16] tag: change misleading --list <pattern> documentation
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-11-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:45:44 -0700
In-Reply-To: <20170321125901.10652-11-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:55 +0000")
Message-ID: <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9807C29A-0E66-11E7-8EF2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> And after Jeff's change, one that took multiple patterns:
>
>     git tag --list 'v*rc*' --list '*2.8*'

I do not think this is a correct depiction of the evolution, and is
a confusing description.  It should say

    git tag --list 'v*rc*' '*2.8*'

instead.

When the logic was still in scripted Porcelain, <pattern> _was_ an
optional argument to the "-l" option (see b867c7c2 ("git-tag: -l to
list tags (usability).", 2006-02-17) you quoted earlier).  But way
before Jeff's change, when the command was reimplemented in C and
started using parse_options(), <pattern> stopped being an argument
to the "-l" option.  What Jeff's change did was that the original
code that only took

    git tag -l 'v*rc*'

to also take

    git tag -l 'v*rc*' '*2.8*'

i.e. multiple patterns.  Yes, thanks to parse_options, you could
have -l twice on the command line, but "multiple patterns" does not
have anything to do with having to (or allowing to) use '-l'
multiple times.

> But since it's actually a toggle all of these work as well, and
> produce identical output to the last example above:
>
>     git tag --list 'v*rc*' '*2.8*'
>     git tag --list 'v*rc*' '*2.8*' --list --list --list
>     git tag --list 'v*rc*' '*2.8*' --list -l --list -l --list

So citing Jeff's change is irrelevant to explain these.  I doubt you
even need to show these variations.

> Now the documentation is more in tune with how the "branch" command
> describes its --list option since commit cddd127b9a ("branch:
> introduce --list option", 2011-08-28).
>
> Change the test suite to assert that these invocations work for the
> cases that weren't already being tested for.

These two paragraphs are relevant.

> --l <pattern>::
> ---list <pattern>::
> -	List tags with names that match the given pattern (or all if no
> -	pattern is given).  Running "git tag" without arguments also
> -	lists all tags. The pattern is a shell wildcard (i.e., matched
> -	using fnmatch(3)).  Multiple patterns may be given; if any of
> -	them matches, the tag is shown.
> +-l::
> +--list::
> +	Activate the list mode. `git tag <pattern>` would try to create a

Dont say <pattern> on this line.  It is `git tag <name>`.

> +	tag, use `git tag --list <pattern>` to list matching branches, (or

Perhaps <pattern>... instead to signal that you can give multiple
patterns?

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 958c77ab86..1de7185be0 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -118,6 +118,18 @@ test_expect_success 'listing all tags if one exist=
s should succeed' '
>  	git tag
>  '
> =20
> +cat >expect <<EOF
> +mytag
> +EOF
> +test_expect_success 'Multiple -l or --list options are equivalent to o=
ne -l option' '
> +	git tag -l -l >actual &&
> +	test_cmp expect actual &&
> +	git tag --list --list >actual &&
> +	test_cmp expect actual &&
> +	git tag --list -l --list >actual &&
> +	test_cmp expect actual
> +'

The "-l/-d/-v" options follow the last-one-wins rule, no?  Perhaps
also show how this one works in this test (while retitling it)?

	git tag -d -v -l

> @@ -336,6 +348,15 @@ test_expect_success 'tag -l can accept multiple pa=
tterns' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'tag -l can accept multiple patterns interleaved w=
ith -l or --list options' '

Please drop "interleaved", as we are not encouraging GNUism.  We
just tolerate it but do not guarantee to keep them working.

> +	git tag -l "v1*" "v0*" >actual &&
> +	test_cmp expect actual &&
> +	git tag -l "v1*" --list "v0*" >actual &&
> +	test_cmp expect actual &&
> +	git tag -l "v1*" "v0*" -l --list >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'listing tags in column' '
>  	COLUMNS=3D40 git tag -l --column=3Drow >actual &&
>  	cat >expected <<\EOF &&
