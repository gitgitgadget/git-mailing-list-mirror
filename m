Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B2C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 18:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbhLISPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:15:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54400 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhLISPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:15:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75E8EFAA2D;
        Thu,  9 Dec 2021 13:12:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p989sw/X5uqo
        ObDNZJNuMi5lHKGoT9PFqwpNle8byt0=; b=IJNhNc6f+zkMXZJSzPYOXYlqAzio
        3u4sNNZ7QCNEubo9Mewz3H/0OCtgiFHZCqUN34DYnXkInSYjMMCvCsRfkj0ELA83
        HlzM+bnfXdwlhouPbYRBf8PS68/vV/W8llbXSszGBEtOsHO9OTscq8Fz8nU0+ufe
        kZJUkLI0rcdgq40=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A445FAA2C;
        Thu,  9 Dec 2021 13:12:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D48CFAA2B;
        Thu,  9 Dec 2021 13:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com>
Date:   Thu, 09 Dec 2021 10:12:07 -0800
In-Reply-To: <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 09 Dec 2021 04:44:11 +0100")
Message-ID: <xmqq4k7htzpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 86721472-591B-11EC-B170-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> So, how about doing it this way?  This is based on 'master' and does
>> not cover contrib/scalar, but if we want to go this route, it should
>> be trivial to do it on top of a merge of ab/ci-updates and js/scalar
>> into 'master'.  Good idea?  Terrible idea?  Not good enough?
>
> With the caveat that I think the greater direction here makes no sense,
> i.e. scalar didn't need its own build system etc. in the first place, s=
o
> having hack-upon-hack to fix various integration issues is clearly wors=
e
> than just having it behave like everything else....

We decided to start Scalar in contrib/, as it hasn't been proven
that Scalar is in a good enough shape to deserve to be in this tree,
and we are giving it a chance by adding it to contrib/ first, hoping
that it may graduate to the more official status someday [*].

And 'test-extra' is a way to give test coverage to things already in
contrib/ that has 'test' target in their Makefile.  When js/scalar
gets merged to a tree with 'test-extra' target, it may be tested in
that target, too, because we want to have it behave like everything
else.


[Footnote]

*1* You may not like the "try unproven things in contrib/ first and
    then we may graduate it later" approach, but that particular
    ship has sailed and this is not a time to complain and waste
    project's time.

