Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9F3C433E3
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785E720708
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JxXOGOMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgHNR3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:29:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64871 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgHNR2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BADAE5968;
        Fri, 14 Aug 2020 13:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=twBxl4y3BehN
        CKFLjj4uz5I9jCQ=; b=JxXOGOMjV3P3iGTb67wlWIWFb31teZgMZ+oNpw+hI0C+
        d+SsEnSB+6IDn8FYSEmy1in4w3Z6PT0K5VPXAf7mwOGYxDsSfBdg5rlSeoNXPU+G
        yVDSuULXDXC3DlYnGkUmhxgzxUFe/3J/wXXoGRpvu9UodAbW9fq2sd4T4JSSbXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=x4HrtD
        HWc/GP3bf9pt3+COKOzwugIPFuoTtoxsKPVNr0HgASW4dHUECiHUDhByGgEkF2dW
        XAjhnTWeXyvOsQLs0ioniD2s29290c4L3s9BGtLYgBVqRen2V02l8cPojQKwbmyv
        Ofh7TuKwuwkR7t2c0Bx/c0AzNoTVK9s0wBP6U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85118E5967;
        Fri, 14 Aug 2020 13:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA266E5966;
        Fri, 14 Aug 2020 13:28:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] http-protocol.txt: document SHA-256 "want"/"have" format
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
        <cover.1597406877.git.martin.agren@gmail.com>
        <5590a68c5ba7081cd7e64c708b5c25db23f5e95b.1597406877.git.martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 10:28:27 -0700
In-Reply-To: <5590a68c5ba7081cd7e64c708b5c25db23f5e95b.1597406877.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 14 Aug 2020 14:21:42
 +0200")
Message-ID: <xmqqk0y1xhl0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9126F854-DE53-11EA-AEAC-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Document that in SHA-1 repositories, we use SHA-1 for "want"s and
> "have"s, and in SHA-256 repositories, we use SHA-256.

Ehh, doesn't this directly contradict the transition plan of "on the
wire everything will use SHA-1 version for now?"



> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/technical/http-protocol.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/=
technical/http-protocol.txt
> index 51a79e63de..507f28f9b3 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -401,8 +401,9 @@ at all in the request stream:
>  The stream is terminated by a pkt-line flush (`0000`).
> =20
>  A single "want" or "have" command MUST have one hex formatted
> -SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
> -multiple commands.
> +object name as its value.  Multiple object names MUST be sent by sendi=
ng
> +multiple commands. (An object name is a SHA-1 hash in a SHA-1 repo
> +and a SHA-256 hash in a SHA-256 repo.)
> =20
>  The `have` list is created by popping the first 32 commits
>  from `c_pending`.  Less can be supplied if `c_pending` empties.
