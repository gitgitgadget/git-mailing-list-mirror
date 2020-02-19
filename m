Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B1AC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEF320801
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q100dokK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgBSR0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:26:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64081 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSR0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:26:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6408C08B0;
        Wed, 19 Feb 2020 12:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d1mdwMd7zG1/v5CzKpDw3NsfneY=; b=Q100do
        kKy/v+6tWlpQqUqOkEV1vqGrQgWDIUKuqL0uMcKDHZ2SzuCH+HI98zA052uGq+C5
        XzDJqMJcz4cMxTsM/a3pVibUhlbUj0rAtPJRYhapdP1eyPZYTNlvvQ00/ByLKxtz
        u641Gzmflx7V6X8frMBrHxn2VBzNewT3yEDrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mAOyYYBbaUpeN/r3WDwVBAuWU8hEw/K8
        Y12jV9I3ppurvUS9U5PTXB1tWO7b8msBLU7OzccfqOT8MylrJd+rwS+xUMfqx7sl
        KpUNEgqVQnZ+EHljCHhwRg2mciufwpJmNhoiF6eqr3naB7PHdxqR+8F1QfR6wpRX
        iKZHxTmwWNk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FFB7C08AF;
        Wed, 19 Feb 2020 12:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C54B4C08AD;
        Wed, 19 Feb 2020 12:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GSoC Patch 3/5] t4215: use lib-log-graph functions
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
        <20200216134750.18947-3-abhishekkumar8222@gmail.com>
Date:   Wed, 19 Feb 2020 09:26:10 -0800
In-Reply-To: <20200216134750.18947-3-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Sun, 16 Feb 2020 19:17:48 +0530")
Message-ID: <xmqqtv3mfpzh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED0A27A6-533C-11EA-8C84-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  t/t4215-log-skewed-merges.sh | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index 1d0d3240ff..bca478cb83 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -3,13 +3,7 @@
>  test_description='git log --graph of skewed merges'
>  
>  . ./test-lib.sh
> -
> -check_graph () {
> -	cat >expect &&
> -	git log --graph --pretty=tformat:%s "$@" >actual.raw &&
> -	sed "s/ *$//" actual.raw >actual &&
> -	test_cmp expect actual
> -}
> +. "$TEST_DIRECTORY"/lib-log-graph.sh
>  
>  test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
>  	git checkout --orphan _p &&
> @@ -22,7 +16,7 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
>  	git checkout _p && git merge --no-ff _r -m G &&
>  	git checkout @^^ && git merge --no-ff _p -m H &&
>  
> -	check_graph <<-\EOF
> +	test_cmp_graph --pretty=tformat:%s <<-\EOF

Almost exactly the same comment as [2/5] applies here, but luckily
the name of the local helper used here is check_graph, so we can
discard all the hunks after -22,7 above and instead use

	check_graph () {
		test_cmp_graph --format:%s "$@"
	}

to reduce the code churn, I would think.
