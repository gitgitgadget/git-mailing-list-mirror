Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1525EC433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2977235F8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbhAOTpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:45:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63885 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbhAOTpf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 14:45:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD6B5A7105;
        Fri, 15 Jan 2021 14:44:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=YotoRKdMJC99Sy1zdg2vD0FzAlo=; b=eHD03nsE3xQyFINr61+n
        CsvRKWVsPEKfkyQfzz3x/gFc039rjx+lWI1zXLSraiFZr+Co4v0KLa+ilzyQgbWK
        gUp+PTocBC/QRphGxYaDlxhgUjmGsMr9wDBaQZ1eFQWkN9d+VH/FGypzLjmif0xg
        R242xZVZH3WIbqOEQyQAnC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Q/aTqJ3s2gLxa3IBIQq17EnyqIioKLWiEYxblt2xl3tT0q
        dFOZEPWANfIUZmFVu47r25sDy4Pp3JiNhcO8PekAxIBJ2msTQj3WIBmPPpkOcfif
        ZXzPrW3PvODX5MmouLIJIzkWagUIAvcksGcIEFeucwySI7eRQ1v7yGNeGy2oU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2927A7104;
        Fri, 15 Jan 2021 14:44:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CD73A7103;
        Fri, 15 Jan 2021 14:44:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <YADOf41CcaRuToD7@google.com>
        <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
        <xmqqr1mmu2nx.fsf@gitster.c.googlers.com>
        <xmqqmtxau2kj.fsf@gitster.c.googlers.com>
        <49a151f1-a04c-703b-cf18-90cc503b0c80@gmail.com>
Date:   Fri, 15 Jan 2021 11:44:50 -0800
Message-ID: <xmqqturirnm5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21F2FD62-576A-11EB-9DDB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Thanks for dealing with this fallout. Sorry for the mixup.
>
>> Helped-by: Emily Shaffer <emilyshaffer@google.com>
>
> Would it be appropriate to convert this to a Co-authored-by?

Or more like "Inspired-by-a-patch-by".  Also you three have about
the same amount of input and deserve credit.

Sorry, but it already is on 'next', which will be discarded in a few
months when the new cycle begins, so I am not sure if it is worth
reverting and reapplying with updated credit trailers.

FWIW, I ended up redoing the merge and did "checkout -m" to recreate
conflicts, and then looked for "config.*pwd" in the block of text
that came from the "part-4" topic and fixed them up manually.  I
then compared the result of this new merge with the earlier merge
that had the issue.  The resulting diff is what went into the patch
you are responding to.  It is good that we had Emily's input as a
comparison material to see that both of us independently touched the
same places to fix.

By the way, the merge into 'master' will directly reuse the conflict
resolution of e47c3632 (Merge branch 'ds/maintenance-part-4' into
jch, 2021-01-14) from the rerere database, without any separate
"merge fix" commit.

Thanks.
