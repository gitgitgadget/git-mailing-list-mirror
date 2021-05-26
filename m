Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB687C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 05:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F02613D3
	for <git@archiver.kernel.org>; Wed, 26 May 2021 05:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhEZFeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 01:34:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59812 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhEZFd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 01:33:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73DF4132C33;
        Wed, 26 May 2021 01:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w1SEeqAqMoKvaFnKnp0JDbJKTsLcsKUTAeVCM2
        tZoO0=; b=WDnifnRK1JVASMlmd39mG8UOym3yEzNpKzMZL75bytGJau1Pu2hPih
        BV27UZ+ew64IOireSAwpzHthLY0wBnW+iQbpu9oZlagW1sWlYv9UfCqJ5HQ1VBmj
        B3CQZ31IQWtSVPLo+tppY+GYkNfYzZRohwz6c4YkDXqO+OEm38Ga4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FB89132C32;
        Wed, 26 May 2021 01:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B5695132C30;
        Wed, 26 May 2021 01:32:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Avar =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: CI: 'seen' minus a few passes tests, eh, almost
References: <xmqqcztecuy7.fsf@gitster.g>
Date:   Wed, 26 May 2021 14:32:19 +0900
In-Reply-To: <xmqqcztecuy7.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        26 May 2021 07:25:20 +0900")
Message-ID: <xmqqzgwiawm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDFC1560-BDE3-11EB-8E8F-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It is sad that the tip of 'seen' rarely passes all tests these days.
>
> I excluded a few topics (chosen primarily by prejudice after looking
> at which tests failed earlier, without locating exactly where and
> why they fail) from 'seen' and the exclusion of them seems to have
> made 'seen' finally pass the tests, eh, almost [*1*].
> ...
> Excluded are:
>
>   ab/fsck-unexpected-type
>   hn/reftable
>   hn/refs-errno-cleanup
>   zh/ref-filter-raw-data
>
> ...
> [Footnote]
>
> *1* Except for "git repack" segfaults only in one of the tests:
>
>   https://github.com/git/git/runs/2669668815?check_suite_focus=true#step:5:2846

Just with a hunch, I further excluded tb/multi-pack-bitmaps from
'seen', in addition to these four topics.  It seems to pass the
whole test suite on both 32- and 64-bit build combinations.

    https://github.com/git/git/actions/runs/877225207

Except that vs-build sometimes fails to download the sdk, that is.

