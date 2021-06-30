Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C35C11F66
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA27D613E8
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhF3XBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 19:01:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50971 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhF3XBw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 19:01:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 033E4CCEB4;
        Wed, 30 Jun 2021 18:59:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Db1efpuJRvFxGQJte/hXFCuyReSf8jesYsnlvmjdX88=; b=XZuP
        Y3Hbz8KFq2vu1kAbTbeJ/L6h7FwP5Ewc/NoNOoul+iPOl/YRYav5NyKYkFDQ/zZ2
        Qty4SxwEUEtrmfj9P7kxzGerFkO5w/JKh4YBLkRgETob1PHggRqDtvjc3sJiZ01K
        IVEyOGlxIUzE4xlMGhPDvS+zY1wXM2A99HJM7+4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE6C3CCEB3;
        Wed, 30 Jun 2021 18:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B577CCEB2;
        Wed, 30 Jun 2021 18:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin <git@mfriebe.de>
Cc:     git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqk0mcy6g2.fsf@gitster.g>
        <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
        <xmqqpmw4uwh2.fsf@gitster.g>
        <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
Date:   Wed, 30 Jun 2021 15:59:21 -0700
Message-ID: <xmqqy2arrmba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF0E65CC-D9F6-11EB-A2DF-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> And yes, for the documentation, it *should* be clear that, removing a
> branch, removes the
> commits on it.
> But then it must be said, that the branch is first removed. That is
> not currently the case.

Sorry, but I still do not see how it makes any difference if the
branch is first removed and then made to point at somewhere else, or
the branch gets just moved without any explicit or impolicit
removal.  A branch cannot point at two different commits at the same
time, so the end result is that the commit at the old tip is no
longer pointed at by the branch after the update.  In other words,

	----o---o---X---Y---Z

if it were possible to move the tip of a branch, that used to point
at commit Z, so that it points at commit X in the above picture,
without making it *not* to point at Z, then I would understand your
explanation, but I do not see how it would be possible.
