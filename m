Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED8C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 18:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiCGSXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244606AbiCGSXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 13:23:50 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211C377D4
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 10:22:55 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B08F012C9FA;
        Mon,  7 Mar 2022 13:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TD3wj86EneDJ
        qjNPZ+ICd/x6NyVIAyEQ+OzHatBLZkk=; b=EsvjFTh0Yizso6IsP67WlV2OA6cB
        sFNTP1ia9rMKJNr7XbnTR7LcBOntt+HAGFAE6us0xBpt3WpOlx4eL9g4lp5NCBFA
        T8YjKvZXBsAwjlJpvYDexZJ0GWaM4O8SKaZ4LvPqcnNvq6Ac8hkBna5caPCeCQYL
        d0tKc9oNIN68QYg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A65CE12C9F9;
        Mon,  7 Mar 2022 13:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D58412C9F8;
        Mon,  7 Mar 2022 13:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: jc/stash-drop
References: <xmqqv8wu2vag.fsf@gitster.g>
        <220305.86y21o327b.gmgdl@evledraar.gmail.com>
Date:   Mon, 07 Mar 2022 10:22:53 -0800
In-Reply-To: <220305.86y21o327b.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 05 Mar 2022 15:25:19 +0100")
Message-ID: <xmqqh789sjuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9AF45456-9E43-11EC-BF51-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Mar 03 2022, Junio C Hamano wrote:
>
>> * jc/stash-drop (2022-03-02) 3 commits
>>  - stash: call reflog_delete() in reflog.c
>>  - reflog: libify delete reflog function and helpers
>>  - stash: add tests to ensure reflog --rewrite --updatref behavior
>>
>>  "git stash drop" is reimplemented as an internal call to
>>  reflog_delete() function, instead of invoking "git reflog delete"
>>  via run_command() API.
>>
>>  Will merge to 'next'?
>>  source: <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
>
> I've been reviewing this closely & it looks good to me, all feedback ha=
s
> been addressed, and there's nothing outstanding (there's one sub-thread
> on v4 answering a question from Phillip Wood asking if the new test
> needs REFFILES, it does).

I think this one is good, and I agree that we should leave the "old
side is not even visible to regular users and tests need to peek
into the implementation detail of the log files---do we need the
--rewrite option at all, instead of doing so always?" outside the
topic.

Thanks.
