Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0BE2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdCRSoc (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:44:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60799 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751665AbdCRSob (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:44:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDA5D87DCA;
        Sat, 18 Mar 2017 14:43:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0wBjhqtJmXq7
        i3Pmcek+CTsnyqI=; b=Cb7uAq350YmUhLSP61gkNHi5tanL53E3GbXfh/EnlUNs
        R2QeUkd0Tqsl4dpWmQNazr6rsqElW2jdvXz08BIax/qv1myM1D48PemNs8HcO1hk
        aJ0sq3vj7tWJxvn81EnqxcVMt8XQBuhamHzfZlGzicuwzIY2NO9w2+ZDYPG/+0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=q0seFT
        VCGxGzZVYzkMsu49TzZRfrY7UZLFkfzJ6h9R2E/CUo6mX0GnvMxdI+EZ7HX74wqO
        U8MTcnP5PKr9c6Ns5RuOjXIqylzQV9fwEe5pzwAdKi/ybMDgH4D3apO57wtXFtM9
        ILnQoY38smBZEsFE3r58dBDN+Izi2xUUXOkEk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C44B887DC9;
        Sat, 18 Mar 2017 14:43:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14F2F87DC8;
        Sat, 18 Mar 2017 14:43:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 3/8] tag: Change  misleading --list <pattern> documentation
References: <20170318103256.27141-1-avarab@gmail.com>
        <20170318103256.27141-4-avarab@gmail.com>
Date:   Sat, 18 Mar 2017 11:43:47 -0700
In-Reply-To: <20170318103256.27141-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 18 Mar 2017 10:32:51 +0000")
Message-ID: <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2A9B614-0C0A-11E7-A611-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> However, documenting this as "-l <pattern>" was never correct, as
> these both worked before Jeff's change:
>
>     git tag -l 'v*'
>     git tag 'v*' -l

Actually, we do not particularly care about the latter, and quite
honestly, I'd prefer we do not advertise and encourage the latter.
Most Git commands take dashed options first and then non-dashed
arguments, and so should "git tag".  A more important example to
show why "-l <pattern>" that pretends <pattern> is an argument to
the option is wrong is this:

	git tag -l --merged X 'v*'

and this one

>     git tag --list 'v*rc*' '*2.8*'

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 74fc82a3c0..d36cd51fe2 100755
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

OK.  I do not care too deeply about this one, but somebody may want
to tighten up the command line parsing to detect conflicting or
duplicated cmdmode as an error in the future, and at that time this
will require updating.  I am not sure if we want to promise that
giving multiple -l will keep working.

> +test_expect_success 'tag -l can accept multiple patterns interleaved w=
ith -l or --list options' '
> +	git tag -l "v1*" "v0*" >actual &&

This is good thing to promise that we will keep it working.

> +	test_cmp expect actual &&
> +	git tag -l "v1*" --list "v0*" >actual &&
> +	test_cmp expect actual &&
> +	git tag -l "v1*" "v0*" -l --list >actual &&
> +	test_cmp expect actual

I'd prefer we do *not* promise that it will keep working if you give
pattern and then later any dashed-option like -l to the command by
having tests like these.

Thanks.
