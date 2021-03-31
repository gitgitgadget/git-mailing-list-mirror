Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59215C433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB2F619CA
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhCaAVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:21:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57840 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhCaAUk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 20:20:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6030C1E22;
        Tue, 30 Mar 2021 20:20:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5DckOvPcQflu
        3c2c4WAIBEu08ic=; b=jDj0jXbsMPEQH8NxLE5NN0zivjQAufiY+oIg+NvxDEt0
        h7jh614iaKjgkN2m5SoFVxSfFFAz2IrHe8/X9bQ3DMP6RDIEpWGuLnyrCHHzItX8
        EeymzVDTtQ+zT/Bc7bDGRXN6KLwjrc521BknNot0fv+oAkFMX2iYc4E9PPcgvkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yUmOys
        rnUc276BJt7BdaCO7CwzlV081bhIzgQqSE4VRSxWhQ8rrf2zNHxrbqnbIEaXg05O
        5PMwmZyXnk/LvpVMBrQhBqnZWZy9Wpti1LT2JRto8FbyRsQVZAiZdCDS0R9gTel5
        ecJvJfKtOtRdKeTRreiwv9MFUVE7axhieRHd4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD6D4C1E21;
        Tue, 30 Mar 2021 20:20:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44F9AC1E20;
        Tue, 30 Mar 2021 20:20:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2021, #07; Mon, 22)
References: <xmqq35wm5y6d.fsf@gitster.g> <878s67o09v.fsf@evledraar.gmail.com>
Date:   Tue, 30 Mar 2021 17:20:38 -0700
In-Reply-To: <878s67o09v.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 28 Mar 2021 15:50:20 +0200")
Message-ID: <xmqqr1jw897t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EBEA59A4-91B6-11EB-95B7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/pickaxe-pcre2 (2021-02-18) 24 commits
>>  - pickaxe -G: don't special-case create/delete
>>  - pickaxe -G: terminate early on matching lines
>>  - xdiff-interface: support early exit in xdiff_outf()
>>  - xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
>>  - pickaxe -S: slightly optimize contains()
>>  - pickaxe: rename variables in has_changes() for brevity
>>  - pickaxe -S: support content with NULs under --pickaxe-regex
>>  - pickaxe: assert that we must have a needle under -G or -S
>>  - pickaxe: refactor function selection in diffcore-pickaxe()
>>  - perf: add performance test for pickaxe
>>  - pickaxe/style: consolidate declarations and assignments
>>  - diff.h: move pickaxe fields together again
>>  - pickaxe: die when --find-object and --pickaxe-all are combined
>>  - pickaxe: die when -G and --pickaxe-regex are combined
>>  - pickaxe tests: test for -G, -S and --find-object incompatibility
>>  - pickaxe tests: add test for "log -S" not being a regex
>>  - pickaxe tests: add test for diffgrep_consume() internals
>>  - pickaxe tests: refactor to use test_commit --append --printf
>>  - test-lib functions: add --printf option to test_commit
>>  - test-lib-functions: reword "test_commit --append" docs
>>  - test-lib-functions: document and test test_commit --no-tag
>>  - grep/pcre2 tests: reword comments referring to kwset
>>  - Merge branch 'jk/rev-list-disk-usage' into ab/pickaxe-pcre2
>>  - Merge branch 'ab/test-lib' into ab/pickaxe-pcre2
>>
>>  Rewrite the backend for "diff -G/-S" to use pcre2 engine when
>>  available.
>>
>>  Ready???
>
> I think it's been ready for while, but unfortunately it hasn't gotten
> much/any review.
>
> The changes to the C code are all rather trivial (just the "change
> return; to return 0" is rather verbose).=20

It is a shame that this series hasn't seen any reviews.  It had so
many low-hanging crufts to be pointed out, netting aspiring reviewer
some "review points" ;-)

I think a change to tolerate -G with --pickaxe-regex combination (as
the latter becomes a redundant no-op in today's world because -G
cannot do fixed strings), instead of marking them incompatible, may
require the "function selection" step to be rewritten, but other
than that, I didn't see much that is fundamentally objectionable.

The summary I wrote in the "What's cooking" report was not quite
right, by the way.  There is nothing pcre2 yet in these patches.
They are preliminary clean-ups only.

Thanks.
