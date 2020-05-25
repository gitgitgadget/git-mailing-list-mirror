Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A7C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F082073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LleVPSJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgEYUDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:03:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55161 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgEYUDN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 16:03:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3515D6E54B;
        Mon, 25 May 2020 16:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OUgpwcZTtSI+ZCDxoMaqaMa+jjc=; b=LleVPS
        JE8bdqGIKNJDaydgEtdYXI6/tNV3VMxDIHugqWivDbpKTatHXilA72/JC0CSRm1F
        HGUsQRQdwyUD/xr7OEVV2+BCbtTTU2TNCBbu+ifEy6kPe0IJrjP6esTtK+Do3uuM
        pt2roAGYYWqHlV3EJDNBUXvsH3bnXgwJHpvpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ceJvapmO/b4kKdM6JvYl/yppapDTUs76
        NY/h+Eyn4JAMdOm9iD+L9Vi3FOmsSq28raNW79Kf7Ga6XHOTSSzlZ40/kNGCB7hn
        212QQYZ9RABR7i0l49JSbfV65d2JAY7Eczn+Vm5SzWWGCN4+SRxqTEm6w/cbEacn
        OoUJLJn0Xvs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A5F96E54A;
        Mon, 25 May 2020 16:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 238D36E548;
        Mon, 25 May 2020 16:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 11/11] ci: modification of main.yml to use cmake for vs-build job
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <fa1b8032906c6042a0e5851f803ec0427922a1a5.1589302255.git.gitgitgadget@gmail.com>
        <xmqq3684c096.fsf@gitster.c.googlers.com>
        <CAKiG+9VXk1vdMM1amQK6pnHcn9H_93-3fkqgK4nwKf=GtrDGyg@mail.gmail.com>
        <CAKiG+9Uz4YG=Hq9PRN8EhFF_agXNUPRnYjetY=ZNVRE6_VDAew@mail.gmail.com>
Date:   Mon, 25 May 2020 13:03:07 -0700
In-Reply-To: <CAKiG+9Uz4YG=Hq9PRN8EhFF_agXNUPRnYjetY=ZNVRE6_VDAew@mail.gmail.com>
        (Sibi Siddharthan's message of "Tue, 26 May 2020 00:46:10 +0530")
Message-ID: <xmqqzh9vok90.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0AD5E4A-9EC2-11EA-83AA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> 1) Relocating the CMake script to contrib/buildsystems from patch 01/xx.
> 2) Parse the Makefile for sources from patch 01/xx.
> 3) Reworded the commit messages you pointed out.
> 4) Rebased the ST_BLOCKS_IN_STRUCT_STAT and ICONV_OMITS_BOM to patch
> 01/xx to make the review process easier.
> ...
> No new features will be introduced in the script, to make the review
> process easier.

You did not answer <xmqqd077qnqc.fsf@gitster.c.googlers.com>,
so I have to guess.

I am guessing that your answer would be that if we keep this series
concentrate only on Windows support from the beginning and do not
add support for any other platform at all, the scope and necessary
effort to bring the patches in reviewable shape would be reduced
dramatically.  And if that is the case, that would be great.

In other words, I'd prefer not just "no new features", but "with
much less features, now we do not even add support for Linux or
macOS to the initial patch series".

But because I haven't heard the question answered, I cannot tell if
that level of simplification is possible and if that is already what
you did in (silent) response to my questions.

> I have looked at the GIT-VERSION-GEN script and the logic it uses to
> determine the version of git.
> The logic is a bit complicated to be implemented in a  CMake script,
> so I am skipping it for now.

Regarding the generation of GIT-VERSION-FILE, I asked you why you
need to hand-parse, instead of running the script itself, which is
the way you generate the config-list.h file in the same patch, which
is done with execute_process() to run generate-cmdlist.sh.

You did not answer the question, either, so I have to guess.

I am guessing that it was an oversight that you did not update the
procedure to handle GIT-VERSION-FILE because you wrote the "let's
string-find in the GIT-VERSION-GEN script" approach way before you
wrote the other parts of the CMake thing, and with the experience
and hindsight of having written command-list-h support, you now
realize that running the script to ensure that you get the result
consistent with folks who use Makefile would be much better.  After
all, the logic being more complex than your CMake support can
express shouldn't be an issue, if you just let the logic execute
itself, no?

But that is also merely my guess, so...

> Any other changes I should make before I submit PATCH v3?

... at this point, it is too early for me to answer that question.
