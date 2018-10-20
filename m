Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7671F453
	for <e@80x24.org>; Sat, 20 Oct 2018 23:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeJUIJz (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 04:09:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33917 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeJUIJz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 04:09:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id z25-v6so6509128wmf.1
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=o0IMFqrJ+vva8aATJxqisML+de/qtIBQaODZRWuzMOg=;
        b=bV7zEmRgdiV+tzJNkbwMB1MU/SrtlknkNERRXSBYaYDCK6Gc1FPdaRR3n22LzVQ9tK
         60loWXBWvl9fA10IFQLOduM3tKEQatBZDExzKwUn4WPJxy1ECQO/iZztfh2SaEwyLEhL
         D33qKDo3b+PkYHFTk0Q/SOcRweO4hnrLHVnfuJlzxN8Lu9ARLAMntYEdqxnZJncOyvzm
         GlS/quX9BEHPHFdz8oIn2SjLKueIo8bM3QUewVL1KChls0bmh5ucetQuhsz/ZvIEeCrU
         udB4YA+eOL1zdVdef/qFuVBxc8zLZ75Lwd3p9K9VqGjqobB1c4NIx1aASn8Cu2s2wVqr
         iIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=o0IMFqrJ+vva8aATJxqisML+de/qtIBQaODZRWuzMOg=;
        b=ffcHV9XJGxgvbmP5M71Rb2ZxLnY7sjFvtXxhlid82gOE683LwWS/Zlt1RcYDkTkRA5
         Uplf2v3oqOIf0f+9bDzygTtNBKmTEKon8rn4N0DAc4AASjRbvBXDj/9yqFd+FkcBV4UZ
         bxyW0d+UjePegFAY23bI8I1Dy18ztqka9DuYDEq1ZtRzUz3y9yJvDGhA15diPGdnc1S2
         DkPKONNeCl9Trl7qVCK0nRyYX6t2tKu+0HebDQtLf7S5DBR4RWW+WL4iO4KDNoNaz39r
         vg+GuRhdBCe8uEjGSZE7d9PkCwOU5RHNM78rPwOzeT0lHQsCJ9ATztvuoc5mx8KJ/aNU
         JXAg==
X-Gm-Message-State: ABuFfoguCffZm7fZ01OlBF8pcTdfU8VtuH9XcaaV8tG1MYoCWVeF+/9z
        JUYbMHEW6WKYV/p4MzQSGxbdhR55gRM=
X-Google-Smtp-Source: ACcGV608p6bc+nBqmv7Z5oT1Djpwf22k8mDcMwJ+wy3v50/Eh48Hyyby9Or2tOlMAlw2JQdnmnYL1g==
X-Received: by 2002:a1c:958d:: with SMTP id x135-v6mr10806868wmd.46.1540079858649;
        Sat, 20 Oct 2018 16:57:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 134-v6sm5331210wmb.13.2018.10.20.16.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 16:57:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple signatures on commits
References: <20181020193020.28517-1-mgorny@gentoo.org>
Date:   Sun, 21 Oct 2018 08:57:36 +0900
In-Reply-To: <20181020193020.28517-1-mgorny@gentoo.org> (=?utf-8?Q?=22Mich?=
 =?utf-8?Q?a=C5=82_G=C3=B3rny=22's?=
        message of "Sat, 20 Oct 2018 21:30:20 +0200")
Message-ID: <xmqqin1wyxvz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

> GnuPG supports creating signatures consisting of multiple signature
> packets.  If such a signature is verified, it outputs all the status
> messages for each signature separately.  However, git currently does not
> account for such scenario and gets terribly confused over getting
> multiple *SIG statuses.
>
> For example, if a malicious party alters a signed commit and appends
> a new untrusted signature, git is going to ignore the original bad
> signature and report untrusted commit instead.  However, %GK and %GS
> format strings may still expand to the data corresponding
> to the original signature, potentially tricking the scripts into
> trusting the malicious commit.
>
> Given that the use of multiple signatures is quite rare, git does not
> support creating them without jumping through a few hoops, and finally
> supporting them properly would require extensive API improvement, it
> seems reasonable to just reject them at the moment.
>
> Signed-off-by: Michał Górny <mgorny@gentoo.org>
> ---
>  gpg-interface.c          | 90 +++++++++++++++++++++++++++-------------
>  t/t7510-signed-commit.sh | 26 ++++++++++++
>  2 files changed, 87 insertions(+), 29 deletions(-)
>
> Changes in v4:
> * switched to using skip_prefix(),
> * renamed the variable to seen_exclusive_status,
> * made the loop terminate early on first duplicate status seen.

Thanks for sticking to the topic and polishing it further.  Looks
very good.  

Will replace.

> +	int seen_exclusive_status = 0;
> +
> +	/* Iterate over all lines */
> +	for (line = buf; *line; line = strchrnul(line+1, '\n')) {
> +		while (*line == '\n')
> +			line++;
> +		/* Skip lines that don't start with GNUPG status */
> +		if (!skip_prefix(line, "[GNUPG:] ", &line))
> +			continue;
> +
> +		/* Iterate over all search strings */
> +		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> +			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
> +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
> +					if (++seen_exclusive_status > 1)
> +						goto found_duplicate_status;

Very minor point but by not using pre-increment, i.e.

		if (seen_exclusive_status++)
			goto found_duplicate_status;

you can use the expression as a "have we already seen?" boolean,
whic may probably be more idiomatic.

The patch is good in the way written as-is, and this is so minor
that it is not worth rerolling to only update this part.

Thanks.

