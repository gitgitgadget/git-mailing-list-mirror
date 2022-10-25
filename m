Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59369C04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 16:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiJYQLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiJYQLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 12:11:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E85BF6C23
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 09:11:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02D171D1307;
        Tue, 25 Oct 2022 12:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WSAJUSQMIGk+wyCxte3giZHx2IptJazIhMh4zp
        PhLLA=; b=gC2jZNs/S7ISdeH1fdEQ90NVE4du1l/xg0YebIby035Wf4iQoVahUD
        4cz+UIkiA1sBLNcor0s0Ofkv/3sRk2BY3vS8Blxb4oGIjrBmZApKYFKlL26RaE22
        jkAztuiNn6eCT7yumrhmH5QdGreUWgyZfM6YgVs/tLneQEJ99GYxI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF49E1D1306;
        Tue, 25 Oct 2022 12:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA40E1D1305;
        Tue, 25 Oct 2022 12:11:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 3/8] rebase --merge: fix reflog when continuing
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
        <2c965f4b97c1773abc6b844b87fa64c5d6d1524c.1666344108.git.gitgitgadget@gmail.com>
        <xmqqk04tm62o.fsf@gitster.g>
        <86699708-d631-fb49-482c-af27204a3570@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 09:11:43 -0700
In-Reply-To: <86699708-d631-fb49-482c-af27204a3570@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 25 Oct 2022 11:08:41 +0100")
Message-ID: <xmqqczafopc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8406C82-547F-11ED-8989-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> Both of these will be fixed in a future series that
>>> stops the sequencer calling setenv().
>> If it gets fixed in a future step in the same series, that is a
>> different matter, but if it is easy enough not to deliberately
>> introduce a new leak, we'd prefer to do so.
>
> It's a couple of patches to fix which are more or less finished, I'm
> planning to send them once this series is in next.

So we will do the "add a known breakage of the same kind as there
exists others, and then later fix them all up, including the one
that is added by this series, because fixes are non-trivial and this
topic is easier to finish if we allowed to add a known breakage"
approach?  Just making sure it is what you plan to do.

Thanks.
