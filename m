Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B98EC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 20:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0420829
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 20:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NrZqJWvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgIJUll (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:41:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50021 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIJU3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 16:29:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0F0077E48;
        Thu, 10 Sep 2020 16:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YcpDq7IxOtPi
        hdSBvnB1p3CjJu0=; b=NrZqJWvvlUfFIpV4xeHLN8C9fRnq17vYa8TLbTq6/atZ
        TPLuavZsNGs4b6JjrRHVkIEC2CXmo0xQL3CMB/1zvkAoap0EyBtG6U5pCgUPSvhI
        a8NI6+NWbbM0LJBG22k976tBapqMoHZsx6ppPGTr5oVlc+WvPl3jd+Ot7etNvmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MMLkSb
        nUYSzPsq91rkSj1yUp/CApGsku+HaUJF7+O6urAKH1MHFJG491bTMXfGl8qQjlUG
        r7HA3onMLGfIQ4MrlNLad2oMa/vJdFefX1WZQ+c9U8/FIrCF0yVgjvMAbtzh1Zfq
        hexkh/TlFjXLPONbvu606FNfTqo5CTMbnrUD4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7CB077E47;
        Thu, 10 Sep 2020 16:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FF9177E46;
        Thu, 10 Sep 2020 16:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/8] worktree: rename copy-pasted variable
References: <cover.1599762679.git.martin.agren@gmail.com>
        <6d913ea3e0c30cc1dbcff05974b5d990797e8dc2.1599762679.git.martin.agren@gmail.com>
Date:   Thu, 10 Sep 2020 13:29:24 -0700
In-Reply-To: <6d913ea3e0c30cc1dbcff05974b5d990797e8dc2.1599762679.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 10 Sep 2020 21:03:40
 +0200")
Message-ID: <xmqq7dt1pe8r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51FF5AD4-F3A4-11EA-B128-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> As the commit message of 04a3dfb8b5 ("worktree.c: check whether branch
> is bisected in another worktree", 2016-04-22) indicates, the function
> `is_worktree_being_bisected()` is based on the older function
> `is_worktree_being_rebased()`. This heritage can also be seen in the
> name of the variable where we store our return value: It was never
> adapted while copy-editing and remains as `found_rebase`.
>
> Rename the variable to make clear that we're looking for a bisect(ion),
> nothing else.

How bad is this copy and paste?  Is it a possibility to make a
single helper function and these existing two a thin wrapper around
the helper that passes customization between bisect and rebase?

