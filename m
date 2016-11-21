Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D07E1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 20:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754492AbcKUU0B (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:26:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51599 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753910AbcKUU0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:26:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD9804FD43;
        Mon, 21 Nov 2016 15:25:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MzUqy9j3RlE7HTKtRyanPNxwLCs=; b=sWzJiQ
        OQvRy4Cpv75PudgYAZinCO2kEpe2Ag2Na33mNrIEQQVBysnyiotSNhVaXPy6szj8
        P/tso20sClkn/OTucbI1JLO+z9cyYDi3QKLoj6X9eY4ug5qYXFH4X4NRssBK9KUu
        PoBy7v9rJR+wRqymHxPdh5vI0+BOpI41jeFjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X347BTbszkfDc1UVQUmIKhxMsYsmrbeW
        EDVp+RDHDTHB61vbJzeUNZ4aArxcJ6yZZFzgk2LcI7l7i8x/yixk1zz0d05C3uzW
        lSnm5n+V8r31oRoflHocQew0GHE1mlLNXiKDIg9nOWKdb8RgDcZcAfp2BYqWGjAB
        EpEOv/v157E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5DC44FD42;
        Mon, 21 Nov 2016 15:25:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37DF74FD41;
        Mon, 21 Nov 2016 15:25:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] rebase -i: highlight problems with core.commentchar
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
        <20161121190514.18574-1-gitster@pobox.com>
Date:   Mon, 21 Nov 2016 12:25:24 -0800
In-Reply-To: <20161121190514.18574-1-gitster@pobox.com> (Junio C. Hamano's
        message of "Mon, 21 Nov 2016 11:05:12 -0800")
Message-ID: <xmqqpoloinrf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A279D0E8-B028-11E6-B31E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The interactive rebase does not currently play well with
> core.commentchar. Let's add some tests to highlight those problems
> that will be fixed in the remainder of the series.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Sorry, I should have commented here after --- line what changes were
proposed by this set of amends.

>  t/t0030-stripspace.sh         |  9 +++++++++
>  t/t3404-rebase-interactive.sh | 11 +++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> index 29e91d861c..c1f6411eb2 100755
> --- a/t/t0030-stripspace.sh
> +++ b/t/t0030-stripspace.sh
> @@ -432,6 +432,15 @@ test_expect_success '-c with changed comment char' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_failure '-c with comment char defined in .git/config' '
> +	test_config core.commentchar = &&
> +	printf "= foo\n" >expect &&
> +	printf "foo" | (
> +		mkdir sub && cd sub && git stripspace -c
> +	) >actual &&
> +	test_cmp expect actual
> +'

I noticed that the lack of "\n" at the end was merely copied from the
previous existing test (i.e. "-c with with changed comment char"),
which was already wrong the same way, so I kept that part as-is.

Running "stripspace" in a subdirectory is to avoid the ".git/config
was read without repository discovery as long as the command runs at
the top-level of the working tree" accident so that this highlights
the breakage with or without Peff's b9605bc4f2 ("config: only read
.git/config from configured repos", 2016-09-12).


> +
>  test_expect_success 'avoid SP-HT sequence in commented line' '
>  	printf "#\tone\n#\n# two\n" >expect &&
>  	printf "\tone\n\ntwo\n" | git stripspace -c >actual &&
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index d6d65a3a94..d941f0a69f 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -983,6 +983,17 @@ test_expect_success 'rebase -i respects core.commentchar' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_failure 'rebase -i respects core.commentchar=auto' '
> +	test_config core.commentchar auto &&
> +	write_script copy-edit-script.sh <<-\EOF &&
> +	cp "$1" edit-script
> +	EOF
> +	test_set_editor "$(pwd)/copy-edit-script.sh" &&
> +	test_when_finished "git rebase --abort || :" &&
> +	git rebase -i HEAD^ &&
> +	test -z "$(grep -ve "^#" -e "^\$" -e "^pick" edit-script)"
> +'
> +

Removed from here is a leftover debugging bit (grep "^#"
edit-script).

