Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D4CC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 22:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiCCWY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiCCWY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 17:24:28 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59210BBE8
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 14:23:42 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8102107505;
        Thu,  3 Mar 2022 17:23:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=87GDQCZBiVp7
        00OpgvNGo5mUogv8UkLy8L1htMyolV8=; b=wsengBCodPLf25RgDxYgc5hsu65a
        OAqRkhCjtwD11euw1DrdRsN5rDYxaXfdC94WkusLHhFoQSHjLS9sGes7T+vtpoXy
        7PrkIc/GJT9l6gZHnmQ6rFRoZw0BFuIFXThyKdRFynHctHNGNpcFYdWLX2ywUwfX
        Fmh++jXxitCyL8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CD91107504;
        Thu,  3 Mar 2022 17:23:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2B49107503;
        Thu,  3 Mar 2022 17:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: ab/object-file-api-updates
References: <xmqqmti9ssah.fsf@gitster.g>
        <220303.86v8wv2evg.gmgdl@evledraar.gmail.com>
Date:   Thu, 03 Mar 2022 14:23:39 -0800
In-Reply-To: <220303.86v8wv2evg.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 03 Mar 2022 17:11:46 +0100")
Message-ID: <xmqq4k4e8yl0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 944FDA2C-9B40-11EC-A6BD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Mar 01 2022, Junio C Hamano wrote:
>
>> * ab/object-file-api-updates (2022-02-25) 12 commits
>>  - object-file API: pass an enum to read_object_with_reference()
>>  - object-file.c: add a literal version of write_object_file_prepare()
>>  - object-file API: have hash_object_file() take "enum object_type"
>>  - object API: rename hash_object_file_literally() to write_*()
>>  - object-file API: split up and simplify check_object_signature()
>>  - object API users + docs: check <0, not !0 with check_object_signatu=
re()
>>  - object API docs: move check_object_signature() docs to cache.h
>>  - object API: correct "buf" v.s. "map" mismatch in *.c and *.h
>>  - object-file API: have write_object_file() take "enum object_type"
>>  - object-file API: add a format_object_header() function
>>  - object-file API: return "void", not "int" from hash_object_file()
>>  - object-file.c: split up declaration of unrelated variables
>>
>>  Object-file API shuffling.
>>
>>  Needs review.
>>  source: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com=
>
>
> Jiang Xin (whose git-unpack-objects series at [1] depends on this) has
> looked this over & acked it at [2].
>
> 1. https://lore.kernel.org/git/cover-v10-0.6-00000000000-20220204T13553=
8Z-avarab@gmail.com/
> 2. https://lore.kernel.org/git/CANYiYbFZN=3DmvcxRT4Cf4Gzao89KR2UjMJXnJM=
63S2zAtbD32Jg@mail.gmail.com/

I've read this one again.  It was mostly a pleasant read and the
endgame state that use object type constant instead of a typename
string as much as possible (i.e. the only exception is the
"literally" stuff that was meant for debugging, which has to take a
possibly bogus typename string) is excellent.

