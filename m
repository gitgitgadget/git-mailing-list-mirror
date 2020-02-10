Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77037C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 17:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDE020733
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 17:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rqr7gQBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgBJR1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:27:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63968 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgBJR1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 12:27:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A17EBB81AD;
        Mon, 10 Feb 2020 12:27:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i6v0kjF6otgu
        vzugtkVJtwkiz2s=; b=rqr7gQBrgudNgljU3Jh0x8HMzzl6FdMDT7ui1FACGElS
        h3m2ZQ25CwsyrhbXOdLMH1pFCXgjxtvf37S19HyU1Ss1mV/fuO62N6vmST9shneO
        k+eGvpztzGwHi2ZEl3ANyKctoxBJQq/Wjt7pFKLe2lAUWdRHtWLZixuFE3fTgXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tC80Db
        ajrQLdZA/gk62TjXZcSiWmYbzlVecVNey0tk1/hJjWe7tz10UANiERVsCKP2N+LO
        a4WjKb+GUXFPRoyEuix/Mli3AyvDa/UtWu/bXXMAr7Kn26ViFGDadvfcgTf9gQEE
        jdRWBaXA7obPz0fXCMnALNjD2uKiwlZPAusos=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 998E8B81AC;
        Mon, 10 Feb 2020 12:27:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C27BEB81AB;
        Mon, 10 Feb 2020 12:27:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/1] mailinfo: don't insert header prefix for handle_content_type()
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
        <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
        <35ef5149-2da9-a147-fb5b-8f175ff617e7@web.de>
Date:   Mon, 10 Feb 2020 09:27:06 -0800
In-Reply-To: <35ef5149-2da9-a147-fb5b-8f175ff617e7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 10 Feb 2020 08:15:19 +0100")
Message-ID: <xmqqlfpa1hg5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90B1D76A-4C2A-11EA-B657-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> handle_content_type() only cares about the value after "Content-Type: "=
;
> there is no need to insert that string for it.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  mailinfo.c | 1 -
>  1 file changed, 1 deletion(-)

OK.  There is only one caller that just saw that the line it is
looking at begins with "Content-Type:", and the only thing the
helper function does is to look for a handful of attr=3Dvalue pairs
(without even looking at the primary thing the header wants to
convey---the type itself, like text/plain etc.).  The helper may
want to learn a bit more careful than the current implementation
in doing what it does, but it does not need to see the header name
to do so.  It's not like we will be accepting more than one kind of
content-type like header with this helper and make it capable of
tailoring its behaviour based on which exact header type it is.

Will queue.  Thanks.

> diff --git a/mailinfo.c b/mailinfo.c
> index 543962d40c..402ef04dd1 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -570,7 +570,6 @@ static int check_header(struct mailinfo *mi,
>  		len =3D strlen("Content-Type: ");
>  		strbuf_add(&sb, line->buf + len, line->len - len);
>  		decode_header(mi, &sb);
> -		strbuf_insertstr(&sb, 0, "Content-Type: ");
>  		handle_content_type(mi, &sb);
>  		ret =3D 1;
>  		goto check_header_out;
> --
> 2.25.0
