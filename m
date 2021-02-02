Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBBEC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9195064F9A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhBBW1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:27:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61164 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhBBWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 17:25:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1F3A102D02;
        Tue,  2 Feb 2021 17:25:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+eJbsVm26RHI
        B9euVwibZIiCsCg=; b=mD25t82RQmblFemXvDekDe7oFIrL6Wqpl/6zPb7t0Oq0
        UE++tgy9LNeY8EazAM+aYkhIMZgbzNTl+EXJK8fU+Yd3NEbXeKKlCKYzgbD/g0kZ
        jCKo0W+TCMBmGIzd5XNUKSFW+89Spzlh6n2CnMEXfHVkeC7arDxqccmIbeOiIng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bf74tr
        S4E/lc+pDa/ZH+0rSDwYLmsWQoUBG2MRtilM48+UxF7nzpZnemrS4uvlpvSy+Hb/
        n98CS96PJ+91mrDyIm/VN4HOpQ5MVmnaVZODcO6qDIYdJV0/RUzIe05ldFnyBvah
        Y9YFUTiH61OqwFGPGVl1t9Q2HMy4K5VGdOV8Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9B15102CFF;
        Tue,  2 Feb 2021 17:25:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1413102CFC;
        Tue,  2 Feb 2021 17:25:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 4/4] init: provide useful advice about
 init.defaultBranch
References: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
        <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
        <ce26446b1a2e7bf14cdf814ca56c37b2e7d6b578.1607686618.git.gitgitgadget@gmail.com>
        <20210202212451.GC2091@szeder.dev>
Date:   Tue, 02 Feb 2021 14:25:01 -0800
In-Reply-To: <20210202212451.GC2091@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 2 Feb 2021 22:24:51 +0100")
Message-ID: <xmqqsg6eds5e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E6D43C4-65A5-11EB-8BBA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
>> +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
>> +			init.defaultBranch=3D"${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-maste=
r}" \
>> +			init \
>>  			"--template=3D$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
>
> This breaks GIT_TEST_INSTALLED when the given Git version doesn't yet
> contain 8b1fa77867 (Allow passing of configuration parameters in the
> command line, 2010-03-26):

Yes, but test-installed is about running an old version of Git on
the current Git test suite.  In the tests we make liberal use of
"git -c <var>=3D<val>", which such an old version of Git has no chance
of passing.  So...
