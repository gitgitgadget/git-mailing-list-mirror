Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE32C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5320781
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uzi4JxVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgFZQgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:36:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63311 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgFZQgB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:36:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 692AEC9C94;
        Fri, 26 Jun 2020 12:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=13C4fKy7CxjXFaaQTrkfx1bDDI0=; b=Uzi4Jx
        VGdjI4EaF1CIWfk7e1+20h3bMkhNmdYcT54gYOUJbh5XChWw5OKO1GvQBPLHn4D0
        66R8mYAKFqN1wuZZobTp37hVW2Ecs1p34H+suX61nu6RgsCdG9mhbHzu2n+8e0jp
        B6Iw21WQxhzoEkQMIFHKk89GlItl1F72Lgw0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlOg6lpsmdmlw7S6vNbxK5FStmAt2riq
        aRWONw0ej0JVrfd/yzdXL0XlCN3I5UJYAwBer8d0aZ8y+YuvY7MYkl1ugN7payI9
        LHMiPhXUGOQmB0COniv42D9gpUCCCLtxoCH9yyIW+LN47rDVt6unnwKObCBQB+Hc
        lR+WFKt1Log=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 606BCC9C93;
        Fri, 26 Jun 2020 12:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D1F8C9C92;
        Fri, 26 Jun 2020 12:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] rebase: add --reset-author-date
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200626095528.117524-1-phillip.wood123@gmail.com>
        <20200626095528.117524-6-phillip.wood123@gmail.com>
Date:   Fri, 26 Jun 2020 09:35:54 -0700
In-Reply-To: <20200626095528.117524-6-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Fri, 26 Jun 2020 10:55:28 +0100")
Message-ID: <xmqqbll5hjit.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C243D54-B7CB-11EA-B573-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>
> The previous commit introduced --ignore-date flag to rebase -i, but the
> name is rather vague as it does not say whether the author date or the
> committer date is ignored. Add an alias to convey the precise purpose.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>

Hmph, did I?

> +		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
> +			 N_("ignore author date and use current date")),
> +		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
> +				N_("synonym of --reset-author-date")),

It is merely hidden but still supported.

> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> index 0ede2b8900..5b8963272a 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -117,53 +117,61 @@ test_ctime_is_ignored () {
>  	! grep -v +0000 authortime
>  }
>  
> -test_expect_success '--ignore-date works with apply backend' '
> +test_expect_success '--reset-author-date works with apply backend' '
>  	git commit --amend --date="$GIT_AUTHOR_DATE" &&
> -	git rebase --apply --ignore-date HEAD^ &&
> +	git rebase --apply --reset-author-date HEAD^ &&
>  	test_ctime_is_ignored -1
>  '

Are there still some tests that check "--ignore-date"?  We probably
should have them, if we are not removing the support.

Thanks.  The entire series looked reasonable to me.
