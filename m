Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F7CC6FA94
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiIUQum (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiIUQuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 12:50:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47372167CD
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 09:46:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D93615190C;
        Wed, 21 Sep 2022 12:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W/ksbrdyi35CD8Y/T13Qk2oZgQaZ69Z8gBJuzw
        A6JW8=; b=EqrvWLr6aN86FK6Cbq/YqMZgdVYT2iNADVuzXXSQyKXqEpKpMOvF5w
        5GXV7ljkbeuBrETBwsXTDQWJ8eIYGGVljXHwuS2POekNeEws3mAI9OABnY0xykWv
        +Uf0ZoOZaNTWwKov30VDpNzUnRwqzE5CDwCXOBlAbx9WkN6dsZScA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01E6F15190B;
        Wed, 21 Sep 2022 12:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E0C215190A;
        Wed, 21 Sep 2022 12:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] refs: unify parse_worktree_ref() and ref_type()
References: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
        <xmqq1qsge71x.fsf@gitster.g> <xmqq35cwcpws.fsf@gitster.g>
        <xmqqillrb7qs.fsf@gitster.g>
        <CAFQ2z_PBWbdKgbaqLO6iXB8WEhG=CTjetrEgm7wHacDi_n8VHw@mail.gmail.com>
        <xmqqwn9z82hk.fsf@gitster.g>
        <CAFQ2z_PQFtq-ph1B0tUFDW7ngVwg9++k2M_5rvozsLVisX2+Qg@mail.gmail.com>
Date:   Wed, 21 Sep 2022 09:45:55 -0700
In-Reply-To: <CAFQ2z_PQFtq-ph1B0tUFDW7ngVwg9++k2M_5rvozsLVisX2+Qg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 20 Sep 2022 10:53:59 +0200")
Message-ID: <xmqqczbo65h8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD1BE13A-39CC-11ED-9416-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Mon, Sep 19, 2022 at 11:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > On Tue, Sep 13, 2022 at 5:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >> then a better approach would be to have a small helper
>> >> parse_local_worktree_ref() and make the primary one into something
>> >> like
>> >>...
>> >
>> > Thanks, good idea. I'm sending you a v2.
>>
>> is that "v2" <pull.1325.v2.git.git.1663605291172.gitgitgadget@gmail.com>
>> or is there another version of it?
>
> I think so.
>
>> Hmph,
>
> Did I do something wrong?

Not "wrong" per-se, but I was surprised by the patch that looked
quite different from what I expected from your response to the
"small helper" suggestion.
