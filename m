Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13FC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089C361244
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhDMVz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:55:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58158 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhDMVz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 17:55:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5DF9B662C;
        Tue, 13 Apr 2021 17:55:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PVpJnFXlEUfA
        mwnZpN0fI0upSyg=; b=ZZBeZ1IPCHMkKuzPJPcGkFToNZPp+96Q0gL+n/DREShx
        ljasRAF34JKtDKghlphzAzJxnHUSLpukGuZGtn8yYS1Pt+NAzyehfyfAm10SVV8h
        3kKRBBCHIZJnB/x7ARpRmy9MBx0KMnIA+Z8MvizaHy0XSoKEJKVCfMCdr+vNJ7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L1Vhte
        WJrsGXFT0v0BLqDfq1WFkrO4JTUerrplJQwkUft4ggpMr16DysBd0XvvhOIubTJH
        fp6bbn+DpPrj5hidbmFHZ9n8Tb3/yw8f5Ku8TP1Ii6FaQ9O3fGgldW7iBF6gd6O7
        IsGc8+P+n03OIJf403NRWpGbuC0Qh5YtYowRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E821B662A;
        Tue, 13 Apr 2021 17:55:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29B12B6629;
        Tue, 13 Apr 2021 17:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
        <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
        <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
        <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
        <87fszu2elw.fsf@evledraar.gmail.com>
        <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
Date:   Tue, 13 Apr 2021 14:55:05 -0700
In-Reply-To: <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 13 Apr 2021 16:55:23
        -0300")
Message-ID: <xmqqlf9lkfye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E85D09FC-9CA2-11EB-9767-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> On Tue, Apr 13, 2021 at 4:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> > Nit: before these two patches, "$actual" was only removed when the
>> > test succeeded. So, in case of failure, the failed output files woul=
d
>> > still be there for debugging. It might be interesting to keep this
>> > behavior and only remove "$actual" at the end of the test.
>>
>> Either I'm missing something or you are, that's how test_when_finished
>> works.
>>
>> It's skipped under e.g. "--immediate --debug". See b586744a864 (test:
>> skip clean-up when running under --immediate mode, 2011-06-27)
>
> I was mostly thinking about the `artifacts` zip we get from our CI
> when a test fails. I find the final trash dir quite useful for some
> post-mortem analysis, especially to debug WIP tests that only fail
> occasionally or test failures on OSes I don't have quick access to.

Yeah, without "--immediate" we do run the clean-up tasks registered
with test_when_finished, so it may be a problem.

