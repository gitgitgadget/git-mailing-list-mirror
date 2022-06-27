Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D49EC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiF0IWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiF0IWO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 04:22:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CA5630A
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 01:22:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 878F2138865;
        Mon, 27 Jun 2022 04:22:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+VrO8yshuyDNb5tpBG8WB+8Yf3euvD9vA7Nb9+aCHhw=; b=wt8K
        WiStKebU7spvGOKpjyOwlW9rglkeurlpfjJNmj6ffEG5Mqgs35JhP1dLWdva5sim
        CcmLiNxhiQ7RPoJO4/Q7EbllG0onRD+fXGcpINCV3MDgVXEbWxQdb880R3SF4W+9
        UVOha26NUlKJRpdboa8suoWP7GmhtF2v7A20e2k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8090A138864;
        Mon, 27 Jun 2022 04:22:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F20B1138863;
        Mon, 27 Jun 2022 04:22:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
        <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
        <220624.86letmi383.gmgdl@evledraar.gmail.com>
        <xmqqsfnuvzxc.fsf@gitster.g>
        <CAOLTT8Tc95-aUE+uN2d8QjTJpGpGw6cBJfG+bpmyE55OcXTSRA@mail.gmail.com>
Date:   Mon, 27 Jun 2022 01:22:07 -0700
Message-ID: <xmqq7d52sehc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CA6FA14-F5F2-11EC-887C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> >> +    else if (skip_prefix(start, "(path)", &p))
>> >> +            write_name_to_buf(sb, data->pathname);
>>
>> These are just "values".
>> ...
>> >> +    else if (skip_prefix(start, "(size)", &p))
>> >> +            strbuf_addf(sb, "size: %u", sd->sd_size);
>> >> +    else if (skip_prefix(start, "(flags)", &p))
>> >> +            strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
>>
>> These are not.
>>
> ... If someone else
> need them for some reason, we can add them back.

If someone else needs to see "size:" printed in front of the value
of sd_size member, we DO NOT HAVE TO DO ANYTHING!  That someone else
can write "--format=size: %(size)" to do so themselves.


