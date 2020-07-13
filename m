Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A66C433E1
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48267206F5
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z4//uxum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGMTpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:45:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60200 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgGMTpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:45:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 974D667A09;
        Mon, 13 Jul 2020 15:45:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cem4rrxLGFlx
        bu5MhZu14o80/CY=; b=Z4//uxumds88UE77gqRJMrWoO7BR0tmUCOT6DIO1rKCE
        GayqWVIACn847+KXqec1+3GdxWVEKss3fPb57DaRUtsQOcEM1hssObinmlT3A3Ex
        kF5OR/nHT6Xyj49Hvq89bgAw4e+in1jjDSnBLyJILU99SG20TBHuqyT1+rxHKlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oKEhHI
        jsWCfhUraawnFfLsW8qLjaIM/k9W8fwaeRxDcklAXAZZp/dmj2dPjA8ofko/vHWO
        Mc9lMOmSPnXxc5ehFsWZUM/WL1AVUnRlMSabVcEypGb9DLF/8/uObywGgOCPRqKw
        e4gJ6aFvJcoXXRjnYb3x9X5PfeSyCfSJbxW1k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F2A267A08;
        Mon, 13 Jul 2020 15:45:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03CFC67A07;
        Mon, 13 Jul 2020 15:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH 1/2] git-diff.txt: don't mark required argument as optional
References: <cover.1594666410.git.martin.agren@gmail.com>
        <77e4442ae51a968d460b2329fc39b6a5e96902b0.1594666410.git.martin.agren@gmail.com>
Date:   Mon, 13 Jul 2020 12:45:49 -0700
In-Reply-To: <77e4442ae51a968d460b2329fc39b6a5e96902b0.1594666410.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 13 Jul 2020 21:10:08
 +0200")
Message-ID: <xmqq365vnqqa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7424EC6E-C541-11EA-97BA-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Commit b7e10b2ca2 ("Documentation: usage for diff combined commits",
> 2020-06-12) modified the synopsis by adding an optional "[<commit>...]"
> to
>
>   'git diff' [<options>] <commit> <commit> [--] [<path>...]
>
> to effectively add
>
>   'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]
>
> as another valid invocation. Which makes sense.
>
> Further down, in the description, it left the existing entry for
>
>   'git diff' [<options>] <commit> <commit> [--] [<path>...]
>
> intact and added a new entry on
>
>   'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>..=
.]
>
> where it says that "[t]his form is to view the results of a merge
> commit" and details how "the first listed commit must be the merge
> itself". But one possible instantiation of this form is `git diff
> <commit> <commit>` for which the added text doesn't really apply.
>
> Remove the brackets so that we lose this overlap between the two
> descriptions. We can still use the more compact representation in the
> synopsis.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/git-diff.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 1018110ddc..c613e71ca4 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -69,7 +69,7 @@ files on disk.
>  	one side is omitted, it will have the same effect as
>  	using HEAD instead.
> =20
> -'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...=
]::
> +'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]:=
:

Thanks.

> =20
>  	This form is to view the results of a merge commit.  The first
>  	listed <commit> must be the merge itself; the remaining two or
