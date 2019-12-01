Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA1C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 06:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3F420867
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 06:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cS0+C2Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfLAG0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 01:26:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55388 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfLAG0t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 01:26:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20ED418D83;
        Sun,  1 Dec 2019 01:26:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vnVD6MNPUGcgM+YX5CTBrHNnUbw=; b=cS0+C2
        Z2T7AoNohS7ISNOVQmoWyQbKtHgQQEdl7meKylnU/6+I1W1kmD86Jk/4CE87qAzk
        8NjM9lM9R7q875EgQoNGNtapgYYZaDuy6q52buzE8QuXxm0xkSpEU3alUAEbxKVf
        xMkTRYW8Vm84eelBHlbFaSiRBg6q80sgta6fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YcemPmya4jRQZEhyFQznUZ2jiKEN2kmO
        tG7RVQe41kNPaPyPvEW6N8/ClC2q19YZaLe2q+E4RKq+IqBdQUgBjwxXf0IVYYew
        owGnWHPkxdLfhubiky1i04W7FqSJUn2onLMoZDaZg8A7MR+M9kEnzy1DI3Mi+rE7
        jSoFdaBsuzw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 188C818D82;
        Sun,  1 Dec 2019 01:26:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7328718D81;
        Sun,  1 Dec 2019 01:26:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>
        <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org>
        <xmqq1rtp2k01.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 30 Nov 2019 22:26:42 -0800
In-Reply-To: <xmqq1rtp2k01.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 30 Nov 2019 12:21:18 -0800")
Message-ID: <xmqqfti41rz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AD4F656-1403-11EA-9C2C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Just like on POSIX the value of errno is indeterminate after a
>> successful system call, the value of GetLastError() indeterminate after
>> a successful Windows API call. Therefore, the err_win_to_posix() would
>> not be able to point at a bogus caller reliably. For this reason, let's
>> consider the function as a simple error code translator, and then
>> translating ERROR_SUCCESS to 0 (or is there ESUCCESS?) makes total sense.
>
> OK, that makes sense.

Actually, I do not think it makes that much sense, especially in the
context of this patch that claims to map success to 0 (assuming that
no E_ANYTHING has the value of zero---I am not sure POSIX gives such
a guarantee) "for good measure".

Even if Windows API makes the GetLastError() unusable after a
success call (unlike POSIX, where errno is left alone), the API
calls themselves would be signaling their own success or failure,
right?  So I would have imagined that any kosher caller would be
doing this:

	if (SomeWinAPI() != SUCCESS) {
		errno = err_win_to_posix(GetLastError());
		... possibly other reactions to the error ...
	}

If using a value grabbed from GetLastError() after a successfull
Windows API call is a wrong thing to do as you taught us in your
message, then an unconditional

	SomeWinAPI();
	errno = err_win_to_posix(GetLastError());

would be wrong anyway, and touching errno unconditionally, when the
previous call may have succeeded without checking, makes the pattern
doubly wrong, no?

Having said that, I do not expect myself to be looking into and
fixing anything in compat/*win*.[ch], so I do not care too deeply
either way, but I thought that it would help keep the sanity of
developers involved if we touched errno only upon a failure from an
underlying system.

Thanks.
