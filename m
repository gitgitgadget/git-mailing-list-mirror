Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0555C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGaPbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjGaPbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 11:31:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C6BF
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 08:31:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B80A51A9A7C;
        Mon, 31 Jul 2023 11:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lSK6xuzDsTjv
        PuNb47Eua2oIxb1/LMiiVYmQcK7ls0E=; b=E50Rbz5RL8QCuN1pusdoZSpCb4VT
        vsGvcpTO/Zg0bdDv0eHYiYASgBVOmUeHd+SbBrM7zOqSeKnOCp6H0X/H7hIZnd9W
        NPFRwTqCJE+R772+bsfEjFkMFu0Ctc3FZ4IlH7fQxju2MU8DFCSz/ipAFrdH0ISx
        dD7/CBxkmWrvEIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A96761A9A7A;
        Mon, 31 Jul 2023 11:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E77251A9A79;
        Mon, 31 Jul 2023 11:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
        <xmqq351hz5xp.fsf@gitster.g>
        <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
        <xmqq4jlxuiuu.fsf@gitster.g>
        <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
        <xmqqr0oxnnx4.fsf@gitster.g>
        <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
        <xmqqh6ptnies.fsf@gitster.g>
        <a19879db-d45a-ee42-1ad5-497e4e9eb8df@web.de>
        <b17b4f6b-199f-973b-3aa9-ef995a61bb3d@gmail.com>
        <31b71333-de8b-d9a8-3ec4-1bad9cae2bf3@web.de>
Date:   Mon, 31 Jul 2023 08:31:07 -0700
In-Reply-To: <31b71333-de8b-d9a8-3ec4-1bad9cae2bf3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 29 Jul 2023 22:40:19 +0200")
Message-ID: <xmqqjzug14jo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 45AEF47C-2FB7-11EE-B4B8-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> A bit more verbose still: Document the negative form on its own line
> with a generated description -- requires no new syntax:
>
>     -v, --invert-match         show non-matching lines
>     --no-invert-match          opposite of --invert-match, default
>     -I, --no-index             find in contents not managed by git
>     --index                    opposite of --no-index, default

I would expect _("opposite of %s, default") is acceptable by l10n
folks, and assuming it is, the above would be a good approach.

> All these imperfect solutions make me wish we could get rid of the
> problem, e.g. by converting all "no-" options to their positive variant=
s
> and mentioning that they are the default.  Won't fly, though,
> because ...

True.

Thanks.
