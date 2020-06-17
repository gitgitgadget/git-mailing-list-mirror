Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A8AC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F1120897
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PXi0Xm+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgFQSHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:07:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50646 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgFQSHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 14:07:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFF90E7560;
        Wed, 17 Jun 2020 14:07:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xndZaAWfbrGaInipLg7eV0CSxYY=; b=PXi0Xm
        +xaJBO49TwNsY7oJzGgNLsN2BKDADXzmh8lM4LGDkdh080cc5TLiS8kV+jPtMxpo
        Y9nXWF613y+bd3N7Ib9mO4SDrPE3mZc4kuZ6FA6JVF77v/1V4i/avitcDezgK3wn
        9JOvNtRKyadHu737WDLO8f789VVXllqRMrZOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aIUN+8SEUUALFosMmxPVwFcs1tg4RPDI
        6Ef/8n5fLm77omlkX/dfdWB4vQw3r8Bm5u1bbDCDmZuTmk3LyiWuCT/vzCC7dkFg
        axOBTcrWjRFGOFVCej5rZdCB6CX4bjNjLT+xiwz5cL3AhuTv8JE5d6MjUMzmWfZn
        rPBKTezj7Gk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8382E755F;
        Wed, 17 Jun 2020 14:07:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 146F7E755E;
        Wed, 17 Jun 2020 14:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/diff: fix incorrect comment
References: <a9aea5dbb821544eea636bc5de9fe8185bb603fb.1592219700.git.liu.denton@gmail.com>
Date:   Wed, 17 Jun 2020 11:07:16 -0700
In-Reply-To: <a9aea5dbb821544eea636bc5de9fe8185bb603fb.1592219700.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Jun 2020 07:15:07 -0400")
Message-ID: <xmqqzh91va5n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 619DC1F0-B0C5-11EA-8FC5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> A comment in cmd_diff() states that if one tree-ish and no blobs are
> provided, it would provide a diff between the tree and the cache. This
> is incorrect because a diff happens between the tree-ish and the working
> tree. Remove the `--cached` in the comment so that the correct behavior
> is shown.

Perhaps "diff-index [--cached]" is more appropriate, then?  After
all, "git diff --cached HEAD" would be N=1 M=0 case, no?

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 8537b17bd5..1ebab58c55 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -276,7 +276,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	 *	compare a blob with a working tree file.
>  	 *
>  	 * N=1, M=0:
> -	 *      tree vs cache (diff-index --cached)
> +	 *      tree vs files (diff-index)
>  	 *
>  	 * N=2, M=0:
>  	 *      tree vs tree (diff-tree)
