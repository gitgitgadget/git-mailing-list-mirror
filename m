Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FADC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiCISdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiCISdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:33:41 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275A4B860
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:32:42 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23D0D17F60E;
        Wed,  9 Mar 2022 13:32:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SgALLHWWwAhW
        H9V3Rj5pKrK5lfyz3svWHxaJMM2nErE=; b=gkE4eU1WBS9MUdAJMN1JljFNtfsc
        DDskvNA/B+yqIahGIsVQeWQjukaYpO0Y+qAumN72lkljzcTsNR3lmD/8hbYoRz8Y
        KscRVFHmNAsm9oRvOsvlnI3B6P4TovoDuh6Mt3gscYPv1PBrH9oKohoNY4GpEV89
        f66UyXcnMiJIcpo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CA5517F60D;
        Wed,  9 Mar 2022 13:32:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9548117F60B;
        Wed,  9 Mar 2022 13:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason via
         GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com, zhiyou.jx@alibaba-inc.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 07/12] list-objects: handle NULL function pointers
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <782182a26e37eb8e84aef7d8cc67cf276b2abb54.1646750359.git.gitgitgadget@gmail.com>
        <xmqq8rtknyni.fsf@gitster.g>
        <220309.86k0d3mee3.gmgdl@evledraar.gmail.com>
Date:   Wed, 09 Mar 2022 10:32:38 -0800
In-Reply-To: <220309.86k0d3mee3.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 09 Mar 2022 14:40:03 +0100")
Message-ID: <xmqqa6dzm0xl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4CC3795C-9FD7-11EC-87B3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I suspect what's wanted here is "print all stuff before the "\n\n"
> header/PACK delimiter, which is better done with "sed" like this:
>
> 	sed -n -e '/^$/q' -e 'p'

I see.  Or just "sed -e '/^$/q'" would also be fine (i.e. "print
everything up to, including the first blank line") for comparison
purposes and may be simpler.

Thanks.
