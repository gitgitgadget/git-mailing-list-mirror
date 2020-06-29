Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E44C433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF6420702
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C01X6qDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbgF2TvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:51:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51417 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbgF2TvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:51:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8689281709;
        Mon, 29 Jun 2020 15:51:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=esrYd1FhCZcBkFd1EU+rwm42SH4=; b=C01X6q
        DcbhD6LlVVlT7zDISrzIFESR43pTTqF3sF6v0NhyZSIzT3+zH3DHPEc4lLroZeS7
        rbguR0naT/C6gsVkMM29nnFvEp6h98vkOFguMhXnWHDSMP+ygYAMO/s4Nj2r6SGT
        Sso1gwwrPNXMlIjJevQcrqE5LBVkykpIZI7ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GAgFvFj8U5uKlqOHozhibF6wBR0hco/M
        wJLF/RU7r4GVQP55ARGwsV10NLld7/FOHLjS56IQw3DUlBOiBYP9s8Rb4dxiT4RZ
        tLUfCbdcM0dJUe2p0GAhR4xR0If695KbegjXbe+t0zVbbL/IKmGGH0bdRQMriVvA
        B9c8ifVVEEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D2BB81706;
        Mon, 29 Jun 2020 15:51:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F359C81703;
        Mon, 29 Jun 2020 15:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Reftable progress
References: <CAFQ2z_NZbg4YoTo1vPaikfwYLMRZrx59bDMaeuczuJW2OG86DQ@mail.gmail.com>
        <CAFQ2z_Ohp29=Txu9ikn1i_GJQ8eYV9HNrKqSpAOMNamL92YZYQ@mail.gmail.com>
Date:   Mon, 29 Jun 2020 12:51:04 -0700
In-Reply-To: <CAFQ2z_Ohp29=Txu9ikn1i_GJQ8eYV9HNrKqSpAOMNamL92YZYQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 29 Jun 2020 20:57:15 +0200")
Message-ID: <xmqqr1txfy6v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEB78A92-BA41-11EA-9768-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Tue, Jun 23, 2020 at 12:03 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>> The bottom 2 commits should be OK to merge as is into next.
>> ("checkout: add '\n' to reflog message", "lib-t6000.sh: write tag
>> using git-update-ref")
>
> The patch t3432: use git-reflog to inspect the reflog for HEAD can
> also be merged as is.

Yeah, carving test updates in the early parts out of the series and
have them in 'next' and then in 'master' may make sense.  Good idea.

>> The major open question is how to handle per-worktree refs.  My idea
>> is that, on creation, the reftable backend can figure out if it is
>> running in a worktree or in the main repository. If it is running in
>> worktree X, we could read/write pseudorefs as ~X/PSEUDO_REF.
>
> I figured out a better way to do this. See the series that I am  posting today.

It seems that patches started trickling in but perhaps missing
pieces are mailspools somewhere and would arrive later?  I'll check
the list archive tomorrow to see if all 20 patches have arrived.

Thanks.
