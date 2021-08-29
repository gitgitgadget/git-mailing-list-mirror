Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC4BC432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3DF60F46
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 22:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhH2WQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 18:16:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64887 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbhH2WQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 18:16:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFAF7EC8AB;
        Sun, 29 Aug 2021 18:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XbAzg0j9Aea8m6rtb+JvTM24OpkQRpz4xZqLzf
        jVHq4=; b=Sh+J1BO2OfiAH3Fpi/COH0dLsSjgjIFE5gHV2xtSDIpExNuI4vc69q
        Sp3heDRZ/wdZBzH99APyURpvE5LFaDfN9GUgawgr/Ajymt0ewl7fefKJJeVeF3NQ
        JgqOutjZJ8jJb8BG3q0AI3F1XenRXXVsnUR1hopSfzT2PWlAkHd+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4EEDEC8A9;
        Sun, 29 Aug 2021 18:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AA36EC89E;
        Sun, 29 Aug 2021 18:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 0/9] ssh signing: Add commit & tag
 signing/verification via SSH keys using ssh-keygen
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
Date:   Sun, 29 Aug 2021 15:15:15 -0700
In-Reply-To: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com> (Fabian
        Stelzer via GitGitGadget's message of "Tue, 03 Aug 2021 13:45:49
        +0000")
Message-ID: <xmqqczpv99u4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B37FD8-0916-11EC-8A2F-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> openssh 8.7 will add valid-after, valid-before options to the allowed keys
> keyring. This allows us to pass the commit timestamp to the verification
> call and make key rollover possible and still be able to verify older
> commits. Set valid-after to the current date when adding your key to the
> keyring and set valid-before to make it fail if used after a certain date.
> Software like gitolite/github or corporate automation can do this
> automatically when ssh push keys are addded / removed I will add this
> feature in a follow up patch afterwards.

Has this follow-on work happened already?

The previous rounds saw enough reviews and responses, but this round
didn't.  Usually no response means no interest from the community,
but let's see if somebody other than the author actually tried the
feature, and and want to tell us about their experience, either
positive or negative?

As the basic step of the topic, possibly to be built upon laster, I
am tempted to say that this v7 may want to be cooked in 'next' for
wider exposure.

I'll typofix the topmost commit before doing so, though.

Thanks.



1:  4ff5911494 ! 1:  b88bcd013b ssh signing: test that gpg fails for unkown keys
    @@ Metadata
     Author: Fabian Stelzer <fs@gigacodes.de>
     
      ## Commit message ##
    -    ssh signing: test that gpg fails for unkown keys
    +    ssh signing: test that gpg fails for unknown keys
     
         Test that verify-commit/tag will fail when a gpg key is completely
         unknown. To do this we have to generate a key, use it for a signature
