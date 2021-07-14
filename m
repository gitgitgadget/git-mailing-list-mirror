Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A94C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543DC613AB
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhGNQdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:33:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56709 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGNQdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:33:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 157DD14B02C;
        Wed, 14 Jul 2021 12:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lT0XESDbIzepZWq08+ujoKFL5aHAzhXZ+cMFzs
        MWfXo=; b=NZe6ZK4SdEco5zrCAUS/szptZP8MG01isn6kjs4C8ne5PVHIBO2WV7
        3TU83Su6mQPSEJLuGNx20P5q1diRyWGkq49fepVfc3CKVBjwerjNv5ysH3uj1hGl
        cPmQs8asCUwcuHp13Kjhy5LvdKeKyclYvNP7tU0GB4P8+SoUM6uB4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E01614B02B;
        Wed, 14 Jul 2021 12:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86F7914B02A;
        Wed, 14 Jul 2021 12:30:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
References: <xmqqmtqpzosf.fsf@gitster.g>
        <CAPig+cQfsACHAQhCrXDs==18p1Ds8MtMRZDmSfso9HsO6dF-qg@mail.gmail.com>
Date:   Wed, 14 Jul 2021 09:30:16 -0700
In-Reply-To: <CAPig+cQfsACHAQhCrXDs==18p1Ds8MtMRZDmSfso9HsO6dF-qg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 13 Jul 2021 22:16:54 -0400")
Message-ID: <xmqqlf68yi1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C63D316A-E4C0-11EB-BD20-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jul 13, 2021 at 9:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * sm/worktree-add-lock (2021-07-12) 3 commits
>>  - worktree: teach `add` to accept --reason <string> with --lock
>>  - worktree: mark lock strings with `_()` for translation
>>  - t2400: clean up '"add" worktree with lock' test
>>
>>  "git worktree add --lock" learned to record why the worktree is
>>  locked with a custom message.
>>
>>  Ready?
>
> I think this series is ready and gave my Reviewed-by: here[1]. One of
> the new tests contains an unnecessary but harmless `test -f`[2], but
> it's such a minor nit that I doubt it's worth demanding a re-roll.

I think having "test -f" is the right thing to do, so [2] is
probably OK as-is.  test_cmp may want to complain about a possible
bug in the test when given a missing file.  I do agree with you that
the unquoted "why not" is a bit problematic from the readability's
point of view but I agree it is not too huge a deal.

Let me "rebase -i"-in your Reviewed-by: before merging it down to
'next'.

Thanks.


> [1]: https://lore.kernel.org/git/CAPig+cSVsJ9AtAMqtRQpyuosCDCGi+mu2C1PJUK49WTb5KvcWQ@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CAPig+cQVSUg1aqry_hMydJ=Uo=-VhOog6TUTpG=0on0LUcw8Dg@mail.gmail.com/
