Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D04A215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756029AbcJLVYv (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:24:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51567 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755111AbcJLVYt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:24:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26B8646882;
        Wed, 12 Oct 2016 17:24:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h8+3Dcdp5ps+tD7UHb7K06AysEQ=; b=BPdygH
        K2PjVCC/NYfM5UsymaaCUsRuMthZ0epdU/jdUiJum2JX39wAA7zv4rdoCD6O8hX6
        DTaflUyoMUPIz8+adqO5qDoQOwCLqye2SxxYNM9ZR3TO6p62hUZkedsSq0yBOFQC
        7EObZlt8+2a6dC3VFDftvJSWQcWXaBVxhbRQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jFvRFefcNtR4Dn3c0bp4vk/97CFY6Y5l
        L6rd53lu5Mpmww5tpa4zGi/A/8C1MYC8/CIiiTqnIvWyUZdA48kBIk6daTUI/N7E
        0+W+5DcrO/htQcU2FD6rvdxFaYjIgLfPEw4uLb6waT3ASEz4OQqwgSBGqvqzFRE4
        ouJaWLgoTB8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E1E846881;
        Wed, 12 Oct 2016 17:24:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C03E46880;
        Wed, 12 Oct 2016 17:24:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 25/25] sequencer: mark all error messages for translation
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <e38bf77ff57d06ca3250bc3ec71a34088b49abd0.1476120229.git.johannes.schindelin@gmx.de>
        <d24a3823-1ed0-ad97-f02d-febab7a97590@kdbg.org>
Date:   Wed, 12 Oct 2016 14:24:30 -0700
In-Reply-To: <d24a3823-1ed0-ad97-f02d-febab7a97590@kdbg.org> (Johannes Sixt's
        message of "Wed, 12 Oct 2016 22:46:15 +0200")
Message-ID: <xmqqlgxt2rch.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 445EC9F8-90C2-11E6-B87A-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Can we please have the following change instead? I think it makes sense
> to deviate from the usual conventions in a case like this.

You have at least two independent changes relative to Dscho's
version.  

 (1) Show line breaks more prominently by avoiding "\n\n" and
     breaking the string at "\n"; this matches the way how the
     result would be displayed more closely to how the source looks
     like.

 (2) Ignore the usual indentation rule and have messages start at
     the left end of the source.

Which one are you saying "makes sense" to?  Both?

I guess both can be grouped together into one theme: match the way
the final output and the source code look like.

If that is the motivation behind "makes sense", I'd prefer to see
the change explained explicitly with that rationale in the log
message.

Thanks.  I personally agree with that motivation (if the one I
guessed above is your motivation, that is).

> Note that this is an error() text, hence, there should not be a
> fullstop on the first line. That's now a good excuse to start the next
> sentence on a new line; hence, this is not a faithful conversion to _()
> anymore (a will happily take authorship and all blame if you don't
> want to for this reason). Also note that _( is not moved to the
> beginning of the line because it would be picked up as hunk header by
> git diff.
>
> ---- 8< ----
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Subject: [PATCH] sequencer: mark all error messages for translation
>
> There was actually only one error message that was not yet marked for
> translation.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  sequencer.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 95a382e..79f7aa4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -515,16 +515,20 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  		if (!env) {
>  			const char *gpg_opt = gpg_sign_opt_quoted(opts);
>  
> -			return error("you have staged changes in your working "
> -				"tree. If these changes are meant to be\n"
> -				"squashed into the previous commit, run:\n\n"
> -				"  git commit --amend %s\n\n"
> -				"If they are meant to go into a new commit, "
> -				"run:\n\n"
> -				"  git commit %s\n\n"
> -				"In both cases, once you're done, continue "
> -				"with:\n\n"
> -				"  git rebase --continue\n", gpg_opt, gpg_opt);
> +			return error(_(
> +"you have staged changes in your working tree\n"
> +"If these changes are meant to be squashed into the previous commit, run:\n"
> +"\n"
> +"  git commit --amend %s\n"
> +"\n"
> +"If they are meant to go into a new commit, run:\n"
> +"\n"
> +"  git commit %s\n"
> +"\n"
> +"In both cases, once you're done, continue with:\n"
> +"\n"
> +"  git rebase --continue\n"),
> +				     gpg_opt, gpg_opt);
>  		}
>  	}
