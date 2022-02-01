Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953FFC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 23:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiBAXDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 18:03:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59137 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBAXDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 18:03:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EC7417643D;
        Tue,  1 Feb 2022 18:03:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CFiQsO86lVQf
        chN8dp506pEqaQBdyRtri3aEruCgIdg=; b=YZBsW/14BADyTsZhPIdzZW4FK6tN
        WcUxZ3/BI5HUF4cAbctafRUmCzwUcIraaaLi1c6J7jsWNyeGmY5iLx2QSXcgQw+B
        /eYVxbwoEdit2w3+jyNKWcRMMP0d8v3K161JY7+AHI3Bwds+033xo7gFKOddeME3
        jSLs3mGND5DqvPU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F78E17643C;
        Tue,  1 Feb 2022 18:03:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AADED17642E;
        Tue,  1 Feb 2022 18:03:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
        <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
        <220201.86ilty9vq2.gmgdl@evledraar.gmail.com>
Date:   Tue, 01 Feb 2022 15:03:37 -0800
In-Reply-To: <220201.86ilty9vq2.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 01 Feb 2022 21:20:59 +0100")
Message-ID: <xmqq8ruub35i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 310FB292-83B3-11EC-860A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The post-image LGTM, but I'm also a bit "meh" on the churn just for
> signed->unsigned, especially given the conflict with my in-flight
> ab/no-errno-from-resolve-ref-unsafe. But it's not too bad, and if Junio
> hasn't complained about it...

I won't complain myself.  I'd still try to help newer developers,
but my intention is to make it the responsibility for individual
developers to make sure their topic works well with topics in
flight ;-)

Between "enum" and #define that is stored in "unsigned", neither
gives us much type safety in C; "enum" may be somewhat worse by
giving a false sense of having a type safety that does not really
exist, than "unsigned int" that is more honestly defeats such a
false sense of safety.  So I have no strong preference either way.

