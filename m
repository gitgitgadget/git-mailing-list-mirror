Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9CAC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 15:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346178AbiE0Ppm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiE0Ppk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 11:45:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D33258E5C
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:45:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44B3713DE60;
        Fri, 27 May 2022 11:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lE7z2K1DqEJY
        h8R/O7HhVR07rw2zKL3XeqIbmmEZPpc=; b=Kxa06aUVtY5IHtPfSdFuVMK1MKtG
        +Akhd+kh0GS0e4yPNOLd5ofKgbdkNKKyL/f0+zFIIYi+XYUTtOce+o/GxRmL7nod
        KcPIP5+No/1Ak9FkukZkymzd1CBM+qB4c6N2fUUtUX0WjwQYuEN19c+CQlaJKlxO
        cqeH19jFBfqLx3o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A89613DE5F;
        Fri, 27 May 2022 11:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DCA413DE5E;
        Fri, 27 May 2022 11:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
        <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
        <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de>
        <xmqq5ylsxccw.fsf@gitster.g>
        <9455d0af-87f2-f331-a440-3d3feb743610@iee.email>
Date:   Fri, 27 May 2022 08:45:36 -0700
In-Reply-To: <9455d0af-87f2-f331-a440-3d3feb743610@iee.email> (Philip Oakley's
        message of "Fri, 27 May 2022 13:17:50 +0100")
Message-ID: <xmqq4k1b6ktb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0DCD6146-DDD4-11EC-B3B6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 26/05/2022 21:33, Junio C Hamano wrote:
>>>> So there's no point in changing this string, nor to have translators
>>>> focus on it, it'll never be used.
>>>>
>>>>
> The translation change would need to be a separate patch, no? That
> would make it easy to drop if not wanted.

I think you are responding to what =C3=86var said, but the string this
patch is modifying is already inside N_(), and modifying a string
that is already marked for translation in any way (other than
removing the N_() or _() around it) incurs the cost to translate the
updated string already, with or without any separate patch.

If we are adding a new die() call that uses a new message, we should
mark the message for translation from the beginning.  The messages
produced by die/warning/error are meant to be read by human users,
so unless there is some very strong reason not to, they should be
marked for translation.




