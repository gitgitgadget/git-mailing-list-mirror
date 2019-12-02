Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE0BC432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E226720833
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLVzr1CP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLBGHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:07:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61130 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfLBGHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 01:07:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7F20A7A41;
        Mon,  2 Dec 2019 01:07:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LP0Ywi9aMFsCn/HfupB+jRP2XSw=; b=ZLVzr1
        CPM6ooBP3esitOnrDgdDdIrmMBk2ApXa+aeIYOjT1Z9L5j4Os9dZu/D2gbUOPesH
        /tflbjUEzVnsjJXccOKtvKZWZnPOYsBFVTbI36EWplCfcUnkNYdBE/JLP2GAlfSe
        XzsaZCtU8vBR1eFzhMlfV9mXC1yhWIvAOxwcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aFOLKNJyH9vnH7upD0lmrO9V290AWe2N
        M++QcGBnXCHumQjwQIupQj0lEMp8khjDHvsJlLrlIQBRafgsshtTNBfxEJ+3+t8g
        Mvs6MnmcGkJ3KB2Ouwe2Op8mz2FOJ9OSRQyAJqigsOONhuLxlB+MB+lk7po/V+Mt
        ebejolajAeI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D043DA7A40;
        Mon,  2 Dec 2019 01:07:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1730CA7A3D;
        Mon,  2 Dec 2019 01:07:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>
        <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org>
        <xmqq1rtp2k01.fsf@gitster-ct.c.googlers.com>
        <xmqqfti41rz1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1912011042460.31080@tvgsbejvaqbjf.bet>
Date:   Sun, 01 Dec 2019 22:07:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912011042460.31080@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Sun, 1 Dec 2019 10:53:25 +0100
        (CET)")
Message-ID: <xmqqk17fz2e7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 065FB132-14CA-11EA-9FDE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But the intention is not to help correct callers! The purpose of mapping
> `ERROR_SUCCESS` to 0 will help _only_ callers that try to report an error
> when none happened. On Windows, which is the only platform where the
> discussed function is compiled and used, `strerror(0)` has the
> well-established behavior of returning "No error".

But is the caller that ends up saying "No error" you mention below
by calling strerror() exists *only* on Windows port somewhere in
compat/ directory?  If the call to strerror() is made from a
codepath that is common to all platforms, then that caller *is*
wrong to do so after seeing *no* errors.

So, no, sorry, but I do not understand the above line of reasoning.

> Now imagine that a user encounters a bug where a code path does indeed
> incorrectly report an error where no error occurred (or where Git is
> looking for the error too late or something like that). You probably agree
> with me that we should really avoid reporting "Function not implemented"
> in such a case and rather say "No error", which will help figure out the
> bug much quicker.

Not really.  A BUG() that catches a call to this function that
should not be called when there is no error would help identify the
problematic caller a lot faster by being louder---those users who
get hit will raise their hands more readily than those who see "No
error" and wonders "why does Git give that error message when there
is no error?".  IOW, "No error" sounds like sweeping the issue under
the rug.

The argument could be "I do not want to be pressured to hunt for the
problematic caller, and taking the approach to be less loud than the
BUG() approach would allow the end users keep operating as if
nothing bad happened, so that I can hunt for the caller iff/when I
feel like it, and with no urgent need I can just ignore the hunt
altogether.  Not hitting with BUG() is a service to the end users
who shouldn't be made a guinea pig---that is why we want to sweep
the problematic caller under the rug.  It may delay the discovery
and fixing of problematic callers, which is a downside, though."

I would understand such an argument, even if I might not think that
such an argument makes the right tradeoff between not hitting the
users with BUG() and not being effective in finding the problematic
caller.

Thanks.
