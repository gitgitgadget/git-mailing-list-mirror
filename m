Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C0F202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 15:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965141AbdKGPMI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 10:12:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65410 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933887AbdKGPMH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 10:12:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CA4BA6FF3;
        Tue,  7 Nov 2017 10:12:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7PicHhOVKNxc3NLYK9X1W3foW90=; b=ORr1/2
        MXRi05pbfBy3rqgUMfRh1OOoNGeLZtFcrswZ6Lm7Fhr416a5cL09EwfGhssFuHAa
        lb7gpNUzMe3dh73b1Qi0BgDunwAHpLT/v+4IC2Daf5j+L9gzhwwupqFVan1OYSRC
        XbCp5s8xoJkYdoypBUrRAMUT9APzgXETJTKtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S3m9mgDMCkdbvundgJaGHbWe3Njkrjbq
        JjOHgjX9oQhCJ+XSVdIhipe1yqBCP204O0by3yuGNqOoQOv+PmCy6QfdYUl9BC8n
        w7izKIbk3LkQq2Dkba0KLaQP7Q0jnCoRbzTks63+8uQQPk0uy2nntzDi8I0mhHj8
        gmogr+H4eYE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33940A6FF2;
        Tue,  7 Nov 2017 10:12:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3C45A6FF1;
        Tue,  7 Nov 2017 10:12:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Teach "diff" to ignore only CR at EOL
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
        <20171107064011.18399-1-gitster@pobox.com>
        <alpine.DEB.2.21.1.1711071329280.6482@virtualbox>
Date:   Wed, 08 Nov 2017 00:12:05 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711071329280.6482@virtualbox> (Johannes
        Schindelin's message of "Tue, 7 Nov 2017 13:30:54 +0100 (CET)")
Message-ID: <xmqqinemdsxm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04A7A02E-C3CE-11E7-9F06-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Good. I was wishing for such a feature in the past.
>
> However, the short and sweet `-b` or `-w` switches are really, really
> nice. `--ignore-cr-at-eol` is just very cumbersome to type out. So I think
> you will want to add this patch to your patch series:

Yeah, I should probably have added that to 2/2 from the beginning.

> -- snipsnap --
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0e16f017a41..b7a45e8df29 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1400,7 +1400,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--patch-with-stat --name-only --name-status --color
>  			--no-color --color-words --no-renames --check
>  			--full-index --binary --abbrev --diff-filter=
> -			--find-copies-harder
> +			--find-copies-harder --ignore-cr-at-eol
>  			--text --ignore-space-at-eol --ignore-space-change
>  			--ignore-all-space --ignore-blank-lines --exit-code
>  			--quiet --ext-diff --no-ext-diff
