Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979BCC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 21:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CB7611B0
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 21:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhIJVCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 17:02:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61669 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhIJVCk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 17:02:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 864B6149E12;
        Fri, 10 Sep 2021 17:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pAD17tmNKjXcl5dk2hpxrp9Oz8CR9dGpDXcRQN
        il7ro=; b=JGZ81hyrK09Pc6p7liF41RD5Zmqc/w1Zo/L3I4IlWgdUaFjreuYm1M
        14Np+sdcRzym20fJoRZUT9Vo8h/GHXVONarC9y7FgbktVKuK9gcHQi9fz1ezGxsG
        fbwpXmTkj2RFDq+rI8p7aM4+29t5qAg3wIC5+FnVJVSQbgDdj29Io=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CA03149E11;
        Fri, 10 Sep 2021 17:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C163E149E10;
        Fri, 10 Sep 2021 17:01:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fabian@stelzer.cloud>
Subject: Re: [PATCH v8 0/9] ssh signing: Add commit & tag
 signing/verification via SSH keys using ssh-keygen
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
        <xmqqfsucrxhg.fsf@gitster.g>
        <ced584ee-4f8b-24d3-1f5b-459c67e75584@gigacodes.de>
Date:   Fri, 10 Sep 2021 14:01:24 -0700
In-Reply-To: <ced584ee-4f8b-24d3-1f5b-459c67e75584@gigacodes.de> (Fabian
        Stelzer's message of "Fri, 10 Sep 2021 22:48:09 +0200")
Message-ID: <xmqqbl50rvq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42D3DCF6-127A-11EC-ABF6-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Sorry, i think i'm just not familiar with the process. What do i do when
> the patch is in next and someone (or myself) find other bugs during testing?
> Do i send a new patch based on "next" or update my patchset but not
> squashing the fixup commits?

In general, you'd send an incremental update on top of what you
submitted and has been queued in my tree so far.  Looking for the
merge of the topic from the tip of 'next':

  $ git show -s "next^{/^Merge branch 'fs/ssh-signing' into next}" |
    grep "^Merge:"
  Merge: 348fe07b87 b88bcd013b
  $ git log --oneline --reverse master..b88bcd013b
  c222385164 ssh signing: preliminary refactoring and clean-up
  3a3fdc0b4e ssh signing: add test prereqs
  c7e2d30efe ssh signing: add ssh key format and signing code
  5493722122 ssh signing: retrieve a default key from ssh-agent
  6869f1f60c ssh signing: provide a textual signing_key_id
  9048bb3c9b ssh signing: verify signatures using ssh-keygen
  587967698a ssh signing: duplicate t7510 tests for commits
  52ac6bd36f ssh signing: tests for logs, tags & push certs
  b88bcd013b ssh signing: test that gpg fails for unknown keys

we learn that b88bcd013b is the tip, so you'd send follow-up patches
to either fix a bug that exists in the tree of b88bcd013b, or enhance
a feature on top of the tree of b88bcd013b.

But since I am already ejecting the previous round out of 'next',
let's remember to do so the next time.  We will have to wait until
mid October (if I recall what I thought I read from you correctly)
anyway, so until then we can iterate outside the 'next' branch.

Thanks.
