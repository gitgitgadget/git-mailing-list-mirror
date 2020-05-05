Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3FC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5C020721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QlmJEh8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgEESRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 14:17:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63155 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgEESRW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 14:17:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACC28C5B89;
        Tue,  5 May 2020 14:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+bzq8e6tvKyjptZ/QVkgyIZ2leM=; b=QlmJEh
        8uAFu+bvnKnKiq/E9eouZ/s7k9JX0tLl1T/6YhveKHKGeRdUTd2+d76Xl1D5GWIK
        XWp0blUIVgq8rF1CWuXQHsqhJu6nEEIPpTNNKZORjVoroYxqnkAzQk9Bbng6K2hf
        EGdAtfftqlcsbi4vUvEb1dKL96ARBxY2pK6Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ao37+Ow68Ol/0hpxPKZPbu9dkTJ8V9iX
        DKA3Sif1t2jSluhEeEKGfLzEACX6a7xsAcNh+NZMs9evpW41ceIt1q3S1PxEbKqy
        XkZPQbOrP1tmZT/5kLYPgGiThUHYsWEcBn6vcItKW/Puiy1fWHwcS9Vu2TEqo6J4
        H+kEgBcn8a0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3310C5B88;
        Tue,  5 May 2020 14:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87174C5B86;
        Tue,  5 May 2020 14:17:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Konstantin Tokarev <annulen@yandex.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
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
        <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
        <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com>
        <xmqqsgghhr32.fsf@gitster.c.googlers.com>
        <689741588534833@mail.yandex.ru>
        <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet>
        <848941588629532@mail.yandex.ru>
        <CAKiG+9Xu+eeET1Y3hFJTSpofxBCWEvwjyaY0cjFbKptzYLACNw@mail.gmail.com>
        <xmqqwo5qc3ec.fsf@gitster.c.googlers.com>
        <CAKiG+9WzQdFa1qM4dKUu8O7k+Q8JGsDMGQg-2GRJr=AJye6wJg@mail.gmail.com>
Date:   Tue, 05 May 2020 11:17:12 -0700
In-Reply-To: <CAKiG+9WzQdFa1qM4dKUu8O7k+Q8JGsDMGQg-2GRJr=AJye6wJg@mail.gmail.com>
        (Sibi Siddharthan's message of "Tue, 5 May 2020 21:53:01 +0530")
Message-ID: <xmqqk11qb61j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5603C14-8EFC-11EA-AA1C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> I have made the following changes as suggested:
> 1) The CMake script works from contrib/cmake now.
> 2) The CMake script parses the Makefile for
> SCRIPT_SH
> SCRIPT_PERL
> TEST_BUILTINS_OBJS
> LIB_OBJS
> BUILTIN_OBJS
> XDIFF_OBJS
> VCSSVN_OBJS
> 3) Philip suggested to change the error message if sh/bash was not
> found on windows.
> 4) CMake now tests for ICONV_OMITS_BOM, NO_ST_BLOCKS_IN_STRUCT_STAT.
>
> Regarding the commits, since 1,2,4 are additions to the script, is it
> acceptable for those changes to be staged in the next commits?

I am not sure what you exactly mean by "to be staged in the next
commits".  But as a new topic (from the point of view of the general
public), please avoid adding a known-broken one in patch 1 and then
following up with a series of "oops, that was wrong and here is to
fix the breakage" patches.

On the other hand, if the final contents added by the resulting
topic is easier to explain and review if built incrementally in
logical steps, please do so.  In other words, a series of follow up
"now we have basics there, teach the machinery to do this, too"
patches is perfectly fine, as opposed to "oops, that was wrong and
here is to fix".

> Regarding the workflow file(main.yml), I modified the vs-build and
> test steps, should I drop the commit or should I keep the changes(a
> modification is further needed if CMake is going to be used for
> vs-build)

It sounds like an integral part of the end result we would want to
get out of this series, so if that is the case, I do not see a
reason to exclude it.

Thanks.
