Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD57C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbiGSSar (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiGSSap (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:30:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF6725C79
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:30:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B54AE197B9A;
        Tue, 19 Jul 2022 14:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B6IcFbmqj4hh
        ofdviGtoyoTZD77NhyQz8nd/W3HJ5GM=; b=oFt17k5pczYRJnlbeYXuXQpSkbkd
        Q6/Re3MtQ6TE6nFHfe1MuT/BpKfRvJ2RkrL8kOsdyjOas4vfvzBJTP4M1q6tstG5
        V3jmQHndsZkfVdyY26mrmTV1rZiSOKechlpUC6N8cTsTD1brgL9P9xQQAzrIz0fe
        GcMowSBIZqUuAvw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99F5F197B99;
        Tue, 19 Jul 2022 14:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 306AF197B93;
        Tue, 19 Jul 2022 14:30:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        vdye@github.com
Subject: Re: [PATCH v1 1/7] t7002: add tests for moving from in-cone to
 out-of-cone
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
        <20220719132809.409247-2-shaoxuan.yuan02@gmail.com>
        <220719.86pmi1up9d.gmgdl@evledraar.gmail.com>
        <d914bd30-0f53-864e-b640-0173d168bcb5@github.com>
Date:   Tue, 19 Jul 2022 11:30:40 -0700
In-Reply-To: <d914bd30-0f53-864e-b640-0173d168bcb5@github.com> (Derrick
        Stolee's message of "Tue, 19 Jul 2022 13:36:46 -0400")
Message-ID: <xmqq4jzdaran.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4B562AE-0790-11ED-94FB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 7/19/2022 10:52 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Jul 19 2022, Shaoxuan Yuan wrote:
>>=20
>>> +	! grep -x "H sub/d" actual &&
>>> +	grep -x "S folder1/d" actual
>>=20
>> This *might* be a portability problem, but probably not. It's listed i=
n
>> POSIX:
>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
>>=20
>> But it appears we have no "grep" use of the "-x" option in-tree, at
>> least from what I found with grepping..
>
> It is helpful to recommend a working alternative when pointing out
> an issue like this.
>
> Here, the '-x' option means to match the entire line.
>
> Would using ^ and $ help here?

Yup, that would be quite reasonable and removes the need to use,
learn about, or have your readers wonder about the "-x" option; I do
not think I saw a grep that did not understand the option, though.

Thanks.
