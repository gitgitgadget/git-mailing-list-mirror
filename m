Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4033C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E60E2173E
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JlMWQEnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfLKR5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:57:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53016 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfLKR5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 12:57:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 287FB930F5;
        Wed, 11 Dec 2019 12:57:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sCQVWbAgoWhu
        cQmy7UMd60mCoQs=; b=JlMWQEnKPmZ+3n4S44oq0iRXHTDPlMMGFUeYsqrqY+oH
        jnop8/HEI+/SM+FiPtB8dCbrkuljPryfH1kYGwB4ZGFFHtAtWwILHm0VRCDZP2+Y
        udCPZeZ7kJ2ctizzYQvGDMhRa/bai35lDvUwZn5bmZwwTh7JQn8qFz1YT+wLGWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ip8uLO
        si8F7c+0OdUfn/tyd8h+pAeg0X1CH6VVjEDMTjp4f3qnu6L/V3tVj4E+CyVSOph1
        XpQImFYZcisnsC49c/jn5Eo/VQrj3g9JWzxMmAj4jqaVplnsZwT0xL6yrKz6RhJg
        neKy7b6lIXufsMLvCdVPhJ1UoS81O3SOo0cfg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 202BC930F3;
        Wed, 11 Dec 2019 12:57:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35569930EE;
        Wed, 11 Dec 2019 12:57:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Ben Keene <seraphire@gmail.com>, Jeff King <peff@peff.net>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings in python3
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
        <20191207194756.GA43949@coredump.intra.peff.net>
        <95ead4b6-21bb-1aa2-f16f-888e61a4e4c0@gmail.com>
        <xmqqwob2pzty.fsf@gitster-ct.c.googlers.com>
        <20191211171356.GA72178@generichostname>
Date:   Wed, 11 Dec 2019 09:57:10 -0800
In-Reply-To: <20191211171356.GA72178@generichostname> (Denton Liu's message of
        "Wed, 11 Dec 2019 09:13:56 -0800")
Message-ID: <xmqq1rtapwy1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9040CD6-1C3F-11EA-B0F5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Wed, Dec 11, 2019 at 08:54:49AM -0800, Junio C Hamano wrote:
>> Ben Keene <seraphire@gmail.com> writes:
>>=20
>> > Yes indeed!
>> >
>> > I hadn't pulled before I attempted the rebase, and got bit.=C2=A0 Ye=
s those
>> > shouldn't be there!
>>=20
>> So, other than that, this is ready to be at least queued on 'pu' if
>> not 'next' at this point?
>
> From what I can tell, Ben agreed to have this series superseded by Yang
> Zhao's competing series[1].

OK.  Let me not worry about this one, then, at least not yet.

