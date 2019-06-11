Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28A91F462
	for <e@80x24.org>; Tue, 11 Jun 2019 20:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406051AbfFKUKr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 16:10:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63117 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405799AbfFKUKr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 16:10:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1BDD168B4B;
        Tue, 11 Jun 2019 16:10:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OhVt7fQOFo+JDPpFsgotcBCHT0g=; b=pKlBPg
        0LLdbx6kv2fS3UX19iF6rz5F6jWSDjt8eL/beAgEsmv17uXWWlNDsPwPTni+WP9g
        70wrTLTMyvAy5lRq6xB5JVI9IoiuaUDuRH1WZOJncy07pLj9LAP4YL6NrDLb4YgF
        TkrdGA5zEnhQP/LXwOyO9SvIK4PZ/MnSTQIgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A5d33yUE1tB/EynPOCRVykS8HBIoF15R
        1d35/F9zM6Bmjl82mJvzvSqEJpQAvVvkFkpOf/2jPanuLiBvzED23++XIqseTsc+
        Hy6599qJxOjwcIVeAC8r9oHrvvWtXjgkqomTpjiMnNVVDkarBTWDnNcFsRyf+39O
        ZWi0E+4arXA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1257668B4A;
        Tue, 11 Jun 2019 16:10:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CCDFB68B49;
        Tue, 11 Jun 2019 16:10:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/1] ref-filter: sort detached HEAD lines firstly
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
        <cover.1560277373.git.matvore@google.com>
        <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
Date:   Tue, 11 Jun 2019 13:10:41 -0700
In-Reply-To: <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
        (Matthew DeVore's message of "Tue, 11 Jun 2019 11:28:18 -0700")
Message-ID: <xmqq7e9rlw72.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE1FB7F6-8C84-11E9-8F8E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> -	if (s->version)
> +	if (s->version) {
>  		cmp = versioncmp(va->s, vb->s);
> -	else if (cmp_type == FIELD_STR)
> -		cmp = cmp_fn(va->s, vb->s);
> -	else {

Ah, this must be the patch noise Jonathan was (half) complaining
about.  It does make it a bit distracting to read the patch but the
resulting code is of course easier to follow ;-).

> +	} else if (cmp_type == FIELD_STR) {
> +		const int a_detached = a->kind & FILTER_REFS_DETACHED_HEAD;
> +
> +		/*
> +		 * When sorting by name, we should put "detached" head lines,
> +		 * which are all the lines in parenthesis, before all others.
> +		 * This usually is automatic, since "(" is before "refs/" and
> +		 * "remotes/", but this does not hold for zh_CN, which uses
> +		 * full-width parenthesis, so make the ordering explicit.
> +		 */
> +		if (a_detached != (b->kind & FILTER_REFS_DETACHED_HEAD))
> +			cmp = a_detached ? -1 : 1;

So, comparing a detached and an undetached ones, the detached side
always sorts lower.  Good.  And ...

> +		else
> +			cmp = cmp_fn(va->s, vb->s);

... otherwise we compare the string using the given function.

Sounds sensible.  Will queue.
