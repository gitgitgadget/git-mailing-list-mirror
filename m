Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90FC433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7B320663
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 17:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W6eTxq1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgGMRNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:13:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58380 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgGMRNb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 13:13:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D677E5B6EB;
        Mon, 13 Jul 2020 13:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qET6UYLprWyeoq7VUXUVZEEGZ9E=; b=W6eTxq
        1XrDBOBgmnPoMHrBjkIn5mMIwWQ0XClCUJGi0LDtchSIa7b2sIXgv5X+f7Lv0to2
        0CbUpIQ8VvkehbYcOAyrdTuD+qnhFmOAfvE+fs898cEnZcZe1JumQ+wEtXPmCDIc
        wUvig4o83s8r1YkMenXr8S8szudtG+pxnBUvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g0JICjjE+wNDSPZqEQSif9qh99z2rwhx
        n4gV7tiATt80W0P/bu9deqsLgx7Wqdm8bJ1tVe57TaDE22Z2Y4FIG+KTsd8dnUEA
        hZHkEOG4eTkytkJPjqjFvKlw+fmFyUhSAoZpe4eYWgvWDco6hX0N/rkED0Aapuiz
        mtQxX/IC8Yk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE13E5B6EA;
        Mon, 13 Jul 2020 13:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 567445B6E8;
        Mon, 13 Jul 2020 13:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
        <xmqqimetrcay.fsf@gitster.c.googlers.com>
        <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
        <xmqqblkkr63u.fsf@gitster.c.googlers.com>
        <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
        <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
        <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
Date:   Mon, 13 Jul 2020 10:13:28 -0700
In-Reply-To: <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org> (Johannes Sixt's
        message of "Mon, 13 Jul 2020 19:09:29 +0200")
Message-ID: <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BE280FC-C52C-11EA-9140-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.07.20 um 22:52 schrieb Junio C Hamano:
>> We could teach "git fetch" a new "--write-fetch-head" option and
>> teach "git pull" to pass it when calling "git fetch".  It is very
>> plausible that some folks rely on "git fetch" to leave FETCH_HEAD
>> without being told, so the option must default to on for a few
>> development cycles before we flip the default to off,
>
> Nah, really??? It's one of the benefits of git-fetch that it writes
> FETCH_HEAD and the primary reason in many cases where I use the command!
> So, either I don't care that FETCH_HEAD is written, or I do use it. IMO,
> not wanting to write FETCH_HEAD is the odd case and would need a
> configuration tweak, not the other way round.

Yeah, that's even easier to arrange.  

Just the "--[no-]write-fetch-head" command line option and the
fetch.writeFetchHEAD configuration variable are introduced and left
off by default forever.

