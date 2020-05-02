Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91136C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE0A24953
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A7iuroR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgEBPsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 11:48:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60698 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgEBPsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 11:48:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1C14CA533;
        Sat,  2 May 2020 11:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xNqlX42HmLud36HGCHqYByvhkOo=; b=A7iuro
        R9uJw/RKBUW4gFlv+BJR3ZwuCIQi/DakcrI/0H70aHpxmMA1ZtnMyb7ntiyXnoj8
        +EKQ2lBGmBb+/ek67qYBthjWHuGZPUSR/m9Pjg50Gs/qhLPveh1PI+8Yx3avmhhq
        sYRsk3Rb+mc+74yW9WlmW73gFV+Y01MnYjfVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pVjUxxlJvjvGO8ehAE3ZF0Z6ry8jqh5P
        acbfRZoLCIvRKMgjWih37DYUnk0wd0yTx1QhyeNgT2H1OK1jZqt3X9jKJ2H43ZaJ
        gTnmelqtH5oKmwuMNapbZ2QRAkFgwYCBnaSlC4tIV6spzOTZC9nElgCCWABSsqlC
        p5iJllm3xzo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8D9CCA532;
        Sat,  2 May 2020 11:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B4E4CA531;
        Sat,  2 May 2020 11:48:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <xmqqv9lod85m.fsf@gitster.c.googlers.com>
        <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
        <xmqq8sikblv2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
        <20200427200852.GC1728884@coredump.intra.peff.net>
        <20200427201228.GD1728884@coredump.intra.peff.net>
        <20200428135222.GB31366@danh.dev>
        <20200428210750.GE4000@coredump.intra.peff.net>
        <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
        <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>
        <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
Date:   Sat, 02 May 2020 08:48:20 -0700
In-Reply-To: <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
        (Sibi Siddharthan's message of "Sat, 2 May 2020 20:01:39 +0530")
Message-ID: <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59F2E5F0-8C8C-11EA-B858-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

>> How about contrib/cmake/?
>>
>
> The CMakeLists.txt will be non-functional if it in any other directory except
> the root source directory. To help users we can,
> add some instructions in INSTALL on how to use the script.
> OR
> create a dummy CMakeLists.txt in the root directory which just
> says
> `message("Copy and Replace the CMakeLists from `whatever-folder` to here")`
> along with some instructions if necessary. This is what LLVM does for autoconf.

Isn't there a corresponding feature to make's "-f" option to specify
which file to read instructions from?

As you say, an extra instruction in INSTALL file to tell users to
copy from contrib/cmake may workable, though it is unsatisfactory.
But the other one will not simply work.  If we need to have a new
file with string "CMake" in its name at the top-level *anyway*, we
should have the real thing to reduce one step from those who want to
use it.  Those who do not want to see "CMake" at the toplevel are
already harmed either way, if is a dummy or if it is the real thing.

Thanks.
