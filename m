Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A701CC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 19:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F01613B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 19:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhDETPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 15:15:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55237 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhDETPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 15:15:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9E54A8CAE;
        Mon,  5 Apr 2021 15:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mxlvkz4Ls7rw
        wQQX1l28mjAwGrw=; b=pHBNc+OIrwb5ieuoo13jfavKnS2BA7GSTAA0pzqSPVtB
        OmVDhArXQrvI7rL6IV5oiPT6kZKg5B978SFByXcq2MVNVoXLVBF9bpj2Ia3Xcr/v
        x1SrMeBXfoJvX5KVsxOayMFRdQ5gmg5X+dobTm6GHFayh262/+K9uSYGu28bsbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Gpk6kd
        8UKaYK/nLHZvpbYs1ZSUk3Hktc66UMZJM3n1eNBeToIRONmTOlaSI5TX4G5UvYO1
        3C7sp1FIx5qTBDL8/7yEbc0BbmViu5FnAhuJ8Cmc55pQXW37NoMDYPZr8Xn+1kty
        6oBDtqfsk3De/Y/L0ZHR2sfhqSMWFtuYFQ2+k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1176A8CAD;
        Mon,  5 Apr 2021 15:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C3E4A8CAC;
        Mon,  5 Apr 2021 15:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 4/4] git-send-email: improve --validate error output
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
        <patch-4.5-a1edceb4913-20210404T091649Z-avarab@gmail.com>
Date:   Mon, 05 Apr 2021 12:14:55 -0700
In-Reply-To: <patch-4.5-a1edceb4913-20210404T091649Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 4 Apr
 2021 11:19:46 +0200")
Message-ID: <xmqqim505ys0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35170B96-9643-11EB-AFCB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Improve the output we emit on --validate error to:
>
>  * Say "FILE:LINE" instead of "FILE: LINE".

OK, that is an improvement because it matches "grep -n" hits,
compiler error messages, etc., to help the editors to jump to these
lines.

>  * Don't say "patch contains a" after just mentioning the filename,
>    just leave it at "FILE:LINE: is longer than[...]. The "contains a"
>    sounded like we were talking about the file in general, when we're
>    actually checking it line-by-line.

This, too.

>  * Don't just say "rejected by sendemail-validate hook", but combine
>    that with the system_or_msg() output to say what exit code the hook
>    died with.
>
> I had an aborted attempt to make the line length checker note all
> lines that were longer than the limit. I didn't think that was worth
> the effort, but I've left in the testing change to check that we die
> as soon as we spot the first long line.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  git-send-email.perl   | 23 ++++++++++-------------
>  t/t9001-send-email.sh | 17 ++++++++++++-----
>  2 files changed, 22 insertions(+), 18 deletions(-)

Will queue.  I like the end result, but left a comment about
flipping-and-flopping between 2/4 and this step on an extra
"validate_patch_error" helper sub.

Thanks.
