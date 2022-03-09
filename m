Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E252C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 20:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbiCIUG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiCIUG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 15:06:26 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EAF286F6
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 12:05:27 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEC5218F8F0;
        Wed,  9 Mar 2022 15:05:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QBqTMastTv3+
        kh58rcND8OqX0iC2Y4UeDOrkO6qY5DA=; b=FTzos537+vEZLtAPdbMR4aBDMqyY
        pDZD9DPoDNLetd1a5JJGVN+ywCojjlwzo6qAfDOJ884daZ0CjaOV7GT/Ug7n2zMy
        WbYg7EkOHIzXs4cTaC05bGgTqOuM+xDV1NR8kQuTEi8Wq6X56uuQ4SovhMk6L++L
        1msnhWliFOBiv0o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E77F018F8EF;
        Wed,  9 Mar 2022 15:05:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D43118F8EA;
        Wed,  9 Mar 2022 15:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/24] revision.[ch]: add and use release_revisions()
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <77c8ef4b-5dce-401b-e703-cfa32e18c853@github.com>
Date:   Wed, 09 Mar 2022 12:05:23 -0800
In-Reply-To: <77c8ef4b-5dce-401b-e703-cfa32e18c853@github.com> (Derrick
        Stolee's message of "Wed, 9 Mar 2022 09:34:55 -0500")
Message-ID: <xmqqlexiki2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41A9B114-9FE4-11EC-9C1E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/9/2022 8:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> =3D=3D For Junio =3D=3D
>>=20
>> This has a trivially resolved conflict with Derrick Stolee's
>> aaf251cdc5c (revision: put object filter into struct rev_info,
>> 2022-03-08) currently in "seen" in builtin/rev-list.c.
>>=20
>> The resolution is to just keep the "goto cleanup" in place of "return
>> 0" in the conflicting lines, but to otherwise keep Derrick's version.
>>=20
>> It will pass with/without SANITIZE=3Dleak when applied to both "master=
"
>> and "seen". I omitted one test change (described in a relevant commit
>> message) due to the latter not being true (no fault of "seen", just a
>> new leaking command being added to a test).
>
> Since ds/partial-bundles will soon be updated in v4 to change the
> pointer added to struct rev_info, it is even more likely that there
> will be more important things to do with regards to clearing the
> memory of rev_infos based on that change. It might be better to wait
> for that update (coming soon) and then rebase directly on top.

;-)

I just saw both of these topics involved, and indeed the
interactions need to be cleaned up.

Thanks, both, for working on these.

