Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1295A20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 04:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdDQEFj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 00:05:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61361 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750836AbdDQEFi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 00:05:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B4038C31A;
        Mon, 17 Apr 2017 00:05:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1YZStic5kDi9
        B9sBHJdlcA16zkM=; b=nGFpelOiBGui0JN+T8DqdQv4ZA8iLJXzEi7e134rpRr1
        dlq8ur6BTnINUleRCLSZmmGnDGDT1UW03cOQqLzsXJYU1o1A6PuCoYqRdNywy62E
        1m8AH08UIXrPIXo5m0kja79NTdAYU06CLVa7WJX7E0btS4H1oou6X8XnOhtRCzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Kor3E0
        U6CerKPhC2OMUjwjyzIrx79b4IcP4m4X76e8+gOG4pjJ2wzNM0+QzoLLLIflfFP+
        0nQcxhFQCCEUq1IEvSIxV8H5vRw+pLFcQaV3VnL6r/b//M2dNZ2c+ixvAbAgO0TX
        WjWZgN1nl3mtdSPwO/ZdiHLsgr06tJKkvMtrY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4313A8C319;
        Mon, 17 Apr 2017 00:05:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A553A8C318;
        Mon, 17 Apr 2017 00:05:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlos Pita <carlosjosepita@gmail.com>,
        =?utf-8?Q?=E2=80=9Cgit=40vger?=
         =?utf-8?Q?=2Ekernel=2Eorg=E2=80=9D?= <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: Index files autocompletion too slow in big repositories (w / suggestion for improvement)
References: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
        <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com>
        <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com>
        <7a07a2a8-07a6-4342-80d0-7684e6242326@kdbg.org>
Date:   Sun, 16 Apr 2017 21:05:35 -0700
In-Reply-To: <7a07a2a8-07a6-4342-80d0-7684e6242326@kdbg.org> (Johannes Sixt's
        message of "Sat, 15 Apr 2017 13:59:34 +0200")
Message-ID: <xmqqefwrk7ao.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C7D910A-2323-11E7-9337-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Cc G=C3=A1bor.
>
> Am 15.04.2017 um 00:33 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Sat, Apr 15, 2017 at 12:08 AM, Carlos Pita <carlosjosepita@gmail.co=
m> wrote:
>>> This is much faster (below 0.1s):
>>>
>>> __git_index_files ()
>>> {
>>>     local dir=3D"$(__gitdir)" root=3D"${2-.}" file;
>>>     if [ -d "$dir" ]; then
>>>         __git_ls_files_helper "$root" "$1" | \
>>>             sed -r 's@/.*@@' | uniq | sort | uniq
>>>     fi
>>> }
>>>
>>> time __git_index_files
>>>
>>> real    0m0.075s
>>> user    0m0.083s
>>> sys    0m0.010s
>>>
>>> Most of the improvement is due to the simpler, non-grouping, regex.
>>> Since I expect most of the common prefixes to arrive consecutively,
>>> running uniq before sort also improves things a bit. I'm not removing
>>> leading double quotes anymore (this isn't being done by the current
>>> version, anyway) but this doesn't seem to hurt.
>>>
>>> Despite the dependence on sed this is ten times faster than the
>>> original, maybe an option to enable fast index completion or somethin=
g
>>> like that might be desirable.
>>
>> It's fine to depend on sed, these shell-scripts are POSIX compatible,
>> and so is sed, we use sed in a lot of the built-in shellscripts.
>
> This is about command line completion. We go a long way to avoid
> forking processes there. What is 10x faster on Linux despite of
> forking a process may not be so on Windows.

Doesn't this depend on how many paths there are?  If there are only
a few paths, the loop in shell would beat a pipe into sed even on
Linux, I suspect, and if there are tons of paths, at some number,
loop in shell would become slower than a single spawning of sed on
platforms with slower fork, no?
