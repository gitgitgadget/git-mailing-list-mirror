Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA9EC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 02:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhK2Cfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 21:35:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60570 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhK2Cdz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 21:33:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8E44E9411;
        Sun, 28 Nov 2021 21:30:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cKtKoJrwWW+e5HuXOuY2o/NJB8VkCSvq/SLcQoKtXoA=; b=bSJa
        c55ZUkTKYlVkyKkIX4/SgKICzfO5qFSJ+ZjLQO87uhLqWg1dX1bs1CvuH3TahmBk
        KN1zQTOQrNj3AGr56FyAmWXw0TRdkD9wP77bg6NKoMEiO2N4epQ8Do9i+2THy62r
        b9jo9o+C98VLO6Olf9u4DxEe6p0UKjL9X6jRh/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF8C2E9410;
        Sun, 28 Nov 2021 21:30:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EA10E940F;
        Sun, 28 Nov 2021 21:30:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
        <xmqq35nnddw7.fsf@gitster.g>
        <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
        <xmqqczmqajdk.fsf@gitster.g>
        <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        <xmqqzgpu7grv.fsf@gitster.g>
        <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
        <xmqqpmqp2xmz.fsf@gitster.g>
        <CAFQ2z_PqgwYy+RxQm7d7WDQYvQQ2vVE0cXHdDKNwQJm3Xc+NFw@mail.gmail.com>
        <xmqqtug1z32j.fsf@gitster.g>
        <CAFQ2z_N-XY6MrvYjKvkH-vNz1824p12aNeiHj8m8VPzPD0JxEA@mail.gmail.com>
Date:   Sun, 28 Nov 2021 18:30:36 -0800
Message-ID: <xmqqa6hn4rsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 564989A4-50BC-11EC-80BA-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Nov 24, 2021 at 9:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Ehh, let's step back a bit.
>>
>> Is there anything in the common part and files backend in ref API
>> that needs to be changed to fix some bug?  I do not see anything
>> broken that needs to be fixed by "assert that the string ends in LF
>> and doesn't need to add LF itself" or by "always add LF".
>
> Clearly, you and I disagree about what is logical behavior here.
>
> I've reworked the series to fit with your opinion on the matter. PTAL.

Thanks.

I find both are logical and internally consistent, so I prefer a
choice that requires fewer changes to what is already working.
