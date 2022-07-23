Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E57DC433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 18:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiGWSqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiGWSqp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 14:46:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E998716598
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 11:46:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8317D1A2FBF;
        Sat, 23 Jul 2022 14:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dudYiL1sAbe7xjgGbOp+BaCbmxRXTEvWY3lS39
        SxQhQ=; b=L4PSXj4vsfNMIM/6iDlg3pfLxVuAYt1jWzjkfpxgBkCHOs+NtTOweB
        T3lKEcxVQp40zWfz4FhNSPeRjEi3axinMh1UoZttsa1qEpPjZDEPrAQcSRTDj2vZ
        +0lrA5Hos7UjJg7eJxyHqSLf/hS/PBstVP5ZVrjs8HyjTvp1sMMZU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A0691A2FBE;
        Sat, 23 Jul 2022 14:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2BC651A2FBB;
        Sat, 23 Jul 2022 14:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
        <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
        <xmqqbktj3ct7.fsf@gitster.g>
        <CAOLTT8RjLoooT7t+ucFqa9P=8TiVL3M+ZgcEY7qVhRbjB=9OhA@mail.gmail.com>
        <xmqqsfmr8ygp.fsf@gitster.g>
Date:   Sat, 23 Jul 2022 11:46:40 -0700
In-Reply-To: <xmqqsfmr8ygp.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        23 Jul 2022 11:40:06 -0700")
Message-ID: <xmqqo7xf8y5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA8E3412-0AB7-11ED-8D8F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> That was not the point.  By extracting only "%(objectmode)" without
> having any other clues (like "%(path)") on the same line, the test
> is assuming that ls-files will always sort its output in the same
> order regardless of the output format, whether it is "--stage" or
> "--format=<spec>", and that was what the "is this testing the right
> thing?" question was about.
>
> The other test that makes sure --format=<spec> can recreate --stage
> output is fine.  If some future developer breaks the output order by
> mistake for --format=<spec>, we will catch such a mistake with it.

Having said that, let's stop rerolling the series just for this.  An
extra test that may not catch potential breakage is fine and it is
not worth spending an extra review cycle only to remove it.

Thanks.
