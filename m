Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F081F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfFSP3g (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:29:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51543 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFSP3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:29:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A9D76162F;
        Wed, 19 Jun 2019 11:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=veZcs9hpziphLOCjPn+tXR45/GU=; b=vuFRov
        6Z2yAg81z9pXNRAZbuDXwPxeJVPyX56SsoVEqJaWcD3pX96tIr8xFjJarLFssv0I
        cEejOqEdtbcxS+zgUTbPPl/5GBZjyq8Z0lRLkvNJMI5hZujoSMWY3ALUeZDVVzSg
        rs1rvBIAfwDoHNeBJQrsx3o2FV49D93xJ3S+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vhA/dTskv9op/BNKY1kv5KtS7guCGAC1
        qFRloA5HvRSkkC5AzeAAoLZSglaxrdM2ni+T2PftPU94ccpVzq7iEgDWR+fEIzpw
        ZsWvLjPNCiOHMC8HknwveeH3o3+8ZSXDa4wjssE8pGZyZ9WtPfzoZYnwqiGv54md
        UZW0ex7rMSQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0291C6162D;
        Wed, 19 Jun 2019 11:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 260DF61629;
        Wed, 19 Jun 2019 11:29:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] ref-filter: sort detached HEAD lines firstly
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
        <cover.1560895672.git.matvore@google.com>
        <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
Date:   Wed, 19 Jun 2019 08:29:29 -0700
In-Reply-To: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
        (Matthew DeVore's message of "Tue, 18 Jun 2019 15:29:15 -0700")
Message-ID: <xmqqv9x1pp9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09B7D01C-92A7-11E9-B432-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> ... By
> removing the parenthesis from the localizable text, we can share strings
> with wt-status.c and remove a cautionary comment to translators.
...
> -			/*
> -			 * TRANSLATORS: make sure this matches "HEAD
> -			 * detached at " in wt-status.c
> -			 */
> -			strbuf_addf(&desc, _("(HEAD detached at %s)"),
> -				state.detached_from);
> +			strbuf_addstr(&desc, HEAD_DETACHED_AT);
>  		else
> -			/*
> -			 * TRANSLATORS: make sure this matches "HEAD
> -			 * detached from " in wt-status.c
> -			 */
> -			strbuf_addf(&desc, _("(HEAD detached from %s)"),
> -				state.detached_from);
> +			strbuf_addstr(&desc, HEAD_DETACHED_FROM);

Very nice ;-)

> +		strbuf_addstr(&desc, state.detached_from);
>  	}
>  	else
> -		strbuf_addstr(&desc, _("(no branch)"));
> +		strbuf_addstr(&desc, _("no branch"));
> +	strbuf_addch(&desc, ')');
> +
>  	free(state.branch);
>  	free(state.onto);
>  	free(state.detached_from);
>  	return strbuf_detach(&desc, NULL);
>  }

> diff --git a/wt-status.h b/wt-status.h
> index 64f1ddc9fd..b0cfdc8011 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -58,20 +58,23 @@ struct wt_status_change_data {
> ...
>  
> +#define HEAD_DETACHED_AT _("HEAD detached at ")
> +#define HEAD_DETACHED_FROM _("HEAD detached from ")
> +
>  struct wt_status_state {

These too.
