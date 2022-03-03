Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9470C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 21:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbiCCVme (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiCCVmd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 16:42:33 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7932C6542C
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 13:41:47 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7A36106FE3;
        Thu,  3 Mar 2022 16:41:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oxm9+QQAxJpr
        jGBvWP1vcQwg/mJmuFuwJ5jQ4M3cpVs=; b=kXTTkV1kwhu5LoM/QbnlpDyUMYTA
        dZqO1yb9Oof1wnh44nIDa2MmdA6/AKlei++kuafs9vGnYkUHrsZrfsgy/TOtbnAu
        K7yfQTuv6n0+9i7MEw52mFAQi6Q+7vqilaahALV0mn9AlUnM6WjT0BqraBx9vO59
        GX1uUgj2UaKa4lQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEBA5106FE2;
        Thu,  3 Mar 2022 16:41:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D6AB106FE0;
        Thu,  3 Mar 2022 16:41:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 00/13] submodule: convert parts of 'update' to C
References: <20220301044132.39474-1-chooglen@google.com>
        <20220303005727.69270-1-chooglen@google.com>
        <220303.86sfrz5p9t.gmgdl@evledraar.gmail.com>
Date:   Thu, 03 Mar 2022 13:41:45 -0800
In-Reply-To: <220303.86sfrz5p9t.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 03 Mar 2022 10:58:57 +0100")
Message-ID: <xmqqzgm690iu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B968C4FA-9B3A-11EC-BD03-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Mar 02 2022, Glen Choo wrote:
>
>> Original series: https://lore.kernel.org/git/20220210092833.55360-1-ch=
ooglen@google.com
>> (I've trimmed the cc list down to the 'most interested' parties)
>>
>> Thanks for the input, =C3=86var :) This just fixes up a few small issu=
es in
>> the previous version.
>
> And thanks for working on this, there was a reason I was down to
> nitpicking in v2, this is looking really good & I can't find any issues
> with this iteration at all.
>
> So I'm happy to give this my:
>
> Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Thanks for reviewing.

I found that the safety of doing [05/13] that early was
questionable, but other than that, it was a pleasant read.
