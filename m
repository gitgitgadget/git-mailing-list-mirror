Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A03FC07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1497610F7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhGUAoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 20:44:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57953 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhGUAog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 20:44:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A313614005D;
        Tue, 20 Jul 2021 21:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FeqtOeC0P2piLF2mOhu6HPYfjmIm35U5mU457s
        NFrvg=; b=WqdPZHpYw13aU4xsod4EjqeVa9oG5f2c9wbsWcIbeTYoF3Vz79eWuc
        p3uEJKc+vhoumA5Cb9dI9c2wt3ON3YXj3IObQUuqqikjZh2AExVCabJkwwDlTol4
        pf9L7bpmnHvtjPU2sHkU/2vZIkaRL1gjNdxUdIf9SeUMCh7ZuXsP4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F78B14005C;
        Tue, 20 Jul 2021 21:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C67E6140059;
        Tue, 20 Jul 2021 21:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 8/9] pull: update docs & code for option compatibility
 with rebasing
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <d1952f014f20d2770c74a311df27f956c8b95e21.1626536508.git.gitgitgadget@gmail.com>
        <xmqq5yx4frlc.fsf@gitster.g>
        <CABPp-BGkiNfy4s9uxFWPYfqVRLj3rT10pJuARW9e3tPrkDbS9w@mail.gmail.com>
Date:   Tue, 20 Jul 2021 18:25:09 -0700
In-Reply-To: <CABPp-BGkiNfy4s9uxFWPYfqVRLj3rT10pJuARW9e3tPrkDbS9w@mail.gmail.com>
        (Elijah Newren's message of "Tue, 20 Jul 2021 17:44:02 -0700")
Message-ID: <xmqqr1fse9vu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DCA2C38-E9C2-11EB-A0AF-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > +Note that `--ff-only` takes precedence over any `--rebase` flag.
>> > ++
>>
>> "`ff-only` overrides any `--rebase` flag"?
>
> Yeah, ignore that, I had already ripped it out after your comments on
> patch 1 yesterday.  I've also got more changes to the pull
> documentation to try to do more of what your sentence above says,
> "covering these interactions and whipping them into a much better
> shape."

OK.  After thinking about it further, "overrides" is not the word,
either, I guess.  It is more like that there are "merge", "rebase"
and "fast-forward-only" for the user to choose from, with "merge"
having two sub-variants (i.e. what happens when we do not have any
development of our own) and "rebase" with a few sub-variants
(i.e. interactive? shape-preserving?).

In any case, when the user says "I'll take nothing but fast-forward
update to their history", it is a bug if we did not fail when their
history is not a descendant of ours, and we have already fixed it in
an earlier part of the series.  This would be a good place to
clarify what the correct behaviour ought to be, if the existing
documentation is not already.

Thanks.
