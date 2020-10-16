Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92928C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 23:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B72120878
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 23:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qe6EeDvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407447AbgJPXOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:14:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61314 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409430AbgJPXOf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 19:14:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B860282EDF;
        Fri, 16 Oct 2020 19:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=avbvziTz7K7ej9aaG0uwdsvwgTw=; b=qe6EeD
        vLnlczKm+W2TwAc56106yyeLNTXRv7u7Y1o6Xq0+4zDLSt/+sMSGsFFRGky7VHL2
        qXVoQTL8b3wtrfbc/xXoswHmIz54aLlvjBtvlIRgCkoTd6xHZa46MtRtY3F8jwdM
        uUDCviJzqYNuI/rH96flv/cvB89zC7XW+3nso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZEhnCR0xQdwki3VcSILqY9vW69rSYfHq
        o9fk0LS7cZIP/UMe0ToglC3mYa9W4TTuFG5dM+Z3HjIqFsaNsLuiuRqVMV/QMUkB
        0EIz0kCAETqq/bvBEN68B7J4ZVcSEtQi1JAVu+cKuqE8XgFBfqqW07e/gklGs1PH
        KOMgxB5ifV8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFD9D82EDE;
        Fri, 16 Oct 2020 19:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A76682EDD;
        Fri, 16 Oct 2020 19:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
References: <20200809060810.31370-1-sunshine@sunshineco.com>
        <20200809174209.15466-1-sunshine@sunshineco.com>
        <20201016001704.GA2937048@coredump.intra.peff.net>
        <CAPig+cSU=1GcQuqZab+0Vff_A-JmD59wEc3RMr3wDojpgRYUuw@mail.gmail.com>
        <xmqqzh4maugq.fsf@gitster.c.googlers.com>
        <xmqqv9f9ao0v.fsf@gitster.c.googlers.com>
Date:   Fri, 16 Oct 2020 16:14:31 -0700
In-Reply-To: <xmqqv9f9ao0v.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Oct 2020 13:56:00 -0700")
Message-ID: <xmqqy2k5931k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59369F4C-1005-11EB-9027-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  test_cmp() {
> -	test $# -eq 2 || BUG "test_cmp requires two arguments"
> -	if ! eval "$GIT_TEST_CMP" '"$@"'
> -	then
> -		test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
> -		test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
> -		return 1
> -	fi
> +	eval "$GIT_TEST_CMP" '"$@"'
>  }
>  
>  # Check that the given config key has the expected value.
> @@ -940,13 +934,7 @@ test_cmp_config() {
>  # test_cmp_bin - helper to compare binary files
>  
>  test_cmp_bin() {
> -	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
> -	if ! cmp "$@"
> -	then
> -		test "x$1" = x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
> -		test "x$2" = x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
> -		return 1
> -	fi
> +	cmp "$@"
>  }

Looking at this again, I think we could keep the "we should have two
arguments, no more than, no less than, but exactly two".  But I think
those who write new tests are working to eventually make them pass,
so hopefully they'll notice and investigate test_cmp that yields false
anyway, I guess.

