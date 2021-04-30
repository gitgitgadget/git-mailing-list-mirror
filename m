Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F03CC433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4FF61264
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhD3A5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:57:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3A5I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 20:57:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C37F2120A0C;
        Thu, 29 Apr 2021 20:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2q+uiXtRSQaOKjTeKEgJ1GOLcUA58s+HdXqjKO
        NRS/w=; b=P4FNakrdKxettcKR/vejcpB3+sT6c2aIVglewjsP0g9pzV8MhW1F02
        7S1BlQSYXV1o36nFOqU789RUNJsGIUnxM7STw+iRQvMpEM2dBdFbnQojtsSqnK0j
        Q2Hv+gI2HhG5AdUr7AWu27QJ7sLZEYpzEmAjvR0eqm1SA0S0OKgFE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBC20120A0B;
        Thu, 29 Apr 2021 20:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2CDD120A0A;
        Thu, 29 Apr 2021 20:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Trygve Aaberge <trygveaa@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH v2] bisect--helper: use BISECT_TERMS in 'bisect skip'
 command
References: <fa098676-a56c-cbb9-28cb-e57d4a8a5d77@ramsayjones.plus.com>
Date:   Fri, 30 Apr 2021 09:56:15 +0900
In-Reply-To: <fa098676-a56c-cbb9-28cb-e57d4a8a5d77@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 29 Apr 2021 21:15:15 +0100")
Message-ID: <xmqqo8dwegk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEE1F0A0-A94E-11EB-B88B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> This v2 patch was also created directly on top of commit e4c7b33747 and,
> once again, applied to current 'master' (@311531c9de). (I was a little
> surprised that it applied clean, given the changes to t6030-*.sh in the
> meantime! ;).
>
> I didn't bother with the range-diff[*], since it wasn't very illuminating
> (just the addition of a few trailing lines in the commit message and the
> addition of the test).

Thanks.  Let's hear from Bagas that this version looks good and
merge it down.

> I don't know if I did the 'Co-authorship' bit correctly; I nearly used an
> 'Co-authored-by:' rather than an 'Signed-off-by:' for Bagas, but I seem to
> remember that caused some push-back recently. Anyway, if I messed that up,
> please just modify however you see fit.

I am not in principle opposed to the idea of co-authored-by; the
case you remember was where we would have used Helped-by (i.e.  a
reviewer offers "writing it this way is cleaner" suggestions on the
list and then gets credited on the next version), and it wasn't
clear to me if the reviewer consented to be a co-author of that
change.  If the party who were named as a co-author responded that
it is OK, I would have taken it.

> [*] Once I got it to work, that is; for some reason, I was trying smaller
> creation-factor values rather than larger! ;-)
>
>  builtin/bisect--helper.c    |  1 +
>  t/t6030-bisect-porcelain.sh | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 7ad9b4d55b..49c07f0710 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1129,6 +1129,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		break;
>  	case BISECT_SKIP:
>  		set_terms(&terms, "bad", "good");
> +		get_terms(&terms);
>  		res = bisect_skip(&terms, argv, argc);
>  		break;
>  	default:
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index aa226381be..b707296ae2 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -919,6 +919,17 @@ test_expect_success 'bisect start takes options and revs in any order' '
>  	test_cmp expected actual
>  '
>  
> +# Bisect is started with --term-new and --term-old arguments,
> +# then skip. The HEAD should be changed.
> +test_expect_success 'bisect skip works with --term*' '
> +	git bisect reset &&
> +	git bisect start --term-new=fixed --term-old=unfixed HEAD $HASH1 &&
> +	hash_skipped_from=$(git rev-parse --verify HEAD) &&
> +	git bisect skip &&
> +	hash_skipped_to=$(git rev-parse --verify HEAD) &&
> +	test "$hash_skipped_from" != "$hash_skipped_to"
> +'
> +
>  test_expect_success 'git bisect reset cleans bisection state properly' '
>  	git bisect reset &&
>  	git bisect start &&
