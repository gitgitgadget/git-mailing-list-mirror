Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69945C38A30
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488BF207FC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 17:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MKKa46YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgDTRak (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:30:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54679 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTRak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 13:30:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1878ED0DC0;
        Mon, 20 Apr 2020 13:30:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0CmJf1dy68eA
        8m1+Gz4fttBy0MI=; b=MKKa46YQzi44WHjdXsvifBKtH8XneBmT39hXtqswJ6at
        JDTDL+Y110JjSrPmGB9onkUE4qFaGeVHz9MDZ1KTJ//OfuPY16vN0rwbf1zaYHvK
        xXDIwdym/wy14uvfnqcU9P2PNeSpkmeb5NrrDojZhpB+dvXYeaV9fYSCXoOXhVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ix/mbZ
        I++MQ5zinvGktgHCDp34M4cDQnvJXsJJR2FpPTEk2y2bUrBRsPi0PVPZcbctsmNP
        WH3b9W2DYpq5P9trVrM5QGepIxaQxLD4YuM65ydEB9EVFHsomTo/bDzWsxceVod7
        LptxMdAmNULZitIPy+jmOesfZb0QC66+nGj0I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 103C4D0DBF;
        Mon, 20 Apr 2020 13:30:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 554C0D0DBE;
        Mon, 20 Apr 2020 13:30:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 1/4] strbuf: fix doc for `strbuf_attach()`
References: <cover.1587240635.git.martin.agren@gmail.com>
        <cover.1587297254.git.martin.agren@gmail.com>
        <54e10bb06a39d23591ea4d02665083d705682468.1587297254.git.martin.agren@gmail.com>
Date:   Mon, 20 Apr 2020 10:30:31 -0700
In-Reply-To: <54e10bb06a39d23591ea4d02665083d705682468.1587297254.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 19 Apr 2020 14:32:27
 +0200")
Message-ID: <xmqqd082rrns.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A3887E96-832C-11EA-818D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Commit 917c9a7133 ("New strbuf APIs: splice and attach.", 2007-09-15)
> added `strbuf_attach()`. In the commit message, it is explicitly
> discussed how using `mem =3D=3D len` is ok, although possibly costly. W=
hen
> this function was documented in dd613e6b87 ("Strbuf documentation:
> document most functions", 2008-06-04), this distinction was missed and
> the documentation simply forbids this case.

In other words, mem=3D=3Dlen implies that the original lacks the
terminating '\0', so attach needs to reallocate from the get go, so
discouraging such use may make sense, but it is too strong to forbid
it, as the strbuf invariant is held safely?  If so, the description
makes sense to me.

> The function handles reallocation and truncation, yet the docs say that
> the "amount [of allocated memory] must be larger than the string length=
,
> because the string you pass is supposed to be a NUL-terminated string".

IOW, _attach() does not mind if the original lacks '\0' at the end.

> diff --git a/strbuf.h b/strbuf.h
> index ce8e49c0b2..2a462f70cc 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -112,10 +112,12 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz=
);
>  /**
>   * Attach a string to a buffer. You should specify the string to attac=
h,
>   * the current length of the string and the amount of allocated memory=
.
> + * The amount must be at least as large as the string length. If the t=
wo
> + * lengths are equal, reallocation will be handled as appropriate and =
in
> + * any case, the string will be NUL-truncated as implied by `len`.

NUL-truncated?  Ah, if mem and len are the same, the string is reallocate=
d
to fit an extra byte to NUL-terminate, to make sure strlen(sb->buf)=3D=3D=
len
holds.  Makes sense.

> + *
> + * This string _must_ be malloc()ed, and after attaching, the pointer
> + * cannot be relied upon anymore, and neither be free()d directly.

That's a good thing to explain.

>   */
>  void strbuf_attach(struct strbuf *sb, void *str, size_t len, size_t me=
m);
