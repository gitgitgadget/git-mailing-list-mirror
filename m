Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49ED22035F
	for <e@80x24.org>; Tue, 25 Oct 2016 21:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965989AbcJYVlh (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 17:41:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51593 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941957AbcJYVlf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 17:41:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1C2447765;
        Tue, 25 Oct 2016 17:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DLCD9KuGx0BMHo19fXdOlkUepnU=; b=C4HLWo
        B9Y99haSMTh1jEmBABVn7g0+F7I/zncJg5tFwXu5Egpnsdf6FEFTbx2V4vM3fdp9
        Dv8p3Jxzahz7DRqEv+U3VpLhkSugPCgR82mga5v6xusMy+QGKJtH7+z8Heipy+oj
        HYKeKhfh3cgZl4af60JqYrKqYyeqqIJ3K3fsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rrTu6f6mwjhpdpq58NxDNcWJqRewtoSn
        WgbmZPSuylGP1FBztBALvDfUSGMf7IJKVGJYZdyQR75p4CMVJTGRY1ufNKMgaAbU
        x/byQdo8lFS8izuUrNmuBdN9OvZzaCNU4cr044+cxbyqz5Bt20q47dXywwat/ARY
        tlIYsptJeFI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9AFB47764;
        Tue, 25 Oct 2016 17:41:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C73547763;
        Tue, 25 Oct 2016 17:41:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron M Watson <watsona4@gmail.com>
Cc:     git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] Allow stashes to be referenced by index only
References: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
        <1477352413-4628-1-git-send-email-watsona4@gmail.com>
Date:   Tue, 25 Oct 2016 14:41:30 -0700
In-Reply-To: <1477352413-4628-1-git-send-email-watsona4@gmail.com> (Aaron
        M. Watson's message of "Mon, 24 Oct 2016 19:40:13 -0400")
Message-ID: <xmqqshrkqf79.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC307582-9AFB-11E6-852A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron M Watson <watsona4@gmail.com> writes:

Aaron M Watson <watsona4@gmail.com> writes:

> Instead of referencing "stash@{n}" explicitly, it can simply be
> referenced as "n".
> Most users only reference stashes by their position
> in the stash stask (what I refer to as the "index").

It is unclear if the first sentence is a statement of the fact, an
expression of desire, or something else.  With the current codebase,
it cannot simply be referenced as "n", and you either "wish it were
possible", or "make it possible to do so", or perhaps little bit of
both.

This is why we tend to use imperative mood to give an order to the
codebase to "be like so" to make it clear.

Perhaps

  Instead of referencing "stash@{n}" explicitly, make it possible to
  simply reference as "n".  Most users only reference stashes by their
  position in the stash stask (what I refer to as the "index" here).

or something like that (which is what I tenatively rewritten this to
while queuing).

> @@ -404,6 +403,9 @@ parse_flags_and_rev()
>  					die "$(eval_gettext "unknown option: \$opt")"
>  				FLAGS="${FLAGS}${FLAGS:+ }$opt"
>  			;;
> +			*)
> +				REV="${REV}${REV:+ }'$opt'"
> +			;;
>  		esac
>  	done
>  
> @@ -422,6 +424,15 @@ parse_flags_and_rev()
>  		;;
>  	esac
>  
> +	case "$1" in
> +		*[!0-9]*)
> +			:
> +		;;
> +		*)
> +			set -- "${ref_stash}@{$1}"
> +		;;
> +	esac

I can see that you inherited the brokenness from an existing one in
the earlier hunk, but case arms in these two case statements are
indented one level too deep.  It would be good to fix it in a
follow-up patch (not a reroll of this patch).

Thanks.  Will queue.
