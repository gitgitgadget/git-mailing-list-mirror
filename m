Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C832C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C0520829
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ErWLOqpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgHNRdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:33:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54166 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNRdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 13:33:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5CCF7F1E4;
        Fri, 14 Aug 2020 13:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MQEW5+M9Y0vX
        URezOBcJsPsHPso=; b=ErWLOqpbLTzj7pIh/DwfDY3GnQ4DcfnoqM0bf9XhEFTe
        muUj4NqdKd48AxAwwmzOoYZbllKN6fBwFsOd7hvp3U6Gyo42jyVqg3GzIP35rxgc
        nel1Oog27oqKIhi2E/KsCpi+J8x5bwaqlWVBDXPQiilvXqQPzhcWC/kTi3+w9Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EgmdcI
        uWbBangTFMcwQlDV/+k/HhMNlhdb5ph+ALpqYkuvSag+VT8wSUaMaRMjlAFaxF6R
        WGD6T6RZEztn+FEoQn1qgEi9qBJFiubFZlHXG9P5bCbDRwemgzNKL1cKtpvdO6Uz
        ctxieIL4SIuWKMqCufgLMECudbQJHBo5P+jaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81AE07F1E3;
        Fri, 14 Aug 2020 13:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41CED7F1E1;
        Fri, 14 Aug 2020 13:33:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/5] protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
        <cover.1597406877.git.martin.agren@gmail.com>
        <13798dfb121c9631e9d811f5f74f9a78c1fcfdf9.1597406877.git.martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 10:33:06 -0700
In-Reply-To: <13798dfb121c9631e9d811f5f74f9a78c1fcfdf9.1597406877.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 14 Aug 2020 14:21:44
 +0200")
Message-ID: <xmqqft8pxhd9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 373251D0-DE54-11EA-A667-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Two of our extensions contain "sha1" in their names, but that's
> historical. The "want"s will take object names that are not necessarily
> SHA-1s. Make this clear, but also make it clear how there's still just
> one correct hash algo: These extensions don't somehow make the "want"s
> take object names derived using *any* hash algorithm.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/technical/protocol-capabilities.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
> index 36ccd14f97..47f1b30090 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -324,15 +324,18 @@ allow-tip-sha1-in-want
>  ----------------------
> =20
>  If the upload-pack server advertises this capability, fetch-pack may
> -send "want" lines with SHA-1s that exist at the server but are not
> -advertised by upload-pack.
> +send "want" lines with object names that exist at the server but are n=
ot
> +advertised by upload-pack. (Note that the name of the capability
> +contains "sha1", but that it's more general than that: in SHA-1
> +repositories, the "want" lines provide SHA-1 values, but in SHA-256
> +repositories, they provide SHA-256 values.)

I think we should have either a new sha256 capability or a more
generic hash-algo capability whose value can be set to sha256.
Neither the connection initiators or the acceptors should talk
in sha256 until both ends agreed to do so. =20

I do not think of any other way to make sure hosting sites to serve
projects that migrate at different pace.  Per project, you might be
able to have a flag day.  You cannot have a flag day that spans the
world.

