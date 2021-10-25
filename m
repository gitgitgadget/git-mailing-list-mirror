Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745BC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F59C60ED4
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJYQMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:12:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59817 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJYQMc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:12:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25CFA16A12F;
        Mon, 25 Oct 2021 12:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EBhRXJE0x47b
        /y3MvWnJfnOLRit6+QQbgRNLRJvyV6w=; b=SlyDqDekgU9w1QrznOXgaAQJv1eY
        48QsMAM+ZJdQietkVZBxj+fnxrBPjUywXyB0sKhMjtulZ6wT+SQH4vKCnDqXf0uy
        MYMxOttBZq5AJ1XFYyMQnB+Mr4T8BJWEJgBzJ/kSjkModXrNksn8W1vBnDPPuTW1
        AbhcFPBst0YcFrE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DF9916A12E;
        Mon, 25 Oct 2021 12:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7391416A12B;
        Mon, 25 Oct 2021 12:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] command-list.txt: remove 'sparse-index' from main help
References: <20211024170730.3428123-1-szeder.dev@gmail.com>
Date:   Mon, 25 Oct 2021 09:10:06 -0700
In-Reply-To: <20211024170730.3428123-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sun, 24 Oct 2021 19:07:30 +0200")
Message-ID: <xmqqmtmx2iht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05859DCE-35AE-11EC-B400-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Ever since 'git sparse-checkout' was introduced [1] it is included in
> 'git --help' in the section "work on the current change" along with
> the commands 'add', 'mv', 'restore', and 'rm'.  It clearly doesn't
> belong to that group, moreover it can't be considered such a common
> command to belong to 'git --help' in the first place, so remove it
> from there.
>
> [1] 94c0956b60 (sparse-checkout: create builtin with 'list'
>                 subcommand, 2019-11-21)
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  command-list.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Redirecting to Stolee just in case for an Ack.

I tend to agree that this is a housekeeping command for a local
repository to control what are and what are not materialized in the
working tree.  It does not directly affect the history produced from
there, similar to "git gc" is, so in that sense, I do not think we
would miss it in the "list of usual commands".

If I had to have it in some category, I do agree with the current
code that it belongs to the "worktree" family, though.

Thanks, will queue.

> diff --git a/command-list.txt b/command-list.txt
> index a289f09ed6..eb9cee8dee 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -168,7 +168,7 @@ git-show-index                          plumbingint=
errogators
>  git-show-ref                            plumbinginterrogators
>  git-sh-i18n                             purehelpers
>  git-sh-setup                            purehelpers
> -git-sparse-checkout                     mainporcelain           worktr=
ee
> +git-sparse-checkout                     mainporcelain
>  git-stash                               mainporcelain
>  git-stage                                                             =
  complete
>  git-status                              mainporcelain           info
