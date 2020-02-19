Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5BDC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCD820801
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UAhu0ux7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSRX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:23:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56507 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSRX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:23:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B126046F6C;
        Wed, 19 Feb 2020 12:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1hZkkRYMYXEBHxQDSiHRWiXXL18=; b=UAhu0u
        x7WBp8oGhvlVko0e/SFW9sLC5T0qHUv7eTBwaJvPeuMEY2atIbtJ4lKxHdKWRUDD
        nUmVslkJIHsu0zAEPDEtpzFmuSxsK13Wv0OVYJughG599oJ2MaxDdMIvOftJjxbT
        XNRt1cQ6RSa6Pb9lGRWfz7RXO11xvKrty8RfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tztlxf0MIyQhRLp0eXeBUdC+0RzJtJP8
        fetlHdsEhIbH6mmeb60QZc+rFfg9vgWPyyRMPohpLjzx7SjFaC9zyiN0VBqyJRoG
        mwmDSTp9ScaM207ptNRaFIcxMXiFMJYbfpo3gR3DmtIxUKdRQ42orVe3W+iL6cqg
        RvR0i3p1nXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8DA946F6B;
        Wed, 19 Feb 2020 12:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 083AC46F6A;
        Wed, 19 Feb 2020 12:23:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GSoC Patch 2/5] t3430: use lib-log-graph functions
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
        <20200216134750.18947-2-abhishekkumar8222@gmail.com>
Date:   Wed, 19 Feb 2020 09:23:19 -0800
In-Reply-To: <20200216134750.18947-2-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Sun, 16 Feb 2020 19:17:47 +0530")
Message-ID: <xmqqy2syfq48.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86A7ED0E-533C-11EA-B6AD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  t/t3430-rebase-merges.sh | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index e72ca348ea..74c61fa787 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -20,13 +20,7 @@ Initial setup:
>  '
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-rebase.sh
> -
> -test_cmp_graph () {
> -	cat >expect &&
> -	git log --graph --boundary --format=%s "$@" >output &&
> -	sed "s/ *$//" <output >output.trimmed &&
> -	test_cmp expect output.trimmed
> -}
> +. "$TEST_DIRECTORY"/lib-log-graph.sh
>  
>  test_expect_success 'setup' '
>  	write_script replace-editor.sh <<-\EOF &&
> @@ -84,7 +78,7 @@ test_expect_success 'create completely different structure' '
>  	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
>  	test_tick &&
>  	git rebase -i -r A master &&
> -	test_cmp_graph <<-\EOF
> +	test_cmp_graph --pretty=tformat:%s --boundary <<-\EOF

The original used a more readble short-hand "--format=%s"; was there
a strong reason why we wanted to use "--pretty=tformat:%s"?

The same comment applies to all the following hunks.

I actually have to wonder if this is a good change at all.  Surely
you lost one local and specialized test helper and replaced its use
with a more flexible one from the lib-log-graph file, but because
the one from the lib-log-graph is more flexible, you now need to
tell it what options the tests want to give to the "git log"
command, the same thing over and over, which would make it much more
error prone, no?

It would have been more acceptable if we kept test_cmp_graph a local
and specialized test helper defined in this file, but changed its
implementation (i.e. the 4 lines we see above) to call to a more
generic helper function defined in lib-log-graph file, i.e.

	test_cmp_graph () {
		test_cmp_graph_from_lib --boundary --format=%s "$@"
	}

but then the more flexible helper defined in lib-log-graph file
cannot squat on the short-and-sweet name "test_cmp_graph" that is
already used in the test scripts without unnecessary churn.

I dunno.
