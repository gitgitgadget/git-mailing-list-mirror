Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D80C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 22:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E42072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 22:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UVquk9SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCSW65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:58:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58805 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSW65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 18:58:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B627747C87;
        Thu, 19 Mar 2020 18:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=z+T2DBrKLI4l
        e5aQHgKvshuwCo8=; b=UVquk9SH+5CiZ7V6wg+BUKd5/q1/etmQ+oXedjoo4gdj
        RHsnHIe+79g+d0LJEBQTVVGOyH6qki2ZNVKG+h0MwDyvP27d6tLw1qHxBAvaMzQ8
        zPs5Px+cwn7FIsF6LMaBaqAXFqTN76KdA1za1uOT1ZSnd2PShCnrhjs156arpnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hjknLF
        aIZxq/Co6JQyaB7BlBs33AXMXnRhrvNHv5lyEmid1KI7Y18P+3UNT+S7p+E7T+9J
        pN2IaX7GN7Uv2FEh7G3Jm4IP/+EV3AveJIZp7yi/pt5vIeemyQCyslCpZQ7RcL1T
        yyxeBxupiDIv4GHZfQavw/Aj3u2de4zWOCasQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADD3447C86;
        Thu, 19 Mar 2020 18:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30EEC47C85;
        Thu, 19 Mar 2020 18:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] t4124: fix test for non-compliance diff
References: <cover.1584625896.git.congdanhqx@gmail.com>
        <285c6830c5182cb602d4fe559525083f69a158e9.1584625896.git.congdanhqx@gmail.com>
        <20200319163334.GG3513282@coredump.intra.peff.net>
Date:   Thu, 19 Mar 2020 15:58:51 -0700
In-Reply-To: <20200319163334.GG3513282@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 19 Mar 2020 12:33:34 -0400")
Message-ID: <xmqqlfnwc5p0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 33BE9268-6A35-11EA-AB08-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 19, 2020 at 09:00:07PM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=
=C3=B4ng Danh wrote:
>
>> POSIX's diff(1) requires output in normal diff format.
>> However, busybox's diff's output is written in unified format.
>
> That's a pretty big difference. I'm surprised this only produces one
> problem in the test scripts. ;)
>
>> POSIX requires no option for normal-diff format.
>>=20
>> A hint in test-lib-functions::test_cmp said `diff -u` isn't available
>> everywhere.
>>=20
>> Workaround this problem by assuming `diff(1)` output is unified
>> if we couldn't make anything from normal-diff format.

I do not mind working it around, but I am a bit disturbed by an
uneven attitude towards POSIX noncompliance this series has.  If
we were willing to break other people's "sed" that does not do BRE
correctly, instead of using '[+]' trick to accomodate them while
making sure that an implementation that does not use nonstandard
extension and does only BRE, we should just similarly be writing
such an implementation of noncompliant diff off as broken, yet we
bend backwards over to make sure we can work with them here. =20

IOW, I do not have trouble changing the test so that it works with
noncompliant "diff".  But then in the same series, I would prefer to
see the existing test keeps working with a possibly noncompliant
"sed" implementation that has been working well with the tests.

> But if this is the only spot, then adjusting to handle unified or norma=
l
> diff isn't too bad.

Yup.

> Could we then make a single invocation that covers both diff formats? W=
e
> can further observe that the only thing we do with the "fixed" file is
> count the lines, so we can leave the markers. Which means we could ditc=
h
> sed entirely and use grep. Something like:
>
> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 971a5a7512..15cb0c81b7 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -50,8 +50,9 @@ test_fix () {
>  	# fix should not barf
>  	apply_patch --whitespace=3Dfix || return 1
> =20
> -	# find touched lines
> -	$DIFF file target | sed -n -e "s/^> //p" >fixed
> +	# find touched lines; handle either normal or unified
> +	# diff, as system diff may generate either
> +	$DIFF file target | grep '^[>+][^+]' >fixed
> =20
>  	# the changed lines are all expected to change
>  	fixed_cnt=3D$(wc -l <fixed)
>
> seems to work for with both busybox diff and GNU diff.

Sounds OK to me.
