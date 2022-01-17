Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5037C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 19:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbiAQTII (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 14:08:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58041 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiAQTIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 14:08:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA07E186FBB;
        Mon, 17 Jan 2022 14:08:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BtP/FRI7GLguqF0jMs8MqudrT7eh8kBFRFCnZn
        At9Ws=; b=b9VmO6ZdN/hsyzerTicwGGvQTzarMxOHJccnIBayJRjoWygc/T7xXu
        Q/K8l7om8eGPYk3wWg/8msi6MQI7d1FxxYJ1WtFYUMnxOITBIHXwJMI3Z1sDVbPy
        KUy4n1ZFzJJYGihVkwJDc20K/Kr8io8ETFvt8gDqsUKpK56BKe15A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3276186FBA;
        Mon, 17 Jan 2022 14:08:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61464186FB8;
        Mon, 17 Jan 2022 14:08:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] reftable: avoid initializing structs from structs
References: <pull.1188.git.git.1642092934523.gitgitgadget@gmail.com>
        <220113.86r19btv5a.gmgdl@evledraar.gmail.com>
        <xmqqy23jh2h3.fsf@gitster.g> <xmqqtue7h0dd.fsf@gitster.g>
        <CAFQ2z_PNRb6HLUD81=_HkRrX0cMLfzz4NmVJaTUQ37EC61MXbg@mail.gmail.com>
Date:   Mon, 17 Jan 2022 11:08:03 -0800
In-Reply-To: <CAFQ2z_PNRb6HLUD81=_HkRrX0cMLfzz4NmVJaTUQ37EC61MXbg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 17 Jan 2022 14:07:35 +0100")
Message-ID: <xmqqpmoquqng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC2A7EFC-77C8-11EC-9909-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Thu, Jan 13, 2022 at 9:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >> Would make sense to steal the compiler version etc. details from my
>> >> <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>. I.e. eventually
>> >> we'll be able to change this & other code back, as nobody will care
>> >> about that older compiler version. It worked before in the pre-image on
>> >> a more recent xlc.
>> >
>> > If so, wouldn't it be a better option not to worry about such an old
>> > compiler at all from the get-go?
>>
>> The above was a genuine question.  If that "nobody will care about
>> the old compiler" will happen only after a few years, then it may
>> not work to just ignore the version of xlc which might still have
>> a meaningful number of users.  I just am not in a good position to
>> judge that.
>
> I'm all for not worrying too much about ancient compilers, but there
> is no downside to this patch, so it seems fine to let this one go
> through.

Yup, I think this already is part of -rc1.

Thanks.
