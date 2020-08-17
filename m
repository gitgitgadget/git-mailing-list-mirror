Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D8BC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364422072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W4YPB+U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392114AbgHQTMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:12:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65016 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392036AbgHQTMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:12:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1789BDF36A;
        Mon, 17 Aug 2020 15:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pmfm1KOkn2+MMZ7q17BX0G71+Ms=; b=W4YPB+
        U28oGK//O5RFIFQ7P6U49djqJDKXxFCL8h/XWwDO4FOnZjB/lIcg6AqGwg/mN3vn
        9RgFmVWe9SqzgR+ZIzB3JssFZ/JFuhpexJvb0vAzfob6iKN28J9SAv1QSoR6bWM1
        wFdC++IfcRSClqHF/co/Z3n84vC56PrPGaknE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AonUDXdZw0JgdrcFfvPfgdHXowgrnfSY
        Yz5dOjxyA7IW52JnMZyLmBVfijYOetP1Y5TVFUj/xl3KruC6RhHMISGMQbq1zuDo
        KzcQhOrljb6aKhuh5/s6XJ3bD6Jllrub195YZADAAHDow9pb2miniO6yUowMyN8S
        fNPKW14Ei5Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1052ADF369;
        Mon, 17 Aug 2020 15:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B586DF366;
        Mon, 17 Aug 2020 15:12:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v8 2/5] am: stop exporting GIT_COMMITTER_DATE
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200817174004.92455-1-phillip.wood123@gmail.com>
        <20200817174004.92455-3-phillip.wood123@gmail.com>
Date:   Mon, 17 Aug 2020 12:12:29 -0700
In-Reply-To: <20200817174004.92455-3-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Mon, 17 Aug 2020 18:40:01 +0100")
Message-ID: <xmqqtux113z6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9951571A-E0BD-11EA-891C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The implementation of --committer-date-is-author-date exports
> GIT_COMMITTER_DATE to override the default committer date but does not
> reset GIT_COMMITTER_DATE in the environment after creating the commit
> so it is set in the environment of any hooks that get run. We're about
> to add the same functionality to the sequencer and do not want to have
> GIT_COMMITTER_DATE set when running hooks or exec commands so lets
> update commit_tree_extended() to take an explicit committer so we
> override the default date without setting GIT_COMMITTER_DATE in the
> environment.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/am.c     | 28 +++++++++++++++++++++++-----
>  builtin/commit.c |  4 ++--
>  commit.c         | 11 +++++++----
>  commit.h         |  7 +++----
>  ident.c          | 24 ++++++++++++++----------
>  sequencer.c      |  4 ++--
>  6 files changed, 51 insertions(+), 27 deletions(-)

Nice.

Obviously this would affect the environment while am is running, and
the change is observable by post-applypatch hook.  I am not sure if
this change-in-behaviour would negatively affect people's hooks, but
given the large end-user population we have, somebody somewhere will
get hit.

> diff --git a/ident.c b/ident.c
> index e666ee4e59..7cbf223350 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -361,11 +361,15 @@ N_("\n"
>  const char *fmt_ident(const char *name, const char *email,
>  		      enum want_ident whose_ident, const char *date_str, int flag)
>  {
> -	static struct strbuf ident = STRBUF_INIT;
> +	static int index;
> +	static struct strbuf ident_pool[2] = { STRBUF_INIT, STRBUF_INIT };
>  	int strict = (flag & IDENT_STRICT);
>  	int want_date = !(flag & IDENT_NO_DATE);
>  	int want_name = !(flag & IDENT_NO_NAME);
>  
> +	struct strbuf *ident = &ident_pool[index];
> +	index = (index + 1) % ARRAY_SIZE(ident_pool);

2-element rotating buffer because we happen to care at most two
idents at the same time, author's and committer's?

How many callers of fmt_ident() do we have these days?  I wonder if
we can introduce a new API that lets/forces the caller to prepare a
strbuf and migrate the current callers of this function to it, of if
it is too large a churn for the purpose of this series.

Thanks.
