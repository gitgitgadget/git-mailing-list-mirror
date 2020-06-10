Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8386AC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A10A2074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PYYDNKWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgFJXAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:00:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52402 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJXAH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 19:00:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AF2676963;
        Wed, 10 Jun 2020 19:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CML4Rc69yFCZD/z7UBSQiFG3e8M=; b=PYYDNK
        WwJl5krnn4zedw6MwpKsuQJcVMe09o0DHCLVfePCgbJF3QYwnFJDgzbOclLv05dA
        TEQ+uvDlrFZAaJgTP+Nsm9Y37lt5Sk9F3GCvIL4O29zBqW5r2gs22EV3fGiCOkyu
        xUe1fx5C6WQQS/KBVBvitqhKTxQocOdaAsu5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pm9FYewsOGhDVv9dS61/158Y9khsdhX/
        QpbA+0v6+NJGmRKYo6ldJcTFC7ISUTBePXKjV1HneM845V1rhEEjdXjmFOH9eFlI
        oZxUvFWhDelMtYOm+4gGk2qBtShgU8SlvbOhc1/RTtS/6bkrmEJ2Vp0oq9P/q7vU
        E/m3z6MXb68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB3DD76961;
        Wed, 10 Jun 2020 19:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0629176959;
        Wed, 10 Jun 2020 19:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 7/9] fmt-merge-msg: learn about the possibly-configured default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <e849def4a8c5cc291839ef4514a386df0c148b2e.1591823971.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 15:59:59 -0700
In-Reply-To: <e849def4a8c5cc291839ef4514a386df0c148b2e.1591823971.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 10 Jun 2020
        21:19:28 +0000")
Message-ID: <xmqqo8pqedcg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C75BBF2-AB6E-11EA-BFDD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When formatting the commit message for merge commits, Git appends "into
> <branch-name>" unless the current branch is the default branch.
>
> Now that we can configure what the default branch name should be, we
> will want to respect that setting in that scenario rather than using the
> compiled-in default branch name.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fmt-merge-msg.c          | 6 ++++--
>  t/t6200-fmt-merge-msg.sh | 8 ++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index 72d32bd73b1..5e5c1d86f1c 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -407,7 +407,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  				const char *current_branch)
>  {
>  	int i = 0;
> -	char *sep = "";
> +	char *sep = "", *default_branch_name;
>  
>  	strbuf_addstr(out, "Merge ");
>  	for (i = 0; i < srcs.nr; i++) {
> @@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  			strbuf_addf(out, " of %s", srcs.items[i].string);
>  	}
>  
> -	if (!strcmp("master", current_branch))
> +	default_branch_name = git_default_branch_name(1);
> +	if (!strcmp(default_branch_name, current_branch))
>  		strbuf_addch(out, '\n');
>  	else
>  		strbuf_addf(out, " into %s\n", current_branch);
> +	free(default_branch_name);
>  }

Good.  J6t reminded me earlier about this one when I said "except
for 'init' and 'clone' (when it cannot tell what primary branch the
source of the clone uses), we do not need a hardcoded 'master'", and
the series covers this case.  Very pleased.


>  static void fmt_tag_signature(struct strbuf *tagbuf,
> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> index e4c2a6eca43..a23cd157ffd 100755
> --- a/t/t6200-fmt-merge-msg.sh
> +++ b/t/t6200-fmt-merge-msg.sh
> @@ -158,6 +158,14 @@ test_expect_success 'setup FETCH_HEAD' '
>  	git fetch . left
>  '
>  
> +test_expect_success 'with overridden default branch name' '
> +	test_config core.defaultBranchName default &&
> +	test_when_finished "git switch master" &&
> +	git switch -c default &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> +	! grep "into default" actual
> +'
> +
>  test_expect_success 'merge.log=3 limits shortlog length' '
>  	cat >expected <<-EOF &&
>  	Merge branch ${apos}left${apos}
