Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C981F731
	for <e@80x24.org>; Fri,  2 Aug 2019 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfHBVEQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 17:04:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56958 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfHBVEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 17:04:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56F3080E68;
        Fri,  2 Aug 2019 17:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MXQQeGhZ5YuvdOIBAjvJ5nwBpL4=; b=KdplKQ
        zyiDq1ijMrZ8Ui6iiP9NysGbzfZPFeHWeHBDaVdhhLnZCMW15xzKmGw+DXlGqUqF
        SMM6ZbykJ0L/2BgHtz3Qz033WwokdUPPOKuTF7s1Wtb0x9702mwbVcy1WFqM550f
        6uFKtHmrp+eX3m8cpQV9dmuQVtWm0ElnloEE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JmVYrw3UJNsGBafAzbv6anvIlcEG98lY
        EKxhOXoz3Cv1LihQv/Z1RkzKieDCSmT+fvaWuxu+ooJ4DRK1Dnv3/cGYbaFjw2CG
        GiHIQhcG8Fr36NQ3luAGucuXVH0KfpgaPorBMjTWTVBPCrFJVTDsUWNornJ1sBoW
        AEyeU4DaE7w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DF7D80E67;
        Fri,  2 Aug 2019 17:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B43180E66;
        Fri,  2 Aug 2019 17:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 11/11] built-in add -i: implement the `help` command
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <db70c6475d85dd77385d773274fa390fa7ed08c0.1563289115.git.gitgitgadget@gmail.com>
Date:   Fri, 02 Aug 2019 14:04:09 -0700
In-Reply-To: <db70c6475d85dd77385d773274fa390fa7ed08c0.1563289115.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 16 Jul 2019
        07:58:45 -0700 (PDT)")
Message-ID: <xmqqpnlnjn3q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1384AAEA-B569-11E9-B66F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static int run_help(struct add_i_state *s, const struct pathspec *ps,
> +		    struct file_list *files, struct list_options *opts)
> +{
> +	const char *help_color = s->help_color;
> +
> +	color_fprintf_ln(stdout, help_color, "status        - %s",
> +			 _("show paths with changes"));
> +	color_fprintf_ln(stdout, help_color, "update        - %s",
> +			 _("add working tree state to the staged set of changes"));
> +	color_fprintf_ln(stdout, help_color, "revert        - %s",
> +			 _("revert staged set of changes back to the HEAD version"));
> +	color_fprintf_ln(stdout, help_color, "patch         - %s",
> +			 _("pick hunks and update selectively"));
> +	color_fprintf_ln(stdout, help_color, "diff          - %s",
> +			 _("view diff between HEAD and index"));
> +	color_fprintf_ln(stdout, help_color, "add untracked - %s",
> +			 _("add contents of untracked files to the staged set of changes"));

As we do not allow the command names to get translated, this makes
sense.

Have we adopted the convention to name callback parameters that have
to stay unused (because the callback function must have a function
signature that accepts the union of what everybody needs to take)
differently from the parameters that actually get used?  It may make
sense to use it in a function like this, to prevent readers from
wasting time by wondering how pathspec is used in this function, for
example.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 69991a3168..cf67756b85 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -647,4 +647,29 @@ test_expect_success 'checkout -p works with pathological context lines' '
>  	test_write_lines a b a b a a b a b a >expect &&
>  	test_cmp expect a
>  '
> +
> +test_expect_success 'show help from add--helper' '
> +	git reset --hard &&
> +	cat >expect <<-EOF &&
> +
> +	<BOLD>*** Commands ***<RESET>
> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
> +	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
> +	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
> +	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
> +	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
> +	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
> +	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
> +	<BOLD>*** Commands ***<RESET>
> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
> +	<BOLD;BLUE>What now<RESET>>$SP
> +	Bye.
> +	EOF
> +	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
> +	test_decode_color <actual.colored >actual &&
> +	test_i18ncmp expect actual
> +'

Nicely done.

