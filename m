Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF29C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EF460FBF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhKLQOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:14:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63863 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhKLQON (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 11:14:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DEAEF8FB3;
        Fri, 12 Nov 2021 11:11:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sexfqLH7bhH4
        Nc1iNl7g7B+6od77XEW0sISR7rp1J9o=; b=SYZdsKKT5GIm1rOWh1ivTggW4bcR
        P1rXEE1h3kJL4LW9XXUIdKjKWS08A8mS0neNbS1LrZN7ODCuO8BNkle1eTxnfSHt
        8N+AImuy5wTQsyEhRduejyJ5y7lj7FLBKmVFgwAHkf5QKOMtZU/WXBk4FkK0LVmT
        +3ulasf15NyzDsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BA3DF8FB2;
        Fri, 12 Nov 2021 11:11:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81AA6F8FB1;
        Fri, 12 Nov 2021 11:11:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/8] grep.h: remove unused "regex_t regexp" from
 grep_opt
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <patch-v2-1.8-1435db727ef-20211110T013632Z-avarab@gmail.com>
Date:   Fri, 12 Nov 2021 08:11:20 -0800
In-Reply-To: <patch-v2-1.8-1435db727ef-20211110T013632Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 Nov
 2021 02:43:43
        +0100")
Message-ID: <xmqqilwxtkuv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D1AC138-43D3-11EC-B110-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This "regex_t" in grep_opt has not been used since
> f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
> we still use a "regex_t" for compiling regexes, but that's in the
> "grep_pat" struct".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  grep.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/grep.h b/grep.h
> index 3e8815c347b..95cccb670f9 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -136,7 +136,6 @@ struct grep_opt {
> =20
>  	const char *prefix;
>  	int prefix_length;
> -	regex_t regexp;
>  	int linenum;
>  	int columnnum;
>  	int invert;

I would have expected "this used to be used but no longer; only
initialization of and assignment to it remain"; I am somewhat
surprised to see there is no mention to it anywhere in the code ;-)

Good find. =20
