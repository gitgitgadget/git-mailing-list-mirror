Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ABAC433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiDFVId (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiDFVIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:08:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0E3CFC3
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 12:45:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E4BA17241E;
        Wed,  6 Apr 2022 15:45:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YOVLohrpdPrN
        DdXf4yh+Z5Lj/LeX6ZGInX/qo/q4iVE=; b=DGYheV8DMY9bMG/c09OSlEHPYkjg
        MI3QxSNNJ2YnvTfoI9LL+6c8l5b8uiqumx1qO6m8Cq3/M0jjkWnOojxuLAHl7Ud5
        bPYsUHgEnIGTM5xuRD0e2GobOplCs0bs3H2rz1vmEMnAYWuAJmiAyUN8JtjD0WYD
        dDL/y9AEj5oUaN8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86E5A17241D;
        Wed,  6 Apr 2022 15:45:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D906C17241B;
        Wed,  6 Apr 2022 15:45:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, prohaska@zib.de, eyvind.bernhardsen@gmail.com
Subject: Re: [PATCH v2] convert: clarify line ending conversion warning
References: <20220405053559.1072115-1-alexhenrie24@gmail.com>
        <20220406180434.4zlb2bwpu6cfumta@tb-raspi4>
        <CAPMMpohYRTSaTcRVTJ6y=Q7+FSOcSNjHjwDvUMhVv4JO7QDB_g@mail.gmail.com>
Date:   Wed, 06 Apr 2022 12:45:46 -0700
In-Reply-To: <CAPMMpohYRTSaTcRVTJ6y=Q7+FSOcSNjHjwDvUMhVv4JO7QDB_g@mail.gmail.com>
        (Tao Klerks's message of "Wed, 6 Apr 2022 20:18:24 +0200")
Message-ID: <xmqqk0c2xafp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27F24AA6-B5E2-11EC-B6A5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> On Wed, Apr 6, 2022 at 8:04 PM Torsten B=C3=B6gershausen <tboegi@web.de=
> wrote:
>
>> May be we can use "updates" instead of "touches" ?
>>
>> "In '%s', CRLF will be replaced by LF the next time Git updates it"
>
> Makes sense to me.
>
>>
>> Or may be
>>
>> "In '%s', CRLF will be replaced by LF the next time a `git checkout` u=
pdates it"
>>
>
> I believe we should stay away from the word "checkout" because it's
> neither accurate nor clear, for at least a couple of reasons:
> 1. We have long, in principle, been promoting the use of "git switch",
> and it's not obvious in a message like this one that this is
> considered to be equivalent.

It is not an equivalent.  "switch" is a strict subset of "checkout"
and branch switching is not the only case that would correct the
line ending on such a file.  Checking the contents out of the index
or a named commit with "git checkout -- path" would also fix the
line endings.

> 2. Files can be touched/updated by other commands/processes, like "git
> pull" (and "rebase", and probably others I can't think of)

Yes.

