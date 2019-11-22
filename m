Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E9AC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 05:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A292071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 05:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J5bmQ55f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfKVFyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:54:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50642 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfKVFyk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 00:54:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5EFD3FF37;
        Fri, 22 Nov 2019 00:54:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pEMhXdR0cvkR
        Wpa+khymhprbi7M=; b=J5bmQ55fM5XNMME7Q3xBuWQGAgDpUVhOtq3BmJk+/6no
        7pVIInx9vwbeo0fe1MMIgQr4IIzg57L4FXiUBHDyy5OCyI3CRpqk+jXd7eElTqs8
        U5cQdMIJMzmscy3vCu5fgL7bSNhRJQnLe1lcwtbMg/NdyX6FCopMhW7jrMwFrBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GtzNsP
        eYFqMgeF706j7JLO4uLW343dCqROtY33GVa/qA6pf+6XSt07CfwXpNJn5v2uCXBj
        xbm1pw9uXx7RyULS/iTD+xXDLJJDclxt8LFRYrB52AWyJcdGdadS1o/SQLbg/z4J
        UuX2/22D01eknh/q4KQAf97Df+G+/m3MCya1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9492F3FF36;
        Fri, 22 Nov 2019 00:54:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08CF23FF35;
        Fri, 22 Nov 2019 00:54:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] coccinelle: improve array.cocci
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
        <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
        <05ab1110-2115-7886-f890-9983caabc52c@web.de>
        <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
        <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
        <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
        <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
        <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
Date:   Fri, 22 Nov 2019 14:54:35 +0900
In-Reply-To: <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 19 Nov 2019 20:15:05 +0100")
Message-ID: <xmqqsgmg5uck.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90DE16EA-0CEC-11EA-9690-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The current version checks if source and destination are of the same ty=
pe,
> and whether the sizeof operand is either said type or an element of sou=
rce
> or destination.  The new one does not.  So I don't see claim 4 ("Increa=
se
> the precision") fulfilled, quite the opposite rather.  It can produce e=
.g.
> a transformation like this:
>
>  void f(int *dst, char *src, size_t n)
>  {
> -	memcpy(dst, src, n * sizeof(short));
> +	COPY_ARRAY(dst, src, n);
>  }
>
> The COPY_ARRAY there effectively expands to:
>
> 	memcpy(dst, src, n * sizeof(*dst));
>
> ... which is quite different -- if short is 2 bytes wide and int 4 byte=
s
> then we copy twice as many bytes as before.
>
> I think an automatic transformation should only be generated if it is
> safe.  It's hard to spot a weird case in a generated patch amid ten
> well-behaving ones.

Nicely said; I agree 100% with you that the priority of this project
is to use these *.cocci transformations in such a way that they are
absolutely safe---so that humans do not have to spend time sifting
the result through to find accidental bad transformations.

And thanks for taking time to very clearly explain why the proposed
rewrite is not something we want to take.
