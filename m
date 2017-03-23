Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E1120958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935628AbdCWSTz (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:19:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55264 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932972AbdCWSTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:19:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C48D688ED1;
        Thu, 23 Mar 2017 14:19:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nKNY+BbZa4nEj93hZYeIXTizKSc=; b=g5fQj3
        oiaKkf8JdJZz+syer9rITzTeydRv0cuNryP+V16wqX+5FVkhkIu6OaWHBk9UuDg0
        rddzCjPgYVrIw7PPLKCZAZlYmeHEJBlMKwpCl5sN1yn0ff1Fe8o9ba3p938FL1Gc
        kFwzrZvf3/ADLhUZAVsC5rz3vMuIZOt2VoLF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rQ3ZFyHR2HiKqxgkr/ZJHP3g22AlSs4p
        HgaVQkmwDiGFjBpN88f/8ait5GVoHSMP21wEr8bFCCTxcO+7KWk4yn/LrSj/CDYN
        xEMmrDBdMTGoseCa2gP6FQB3Q4tFj2CgCaCPX/VVTxj7cGlVXwp9s7iEWmYmVnMk
        NNb5kyNUi7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB58F88ED0;
        Thu, 23 Mar 2017 14:19:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22E8788ECF;
        Thu, 23 Mar 2017 14:19:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] sequencer: fix missing newline
References: <20170323170233.50499-1-bmwill@google.com>
Date:   Thu, 23 Mar 2017 11:19:50 -0700
In-Reply-To: <20170323170233.50499-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 23 Mar 2017 10:02:33 -0700")
Message-ID: <xmqqzigbdfeh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ECCE822-0FF5-11E7-9A1B-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> When using rebase --interactive where one of the lines is marked as
> 'edit' this is the resulting output:
>
>     Stopped at ec3b9c4...  stuffYou can amend the commit now, with
>
>       git commit --amend
>
>     Once you are satisfied with your changes, run
>
>       git rebase --continue
>
> A newline character is missing at the end of the "Stopped at ..." line and
> before the "You can amend ..." line.  This patch fixes the malformed output by
> adding the missing newline character to the end of the "Stopped at ..." line.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Oops, obviously correct.  Thanks.

> diff --git a/sequencer.c b/sequencer.c
> index 8183a83c1..d76dc9cb2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1998,7 +1998,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  				struct commit *commit = item->commit;
>  				if (!res)
>  					fprintf(stderr,
> -						_("Stopped at %s...  %.*s"),
> +						_("Stopped at %s...  %.*s\n"),
>  						short_commit_name(commit),
>  						item->arg_len, item->arg);
>  				return error_with_patch(commit,
