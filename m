Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BB7C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 03:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C39F60F48
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 03:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbhIQDoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 23:44:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57357 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbhIQDoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 23:44:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14692DAC3B;
        Thu, 16 Sep 2021 23:43:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HYhvGo8JIVaeV7Tq9szrO6xvMCEmhjVyN5LE+5
        8ouVk=; b=BBEQoTcZQGKuJHIWb/BhVToypeEXnVqbggcblYcKIBbnuRNDRbAnI+
        xtPcawHdHW/79hFVHn+0iqoK59ytZ9z/Gzj37EbWKXFsRmM1O2jUtG01N8pd0jZJ
        9+ykNRHtcv9vUSGYFH+84nlNw4YDvM56It/vasrHMh+Le1zCSr4Sw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C8C3DAC39;
        Thu, 16 Sep 2021 23:43:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 709F7DAC38;
        Thu, 16 Sep 2021 23:43:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, sam@vilain.net, avarab@gmail.com
Subject: Re: [PATCH 2/3] git-cvsserver: protect against NULL in crypt(3)
References: <20210915080948.11891-1-carenas@gmail.com>
        <20210915080948.11891-3-carenas@gmail.com>
        <xmqqczp8rx1c.fsf@gitster.g>
        <CAPUEspjqD5zy8TLuFA96usU7FYi=0wF84y7NgOVFqegtxL9zbw@mail.gmail.com>
Date:   Thu, 16 Sep 2021 20:43:31 -0700
In-Reply-To: <CAPUEspjqD5zy8TLuFA96usU7FYi=0wF84y7NgOVFqegtxL9zbw@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 16 Sep 2021 15:44:10 -0700")
Message-ID: <xmqqsfy350kc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DEB6D84-1769-11EC-8305-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> It is not wrong per-se to separate the two checks into two separate
>> parts of the conditional, but because we check for definedness only
>> because comparison of it with $1 makes sense only when it is
>> defined, writing it either like this,
>>
>>                 if (defined $hash and $hash eq $1) {
>>                         $auth_ok = 1;
>>                 }
>>
>> or even like this,
>>
>>                 $auth_ok = (defined $hash and $hash eq $1);
>>
>> may be easier to read, no?
>
> yes, let's go with the earlier; I was trying to mimic the original
> code, but agree on a second read that it looks confusing.
> assuming there are no more comments, would you want a reroll?

If there are no more comments, I certainly can tweak it myself, but
I'd rather not have to keep an eye to see if the thread gets any
comment myself to begin with, as it will not scale as the process
when there are multiple contributors and only one maintainer.

So, I'll make a local tweak myself and mark the topic as "On hold",
to let you ping me after waiting for a while to see if the thread
gets other comments that require a reroll.

Thanks.
