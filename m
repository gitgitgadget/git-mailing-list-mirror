Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE44C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbiAFVJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:09:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60503 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiAFVJE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:09:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73001164436;
        Thu,  6 Jan 2022 16:09:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bZO9IA5sgF5qS40wWJm/wPZ+UXT8KkzrToKAH/
        YBU24=; b=sR2GGr3leV3tdqwAoeVqKprqUxn4IVs/N0PQZnBp+zo/65bcYKcvKx
        haC7Wp0UfZ5xpNrzMIzPQOzUiqb9tbNjNw+P/54xsJEAfSDLElH+VVC7tkpu0rYW
        ykOYqSNbFl1CegIEa8pZgh/+npJzSEO1uJn5exGkZSJ/S6IwcyQH8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BBFD164435;
        Thu,  6 Jan 2022 16:09:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D839E164433;
        Thu,  6 Jan 2022 16:09:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v5] builtin/reflog.c: use parse-options api for expire,
 delete subcommands
References: <pull.1175.v4.git.git.1641355561700.gitgitgadget@gmail.com>
        <pull.1175.v5.git.git.1641495981650.gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 13:09:00 -0800
In-Reply-To: <pull.1175.v5.git.git.1641495981650.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 06 Jan 2022 19:06:21 +0000")
Message-ID: <xmqq1r1kd11v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF6BD728-6F34-11EC-801A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Switching out manual arg parsing for the parse-options API for the
> expire and delete subcommands.
>
> Move explicit_expiry flag into cmd_reflog_expire_cb struct so callbacks
> can set both the value of the timestamp as well as the explicit_expiry
> flag.
>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---

Thanks.  Will queue.

>      @@ builtin/reflog.c: static void set_reflog_expiry_param(struct cmd_reflog_expire_c
>       +	const struct option options[] = {
>       +		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
>       +			EXPIRE_REFLOGS_DRY_RUN),
>      -+		OPT_BIT(0, "rewrite", &flags,
>      ++			OPT_BIT(0, "rewrite", &flags,
>       +			N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),

I think this change is a fat-finger; will correct while queuing.
