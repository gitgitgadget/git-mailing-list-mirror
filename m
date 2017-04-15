Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C25F20D09
	for <e@80x24.org>; Sat, 15 Apr 2017 07:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbdDOHwh (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 03:52:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65341 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752550AbdDOHwg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 03:52:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FCB378470;
        Sat, 15 Apr 2017 03:52:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ePIjEzckJvEx
        tV9YpP+GjDQc0Qw=; b=w1IrXTwz40YZj0Rf2iqohMVRKAfyesCtfXqrYUZXCF7g
        p1abBs0Mf63FF2JRnY0TiAiez0uXmy1YyFiNBd89TVKyi4D/fgGlDUtOAB9LLYrr
        4fzhDHy6GjguHE8hYrL8+knJQFOg9HbrqFyit7dKeEU0X6Kf0VdO9y9hkJjot3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ANSLCo
        1oCftUi5kEzM1RKfmR6iG2/D9CMJsyxiQN7X75y8rQRc0YlKLUhccNcsxTIYGTyJ
        jEGEH8G5cg7jtTUYXp/x3GLhqsMOnYUvAAqZCzuLCapz0x25E6Pw5/Xy/TbsG21V
        PNsYjBbSKIGXGfngt7XY1b1ZgUcFsLzc5pmEw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1658D7846F;
        Sat, 15 Apr 2017 03:52:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81A8A7846D;
        Sat, 15 Apr 2017 03:52:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlos Pita <carlosjosepita@gmail.com>,
        =?utf-8?Q?=E2=80=9Cgit=40vger?=
         =?utf-8?Q?=2Ekernel=2Eorg=E2=80=9D?= <git@vger.kernel.org>
Subject: Re: Index files autocompletion too slow in big repositories (w / suggestion for improvement)
References: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
        <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com>
        <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com>
        <CA+P7+xoBYApdmucEpdxT8qHJ0HP5RR2gOkStykd5Fq=8qsZxZQ@mail.gmail.com>
Date:   Sat, 15 Apr 2017 00:52:23 -0700
In-Reply-To: <CA+P7+xoBYApdmucEpdxT8qHJ0HP5RR2gOkStykd5Fq=8qsZxZQ@mail.gmail.com>
        (Jacob Keller's message of "Fri, 14 Apr 2017 18:37:08 -0700")
Message-ID: <xmqqr30um7k8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 769427A4-21B0-11E7-A206-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Fri, Apr 14, 2017 at 3:33 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
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
>>>
>>> Best regards
>>
>> It's fine to depend on sed, these shell-scripts are POSIX compatible,
>> and so is sed, we use sed in a lot of the built-in shellscripts.
>>
>> I think you should submit this as a patch, see Documentation/Submittin=
gPatches.
>
> Yea it should be fine to use sed.

As long as the use of "sed" is in line with POSIX.1; I do not think
you need the non-portable "-r" merely to strip out everything that
follow the first slash, so perhaps "s|-r|-e|" with the above (and do
not write backslash after pipe at the end of the line---shell knows
you haven't finished talking to it yet if you end a line with a
pipe, and there is no need for backslash), you'd be golden.
