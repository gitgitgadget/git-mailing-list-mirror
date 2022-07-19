Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B55C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 23:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiGSXVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 19:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiGSXVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 19:21:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3D474F7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 16:21:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DE5514E0A4;
        Tue, 19 Jul 2022 19:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SeSbfPSvNYxf
        hHn96yMXoUA0e0b+1/zlEgvYh7c5WOw=; b=tsI60fJlCBu7uEA9pKU6vV2eB0eT
        T4JkfB7zd0I34Jagcu+zrMdmH1eHMFztXkH4hivEGjnx2uy/faFR126UKmgL4jay
        tjxWhH36QU18pYLeIH0OjJYWfe3Mj/bs40NiXHNnF+PT9VjE1Ao+jjctdIRn88j8
        rDcv8IQGnaVPW7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 433E814E0A3;
        Tue, 19 Jul 2022 19:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A210C14E0A2;
        Tue, 19 Jul 2022 19:21:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 2/8] git docs: split "User-facing file formats" off
 from "Guides"
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
        <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
        <patch-v4-2.8-883c483d4e7-20220718T132911Z-avarab@gmail.com>
        <xmqqlesqqr1v.fsf@gitster.g>
        <220718.86mtd6w90v.gmgdl@evledraar.gmail.com>
Date:   Tue, 19 Jul 2022 16:21:36 -0700
In-Reply-To: <220718.86mtd6w90v.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 18 Jul 2022 20:41:39 +0200")
Message-ID: <xmqqcze0664f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89938F3A-07B9-11ED-BEB7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> If we can come up with a word that is more appropriate than
>> "format", it would be great.  If we do not place too much emphasis
>> on "format", I agree that both "gitignore" and "githook" fall into
>> the same category, because they define how the contents written in
>> these files affect the operation of Git commands.
>
> *nod*, another word would be most welcome :)

True.  What I am absolutely sure about is that the word is not
"format" X-<.  It is the interface end-users interact with internals
of Git, with need similar to how "plugin" interfaces need to have
documentation for their users.

> I do think that if we have --user-formats or --user-X it makes sense to
> have to have that match the --git-X. I.e. the "format" of say the
> commit-graph includes how we arrange those files on disk, just as is th=
e
> case with the hoks.
>
>>> -With no options and no '<command>' or '<guide>' given, the synopsis =
of the 'git'
>>> +With no options and no '<command>', '<guide>' or '<doc>' given, the =
synopsis of the 'git'
>>
>> At some point, we will have enough <doc> that it would probably
>> become meaningless to treat <guide> as a separate class, no?
>> Guides, user-supplied customization files, and implementation
>> details of on-disk files that may help reimplementations of Git, all
>> will become <doc>.
>
> Maybe I should just use <name> here?

I think <doc> is very good, much better than <name>, here.
