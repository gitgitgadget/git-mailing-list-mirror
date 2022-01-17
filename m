Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C092C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 19:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbiAQTke (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 14:40:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64940 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiAQTke (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 14:40:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FBFE187330;
        Mon, 17 Jan 2022 14:40:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pJ1vzL5zXNhCI4T92VfHpnqPGEBGZzNy1hvEpS
        nl3n8=; b=GtLdFFMxFefzf+7wMBLkGWE/Hgt3UmWmNGC68jAopz59ZGzAMTbhPG
        wmmqXm2s5Neu9f95cNkBOSTJOxROrW4xVJgle53iWOajh9W6cmaRnqaUEkgfFKGc
        hEHeYU3MpR/ak31Sb7cu4+r2oW1uB3h7j1UY9rFZN/U06kVfVP94w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 071D518732F;
        Mon, 17 Jan 2022 14:40:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 790D018732E;
        Mon, 17 Jan 2022 14:40:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
        <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
        <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
        <20220115095725.GA1738@szeder.dev>
        <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
        <xmqqv8yjz5us.fsf@gitster.g>
        <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
Date:   Mon, 17 Jan 2022 11:40:30 -0800
In-Reply-To: <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 17 Jan 2022 10:14:58 -0800")
Message-ID: <xmqq7dayup5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54B9A4BA-77CD-11EC-A716-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm not sure I follow.  READM<TAB> already doesn't complete to
> README.md in the following example command lines:
>    'cd READM<TAB>'
>    'ssh READM<TAB>'

If the example were "ls READM<TAB>", it would have been worth the
time to read and think about this again, but all users expect "cd"
to go into directories, and "ssh" to go visit another host, and
taking a local filename as a hint to complete would be nonsense.

But that is not what we are talking about (and it is frustrating
that you know it).  

To users, what sparse-checkout takes look like local pathnames, not
necessarily limited to directory names (if you disagree, go back and
read what SZEDER wrote to trigger this thread).

I know it is your preference to complete only directories and
exclude filenames, but I question if the confusion such a design
causes to end-users is worth it.
